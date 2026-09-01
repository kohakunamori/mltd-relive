import hashlib
import http.client
import sys
import tempfile
import threading
import time
import types
from concurrent.futures import ThreadPoolExecutor
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


logging_module.logger = DummyLogger()
sys.modules.setdefault('mltd.servers.logging', logging_module)

from mltd.servers.asset_cache import AssetStore  # noqa: E402
from mltd.servers.asset_server import create_server  # noqa: E402


WORKERS = 32
REQUESTS_PER_WORKER = 50
PAYLOAD_SIZE = 64 * 1024


def main():
    with tempfile.TemporaryDirectory() as root:
        store = AssetStore(root)
        name = 'benchmark.data'
        payload = bytes(range(256)) * (PAYLOAD_SIZE // 256)
        path = store.object_path('zh', 'android', name)
        path.write_bytes(payload)
        store.put_metadata(
            'zh', 'android', name,
            status=200,
            size=len(payload),
            sha256=hashlib.sha256(payload).hexdigest(),
            headers={'Content-Type': 'application/octet-stream'},
        )

        server = create_server('127.0.0.1', 0, store)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        port = server.server_address[1]
        request_path = f'/zh-android/{name}'

        def worker(_):
            conn = http.client.HTTPConnection('127.0.0.1', port, timeout=10)
            transferred = 0
            try:
                for _ in range(REQUESTS_PER_WORKER):
                    conn.request('GET', request_path)
                    response = conn.getresponse()
                    body = response.read()
                    if response.status != 200 or body != payload:
                        raise AssertionError(
                            f'bad asset response status={response.status} '
                            f'bytes={len(body)}'
                        )
                    transferred += len(body)
            finally:
                conn.close()
            return transferred

        # Warm the request machinery before measuring the sustained path.
        warm = http.client.HTTPConnection('127.0.0.1', port, timeout=5)
        warm.request('GET', request_path)
        response = warm.getresponse()
        assert response.status == 200
        assert response.read() == payload
        warm.close()

        start = time.perf_counter()
        try:
            with ThreadPoolExecutor(max_workers=WORKERS) as executor:
                total_bytes = sum(executor.map(worker, range(WORKERS)))
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=2)
        elapsed = time.perf_counter() - start

        requests = WORKERS * REQUESTS_PER_WORKER
        mib = total_bytes / (1024 * 1024)
        print(
            'Asset server benchmark: '
            f'{requests} requests, {WORKERS} persistent clients, '
            f'{mib:.1f} MiB in {elapsed:.3f}s, '
            f'{requests / elapsed:.1f} req/s, {mib / elapsed:.1f} MiB/s'
        )


if __name__ == '__main__':
    main()
