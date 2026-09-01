import hashlib
import sys
import tempfile
import threading
import types
import unittest
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from unittest.mock import patch

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


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers.asset_cache import (  # noqa: E402
    AssetMirror,
    AssetStore,
    manifest_name,
)
from mltd.servers.asset_prepare import prepare_local_assets  # noqa: E402
from mltd.servers.config import config  # noqa: E402


class CountingStore(AssetStore):
    def __init__(self, *args, **kwargs):
        self.connect_count = 0
        super().__init__(*args, **kwargs)

    def _connect(self):
        self.connect_count += 1
        return super()._connect()


class ManyObjectsHandler(BaseHTTPRequestHandler):
    requests = 0

    def do_GET(self):
        type(self).requests += 1
        body = (self.path.encode() * 20)[:4096]
        self.send_response(200)
        self.send_header('Content-Length', str(len(body)))
        self.send_header('Content-Type', 'application/octet-stream')
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass


class ManifestHandler(BaseHTTPRequestHandler):
    counts = {}

    def do_GET(self):
        type(self).counts[self.path] = type(self).counts.get(self.path, 0) + 1
        parts = self.path.strip('/').split('/')
        if len(parts) != 2:
            self.send_error(404)
            return
        scope, name = parts
        if name == manifest_name('zh'):
            body = packb([
                {
                    'a': [0, 'a.bin'],
                    'b': [0, 'b.bin'],
                }
            ], use_bin_type=True)
        elif name in {'a.bin', 'b.bin'}:
            body = (scope + name).encode() * 100
        else:
            self.send_error(404)
            return
        self.send_response(200)
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        pass


class AssetPrefetchFastPathTest(unittest.TestCase):
    def test_complete_names_uses_single_db_snapshot(self):
        with tempfile.TemporaryDirectory() as temp:
            store = CountingStore(temp)
            names = [f'{i:05d}.bin' for i in range(1000)]
            records = []
            for i, name in enumerate(names):
                body = f'body-{i}'.encode()
                store.object_path('zh', 'android', name).write_bytes(body)
                records.append(store._metadata_record(
                    'zh-android',
                    name,
                    status=200,
                    size=len(body),
                    sha256=hashlib.sha256(body).hexdigest(),
                    headers={},
                ))
            store.put_metadata_batch(records)

            store.connect_count = 0
            complete = store.complete_names('zh', 'android', names)
            self.assertEqual(len(complete), len(names))
            self.assertEqual(store.connect_count, 1)

    def test_prefetch_batches_metadata_writes(self):
        ManyObjectsHandler.requests = 0
        server = ThreadingHTTPServer(('127.0.0.1', 0), ManyObjectsHandler)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        try:
            with tempfile.TemporaryDirectory() as temp:
                store = CountingStore(temp)
                store.connect_count = 0
                mirror = AssetMirror(
                    store,
                    remote_root=f'http://127.0.0.1:{server.server_address[1]}',
                )
                names = [f'{i:05d}.bin' for i in range(130)]
                result = mirror.prefetch(
                    'zh',
                    'android',
                    workers=16,
                    manifest_objects=names,
                    metadata_batch_size=64,
                )
                self.assertEqual(result['downloaded'], 130)
                self.assertEqual(ManyObjectsHandler.requests, 130)
                self.assertEqual(store.connect_count, 4)
                self.assertEqual(
                    len(store.complete_names('zh', 'android', names)),
                    130,
                )
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=2)

    def test_bulk_prefetch_skips_per_object_fsync_by_default(self):
        ManyObjectsHandler.requests = 0
        server = ThreadingHTTPServer(('127.0.0.1', 0), ManyObjectsHandler)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        try:
            with tempfile.TemporaryDirectory() as temp:
                mirror = AssetMirror(
                    AssetStore(temp),
                    remote_root=f'http://127.0.0.1:{server.server_address[1]}',
                )
                with patch('mltd.servers.asset_cache.os.fsync') as fsync:
                    result = mirror.prefetch(
                        'zh',
                        'android',
                        workers=4,
                        manifest_objects=['a.bin', 'b.bin'],
                    )
                self.assertEqual(result['downloaded'], 2)
                fsync.assert_not_called()
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=2)

    def test_prepare_uses_configured_android_only_default(self):
        ManifestHandler.counts = {}
        server = ThreadingHTTPServer(('127.0.0.1', 0), ManifestHandler)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        old_value = config['default'].get('asset_local_platforms', 'android')
        config['default']['asset_local_platforms'] = 'android'
        try:
            with tempfile.TemporaryDirectory() as temp:
                remote = f'http://127.0.0.1:{server.server_address[1]}'
                result = prepare_local_assets(
                    'zh',
                    temp,
                    workers=8,
                    remote_root=remote,
                )
                self.assertEqual(tuple(result), ('android',))
                self.assertEqual(result['android']['complete'], 2)
                manifest = manifest_name('zh')
                self.assertEqual(
                    ManifestHandler.counts[f'/zh-android/{manifest}'], 1
                )
                self.assertFalse(any(
                    path.startswith('/zh-ios/')
                    for path in ManifestHandler.counts
                ))
        finally:
            config['default']['asset_local_platforms'] = old_value
            server.shutdown()
            server.server_close()
            thread.join(timeout=2)

    def test_prepare_fetches_each_manifest_once_when_all_explicit(self):
        ManifestHandler.counts = {}
        server = ThreadingHTTPServer(('127.0.0.1', 0), ManifestHandler)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        try:
            with tempfile.TemporaryDirectory() as temp:
                remote = f'http://127.0.0.1:{server.server_address[1]}'
                result = prepare_local_assets(
                    'zh',
                    temp,
                    platforms=('android', 'ios'),
                    workers=8,
                    remote_root=remote,
                )
                self.assertEqual(result['android']['complete'], 2)
                self.assertEqual(result['ios']['complete'], 2)
                manifest = manifest_name('zh')
                self.assertEqual(
                    ManifestHandler.counts[f'/zh-android/{manifest}'], 1
                )
                self.assertEqual(
                    ManifestHandler.counts[f'/zh-ios/{manifest}'], 1
                )
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=2)


if __name__ == '__main__':
    unittest.main()
