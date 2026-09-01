import hashlib
import http.client
import sys
import tempfile
import threading
import types
import unittest
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from unittest.mock import Mock

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

logging_module = types.ModuleType('mltd.servers.logging')


class DummyLogger:
    def debug(self, *args, **kwargs):
        pass

    info = debug
    warning = debug
    error = debug


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers.asset_cache import AssetStore  # noqa: E402
from mltd.servers.asset_server import create_server  # noqa: E402


class AssetServingHotPathTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.store = AssetStore(self.temp.name)
        self.name = 'hot-path.data'
        self.body = (b'0123456789abcdef' * 65536)  # 1 MiB
        path = self.store.object_path('zh', 'android', self.name)
        path.write_bytes(self.body)
        self.store.put_metadata(
            'zh', 'android', self.name,
            status=200,
            size=len(self.body),
            sha256=hashlib.sha256(self.body).hexdigest(),
            headers={
                'Content-Type': 'application/octet-stream',
                'ETag': '"hot-path"',
                'Cache-Control': 'public, max-age=3600',
            },
        )
        self.server = create_server('127.0.0.1', 0, self.store)
        self.thread = threading.Thread(
            target=self.server.serve_forever, daemon=True
        )
        self.thread.start()
        self.port = self.server.server_address[1]

    def tearDown(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=2)
        self.temp.cleanup()

    def _get(self, *, range_header=None):
        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=5)
        headers = {}
        if range_header:
            headers['Range'] = range_header
        conn.request('GET', f'/zh-android/{self.name}', headers=headers)
        response = conn.getresponse()
        body = response.read()
        status = response.status
        conn.close()
        return status, body

    def test_repeated_hits_do_not_query_sqlite_metadata(self):
        # create_server() already loaded the complete serving index.  Any
        # request-time get_metadata call would prove the hot path regressed.
        self.store.get_metadata = Mock(
            side_effect=AssertionError('hot path queried SQLite metadata')
        )
        for _ in range(8):
            status, body = self._get()
            self.assertEqual(status, 200)
            self.assertEqual(body, self.body)
        self.store.get_metadata.assert_not_called()

    def test_concurrent_reads_and_ranges(self):
        def request(i):
            if i % 3 == 0:
                status, body = self._get(range_header='bytes=128-65535')
                return status == 206 and body == self.body[128:65536]
            status, body = self._get()
            return status == 200 and body == self.body

        with ThreadPoolExecutor(max_workers=32) as executor:
            results = list(executor.map(request, range(96)))
        self.assertTrue(all(results))

    def test_runtime_cache_addition_is_discovered_once(self):
        late_name = 'late.data'
        late_body = b'late-cache-object' * 1024
        path = self.store.object_path('zh', 'android', late_name)
        path.write_bytes(late_body)
        self.store.put_metadata(
            'zh', 'android', late_name,
            status=200,
            size=len(late_body),
            sha256=hashlib.sha256(late_body).hexdigest(),
            headers={'Content-Type': 'application/octet-stream'},
        )

        conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=5)
        conn.request('GET', f'/zh-android/{late_name}')
        response = conn.getresponse()
        self.assertEqual(response.status, 200)
        self.assertEqual(response.read(), late_body)
        conn.close()

        original = self.store.get_metadata
        self.store.get_metadata = Mock(
            side_effect=AssertionError('second late hit queried SQLite')
        )
        try:
            conn = http.client.HTTPConnection('127.0.0.1', self.port, timeout=5)
            conn.request('GET', f'/zh-android/{late_name}')
            response = conn.getresponse()
            self.assertEqual(response.status, 200)
            self.assertEqual(response.read(), late_body)
            conn.close()
            self.store.get_metadata.assert_not_called()
        finally:
            self.store.get_metadata = original


if __name__ == '__main__':
    unittest.main()
