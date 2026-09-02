import http.client
import sys
import threading
import time
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers import proxy  # noqa: E402


class APIConcurrencyCompatibilityTest(unittest.TestCase):
    def setUp(self):
        self.state_lock = threading.Lock()
        self.active = 0
        self.max_active = 0
        self.entered = threading.Barrier(2)

        def application(environ, start_response):
            with self.state_lock:
                self.active += 1
                self.max_active = max(self.max_active, self.active)
            try:
                time.sleep(0.08)
                body = b'ok'
                start_response(
                    '200 OK',
                    [('Content-Type', 'application/octet-stream')],
                )
                return [body]
            finally:
                with self.state_lock:
                    self.active -= 1

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
        proxy.ProxyHTTPRequestHandler.api_application = None

    def _post(self, results, index):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        self.entered.wait(timeout=2)
        conn.request(
            'POST',
            '/api',
            body=b'x',
            headers={
                'Content-Length': '1',
                'Host': 'theaterdays-zh.appspot.com',
            },
        )
        response = conn.getresponse()
        results[index] = (
            response.status,
            response.getheader('Connection'),
            response.read(),
        )
        conn.close()

    def test_concurrent_api_posts_can_overlap_wsgi_dispatch(self):
        results = [None, None]
        workers = [
            threading.Thread(target=self._post, args=(results, i))
            for i in range(2)
        ]
        for worker in workers:
            worker.start()
        for worker in workers:
            worker.join(timeout=3)
            self.assertFalse(worker.is_alive())

        self.assertGreaterEqual(self.max_active, 2)
        for result in results:
            self.assertEqual(result, (200, None, b'ok'))


if __name__ == '__main__':
    unittest.main()
