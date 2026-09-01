#!/usr/bin/env python3
import http.client
import sys
import tempfile
import threading
from pathlib import Path

import requests

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import (  # noqa: E402
    REMOTE_ASSET_ROOT,
    AssetMirror,
    AssetStore,
    manifest_name,
    scope_name,
)
from mltd.servers.asset_server import create_server  # noqa: E402

SCOPES = (
    ('zh', 'android'),
    ('zh', 'ios'),
    ('ko', 'android'),
    ('ko', 'ios'),
)
REPLAY_HEADERS = ('content-type', 'etag', 'last-modified', 'cache-control')


def local_request(port, method, path, headers=None):
    conn = http.client.HTTPConnection('127.0.0.1', port, timeout=10)
    conn.request(method, path, headers=headers or {})
    response = conn.getresponse()
    body = response.read()
    result = response.status, {k.lower(): v for k, v in response.getheaders()}, body
    conn.close()
    return result


def check_equal(label, actual, expected):
    if actual != expected:
        raise AssertionError(f'{label}: local={actual!r}, remote={expected!r}')


def main():
    remote = requests.Session()
    remote.headers['Accept-Encoding'] = 'identity'

    with tempfile.TemporaryDirectory() as temp:
        store = AssetStore(temp)
        mirror = AssetMirror(store)

        # Populate the local cache using the exact public manifest bytes and
        # response metadata, then validate local HTTP behavior against the
        # public host before any game-facing routing is changed.
        for language, platform in SCOPES:
            mirror.fetch_manifest(language, platform, force=True)

        server = create_server('127.0.0.1', 0, store)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        port = server.server_address[1]
        try:
            for language, platform in SCOPES:
                scope = scope_name(language, platform)
                name = manifest_name(language)
                path = f'/{scope}/{name}'
                remote_url = f'{REMOTE_ASSET_ROOT}/{scope}/{name}'
                print(f'checking {scope}', flush=True)

                r_get = remote.get(remote_url, timeout=60)
                r_get.raise_for_status()
                l_status, l_headers, l_body = local_request(port, 'GET', path)
                check_equal(f'{scope} GET status', l_status, r_get.status_code)
                check_equal(f'{scope} GET body', l_body, r_get.content)
                remote_headers = {k.lower(): v for k, v in r_get.headers.items()}
                for header in REPLAY_HEADERS:
                    if header in remote_headers:
                        check_equal(
                            f'{scope} GET {header}',
                            l_headers.get(header),
                            remote_headers[header],
                        )

                r_head = remote.head(remote_url, timeout=60)
                l_status, l_headers, l_body = local_request(port, 'HEAD', path)
                check_equal(f'{scope} HEAD status', l_status, r_head.status_code)
                check_equal(f'{scope} HEAD body', l_body, b'')
                if r_head.status_code == 200 and r_head.headers.get('Content-Length'):
                    check_equal(
                        f'{scope} HEAD content-length',
                        l_headers.get('content-length'),
                        r_head.headers['Content-Length'],
                    )

                range_headers = {'Range': 'bytes=0-63', 'Accept-Encoding': 'identity'}
                r_range = remote.get(remote_url, headers=range_headers, timeout=60)
                l_status, l_headers, l_body = local_request(
                    port, 'GET', path, {'Range': 'bytes=0-63'}
                )
                check_equal(f'{scope} Range status', l_status, r_range.status_code)
                check_equal(f'{scope} Range body', l_body, r_range.content)
                if r_range.headers.get('Content-Range'):
                    check_equal(
                        f'{scope} Range content-range',
                        l_headers.get('content-range'),
                        r_range.headers['Content-Range'],
                    )

                etag = r_get.headers.get('ETag')
                if etag:
                    r_cond = remote.get(
                        remote_url, headers={'If-None-Match': etag}, timeout=60
                    )
                    l_status, _, _ = local_request(
                        port, 'GET', path, {'If-None-Match': etag}
                    )
                    check_equal(
                        f'{scope} If-None-Match status',
                        l_status,
                        r_cond.status_code,
                    )

                missing = '/'.join((REMOTE_ASSET_ROOT, scope, '__missing__.data'))
                r_missing = remote.get(missing, timeout=60)
                l_status, _, _ = local_request(
                    port, 'GET', f'/{scope}/__missing__.data'
                )
                check_equal(
                    f'{scope} missing status', l_status, r_missing.status_code
                )

                print(
                    f'  ok: {len(r_get.content)} bytes, '
                    f'Range={r_range.status_code}, ETag={etag!r}',
                    flush=True,
                )
        finally:
            server.shutdown()
            server.server_close()
            thread.join(timeout=5)

    print('remote asset compatibility check passed')


if __name__ == '__main__':
    main()
