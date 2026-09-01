#!/usr/bin/env python3
import argparse
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import AssetMirror, AssetStore  # noqa: E402


def progress(done, total, name, ok, error):
    state = 'ok' if ok else f'FAILED: {error}'
    print(f'[{done}/{total}] {name} {state}', flush=True)


def main():
    parser = argparse.ArgumentParser(
        description='Pre-download MLTD assets into the local mirror cache.'
    )
    parser.add_argument('language', choices=('zh', 'ko'))
    parser.add_argument('platform', choices=('android', 'ios'))
    parser.add_argument('--root', default='asset-cache',
                        help='local asset cache directory (default: asset-cache)')
    parser.add_argument('--workers', type=int, default=8)
    parser.add_argument('--force', action='store_true',
                        help='redownload already cached objects')
    parser.add_argument('--verify-existing', action='store_true',
                        help='SHA-256 verify cached objects before skipping them')
    args = parser.parse_args()

    store = AssetStore(args.root)
    mirror = AssetMirror(store)
    result = mirror.prefetch(
        args.language,
        args.platform,
        workers=args.workers,
        force=args.force,
        verify_existing=args.verify_existing,
        progress=progress,
    )
    print('\nSummary:')
    for key in ('manifest', 'total_manifest_objects', 'requested',
                'already_cached', 'downloaded'):
        print(f'  {key}: {result[key]}')
    if result['failed']:
        print(f"  failed: {len(result['failed'])}")
        for name, error in result['failed'][:20]:
            print(f'    {name}: {error}')
        raise SystemExit(1)
    print('  failed: 0')


if __name__ == '__main__':
    main()
