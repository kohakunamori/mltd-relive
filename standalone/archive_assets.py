"""Create or verify a durable archive of the current MLTD remote assets.

This is deliberately separate from the standalone game's runtime Asset path.
The corrected client always uses a normal HTTPS remote endpoint; this command
exists only for preservation/disaster recovery and can target a NAS mount.
"""

import argparse
import json
import time
from pathlib import Path

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT
from mltd.servers.asset_prepare import prepare_local_assets


def parse_args():
    parser = argparse.ArgumentParser(
        description='Archive MLTD remote assets for disaster recovery.'
    )
    parser.add_argument(
        '--root', default='asset-archive',
        help='Archive directory. Point this at a durable/NAS-mounted path.',
    )
    parser.add_argument(
        '--scope', action='append', dest='scopes',
        help=(
            'Scope to archive, e.g. zh-android. May be specified multiple '
            'times. Default: zh-android.'
        ),
    )
    parser.add_argument(
        '--workers', type=int, default=48,
        help='Concurrent download workers (default: 48).',
    )
    parser.add_argument(
        '--proxy', default='',
        help='Optional HTTP/SOCKS proxy used only for archive upstream fetches.',
    )
    parser.add_argument(
        '--remote-root', default=REMOTE_ASSET_ROOT,
        help='Remote Asset root to snapshot.',
    )
    parser.add_argument(
        '--verify', action='store_true',
        help='SHA256-verify already archived objects instead of using fast-ready.',
    )
    return parser.parse_args()


def main():
    args = parse_args()
    scopes = tuple(dict.fromkeys(args.scopes or ('zh-android',)))
    root = Path(args.root).expanduser().resolve()
    root.mkdir(parents=True, exist_ok=True)

    started = time.time()
    summary = prepare_local_assets(
        scopes[0].split('-', 1)[0],
        str(root),
        scopes=scopes,
        workers=max(1, args.workers),
        verify_existing=args.verify,
        remote_root=args.remote_root.rstrip('/'),
        upstream_proxy=(args.proxy.strip() or None),
    )

    snapshot = {
        'format_version': 1,
        'purpose': 'mltd-remote-asset-disaster-recovery',
        'remote_root': args.remote_root.rstrip('/'),
        'scopes': list(scopes),
        'started_at': started,
        'completed_at': time.time(),
        'verify_existing': bool(args.verify),
        'summary': summary,
    }
    snapshot_path = root / 'archive-snapshot.json'
    temporary = snapshot_path.with_suffix('.json.tmp')
    temporary.write_text(
        json.dumps(snapshot, ensure_ascii=False, indent=2, sort_keys=True),
        encoding='utf-8',
    )
    temporary.replace(snapshot_path)

    print(f'Archive complete: {root}')
    print(f'Snapshot metadata: {snapshot_path}')
    for scope, result in summary.items():
        print(
            f'{scope}: complete={result.get("complete", 0)} '
            f'downloaded={result.get("downloaded", 0)} '
            f'already_cached={result.get("already_cached", 0)}'
        )


if __name__ == '__main__':
    main()
