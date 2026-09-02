import hashlib
import os
import re
import socket
import ssl
import threading
from email.utils import parsedate_to_datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import NamedTuple
from urllib.parse import unquote, urlsplit

import requests

from mltd.servers.asset_cache import (
    REMOTE_ASSET_ROOT,
    SUPPORTED_LANGUAGES,
    SUPPORTED_PLATFORMS,
    AssetStore,
    scope_name,
)
from mltd.servers.logging import logger

relay_port = 7651
_PATH_RE = re.compile(r'^/([a-z]{2})-(android|ios)/([^/]+)$')
_RANGE_RE = re.compile(r'^bytes=(\d*)-(\d*)$')
_STREAM_BUFFER_SIZE = 1024 * 1024
_SOCKET_TIMEOUT = 60
_REQUEST_QUEUE_SIZE = 512


class _ServingEntry(NamedTuple):
    path: Path
    size: int
    metadata: dict


class RelayUpstream:
    """Request-driven upstream fetcher used only for cache misses.

    Relay startup never touches the upstream.  Cached objects therefore remain
    fully serviceable when the origin, DNS, proxy, or Internet connection is
    unavailable.  This class is instantiated only when cache_only=False.
    """

    def __init__(self, store: AssetStore, remote_root: str = REMOTE_ASSET_ROOT,
                 timeout: float = 60.0, upstream_proxy: str | None = None):
        self.store = store
        self.remote_root = remote_root.rstrip('/')
        self.timeout = timeout
        self.upstream_proxy = upstream_proxy.strip() if upstream_proxy else None
        self._local = threading.local()

    def _session(self) -> requests.Session:
        session = getattr(self._local, 'session', None)
        if session is None:
            session = requests.Session()
            adapter = requests.adapters.HTTPAdapter(
                pool_connections=1,
                pool_maxsize=1,
                max_retries=3,
            )
            session.mount('http://', adapter)
            session.mount('https://', adapter)
            session.headers['User-Agent'] = 'mltd-relive-asset-relay/1'
            if self.upstream_proxy:
                session.proxies.update({
                    'http': self.upstream_proxy,
                    'https': self.upstream_proxy,
                })
            self._local.session = session
        return session

    def remote_url(self, language: str, platform: str, name: str) -> str:
        return f'{self.remote_root}/{scope_name(language, platform)}/{name}'

    def fetch(self, language: str, platform: str, name: str) -> Path:
        destination = self.store.object_path(language, platform, name)
        if self.store.is_complete(language, platform, name):
            return destination

        part = self.store.part_path(language, platform, name)
        try:
            resume_at = part.stat().st_size
        except OSError:
            resume_at = 0

        headers = {'Accept-Encoding': 'identity'}
        if resume_at:
            headers['Range'] = f'bytes={resume_at}-'

        response = self._session().get(
            self.remote_url(language, platform, name),
            headers=headers,
            stream=True,
            timeout=self.timeout,
        )
        try:
            if response.status_code == 416 and resume_at:
                part.unlink(missing_ok=True)
                return self.fetch(language, platform, name)
            response.raise_for_status()

            append = resume_at > 0 and response.status_code == 206
            if not append:
                resume_at = 0
            mode = 'ab' if append else 'wb'
            digest = hashlib.sha256()
            if append:
                with part.open('rb') as existing:
                    for chunk in iter(lambda: existing.read(1024 * 1024), b''):
                        digest.update(chunk)

            with part.open(mode) as file:
                for chunk in response.iter_content(chunk_size=1024 * 1024):
                    if not chunk:
                        continue
                    file.write(chunk)
                    digest.update(chunk)
                file.flush()
                os.fsync(file.fileno())

            size = part.stat().st_size
            expected_total = None
            if response.status_code == 206:
                content_range = response.headers.get('Content-Range', '')
                if '/' in content_range:
                    total = content_range.rsplit('/', 1)[1]
                    if total.isdigit():
                        expected_total = int(total)
            elif response.headers.get('Content-Length', '').isdigit():
                expected_total = int(response.headers['Content-Length'])

            if expected_total is not None and size != expected_total:
                raise IOError(
                    f'Incomplete relay asset {name}: got {size} bytes, '
                    f'expected {expected_total}'
                )

            os.replace(part, destination)
            self.store.put_metadata(
                language,
                platform,
                name,
                status=200,
                size=size,
                sha256=digest.hexdigest(),
                headers=response.headers,
            )
            return destination
        finally:
            response.close()


def _parse_range(value: str, size: int):
    match = _RANGE_RE.fullmatch(value.strip())
    if not match:
        return None
    start_s, end_s = match.groups()
    if not start_s and not end_s:
        return None
    if not start_s:
        suffix = int(end_s)
        if suffix <= 0:
            return None
        start = max(0, size - suffix)
        end = size - 1
    else:
        start = int(start_s)
        end = int(end_s) if end_s else size - 1
        if end >= size:
            end = size - 1
    if start >= size or end < start:
        return 'unsatisfiable'
    return start, end


def _not_modified(headers, metadata) -> bool:
    etag = metadata.get('etag') if metadata else None
    if_none_match = headers.get('If-None-Match')
    if etag and if_none_match:
        candidates = [item.strip() for item in if_none_match.split(',')]
        if '*' in candidates or etag in candidates:
            return True

    last_modified = metadata.get('last_modified') if metadata else None
    if_modified_since = headers.get('If-Modified-Since')
    if last_modified and if_modified_since:
        try:
            remote_dt = parsedate_to_datetime(last_modified)
            client_dt = parsedate_to_datetime(if_modified_since)
            return remote_dt <= client_dt
        except (TypeError, ValueError, OverflowError):
            pass
    return False


def _load_serving_index(store: AssetStore) -> dict:
    """Load cached response metadata without contacting any upstream."""
    conn = store._connect()
    try:
        rows = conn.execute('''
            SELECT scope, name, size, content_type, etag, last_modified,
                   cache_control, content_encoding
              FROM object_metadata
        ''').fetchall()
    finally:
        conn.close()

    index = {}
    for (scope, name, size, content_type, etag, last_modified,
         cache_control, content_encoding) in rows:
        if '-' not in scope:
            continue
        language, platform = scope.split('-', 1)
        if (language not in SUPPORTED_LANGUAGES
                or platform not in SUPPORTED_PLATFORMS):
            continue
        path = store.root / scope / name
        try:
            if not path.is_file() or path.stat().st_size != int(size):
                continue
        except OSError:
            continue
        metadata = {
            'content_type': content_type,
            'etag': etag,
            'last_modified': last_modified,
            'cache_control': cache_control,
            'content_encoding': content_encoding,
        }
        index[(language, platform, name)] = _ServingEntry(
            path,
            int(size),
            metadata,
        )
    return index


def _tune_client_socket(request):
    request.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    request.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
    request.settimeout(_SOCKET_TIMEOUT)


class ThreadedRelayServer(ThreadingHTTPServer):
    daemon_threads = True
    block_on_close = False
    allow_reuse_address = True
    request_queue_size = _REQUEST_QUEUE_SIZE

    def get_request(self):
        request, client_address = super().get_request()
        _tune_client_socket(request)
        return request, client_address


class RelayHTTPRequestHandler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    store: AssetStore | None = None
    upstream: RelayUpstream | None = None
    cache_only = False
    _download_locks_guard = threading.Lock()
    _download_locks = {}
    _serving_index_lock = threading.Lock()
    _serving_index = {}

    def do_HEAD(self):
        if self._is_origin_form():
            self._serve_path(self.path, send_body=False)

    def do_GET(self):
        if self._is_origin_form():
            self._serve_path(self.path, send_body=True)

    def _is_origin_form(self):
        parsed = urlsplit(self.path)
        if parsed.scheme or parsed.netloc:
            self.send_error(400, 'Forward proxy requests are not supported')
            return False
        return True

    def _lookup_entry(self, language: str, platform: str, name: str):
        entry = type(self)._serving_index.get((language, platform, name))
        if entry is None:
            return None
        try:
            if entry.path.is_file() and entry.path.stat().st_size == entry.size:
                return entry
        except OSError:
            pass
        self._invalidate_entry(language, platform, name)
        return None

    def _refresh_entry(self, language: str, platform: str, name: str):
        assert self.store is not None
        metadata = self.store.get_metadata(language, platform, name)
        if metadata is None:
            return None
        path = self.store.object_path(language, platform, name)
        try:
            size = path.stat().st_size
        except OSError:
            return None
        if size != int(metadata['size']):
            return None
        entry = _ServingEntry(
            path,
            size,
            {
                'content_type': metadata.get('content_type'),
                'etag': metadata.get('etag'),
                'last_modified': metadata.get('last_modified'),
                'cache_control': metadata.get('cache_control'),
                'content_encoding': metadata.get('content_encoding'),
            },
        )
        with type(self)._serving_index_lock:
            type(self)._serving_index[(language, platform, name)] = entry
        return entry

    def _invalidate_entry(self, language: str, platform: str, name: str):
        with type(self)._serving_index_lock:
            type(self)._serving_index.pop((language, platform, name), None)

    def _resolve_entry(self, language: str, platform: str, name: str):
        entry = self._lookup_entry(language, platform, name)
        if entry is not None:
            return entry

        entry = self._refresh_entry(language, platform, name)
        if entry is not None:
            return entry

        if self.cache_only or self.upstream is None:
            return 404

        status = self._fetch_missing(language, platform, name)
        if status is not None:
            return status
        return self._refresh_entry(language, platform, name) or 502

    def _fetch_missing(self, language: str, platform: str, name: str):
        key = (language, platform, name)
        with type(self)._download_locks_guard:
            lock = type(self)._download_locks.setdefault(key, threading.Lock())
        with lock:
            assert self.store is not None
            if self.store.is_complete(language, platform, name):
                return None
            try:
                assert self.upstream is not None
                self.upstream.fetch(language, platform, name)
            except requests.HTTPError as exc:
                response = exc.response
                if response is not None and response.status_code == 404:
                    return 404
                logger.warning(f'Relay upstream HTTP error for {key}: {exc}')
                return 502
            except (requests.RequestException, OSError) as exc:
                logger.warning(f'Relay upstream unavailable for {key}: {exc}')
                return 502
            return None

    def _serve_path(self, request_path: str, *, send_body: bool):
        path = unquote(urlsplit(request_path).path)
        match = _PATH_RE.fullmatch(path)
        if not match:
            self.send_error(404)
            return
        language, platform, name = match.groups()
        if language not in SUPPORTED_LANGUAGES or platform not in SUPPORTED_PLATFORMS:
            self.send_error(404)
            return
        if name in {'.', '..'} or '\\' in name:
            self.send_error(404)
            return

        entry = self._resolve_entry(language, platform, name)
        if isinstance(entry, int):
            self.send_error(entry)
            return

        metadata = entry.metadata
        size = entry.size
        if _not_modified(self.headers, metadata):
            self.send_response(304)
            self._send_replayed_headers(metadata, include_encoding=False)
            self.send_header('Content-Length', '0')
            self.end_headers()
            return

        byte_range = None
        range_header = self.headers.get('Range')
        if range_header:
            byte_range = _parse_range(range_header, size)
            if byte_range is None or byte_range == 'unsatisfiable':
                self.send_response(416)
                self.send_header('Content-Range', f'bytes */{size}')
                self.send_header('Accept-Ranges', 'bytes')
                self.send_header('Content-Length', '0')
                self.end_headers()
                return

        if byte_range:
            start, end = byte_range
            content_length = end - start + 1
        else:
            start, end = 0, size - 1
            content_length = size

        file = None
        if send_body and content_length:
            try:
                file = entry.path.open('rb')
            except OSError:
                self._invalidate_entry(language, platform, name)
                self.send_error(404 if self.cache_only else 502)
                return

        try:
            if byte_range:
                self.send_response(206)
                self.send_header('Content-Range', f'bytes {start}-{end}/{size}')
            else:
                self.send_response(200)
            self._send_replayed_headers(metadata, include_encoding=True)
            self.send_header('Accept-Ranges', 'bytes')
            self.send_header('Content-Length', str(content_length))
            self.end_headers()
            if file is not None:
                self._transfer_file(file, start, content_length)
        except (BrokenPipeError, ConnectionResetError, TimeoutError):
            pass
        finally:
            if file is not None:
                file.close()

    def _transfer_file(self, file, start: int, content_length: int):
        connection = self.connection
        if not isinstance(connection, ssl.SSLSocket) and hasattr(connection, 'sendfile'):
            try:
                connection.sendfile(file, offset=start, count=content_length)
                return
            except (OSError, ValueError):
                pass

        file.seek(start)
        remaining = content_length
        buffer = bytearray(min(_STREAM_BUFFER_SIZE, max(1, remaining)))
        view = memoryview(buffer)
        while remaining:
            size = min(len(buffer), remaining)
            read = file.readinto(view[:size])
            if not read:
                break
            self.wfile.write(view[:read])
            remaining -= read

    def _send_replayed_headers(self, metadata, *, include_encoding: bool):
        self.send_header(
            'Content-Type', metadata.get('content_type') or 'application/octet-stream'
        )
        for key, field in (
            ('ETag', 'etag'),
            ('Last-Modified', 'last_modified'),
            ('Cache-Control', 'cache_control'),
        ):
            value = metadata.get(field)
            if value:
                self.send_header(key, value)
        if include_encoding and metadata.get('content_encoding'):
            self.send_header('Content-Encoding', metadata['content_encoding'])

    def log_message(self, format, *args):
        logger.debug('Asset relay: ' + format, *args)


def create_server(host: str = '', port: int = relay_port,
                  store: AssetStore | None = None,
                  *, cache_only: bool = False,
                  remote_root: str = REMOTE_ASSET_ROOT,
                  upstream_proxy: str | None = None,
                  upstream_timeout: float = 60.0):
    if store is None:
        store = AssetStore('asset-relay-cache')
    upstream = None if cache_only else RelayUpstream(
        store,
        remote_root=remote_root,
        timeout=upstream_timeout,
        upstream_proxy=upstream_proxy,
    )

    class BoundRelayHTTPRequestHandler(RelayHTTPRequestHandler):
        pass

    BoundRelayHTTPRequestHandler.store = store
    BoundRelayHTTPRequestHandler.upstream = upstream
    BoundRelayHTTPRequestHandler.cache_only = bool(cache_only)
    BoundRelayHTTPRequestHandler._download_locks_guard = threading.Lock()
    BoundRelayHTTPRequestHandler._download_locks = {}
    BoundRelayHTTPRequestHandler._serving_index_lock = threading.Lock()
    BoundRelayHTTPRequestHandler._serving_index = _load_serving_index(store)

    logger.info(
        f'Asset relay cache index: '
        f'{len(BoundRelayHTTPRequestHandler._serving_index)} objects'
    )
    return ThreadedRelayServer((host, port), BoundRelayHTTPRequestHandler)


def start(port: int = relay_port, conn=None, root: str = 'asset-relay-cache',
          *, cache_only: bool = False,
          remote_root: str = REMOTE_ASSET_ROOT,
          upstream_proxy: str | None = None,
          upstream_timeout: float = 60.0):
    store = AssetStore(root)
    httpd = create_server(
        port=port,
        store=store,
        cache_only=cache_only,
        remote_root=remote_root,
        upstream_proxy=upstream_proxy,
        upstream_timeout=upstream_timeout,
    )
    logger.info(f'Asset Relay Server is running on port {port}...')
    logger.info(f'Relay cache root: {Path(root).resolve()}')
    if cache_only:
        logger.info('Relay mode: cache-only/offline; upstream will never be contacted')
    else:
        logger.info(f'Relay upstream: {remote_root.rstrip("/")}')
        if upstream_proxy:
            logger.info(f'Relay upstream proxy: {upstream_proxy}')
    if conn:
        conn.send(True)
        conn.close()
    httpd.serve_forever()


if __name__ == '__main__':
    start()
