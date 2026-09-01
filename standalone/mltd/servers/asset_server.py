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
    SUPPORTED_LANGUAGES,
    SUPPORTED_PLATFORMS,
    AssetMirror,
    AssetStore,
)
from mltd.servers.logging import logger

asset_port = 7651
_PATH_RE = re.compile(r'^/([a-z]{2})-(android|ios)/([^/]+)$')
_RANGE_RE = re.compile(r'^bytes=(\d*)-(\d*)$')
_STREAM_BUFFER_SIZE = 1024 * 1024
_SOCKET_TIMEOUT = 60
_REQUEST_QUEUE_SIZE = 512


class _ServingEntry(NamedTuple):
    path: Path
    size: int
    metadata: dict


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
    """Load all request-time metadata in one SQLite read at server startup.

    A complete local mirror is immutable while the server is running.  Keeping
    the small response metadata in memory removes one SQLite connection/query
    and two filesystem stat calls from every GET/HEAD request.  Hybrid cache
    misses update this index incrementally after the object is downloaded.
    """
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
        metadata = {
            'content_type': content_type,
            'etag': etag,
            'last_modified': last_modified,
            'cache_control': cache_control,
            'content_encoding': content_encoding,
        }
        index[(language, platform, name)] = _ServingEntry(
            store.root / scope / name,
            int(size),
            metadata,
        )
    return index


def _tune_client_socket(request):
    request.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    request.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
    request.settimeout(_SOCKET_TIMEOUT)


class ThreadedAssetServer(ThreadingHTTPServer):
    daemon_threads = True
    block_on_close = False
    allow_reuse_address = True
    request_queue_size = _REQUEST_QUEUE_SIZE

    def get_request(self):
        request, client_address = super().get_request()
        _tune_client_socket(request)
        return request, client_address


class AssetHTTPRequestHandler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    store: AssetStore | None = None
    mirror: AssetMirror | None = None
    fetch_on_miss = False
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
        return type(self)._serving_index.get((language, platform, name))

    def _refresh_entry(self, language: str, platform: str, name: str):
        assert self.store is not None
        metadata = self.store.get_metadata(language, platform, name)
        if metadata is None:
            return None
        entry = _ServingEntry(
            self.store.object_path(language, platform, name),
            int(metadata['size']),
            {
                'content_type': metadata.get('content_type'),
                'etag': metadata.get('etag'),
                'last_modified': metadata.get('last_modified'),
                'cache_control': metadata.get('cache_control'),
                'content_encoding': metadata.get('content_encoding'),
            },
        )
        key = (language, platform, name)
        with type(self)._serving_index_lock:
            type(self)._serving_index[key] = entry
        return entry

    def _invalidate_entry(self, language: str, platform: str, name: str):
        key = (language, platform, name)
        with type(self)._serving_index_lock:
            type(self)._serving_index.pop(key, None)

    def _resolve_entry(self, language: str, platform: str, name: str):
        entry = self._lookup_entry(language, platform, name)
        if entry is not None:
            return entry
        error_status = self._fetch_missing(language, platform, name)
        if error_status is not None:
            return error_status
        return self._refresh_entry(language, platform, name) or 404

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
                # External cache mutation is not part of the normal local hot
                # path.  In hybrid mode recover before sending headers; strict
                # local returns 404 and the next preparation pass repairs it.
                self._invalidate_entry(language, platform, name)
                error_status = self._fetch_missing(language, platform, name)
                if error_status is not None:
                    self.send_error(error_status)
                    return
                entry = self._refresh_entry(language, platform, name)
                if entry is None:
                    self.send_error(404)
                    return
                metadata = entry.metadata
                size = entry.size
                if byte_range:
                    parsed_range = _parse_range(range_header, size)
                    if not isinstance(parsed_range, tuple):
                        self.send_response(416)
                        self.send_header('Content-Range', f'bytes */{size}')
                        self.send_header('Content-Length', '0')
                        self.end_headers()
                        return
                    start, end = parsed_range
                    content_length = end - start + 1
                else:
                    start, end = 0, size - 1
                    content_length = size
                try:
                    file = entry.path.open('rb')
                except OSError:
                    self.send_error(404)
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
        """Use kernel sendfile on plaintext sockets, reusable buffers on TLS."""
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

    def _fetch_missing(self, language: str, platform: str, name: str):
        if not self.fetch_on_miss or self.mirror is None:
            return 404

        key = (language, platform, name)
        with self._download_locks_guard:
            # Keep one lock per object for the lifetime of the bound handler.
            # Removing an unlocked lock is racy because a waiter may already
            # hold a reference while a third request creates a second lock.
            lock = self._download_locks.setdefault(key, threading.Lock())
        with lock:
            assert self.store is not None
            if self.store.is_complete(language, platform, name):
                return None
            try:
                self.mirror.download(language, platform, name)
            except requests.HTTPError as exc:
                response = exc.response
                if response is not None and response.status_code == 404:
                    return 404
                logger.warning(
                    f'Asset upstream HTTP error for {key}: {exc}'
                )
                return 502
            except (requests.RequestException, OSError) as exc:
                logger.warning(f'Asset upstream error for {key}: {exc}')
                return 502
            return None

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
        logger.debug('Asset server: ' + format, *args)


def bind_asset_handler(handler_class, store: AssetStore,
                       mirror: AssetMirror | None = None,
                       fetch_on_miss: bool = False):
    handler_class.store = store
    handler_class.mirror = mirror
    handler_class.fetch_on_miss = fetch_on_miss
    handler_class._download_locks_guard = threading.Lock()
    handler_class._download_locks = {}
    handler_class._serving_index_lock = threading.Lock()
    handler_class._serving_index = _load_serving_index(store)
    logger.info(
        f'Asset serving index: {len(handler_class._serving_index)} objects '
        '(request hot path does not query SQLite)'
    )
    return handler_class


def create_server(host: str = '', port: int = asset_port,
                  store: AssetStore | None = None,
                  mirror: AssetMirror | None = None,
                  fetch_on_miss: bool = False):
    if store is None:
        store = AssetStore()
    if fetch_on_miss and mirror is None:
        mirror = AssetMirror(store)

    class BoundAssetHTTPRequestHandler(AssetHTTPRequestHandler):
        pass

    bind_asset_handler(
        BoundAssetHTTPRequestHandler,
        store,
        mirror,
        fetch_on_miss,
    )
    return ThreadedAssetServer((host, port), BoundAssetHTTPRequestHandler)


def start(port: int = asset_port, conn=None, root: str | None = None,
          fetch_on_miss: bool | None = None):
    from mltd.servers.config import config

    if root is None:
        root = config.asset_cache_root
    if config.asset_mode == 'local':
        from mltd.servers.asset_prepare import prepare_local_assets
        prepare_local_assets(
            config.language,
            root,
            workers=config.asset_prefetch_workers,
            upstream_proxy=config.asset_upstream_proxy,
        )
    if fetch_on_miss is None:
        fetch_on_miss = config.asset_mode == 'hybrid'
    store = AssetStore(root)
    mirror = AssetMirror(
        store,
        upstream_proxy=config.asset_upstream_proxy,
    ) if fetch_on_miss else None
    httpd = create_server(
        port=port,
        store=store,
        mirror=mirror,
        fetch_on_miss=fetch_on_miss,
    )
    logger.info(f'Asset mirror HTTP server is running on port {port}...')
    logger.info(f'Asset mirror root: {Path(root).resolve()}')
    logger.info(
        'Asset cache misses: '
        + ('fetch from remote' if fetch_on_miss else 'return 404')
    )
    if config.asset_upstream_proxy:
        logger.info(f'Asset upstream proxy: {config.asset_upstream_proxy}')
    if conn:
        conn.send(True)
        conn.close()
    httpd.serve_forever()


if __name__ == '__main__':
    start()
