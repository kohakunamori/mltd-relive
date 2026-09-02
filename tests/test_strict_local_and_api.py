import http.client
import sys
import threading
import types
import unittest
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

logging_module = types.ModuleType('mltd.servers.logging')


class DummyLogger:
    def debug(self, *args, **kwargs):
        pass

    info = debug
    warning = debug
    error = debug

    def isEnabledFor(self, level):
        return False


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers import proxy  # noqa: E402


class FakeAPIHandler(BaseHTTPRequestHandler):
    calls = 0

    def do_POST(self):
        type(self).calls += 1
        length = int(self.headers.get('Content-Length', '0'))
        self.rfile.read(length)
        body = b'fallback-api'
        self.send_response(200)
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass


class DirectWSGIDispatchTest(unittest.TestCase):
    def setUp(self):
        FakeAPIHandler.calls = 0
        self.api = ThreadingHTTPServer(('127.0.0.1', 0), FakeAPIHandler)
        self.api_thread = threading.Thread(
            target=self.api.serve_forever, daemon=True
        )
        self.api_thread.start()
        self.old_api_port = proxy.api_port
        proxy.api_port = self.api.server_address[1]

        def application(environ, start_response):
            body = b'direct-wsgi'
            start_response(
                '200 OK', [('Content-Type', 'application/octet-stream')]
            )
            return [body]

        proxy.ProxyHTTPRequestHandler.api_application = application
        self.server = proxy.ThreadedProxyServer(
            ('127.0.0.1', 0), proxy.ProxyHTTPRequestHandler
        )
        self.thread = threading.Thread(
            target=self.server.serve_forever, daemon=True
        )
        self.thread.start()
        self.port = self.server.server_address[1]

    def tearDown(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=2)
        self.api.shutdown()
        self.api.server_close()
        self.api_thread.join(timeout=2)
        proxy.ProxyHTTPRequestHandler.api_application = None
        proxy.api_port = self.old_api_port

    def test_direct_wsgi_bypasses_local_http_api_and_closes_api_connection(self):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        headers = {
            'Content-Length': '1',
            'Host': 'theaterdays-zh.appspot.com',
        }

        conn.request('POST', '/api', body=b'a', headers=headers)
        first = conn.getresponse()
        self.assertEqual(first.getheader('Connection'), 'close')
        self.assertEqual(first.read(), b'direct-wsgi')

        conn.request('POST', '/api', body=b'b', headers=headers)
        second = conn.getresponse()
        self.assertEqual(second.getheader('Connection'), 'close')
        self.assertEqual(second.read(), b'direct-wsgi')
        self.assertEqual(FakeAPIHandler.calls, 0)
        conn.close()


if __name__ == '__main__':
    unittest.main()
