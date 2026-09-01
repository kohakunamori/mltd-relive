#!/usr/bin/env python3
import argparse
import hashlib
import random
import sys
from pathlib import Path

import requests

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import (  # noqa: E402
    REMOTE_ASSET_ROOT,
    AssetStore,
    manifest_name,
    parse_manifest_objects,
    scope_name,
)


def digest_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open('rb') as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b''):
            digest.update(chunk)
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser(
        description='Compare cached asset bytes against the public asset CDN.'
    )
    parser.add_argument('language', choices=('zh', 'ko'))
    parser.add_argument('platform', choices=('android', 'ios'))
    parser.add_argument('--root', default='asset-cache')
    parser.add_argument('--sample', type=int, default=50,
                        help='number of manifest objects to compare (default: 50)')
    parser.add_argument('--seed', type=int, default=7297)
    parser.add_argument('--all', action='store_true',
                        help='verify every object instead of sampling')
    parser.add_argument('--remote-root', default=REMOTE_ASSET_ROOT)
    args = parser.parse_args()

    store = AssetStore(args.root)
    scope = scope_name(args.language, args.platform)
    manifest = manifest_name(args.language)
    manifest_path = store.object_path(args.language, args.platform, manifest)
    if not manifest_path.is_file():
        raise SystemExit(f'Missing local manifest: {manifest_path}')

    session = requests.Session()
    session.headers['Accept-Encoding'] = 'identity'
    remote_manifest_url = f"{args.remote_root.rstrip('/')}/{scope}/{manifest}"
    response = session.get(remote_manifest_url, timeout=60)
    response.raise_for_status()
    local_manifest = manifest_path.read_bytes()
    if response.content != local_manifest:
        raise SystemExit('Manifest mismatch: local bytes differ from remote CDN')
    print('manifest: byte-for-byte match')

    objects = parse_manifest_objects(local_manifest)
    if args.all:
        selected = objects
    else:
        rng = random.Random(args.seed)
        selected = rng.sample(objects, min(args.sample, len(objects)))

    failures = []
    for index, name in enumerate(selected, 1):
        local_path = store.object_path(args.language, args.platform, name)
        if not local_path.is_file():
            failures.append((name, 'missing local object'))
            print(f'[{index}/{len(selected)}] {name}: MISSING')
            continue
        remote_url = f"{args.remote_root.rstrip('/')}/{scope}/{name}"
        remote = session.get(remote_url, timeout=60)
        if remote.status_code != 200:
            failures.append((name, f'remote status {remote.status_code}'))
            print(f'[{index}/{len(selected)}] {name}: remote {remote.status_code}')
            continue
        local_hash = digest_file(local_path)
        remote_hash = hashlib.sha256(remote.content).hexdigest()
        if local_hash != remote_hash:
            failures.append((name, 'sha256 mismatch'))
            print(f'[{index}/{len(selected)}] {name}: SHA256 MISMATCH')
            continue
        print(f'[{index}/{len(selected)}] {name}: match ({len(remote.content)} bytes)')

    print(f'checked: {len(selected)}, failures: {len(failures)}')
    if failures:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
