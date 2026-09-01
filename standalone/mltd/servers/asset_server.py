import re
from email.utils import parsedate_to_datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import unquote, urlsplit

from mltd.servers.asset_cache import (
    SUPPORTED_LANGUAGES,
    SUPPORTED_PLATFORMS,
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


class AssetHTTPRequestHandler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    store: AssetStore | None = None

    def do_HEAD(self):
        self._serve(send_body=False)

    def do_GET(self):
        self._serve(send_body=True)

    def _serve(self, *, send_body: bool):
        path = unquote(urlsplit(self.path).path)
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


def create_server(host: str = '', port: int = asset_port,
                  store: AssetStore | None = None):
    if store is None:
        store = AssetStore()

    class BoundAssetHTTPRequestHandler(AssetHTTPRequestHandler):
        pass

    BoundAssetHTTPRequestHandler.store = store
    server = ThreadingHTTPServer((host, port), BoundAssetHTTPRequestHandler)
    server.daemon_threads = True
    return server


def start(port: int = asset_port, conn=None, root: str = 'asset-cache'):
    store = AssetStore(root)
    httpd = create_server(port=port, store=store)
    logger.info(f'Asset mirror HTTP server is running on port {port}...')
    logger.info(f'Asset mirror root: {Path(root).resolve()}')
    if conn:
        conn.send(True)
        conn.close()
    httpd.serve_forever()


if __name__ == '__main__':
    start()
