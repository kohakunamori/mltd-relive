#!/usr/bin/env python3
import argparse
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT / 'standalone'))

from mltd.servers.asset_cache import AssetMirror, AssetStore  # noqa: E402
from mltd.servers.asset_prepare import prepare_local_assets  # noqa: E402


def progress(done, total, name, ok, error):
    state = 'ok' if ok else f'FAILED: {error}'
    print(f'[{done}/{total}] {name} {state}', flush=True)


def main():
    parser = argparse.ArgumentParser(
        description='Pre-download MLTD assets into the local mirror cache.'
    )
    parser.add_argument('language', choices=('zh', 'ko'))
    parser.add_argument(
        'platform',
        choices=('android', 'ios', 'all'),
        help='use "all" only when an Android+iOS mirror is explicitly needed',
    )
    parser.add_argument('--root', default='asset-cache',
                        help='local asset cache directory (default: asset-cache)')
    parser.add_argument('--workers', type=int, default=48,
                        help='parallel asset downloads (default: 48)')
    parser.add_argument(
        '--proxy',
        help='HTTP proxy used only for outbound asset CDN requests, e.g. '
             'http://127.0.0.1:7890',
    )
    parser.add_argument('--force', action='store_true',
                        help='redownload already cached objects (single platform only)')
    parser.add_argument('--verify-existing', action='store_true',
                        help='SHA-256 verify cached objects before skipping them')
    args = parser.parse_args()

    if args.platform == 'all':
        if args.force:
            parser.error('--force is not supported with platform=all; remove the cache '
                         'or prefetch each platform explicitly')
        result = prepare_local_assets(
            args.language,
            args.root,
            platforms=('android', 'ios'),
            workers=args.workers,
            verify_existing=args.verify_existing,
            upstream_proxy=args.proxy,
        )
        print('\nStrict local cache ready:')
        for platform, summary in result.items():
            print(
                f'  {platform}: {summary["complete"]} objects complete, '
                f'{summary["downloaded"]} downloaded this run'
            )
        return

    store = AssetStore(args.root)
    mirror = AssetMirror(store, upstream_proxy=args.proxy)
    result = mirror.prefetch(
        args.language,
        args.platform,
        workers=args.workers,
        force=args.force,
        verify_existing=args.verify_existing,
        progress=progress,
        durable_writes=False,
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
