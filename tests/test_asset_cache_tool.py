import importlib.util
import sys
import tempfile
import threading
import unittest
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

from msgpack import packb

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import (  # noqa: E402
    AssetStore,
    manifest_name,
    parse_manifest_objects,
)

TOOL_PATH = REPO_ROOT / 'tools' / 'cache_assets.py'
SPEC = importlib.util.spec_from_file_location('cache_assets_tool', TOOL_PATH)
cache_assets = importlib.util.module_from_spec(SPEC)
assert SPEC.loader is not None
sys.modules[SPEC.name] = cache_assets
SPEC.loader.exec_module(cache_assets)


class FakeR2Handler(BaseHTTPRequestHandler):
    objects = {
        'a.unity3d': b'UnityFS-a' * 2048,
        'b.unity3d': b'UnityFS-b' * 4096,
    }
    requests = 0

    def do_GET(self):
        type(self).requests += 1
        prefix = '/zh-android/'
        if not self.path.startswith(prefix):
            self.send_error(404)
            return
        name = self.path[len(prefix):]
        if name == manifest_name('zh'):
            body = packb([
                {
                    'logical-a': [0, 'a.unity3d'],
                    'logical-b': [0, 'b.unity3d'],
                }
            ], use_bin_type=True)
        elif name in self.objects:
            body = self.objects[name]
        else:
            self.send_error(404)
            return

        self.send_response(200)
        self.send_header('Content-Type', 'application/octet-stream')
        self.send_header('Content-Length', str(len(body)))
        self.send_header('ETag', f'"{name}"')
        self.send_header('Cache-Control', 'public, max-age=3600')
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass


class AssetCachePreservationTest(unittest.TestCase):
    def test_cache_survives_complete_upstream_loss(self):
        FakeR2Handler.requests = 0
        upstream = ThreadingHTTPServer(('127.0.0.1', 0), FakeR2Handler)
        thread = threading.Thread(target=upstream.serve_forever, daemon=True)
        thread.start()

        with tempfile.TemporaryDirectory() as temp:
            store = AssetStore(temp)
            client = cache_assets.AssetCacheClient(
                store,
                remote_root=f'http://127.0.0.1:{upstream.server_address[1]}',
                timeout=3,
            )
            result = client.sync_scope(
                'zh-android',
                workers=2,
                force=False,
                verify_existing=False,
                durable_write=False,
            )
            self.assertEqual(result['objects'], 2)
            self.assertEqual(result['downloaded'], 2)
            self.assertEqual(result['failed'], [])
            self.assertGreaterEqual(FakeR2Handler.requests, 3)

            upstream.shutdown()
            upstream.server_close()
            thread.join(timeout=2)

            # No upstream exists from this point onward. Verification uses only
            # the preserved manifest, local bytes, size and stored SHA256.
            manifest = manifest_name('zh')
            manifest_path = store.object_path('zh', 'android', manifest)
            self.assertTrue(store.verify('zh', 'android', manifest))
            names = parse_manifest_objects(manifest_path.read_bytes())
            self.assertEqual(set(names), {'a.unity3d', 'b.unity3d'})
            complete = store.complete_names(
                'zh', 'android', names, verify=True
            )
            self.assertEqual(complete, set(names))

    def test_local_verification_detects_corruption_without_network(self):
        with tempfile.TemporaryDirectory() as temp:
            store = AssetStore(temp)
            path = store.object_path('zh', 'android', 'broken.unity3d')
            path.write_bytes(b'good')
            store.put_metadata(
                'zh', 'android', 'broken.unity3d',
                status=200,
                size=4,
                sha256='770e607624d689265ca6c44884d0807d9b054d23c473c106c72be9de08b7376c',
                headers={},
            )
            self.assertTrue(store.verify('zh', 'android', 'broken.unity3d'))
            path.write_bytes(b'bad!')
            self.assertFalse(store.verify('zh', 'android', 'broken.unity3d'))


if __name__ == '__main__':
    unittest.main()
