#!/usr/bin/env python3
"""Cache and verify MLTD remote assets for long-term preservation.

This tool is intentionally independent from the MLTD standalone runtime.
The game server only returns a normal HTTPS remote Asset URL; this utility can
snapshot the current remote/R2 contents into durable local or NAS storage so a
future upstream outage does not destroy the preserved files.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import NamedTuple

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

_METADATA_BATCH_SIZE = 256
_CHUNK_SIZE = 1024 * 1024


class DownloadOutcome(NamedTuple):
    name: str
    metadata: tuple
    size: int


class AssetCacheClient:
    def __init__(self, store: AssetStore, *, remote_root: str,
                 proxy: str | None = None, timeout: float = 60.0):
        self.store = store
        self.remote_root = remote_root.rstrip('/')
        self.proxy = proxy.strip() if proxy else None
        self.timeout = timeout
        self._local = threading.local()

    def _session(self) -> requests.Session:
        session = getattr(self._local, 'session', None)
        if session is None:
            session = requests.Session()
            adapter = requests.adapters.HTTPAdapter(
                pool_connections=1,
                pool_maxsize=1,
                max_retries=3,
            )
            session.mount('http://', adapter)
            session.mount('https://', adapter)
            session.headers['User-Agent'] = 'mltd-relive-asset-cache/1'
            if self.proxy:
                session.proxies.update({'http': self.proxy, 'https': self.proxy})
            self._local.session = session
        return session

    def remote_url(self, language: str, platform: str, name: str) -> str:
        return f'{self.remote_root}/{scope_name(language, platform)}/{name}'

    def download(self, language: str, platform: str, name: str, *,
                 force: bool = False, defer_metadata: bool = False,
                 durable_write: bool = False) -> DownloadOutcome:
        destination = self.store.object_path(language, platform, name)
        if not force and self.store.is_complete(language, platform, name):
            return DownloadOutcome(name, (), destination.stat().st_size)

        part = self.store.part_path(language, platform, name)
        try:
            resume_at = part.stat().st_size
        except OSError:
            resume_at = 0

        headers = {'Accept-Encoding': 'identity'}
        if resume_at:
            headers['Range'] = f'bytes={resume_at}-'

        response = self._session().get(
            self.remote_url(language, platform, name),
            headers=headers,
            stream=True,
            timeout=self.timeout,
        )
        try:
            if response.status_code == 416 and resume_at:
                part.unlink(missing_ok=True)
                return self.download(
                    language, platform, name,
                    force=True,
                    defer_metadata=defer_metadata,
                    durable_write=durable_write,
                )
            response.raise_for_status()

            append = resume_at > 0 and response.status_code == 206
            if not append:
                resume_at = 0
            mode = 'ab' if append else 'wb'

            digest = hashlib.sha256()
            if append:
                with part.open('rb') as existing:
                    for chunk in iter(lambda: existing.read(_CHUNK_SIZE), b''):
                        digest.update(chunk)

            with part.open(mode) as file:
                for chunk in response.iter_content(chunk_size=_CHUNK_SIZE):
                    if not chunk:
                        continue
                    file.write(chunk)
                    digest.update(chunk)
                if durable_write:
                    file.flush()
                    os.fsync(file.fileno())

            size = part.stat().st_size
            expected_total = None
            if response.status_code == 206:
                content_range = response.headers.get('Content-Range', '')
                if '/' in content_range:
                    total = content_range.rsplit('/', 1)[1]
                    if total.isdigit():
                        expected_total = int(total)
            elif response.headers.get('Content-Length', '').isdigit():
                expected_total = int(response.headers['Content-Length'])

            if expected_total is not None and size != expected_total:
                raise IOError(
                    f'Incomplete asset {name}: got {size} bytes, '
                    f'expected {expected_total}'
                )

            os.replace(part, destination)
            record = self.store._metadata_record(
                scope_name(language, platform),
                name,
                status=200,
                size=size,
                sha256=digest.hexdigest(),
                headers=response.headers,
            )
            if not defer_metadata:
                self.store.put_metadata_batch([record])
            return DownloadOutcome(name, record, size)
        finally:
            response.close()

    def sync_scope(self, scope: str, *, workers: int, force: bool,
                   verify_existing: bool, durable_write: bool) -> dict:
        language, platform = scope.split('-', 1)
        manifest = manifest_name(language)

        # Always refresh the manifest so every sync snapshots the current R2
        # object set rather than trusting a previous local manifest.
        manifest_outcome = self.download(
            language,
            platform,
            manifest,
            force=True,
            durable_write=durable_write,
        )
        manifest_path = self.store.object_path(language, platform, manifest)
        names = parse_manifest_objects(manifest_path.read_bytes())

        if force:
            complete = set()
        else:
            complete = self.store.complete_names(
                language,
                platform,
                names,
                verify=verify_existing,
            )
        pending = [name for name in names if name not in complete]

        result = {
            'scope': scope,
            'manifest': str(manifest_path),
            'manifest_sha256': self.store.get_metadata(
                language, platform, manifest
            )['sha256'],
            'manifest_size': manifest_outcome.size,
            'objects': len(names),
            'already_cached': len(names) - len(pending),
            'downloaded': 0,
            'failed': [],
        }
        if not pending:
            return result

        metadata_batch = []
        started = time.monotonic()
        downloaded_bytes = 0
        with ThreadPoolExecutor(
            max_workers=min(max(1, workers), len(pending))
        ) as executor:
            futures = {
                executor.submit(
                    self.download,
                    language,
                    platform,
                    name,
                    force=force,
                    defer_metadata=True,
                    durable_write=durable_write,
                ): name
                for name in pending
            }
            completed = 0
            for future in as_completed(futures):
                name = futures[future]
                completed += 1
                try:
                    outcome = future.result()
                except Exception as exc:
                    result['failed'].append((name, str(exc)))
                else:
                    metadata_batch.append(outcome.metadata)
                    downloaded_bytes += outcome.size
                    result['downloaded'] += 1
                    if len(metadata_batch) >= _METADATA_BATCH_SIZE:
                        self.store.put_metadata_batch(metadata_batch)
                        metadata_batch.clear()

                if completed == len(pending) or completed % 250 == 0:
                    elapsed = max(time.monotonic() - started, 0.001)
                    rate = downloaded_bytes / elapsed / (1024 * 1024)
                    print(
                        f'[{scope}] {completed}/{len(pending)} pending '
                        f'processed; downloaded={result["downloaded"]}; '
                        f'failed={len(result["failed"])}; {rate:.1f} MiB/s',
                        flush=True,
                    )

        if metadata_batch:
            self.store.put_metadata_batch(metadata_batch)
        return result


def _parse_scopes(values: list[str] | None) -> list[str]:
    scopes = values or ['zh-android']
    normalized = []
    for value in scopes:
        value = value.strip().lower()
        if '-' not in value:
            raise ValueError(f'Invalid scope: {value}')
        language, platform = value.split('-', 1)
        scope_name(language, platform)  # validates both components
        if value not in normalized:
            normalized.append(value)
    return normalized


def _write_snapshot(root: Path, *, remote_root: str, scopes: list[str],
                    results: list[dict], started_at: float):
    payload = {
        'format_version': 1,
        'purpose': 'mltd-remote-asset-cache-preservation',
        'remote_root': remote_root.rstrip('/'),
        'scopes': scopes,
        'started_at': started_at,
        'completed_at': time.time(),
        'results': results,
    }
    path = root / 'cache-snapshot.json'
    temporary = path.with_suffix('.json.tmp')
    temporary.write_text(
        json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True),
        encoding='utf-8',
    )
    os.replace(temporary, path)
    return path


def sync_command(args):
    root = Path(args.root).expanduser().resolve()
    root.mkdir(parents=True, exist_ok=True)
    scopes = _parse_scopes(args.scope)
    store = AssetStore(root)
    client = AssetCacheClient(
        store,
        remote_root=args.remote_root,
        proxy=args.proxy,
        timeout=max(1.0, args.timeout),
    )

    started_at = time.time()
    results = []
    failed = False
    for scope in scopes:
        print(f'Syncing {scope} -> {root}', flush=True)
        result = client.sync_scope(
            scope,
            workers=max(1, args.workers),
            force=args.force,
            verify_existing=args.verify_existing,
            durable_write=args.durable,
        )
        results.append(result)
        if result['failed']:
            failed = True
            print(f'{scope}: {len(result["failed"])} download(s) failed')
            for name, error in result['failed'][:20]:
                print(f'  {name}: {error}')
        else:
            print(
                f'{scope}: complete object set={result["objects"]}; '
                f'downloaded={result["downloaded"]}; '
                f'already_cached={result["already_cached"]}'
            )

    snapshot = _write_snapshot(
        root,
        remote_root=args.remote_root,
        scopes=scopes,
        results=results,
        started_at=started_at,
    )
    print(f'Snapshot: {snapshot}')
    if failed:
        raise SystemExit(1)


def verify_command(args):
    root = Path(args.root).expanduser().resolve()
    scopes = _parse_scopes(args.scope)
    store = AssetStore(root)
    total_failures = 0

    for scope in scopes:
        language, platform = scope.split('-', 1)
        manifest = manifest_name(language)
        manifest_path = store.object_path(language, platform, manifest)
        if not manifest_path.is_file():
            print(f'{scope}: missing manifest {manifest_path}')
            total_failures += 1
            continue
        if not store.verify(language, platform, manifest):
            print(f'{scope}: manifest SHA256/size verification FAILED')
            total_failures += 1
            continue

        names = parse_manifest_objects(manifest_path.read_bytes())
        complete = store.complete_names(
            language,
            platform,
            names,
            verify=True,
        )
        missing = [name for name in names if name not in complete]
        print(
            f'{scope}: verified {len(complete)}/{len(names)} objects; '
            f'missing-or-invalid={len(missing)}'
        )
        if missing:
            total_failures += len(missing)
            for name in missing[:20]:
                print(f'  {name}')

    if total_failures:
        raise SystemExit(1)


def build_parser():
    parser = argparse.ArgumentParser(
        description='Cache MLTD remote/R2 assets for preservation.'
    )
    subparsers = parser.add_subparsers(dest='command', required=True)

    sync = subparsers.add_parser(
        'sync', help='download/update complete manifest-defined asset caches'
    )
    sync.add_argument(
        '--scope', action='append',
        help='scope such as zh-android; repeat for multiple scopes; default zh-android',
    )
    sync.add_argument(
        '--root', default='asset-cache',
        help='cache directory; may be a durable/NAS-mounted path',
    )
    sync.add_argument('--workers', type=int, default=48)
    sync.add_argument('--remote-root', default=REMOTE_ASSET_ROOT)
    sync.add_argument(
        '--proxy',
        help='optional requests-compatible proxy for outbound R2/CDN access',
    )
    sync.add_argument('--timeout', type=float, default=60.0)
    sync.add_argument(
        '--force', action='store_true',
        help='redownload every manifest object even when cached',
    )
    sync.add_argument(
        '--verify-existing', action='store_true',
        help='SHA256-check existing objects before deciding they can be skipped',
    )
    sync.add_argument(
        '--durable', action='store_true',
        help='fsync each downloaded object before committing it to the cache',
    )
    sync.set_defaults(func=sync_command)

    verify = subparsers.add_parser(
        'verify', help='verify a cache locally without contacting the remote source'
    )
    verify.add_argument(
        '--scope', action='append',
        help='scope such as zh-android; repeat for multiple scopes; default zh-android',
    )
    verify.add_argument('--root', default='asset-cache')
    verify.set_defaults(func=verify_command)
    return parser


def main():
    args = build_parser().parse_args()
    args.func(args)


if __name__ == '__main__':
    main()
