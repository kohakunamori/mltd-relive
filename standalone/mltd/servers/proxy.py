import sys
import threading
from http.server import ThreadingHTTPServer
from os import path
from ssl import PROTOCOL_TLS_SERVER, SSLContext
from urllib.parse import urlsplit

import requests
import urllib3

from mltd.servers.asset_cache import AssetMirror, AssetStore
from mltd.servers.asset_server import AssetHTTPRequestHandler, bind_asset_handler
from mltd.servers.config import api_port, config
from mltd.servers.logging import logger

proxy_port = 443
_ASSET_PREFIX = '/__mltd_assets'
_HOP_BY_HOP_HEADERS = {
    'connection',
    'keep-alive',
    'proxy-authenticate',
    'proxy-authorization',
    'proxy-connection',
    'te',
    'trailer',
    'transfer-encoding',
    'upgrade',
}
_thread_local = threading.local()

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def _upstream_session():
    session = getattr(_thread_local, 'session', None)
    if session is None:
        session = requests.Session()
        adapter = requests.adapters.HTTPAdapter(
            pool_connections=2,
            pool_maxsize=4,
            max_retries=0,
        )
        session.mount('http://', adapter)
        _thread_local.session = session
    return session


class ProxyHTTPRequestHandler(AssetHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'

    def do_HEAD(self):
        asset_path = self._asset_path()
        if asset_path is None:
            self.send_error(404)
            return
        self._serve_path(asset_path, send_body=False)

    def do_GET(self):
        asset_path = self._asset_path()
        if asset_path is None:
            self.send_error(404)
            return
        self._serve_path(asset_path, send_body=True)

    def _asset_path(self):
        request_path = urlsplit(self.path).path
        if request_path == _ASSET_PREFIX:
            return '/'
        if request_path.startswith(_ASSET_PREFIX + '/'):
            return request_path[len(_ASSET_PREFIX):]
        return None

    def do_POST(self):
        host = f'127.0.0.1:{api_port}'
        url = f'http://{host}{self.path}'
        content_len = int(self.headers.get('Content-Length', '0'))
        req_body = self.rfile.read(content_len)

        headers = {
            key: value
            for key, value in self.headers.items()
            if key.lower() not in _HOP_BY_HOP_HEADERS
        }
        try:
            resp = _upstream_session().post(
                url,
                headers=headers,
                data=req_body,
                stream=True,
                verify=False,
                timeout=(5, 120),
            )
            content = resp.raw.read(decode_content=False)
        except requests.RequestException as exc:
            logger.error(f'Local API proxy request failed: {exc}')
            self.send_error(502)
            return

        try:
            self.send_response(resp.status_code)
            has_content_length = False
            for header, value in resp.headers.items():
                lower = header.lower()
                if lower in _HOP_BY_HOP_HEADERS or lower in {'server', 'date'}:
                    continue
                if lower == 'content-length':
                    has_content_length = True
                self.send_header(header, value)
            if not has_content_length:
                self.send_header('Content-Length', str(len(content)))
            self.end_headers()
            if content:
                self.wfile.write(content)
        except (BrokenPipeError, ConnectionResetError):
            pass
        finally:
            resp.close()

    def log_message(self, format, *args):
        # Disable stderr output
        pass


def key_path():
    base_path = getattr(sys, '_MEIPASS', path.abspath('..'))
    return path.join(base_path, 'key')


def start(port=proxy_port, conn=None):
    store = AssetStore(config.asset_cache_root)
    fetch_on_miss = config.asset_mode == 'hybrid'
    mirror = AssetMirror(store) if fetch_on_miss else None
    bind_asset_handler(
        ProxyHTTPRequestHandler,
        store,
        mirror=mirror,
        fetch_on_miss=fetch_on_miss,
    )

    server_address = ('', port)
    httpd = ThreadingHTTPServer(server_address, ProxyHTTPRequestHandler)
    httpd.daemon_threads = True
    certfile = path.join(key_path(), 'api.crt')
    keyfile = path.join(key_path(), 'api.key')
    context = SSLContext(PROTOCOL_TLS_SERVER)
    context.load_cert_chain(certfile, keyfile)
    httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

    logger.info(f'Reverse proxy is running on port {port}...')
    logger.info(f'Asset mode: {config.asset_mode}')
    if conn:
        conn.send(True)
        conn.close()
    httpd.serve_forever()


if __name__ == '__main__':
    start()
