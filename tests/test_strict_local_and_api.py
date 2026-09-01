import hashlib
import http.client
import sys
import tempfile
import threading
import types
import unittest
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

from msgpack import packb

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

from mltd.servers.asset_cache import AssetStore, manifest_name  # noqa: E402
from mltd.servers.asset_prepare import prepare_local_assets  # noqa: E402
from mltd.servers.asset_server import create_server  # noqa: E402
from mltd.servers import proxy  # noqa: E402


class FakeCompleteAssetUpstream(BaseHTTPRequestHandler):
    asset_body = b'complete-local-asset' * 128

    def do_GET(self):
        parts = self.path.strip('/').split('/')
        if len(parts) != 2:
            self.send_error(404)
            return
        scope, name = parts
        if scope not in {'zh-android', 'zh-ios'}:
            self.send_error(404)
            return
        if name == manifest_name('zh'):
            body = packb([
                {
                    'logical-a': [0, 'a.unity3d'],
                    'logical-b': [0, 'b.unity3d'],
                }
            ], use_bin_type=True)
        elif name in {'a.unity3d', 'b.unity3d'}:
            body = self.asset_body + scope.encode() + name.encode()
        else:
            self.send_error(404)
            return
        self.send_response(200)
        self.send_header('Content-Type', 'application/octet-stream')
        self.send_header('Content-Length', str(len(body)))
        self.send_header('ETag', f'"{scope}-{name}"')
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass


class StrictLocalPrefetchTest(unittest.TestCase):
    def test_local_prefetch_completes_both_platforms(self):
        upstream = ThreadingHTTPServer(
            ('127.0.0.1', 0), FakeCompleteAssetUpstream
        )
        thread = threading.Thread(target=upstream.serve_forever, daemon=True)
        thread.start()
        try:
            with tempfile.TemporaryDirectory() as temp:
                remote = f'http://127.0.0.1:{upstream.server_address[1]}'
                result = prepare_local_assets(
                    'zh',
                    temp,
                    platforms=('android', 'ios'),
                    workers=2,
                    remote_root=remote,
                )
                store = AssetStore(temp)
                self.assertEqual(result['android']['complete'], 2)
                self.assertEqual(result['ios']['complete'], 2)
                for platform in ('android', 'ios'):
                    for name in ('a.unity3d', 'b.unity3d'):
                        self.assertTrue(store.is_complete('zh', platform, name))
                        self.assertTrue(store.verify('zh', platform, name))
        finally:
            upstream.shutdown()
            upstream.server_close()
            thread.join(timeout=2)


class AssetHTTPProxyTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.store = AssetStore(self.temp.name)
        self.name = 'proxy-object.unity3d'
        self.body = b'http-proxy-cache' * 64
        path = self.store.object_path('zh', 'android', self.name)
        path.write_bytes(self.body)
        self.store.put_metadata(
            'zh', 'android', self.name,
            status=200,
            size=len(self.body),
            sha256=hashlib.sha256(self.body).hexdigest(),
            headers={'Content-Type': 'application/octet-stream'},
        )
        self.server = create_server('127.0.0.1', 0, self.store)
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)
        self.thread.start()
        self.port = self.server.server_address[1]

    def tearDown(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=2)
        self.temp.cleanup()

    def request(self, method, target):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        conn.request(method, target)
        response = conn.getresponse()
        body = response.read()
        status = response.status
        conn.close()
        return status, body

    def test_absolute_form_asset_proxy_uses_local_cache(self):
        target = (
            'http://assets.rainbowunicorn7297.com/'
            f'zh-android/{self.name}'
        )
        status, body = self.request('GET', target)
        self.assertEqual(status, 200)
        self.assertEqual(body, self.body)

    def test_absolute_form_rejects_other_hosts(self):
        status, _ = self.request(
            'GET', 'http://example.com/zh-android/proxy-object.unity3d'
        )
        self.assertEqual(status, 403)

    def test_connect_is_disabled_for_strict_local_server(self):
        status, _ = self.request(
            'CONNECT', 'assets.rainbowunicorn7297.com:443'
        )
        self.assertEqual(status, 403)


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
        self.api_thread = threading.Thread(target=self.api.serve_forever, daemon=True)
        self.api_thread.start()
        self.old_api_port = proxy.api_port
        proxy.api_port = self.api.server_address[1]

        def application(environ, start_response):
            body = b'direct-wsgi'
            start_response('200 OK', [('Content-Type', 'application/octet-stream')])
            return [body]

        proxy.ProxyHTTPRequestHandler.api_application = application
        self.temp = tempfile.TemporaryDirectory()
        store = AssetStore(self.temp.name)
        self.server = proxy.ThreadedProxyServer(
            ('127.0.0.1', 0), proxy.ProxyHTTPRequestHandler
        )
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
        proxy.ProxyHTTPRequestHandler.api_application = None
        proxy.api_port = self.old_api_port
        self.temp.cleanup()

    def test_direct_wsgi_bypasses_local_http_api_and_keeps_connection(self):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        headers = {'Content-Length': '1', 'Host': 'theaterdays-zh.appspot.com'}
        conn.request('POST', '/api', body=b'a', headers=headers)
        first = conn.getresponse()
        self.assertEqual(first.read(), b'direct-wsgi')
        first_socket = conn.sock
        self.assertIsNotNone(first_socket)

        conn.request('POST', '/api', body=b'b', headers=headers)
        second = conn.getresponse()
        self.assertEqual(second.read(), b'direct-wsgi')
        self.assertIs(conn.sock, first_socket)
        self.assertEqual(FakeAPIHandler.calls, 0)
        conn.close()


if __name__ == '__main__':
    unittest.main()
