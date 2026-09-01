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
    parse_manifest_objects,
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


def choose_small_asset(remote, scope, names, max_size=2 * 1024 * 1024):
    """Pick one real CDN object small enough for a full byte comparison."""
    for name in names[:64]:
        url = f'{REMOTE_ASSET_ROOT}/{scope}/{name}'
        probe = remote.get(
            url,
            headers={'Range': 'bytes=0-0', 'Accept-Encoding': 'identity'},
            timeout=30,
        )
        if probe.status_code not in (200, 206):
            continue
        total = None
        content_range = probe.headers.get('Content-Range', '')
        if '/' in content_range:
            tail = content_range.rsplit('/', 1)[1]
            if tail.isdigit():
                total = int(tail)
        if total is None and probe.headers.get('Content-Length', '').isdigit():
            total = int(probe.headers['Content-Length'])
        if total is not None and 0 < total <= max_size:
            return name, total
    raise AssertionError(f'{scope}: no <= {max_size} byte sample in first 64 objects')


def main():
    remote = requests.Session()
    remote.headers['Accept-Encoding'] = 'identity'

    with tempfile.TemporaryDirectory() as temp:
        store = AssetStore(temp)
        mirror = AssetMirror(store)

        # Populate the local cache using the exact public manifest bytes and
        # response metadata, then validate the local HTTP behavior against the
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

                objects = parse_manifest_objects(r_get.content)
                sample_name, sample_size = choose_small_asset(remote, scope, objects)
                mirror.download(language, platform, sample_name, force=True)
                sample_path = f'/{scope}/{sample_name}'
                sample_url = f'{REMOTE_ASSET_ROOT}/{scope}/{sample_name}'
                r_sample = remote.get(sample_url, timeout=60)
                r_sample.raise_for_status()
                l_status, l_headers, l_body = local_request(port, 'GET', sample_path)
                check_equal(f'{scope} sample GET status', l_status, r_sample.status_code)
                check_equal(f'{scope} sample GET body', l_body, r_sample.content)
                check_equal(f'{scope} sample size', len(l_body), sample_size)
                sample_remote_headers = {
                    k.lower(): v for k, v in r_sample.headers.items()
                }
                for header in REPLAY_HEADERS:
                    if header in sample_remote_headers:
                        check_equal(
                            f'{scope} sample GET {header}',
                            l_headers.get(header),
                            sample_remote_headers[header],
                        )

                sample_range_headers = {
                    'Range': 'bytes=0-63',
                    'Accept-Encoding': 'identity',
                }
                r_sample_range = remote.get(
                    sample_url, headers=sample_range_headers, timeout=60
                )
                l_status, _, l_body = local_request(
                    port, 'GET', sample_path, {'Range': 'bytes=0-63'}
                )
                check_equal(
                    f'{scope} sample Range status',
                    l_status,
                    r_sample_range.status_code,
                )
                check_equal(
                    f'{scope} sample Range body', l_body, r_sample_range.content
                )

                print(
                    f'  ok: manifest={len(r_get.content)} bytes, '
                    f'sample={sample_name} ({sample_size} bytes), '
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
