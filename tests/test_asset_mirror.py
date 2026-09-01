import hashlib
import http.client
import sys
import tempfile
import threading
import types
import unittest
from pathlib import Path

from msgpack import packb

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

# Avoid importing the project's logging configuration in this isolated test.
logging_module = types.ModuleType('mltd.servers.logging')


class DummyLogger:
    def debug(self, *args, **kwargs):
        pass

    info = debug


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers.asset_cache import AssetStore, parse_manifest_objects  # noqa: E402
from mltd.servers.asset_server import create_server  # noqa: E402


class AssetManifestTest(unittest.TestCase):
    def test_parse_manifest_objects_matches_prototype_shape(self):
        packed = packb([
            {
                'logical/a': [123, 'aaa.data', 1],
                'logical/b': [456, 'bbb.data', 2],
                'logical/duplicate': [789, 'aaa.data', 3],
            }
        ], use_bin_type=True)
        self.assertEqual(parse_manifest_objects(packed), ['aaa.data', 'bbb.data'])


class AssetServerTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.store = AssetStore(self.temp.name)
        self.body = bytes(range(256)) * 8
        self.name = '0123456789abcdef.data'
        path = self.store.object_path('zh', 'android', self.name)
        path.write_bytes(self.body)
        self.store.put_metadata(
            'zh', 'android', self.name,
            status=200,
            size=len(self.body),
            sha256=hashlib.sha256(self.body).hexdigest(),
            headers={
                'Content-Type': 'application/octet-stream',
                'ETag': '"test-etag"',
                'Last-Modified': 'Tue, 01 Sep 2026 00:00:00 GMT',
                'Cache-Control': 'public, max-age=3600',
            },
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

    def request(self, method='GET', headers=None, path=None):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=3)
        conn.request(method, path or f'/zh-android/{self.name}', headers=headers or {})
        response = conn.getresponse()
        body = response.read()
        response_headers = dict(response.getheaders())
        status = response.status
        conn.close()
        return status, response_headers, body

    def test_full_get_and_replayed_headers(self):
        status, headers, body = self.request()
        self.assertEqual(status, 200)
        self.assertEqual(body, self.body)
        self.assertEqual(headers['ETag'], '"test-etag"')
        self.assertEqual(headers['Cache-Control'], 'public, max-age=3600')
        self.assertEqual(headers['Accept-Ranges'], 'bytes')
        self.assertEqual(int(headers['Content-Length']), len(self.body))

    def test_head_has_no_body(self):
        status, headers, body = self.request(method='HEAD')
        self.assertEqual(status, 200)
        self.assertEqual(body, b'')
        self.assertEqual(int(headers['Content-Length']), len(self.body))

    def test_range_request(self):
        status, headers, body = self.request(headers={'Range': 'bytes=10-19'})
        self.assertEqual(status, 206)
        self.assertEqual(body, self.body[10:20])
        self.assertEqual(headers['Content-Range'], f'bytes 10-19/{len(self.body)}')
        self.assertEqual(headers['Content-Length'], '10')

    def test_suffix_range_request(self):
        status, headers, body = self.request(headers={'Range': 'bytes=-16'})
        self.assertEqual(status, 206)
        self.assertEqual(body, self.body[-16:])

    def test_unsatisfiable_range(self):
        status, headers, body = self.request(
            headers={'Range': f'bytes={len(self.body) + 1}-'}
        )
        self.assertEqual(status, 416)
        self.assertEqual(body, b'')
        self.assertEqual(headers['Content-Range'], f'bytes */{len(self.body)}')

    def test_if_none_match(self):
        status, headers, body = self.request(headers={'If-None-Match': '"test-etag"'})
        self.assertEqual(status, 304)
        self.assertEqual(body, b'')

    def test_unknown_object_is_404(self):
        status, _, _ = self.request(path='/zh-android/not-found.data')
        self.assertEqual(status, 404)

    def test_path_shape_is_strict(self):
        status, _, _ = self.request(path='/zh-android/subdir/file.data')
        self.assertEqual(status, 404)


if __name__ == '__main__':
    unittest.main()
