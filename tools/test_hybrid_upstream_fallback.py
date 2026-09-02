#!/usr/bin/env python3
import sys
import tempfile
import threading
from pathlib import Path

import requests

ROOT = Path(__file__).resolve().parents[1]
STANDALONE = ROOT / 'standalone'
sys.path.insert(0, str(STANDALONE))

from mltd.servers.asset_cache import AssetMirror, AssetStore, REMOTE_ASSET_ROOT
from mltd.servers.asset_server import create_server


class FailingMirror(AssetMirror):
    def download(self, language, platform, name, *, force=False):
        raise requests.ConnectionError('simulated WSL upstream failure')


def run_server(store, mirror, fetch_on_miss):
    server = create_server(
        host='127.0.0.1',
        port=0,
        store=store,
        mirror=mirror,
        fetch_on_miss=fetch_on_miss,
    )
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    return server, thread


def main():
    name = '85822153578df611a4f852d4e02660f6f34401e4.data'

    with tempfile.TemporaryDirectory(prefix='mltd-fallback-') as root:
        store = AssetStore(root)
        mirror = FailingMirror(store)
        server, thread = run_server(store, mirror, True)
        try:
            port = server.server_address[1]
            response = requests.get(
                f'http://127.0.0.1:{port}/zh-android/{name}',
                allow_redirects=False,
                timeout=10,
            )
            print('hybrid failure response:', response.status_code, response.headers.get('Location'))
            assert response.status_code == 307
            assert response.headers['Location'] == f'{REMOTE_ASSET_ROOT}/zh-android/{name}'
            assert response.headers['Content-Length'] == '0'
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=5)

    with tempfile.TemporaryDirectory(prefix='mltd-local-') as root:
        store = AssetStore(root)
        server, thread = run_server(store, None, False)
        try:
            port = server.server_address[1]
            response = requests.get(
                f'http://127.0.0.1:{port}/zh-android/{name}',
                allow_redirects=False,
                timeout=10,
            )
            print('strict local miss response:', response.status_code)
            assert response.status_code == 404
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=5)

    print('HYBRID UPSTREAM FALLBACK: PASS')


if __name__ == '__main__':
    main()
