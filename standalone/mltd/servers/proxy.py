import io
import socket
import sys
import threading
import traceback
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from os import path
from ssl import PROTOCOL_TLS_SERVER, SSLContext
from urllib.parse import unquote, urlsplit

import requests
import urllib3

from mltd.servers.config import api_port, config
from mltd.servers.logging import logger

proxy_port = 443
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
_API_COMPAT_LOCK = threading.Lock()
_REQUEST_QUEUE_SIZE = 512
_SOCKET_TIMEOUT = 60

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


def _tune_client_socket(request):
    request.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    request.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
    request.settimeout(_SOCKET_TIMEOUT)


class ThreadedProxyServer(ThreadingHTTPServer):
    daemon_threads = True
    block_on_close = False
    allow_reuse_address = True
    request_queue_size = _REQUEST_QUEUE_SIZE

    def get_request(self):
        request, client_address = super().get_request()
        _tune_client_socket(request)
        return request, client_address


class ProxyHTTPRequestHandler(BaseHTTPRequestHandler):
    protocol_version = 'HTTP/1.1'
    api_application = None

    def do_HEAD(self):
        self.send_error(404)

    def do_GET(self):
        self.send_error(404)

    def do_POST(self):
        # Preserve the original corrected-client API behavior while Asset
        # traffic is fully remote and no longer shares this process/listener.
        self.close_connection = True

        with _API_COMPAT_LOCK:
            content_len = int(self.headers.get('Content-Length', '0'))
            req_body = self.rfile.read(content_len)
            if type(self).api_application is not None:
                self._dispatch_wsgi(req_body)
            else:
                self._forward_to_local_api(req_body)

    def _dispatch_wsgi(self, req_body: bytes):
        application = type(self).api_application
        if application is None:
            self.send_error(503)
            return
        parsed = urlsplit(self.path)
        environ = {
            'REQUEST_METHOD': 'POST',
            'SCRIPT_NAME': '',
            'PATH_INFO': unquote(parsed.path),
            'QUERY_STRING': parsed.query,
            'SERVER_NAME': self.server.server_address[0] or '0.0.0.0',
            'SERVER_PORT': str(self.server.server_address[1]),
            'SERVER_PROTOCOL': self.request_version,
            'REMOTE_ADDR': self.client_address[0],
            'CONTENT_LENGTH': str(len(req_body)),
            'wsgi.version': (1, 0),
            'wsgi.url_scheme': 'https',
            'wsgi.input': io.BytesIO(req_body),
            'wsgi.errors': sys.stderr,
            'wsgi.multithread': False,
            'wsgi.multiprocess': True,
            'wsgi.run_once': False,
        }
        for header, value in self.headers.items():
            normalized = header.upper().replace('-', '_')
            if normalized == 'CONTENT_TYPE':
                environ['CONTENT_TYPE'] = value
            elif normalized == 'CONTENT_LENGTH':
                continue
            else:
                environ[f'HTTP_{normalized}'] = value

        response_status = []
        response_headers = []
        written = []

        def start_response(status, headers, exc_info=None):
            if exc_info is not None and response_status:
                raise exc_info[1].with_traceback(exc_info[2])
            response_status[:] = [status]
            response_headers[:] = list(headers)

            def write(data):
                written.append(data)

            return write

        result = None
        try:
            result = application(environ, start_response)
            chunks = written + list(result)
            content = b''.join(chunks)
            if not response_status:
                raise RuntimeError('WSGI application did not call start_response')
            status_code = int(response_status[0].split(' ', 1)[0])
            self._send_response(status_code, response_headers, content)
        except Exception:
            logger.error('Direct API dispatch failed:\n' + traceback.format_exc())
            if not self.wfile.closed:
                try:
                    self.send_error(500)
                except (BrokenPipeError, ConnectionResetError):
                    pass
        finally:
            if result is not None and hasattr(result, 'close'):
                result.close()

    def _forward_to_local_api(self, req_body: bytes):
        host = f'127.0.0.1:{api_port}'
        url = f'http://{host}{self.path}'
        headers = {
            key: value
            for key, value in self.headers.items()
            if key.lower() not in _HOP_BY_HOP_HEADERS
        }
        resp = None
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
            self._send_response(resp.status_code, resp.headers.items(), content)
        except requests.RequestException as exc:
            logger.error(f'Local API proxy request failed: {exc}')
            self.send_error(502)
        finally:
            if resp is not None:
                resp.close()

    def _send_response(self, status_code, headers, content: bytes):
        try:
            self.send_response(status_code)
            has_content_length = False
            for header, value in headers:
                lower = header.lower()
                if lower in _HOP_BY_HOP_HEADERS or lower in {'server', 'date'}:
                    continue
                if lower == 'content-length':
                    has_content_length = True
                self.send_header(header, value)
            if not has_content_length:
                self.send_header('Content-Length', str(len(content)))
            if self.close_connection:
                self.send_header('Connection', 'close')
            self.end_headers()
            if content:
                self.wfile.write(content)
        except (BrokenPipeError, ConnectionResetError):
            pass

    def send_error(self, code, message=None, explain=None):
        if code in {404, 500, 502, 503}:
            logger.warning(
                'Client API HTTP error: '
                f'status={code} method={self.command} '
                f'host={self.headers.get("Host", "")} path={self.path}'
            )
        super().send_error(code, message, explain)

    def log_message(self, format, *args):
        pass


def key_path():
    base_path = getattr(sys, '_MEIPASS', path.abspath('..'))
    return path.join(base_path, 'key')


def start(port=proxy_port, conn=None):
    from mltd.servers.handler import application

    ProxyHTTPRequestHandler.api_application = application

    httpd = ThreadedProxyServer(('', port), ProxyHTTPRequestHandler)
    certfile = path.join(key_path(), 'api.crt')
    keyfile = path.join(key_path(), 'api.key')
    context = SSLContext(PROTOCOL_TLS_SERVER)
    context.load_cert_chain(certfile, keyfile)

    # Preserve the v0.1.6 TLS accept path for corrected game-client
    # compatibility. The listener itself is SSL-wrapped before serve_forever.
    httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

    logger.info(f'TLS API server is running on port {port}...')
    logger.info('TLS handshakes: listener-wrapped compatibility mode')
    logger.info(
        'API dispatch: direct WSGI, serialized Connection: close compatibility'
    )
    if config.asset_remote_url:
        logger.info(f'Asset transport: remote relay {config.asset_remote_url}')
    else:
        logger.info('Asset transport: Rainbow remote CDN')
    if conn:
        conn.send(True)
        conn.close()
    httpd.serve_forever()


if __name__ == '__main__':
    start()
