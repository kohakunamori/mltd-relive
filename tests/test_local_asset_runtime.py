import http.client
import sys
import tempfile
import threading
import types
import unittest
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

# Keep transport tests independent from the application's rotating log files.
logging_module = types.ModuleType('mltd.servers.logging')


class DummyLogger:
    def debug(self, *args, **kwargs):
        pass

    info = debug
    warning = debug
    error = debug


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers.asset_cache import AssetMirror, AssetStore  # noqa: E402
from mltd.servers.asset_server import create_server  # noqa: E402
from mltd.servers import proxy  # noqa: E402


class FakeAssetUpstreamHandler(BaseHTTPRequestHandler):
    body = b'UnityFS-test-asset-' * 256
    requests = 0

    def do_GET(self):
        type(self).requests += 1
        if self.path != '/zh-android/sample.unity3d':
            self.send_error(404)
            return
        self.send_response(200)
        self.send_header('Content-Type', 'application/octet-stream')
        self.send_header('Content-Length', str(len(self.body)))
        self.send_header('ETag', '"sample-etag"')
        self.send_header('Cache-Control', 'public, max-age=3600')
        self.end_headers()
        self.wfile.write(self.body)

    def log_message(self, format, *args):
        pass


class FakeAPIHandler(BaseHTTPRequestHandler):
    calls = 0

    def do_POST(self):
        type(self).calls += 1
        length = int(self.headers.get('Content-Length', '0'))
        self.rfile.read(length)
        body = b'api-ok'
        self.send_response(200)
        self.send_header('Content-Type', 'application/octet-stream')
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass


class HybridAssetTest(unittest.TestCase):
    def setUp(self):
        FakeAssetUpstreamHandler.requests = 0
        self.upstream = ThreadingHTTPServer(
            ('127.0.0.1', 0), FakeAssetUpstreamHandler
        )
        self.upstream_thread = threading.Thread(
            target=self.upstream.serve_forever, daemon=True
        )
        self.upstream_thread.start()

        self.temp = tempfile.TemporaryDirectory()
        self.store = AssetStore(self.temp.name)
        remote_root = f'http://127.0.0.1:{self.upstream.server_address[1]}'
        self.mirror = AssetMirror(self.store, remote_root=remote_root, timeout=3)
        self.server = create_server(
            '127.0.0.1',
            0,
            self.store,
            mirror=self.mirror,
            fetch_on_miss=True,
        )
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)
        self.thread.start()
        self.port = self.server.server_address[1]

    def tearDown(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=2)
        if self.upstream:
            self.upstream.shutdown()
            self.upstream.server_close()
            self.upstream_thread.join(timeout=2)
        self.temp.cleanup()

    def request(self, path, headers=None):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        conn.request('GET', path, headers=headers or {})
        response = conn.getresponse()
        body = response.read()
        result = response.status, dict(response.getheaders()), body
        conn.close()
        return result

    def test_hybrid_miss_fetches_then_survives_upstream_shutdown(self):
        path = '/zh-android/sample.unity3d'
        status, headers, body = self.request(path)
        self.assertEqual(status, 200)
        self.assertEqual(body, FakeAssetUpstreamHandler.body)
        self.assertEqual(headers.get('ETag'), '"sample-etag"')
        self.assertEqual(FakeAssetUpstreamHandler.requests, 1)
        self.assertTrue(self.store.is_complete('zh', 'android', 'sample.unity3d'))
        self.assertTrue(self.store.verify('zh', 'android', 'sample.unity3d'))

        self.upstream.shutdown()
        self.upstream.server_close()
        self.upstream_thread.join(timeout=2)
        self.upstream = None

        status, headers, body = self.request(
            path, headers={'Range': 'bytes=2-31'}
        )
        self.assertEqual(status, 206)
        self.assertEqual(body, FakeAssetUpstreamHandler.body[2:32])
        self.assertEqual(headers.get('Content-Range'),
                         f'bytes 2-31/{len(FakeAssetUpstreamHandler.body)}')

    def test_hybrid_preserves_upstream_404(self):
        status, _, _ = self.request('/zh-android/missing.unity3d')
        self.assertEqual(status, 404)


class ProxyTransportTest(unittest.TestCase):
    def setUp(self):
        FakeAPIHandler.calls = 0
        self.api = ThreadingHTTPServer(('127.0.0.1', 0), FakeAPIHandler)
        self.api_thread = threading.Thread(target=self.api.serve_forever, daemon=True)
        self.api_thread.start()
        self.old_api_port = proxy.api_port
        proxy.api_port = self.api.server_address[1]

        self.server = ThreadingHTTPServer(
            ('127.0.0.1', 0), proxy.ProxyHTTPRequestHandler
        )
        self.server.daemon_threads = True
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)
        self.thread.start()
        self.port = self.server.server_address[1]

    def tearDown(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=2)
        self.api.shutdown()
        self.api.server_close()
        self.api_thread.join(timeout=2)
        proxy.api_port = self.old_api_port

    def test_api_listener_no_longer_serves_asset_gets(self):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        conn.request('GET', '/zh-android/sample.unity3d')
        response = conn.getresponse()
        response.read()
        self.assertEqual(response.status, 404)
        conn.close()

    def test_post_connection_is_closed_for_client_compatibility(self):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        headers = {
            'Content-Length': '1',
            'Host': 'theaterdays-zh.appspot.com',
        }
        conn.request('POST', '/api', body=b'a', headers=headers)
        first = conn.getresponse()
        self.assertEqual(first.read(), b'api-ok')
        self.assertEqual((first.getheader('Connection') or '').lower(), 'close')

        # The HTTPConnection object transparently reconnects; the server must
        # not keep the previous API socket alive.
        conn.request('POST', '/api', body=b'b', headers=headers)
        second = conn.getresponse()
        self.assertEqual(second.read(), b'api-ok')
        self.assertEqual((second.getheader('Connection') or '').lower(), 'close')
        self.assertEqual(FakeAPIHandler.calls, 2)
        conn.close()


if __name__ == '__main__':
    unittest.main()
