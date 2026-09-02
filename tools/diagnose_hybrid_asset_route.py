#!/usr/bin/env python3
import hashlib
import ssl
import sys
import tempfile
import threading
from pathlib import Path

import requests
from msgpack import unpackb

ROOT = Path(__file__).resolve().parents[1]
STANDALONE = ROOT / 'standalone'
sys.path.insert(0, str(STANDALONE))

from mltd.servers.asset_cache import AssetMirror, AssetStore, REMOTE_ASSET_ROOT, MANIFEST_NAMES
from mltd.servers.asset_server import bind_asset_handler
from mltd.servers.proxy import ProxyHTTPRequestHandler, ThreadedProxyServer

requests.packages.urllib3.disable_warnings()  # diagnostic TLS endpoint uses repo cert


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def pick_small_object(manifest_bytes: bytes):
    table = unpackb(manifest_bytes, raw=False)[0]
    candidates = []
    for logical_name, record in table.items():
        if not isinstance(record, (list, tuple)) or len(record) < 3:
            continue
        object_name = record[1]
        size = record[2]
        if isinstance(object_name, bytes):
            object_name = object_name.decode('utf-8')
        if isinstance(object_name, str) and isinstance(size, int) and size > 0:
            candidates.append((size, logical_name, object_name))
    if not candidates:
        raise RuntimeError('manifest contains no usable objects')
    return min(candidates)


def main():
    language = 'zh'
    platform = 'android'
    scope = f'{language}-{platform}'
    manifest_name = MANIFEST_NAMES[language]

    with tempfile.TemporaryDirectory(prefix='mltd-asset-diag-') as temp_root:
        store = AssetStore(temp_root)
        mirror = AssetMirror(store)

        class BoundProxyHandler(ProxyHTTPRequestHandler):
            pass

        bind_asset_handler(
            BoundProxyHandler,
            store,
            mirror=mirror,
            fetch_on_miss=True,
        )

        server = ThreadedProxyServer(('127.0.0.1', 0), BoundProxyHandler)
        certfile = ROOT / 'key' / 'api.crt'
        keyfile = ROOT / 'key' / 'api.key'
        context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
        context.load_cert_chain(certfile, keyfile)
        server.socket = context.wrap_socket(server.socket, server_side=True)

        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        port = server.server_address[1]

        session = requests.Session()
        session.headers['Host'] = 'theaterdays-zh.appspot.com'
        local_root = f'https://127.0.0.1:{port}/__mltd_assets/{scope}'
        remote_root = f'{REMOTE_ASSET_ROOT}/{scope}'

        try:
            remote_manifest = requests.get(
                f'{remote_root}/{manifest_name}',
                headers={'Accept-Encoding': 'identity'},
                timeout=60,
            )
            remote_manifest.raise_for_status()
            local_manifest = session.get(
                f'{local_root}/{manifest_name}',
                headers={'Accept-Encoding': 'identity'},
                verify=False,
                timeout=60,
            )
            print('manifest statuses:', remote_manifest.status_code, local_manifest.status_code)
            print('manifest lengths:', len(remote_manifest.content), len(local_manifest.content))
            print('manifest sha256:', sha256(remote_manifest.content), sha256(local_manifest.content))
            assert local_manifest.status_code == 200
            assert local_manifest.content == remote_manifest.content

            size, logical_name, object_name = pick_small_object(remote_manifest.content)
            print('sample object:', logical_name, object_name, 'manifest_size=', size)

            remote_object = requests.get(
                f'{remote_root}/{object_name}',
                headers={'Accept-Encoding': 'identity'},
                timeout=60,
            )
            remote_object.raise_for_status()
            local_object = session.get(
                f'{local_root}/{object_name}',
                headers={'Accept-Encoding': 'identity'},
                verify=False,
                timeout=60,
            )
            print('object statuses:', remote_object.status_code, local_object.status_code)
            print('object lengths:', len(remote_object.content), len(local_object.content))
            print('object sha256:', sha256(remote_object.content), sha256(local_object.content))
            assert local_object.status_code == 200
            assert local_object.content == remote_object.content

            local_head = session.head(
                f'{local_root}/{object_name}',
                headers={'Accept-Encoding': 'identity'},
                verify=False,
                timeout=30,
            )
            print('HEAD:', local_head.status_code, dict(local_head.headers))
            assert local_head.status_code == 200
            assert int(local_head.headers['Content-Length']) == len(remote_object.content)
            assert local_head.headers.get('Accept-Ranges') == 'bytes'

            remote_range = requests.get(
                f'{remote_root}/{object_name}',
                headers={'Range': 'bytes=0-1023', 'Accept-Encoding': 'identity'},
                timeout=30,
            )
            remote_range.raise_for_status()
            local_range = session.get(
                f'{local_root}/{object_name}',
                headers={'Range': 'bytes=0-1023', 'Accept-Encoding': 'identity'},
                verify=False,
                timeout=30,
            )
            print('range statuses:', remote_range.status_code, local_range.status_code)
            print('remote range headers:', dict(remote_range.headers))
            print('local range headers:', dict(local_range.headers))
            print('range lengths:', len(remote_range.content), len(local_range.content))
            assert local_range.status_code == 206
            assert local_range.content == remote_object.content[:1024]
            if remote_range.status_code == 206:
                assert local_range.content == remote_range.content

            etag = local_object.headers.get('ETag')
            if etag:
                conditional = session.get(
                    f'{local_root}/{object_name}',
                    headers={'If-None-Match': etag, 'Accept-Encoding': 'identity'},
                    verify=False,
                    timeout=30,
                )
                print('conditional GET:', conditional.status_code, 'etag=', etag)
                assert conditional.status_code == 304

            print('HYBRID ASSET HTTPS ROUTE: PASS')
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=5)


if __name__ == '__main__':
    main()
