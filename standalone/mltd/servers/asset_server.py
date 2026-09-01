import re
import socket
import threading
from email.utils import parsedate_to_datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
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


class ThreadedAssetServer(ThreadingHTTPServer):
    daemon_threads = True
    allow_reuse_address = True
    request_queue_size = 64

    def get_request(self):
        request, client_address = super().get_request()
        request.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        return request, client_address


class AssetHTTPRequestHandler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    store: AssetStore | None = None
    mirror: AssetMirror | None = None
    fetch_on_miss = False
    _download_locks_guard = threading.Lock()
    _download_locks = {}

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

        assert self.store is not None
        object_path = self.store.object_path(language, platform, name)
        if not object_path.is_file():
            error_status = self._fetch_missing(language, platform, name)
            if error_status is not None:
                self.send_error(error_status)
                return
            object_path = self.store.object_path(language, platform, name)
            if not object_path.is_file():
                self.send_error(404)
                return

        metadata = self.store.get_metadata(language, platform, name) or {}
        size = object_path.stat().st_size

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
            self.send_response(206)
            self.send_header('Content-Range', f'bytes {start}-{end}/{size}')
        else:
            start, end = 0, size - 1
            content_length = size
            self.send_response(200)

        self._send_replayed_headers(metadata, include_encoding=True)
        self.send_header('Accept-Ranges', 'bytes')
        self.send_header('Content-Length', str(content_length))
        self.end_headers()

        if not send_body or content_length == 0:
            return
        try:
            with object_path.open('rb') as file:
                file.seek(start)
                remaining = content_length
                while remaining:
                    chunk = file.read(min(1024 * 1024, remaining))
                    if not chunk:
                        break
                    self.wfile.write(chunk)
                    remaining -= len(chunk)
        except (BrokenPipeError, ConnectionResetError):
            pass

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
