import json
import os
import time
from collections.abc import Iterable
from pathlib import Path

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT, AssetMirror, AssetStore
from mltd.servers.logging import logger

PROGRESS_STATUS_NAME = '.asset-prepare-status.json'
_PROGRESS_WRITE_INTERVAL = 0.1


def progress_status_path(root: str = 'asset-cache') -> Path:
    return Path(root) / PROGRESS_STATUS_NAME


class _ProgressReporter:
    def __init__(self, root: str):
        self.path = progress_status_path(root)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self._last_write = 0.0

    def emit(self, *, force: bool = False, **payload):
        now = time.time()
        if not force and now - self._last_write < _PROGRESS_WRITE_INTERVAL:
            return
        payload = {'updated_at': now, **payload}
        temporary = self.path.with_name(f'{self.path.name}.{os.getpid()}.tmp')
        try:
            temporary.write_text(
                json.dumps(payload, ensure_ascii=False, separators=(',', ':')),
                encoding='utf-8',
            )
            os.replace(temporary, self.path)
            self._last_write = now
        except OSError as exc:
            logger.debug(f'Unable to update asset progress status: {exc}')
            temporary.unlink(missing_ok=True)


def prepare_local_assets(language: str,
                         root: str = 'asset-cache',
                         *,
                         platforms: Iterable[str] | None = None,
                         scopes: Iterable[str] | None = None,
                         workers: int = 48,
                         verify_existing: bool = False,
                         remote_root: str = REMOTE_ASSET_ROOT,
                         upstream_proxy: str | None = None,
                         conn=None) -> dict:
    """Ensure explicitly configured strict-local scopes are complete."""
    configured_mode = scopes is None and platforms is None
    if configured_mode:
        from mltd.servers.config import config
        scopes = config.asset_local_scopes

    if scopes is not None:
        scope_pairs = []
        for scope in scopes:
            lang, platform = str(scope).lower().split('-', 1)
            pair = (lang, platform)
            if pair not in scope_pairs:
                scope_pairs.append(pair)
    else:
        platform_list = tuple(dict.fromkeys(
            str(p).lower() for p in (platforms or ('android',))
        ))
        scope_pairs = [(language, platform) for platform in platform_list]

    if not scope_pairs:
        raise ValueError('At least one local asset scope is required')

    store = AssetStore(root)
    mirror = AssetMirror(store, remote_root=remote_root,
                         upstream_proxy=upstream_proxy)
    reporter = _ProgressReporter(root)
    summary = {}
    scope_count = len(scope_pairs)

    reporter.emit(force=True, phase='starting', language='', platform='',
                  platform_index=0, platform_count=scope_count)

    try:
        for scope_index, (scope_language, platform) in enumerate(
                scope_pairs, start=1):
            scope = f'{scope_language}-{platform}'
            logger.info(
                f'Preparing complete local assets for {scope} '
                f'with {workers} workers...'
            )
            reporter.emit(
                force=True, phase='manifest', language=scope_language,
                platform=platform, platform_index=scope_index,
                platform_count=scope_count, manifest_total=0,
            )

            _, manifest_names = mirror.fetch_manifest(scope_language, platform)
            manifest_total = len(manifest_names)
            reporter.emit(
                force=True, phase='scan', language=scope_language,
                platform=platform, platform_index=scope_index,
                platform_count=scope_count, manifest_total=manifest_total,
            )

            last_logged = 0
            failed_count = 0
            downloaded_bytes = 0
            started_at = time.monotonic()

            def progress(completed, total, name, ok, error):
                nonlocal last_logged, failed_count, downloaded_bytes
                if ok:
                    try:
                        downloaded_bytes += store.object_path(
                            scope_language, platform, name).stat().st_size
                    except OSError:
                        pass
                else:
                    failed_count += 1
                downloaded_count = completed - failed_count
                cached_count = max(0, manifest_total - total)
                elapsed = max(time.monotonic() - started_at, 0.001)
                reporter.emit(
                    force=completed == total, phase='prefetch',
                    language=scope_language, platform=platform,
                    platform_index=scope_index, platform_count=scope_count,
                    manifest_total=manifest_total, pending_total=total,
                    completed=completed, cached=cached_count,
                    downloaded=downloaded_count, failed=failed_count,
                    bytes_downloaded=downloaded_bytes,
                    rate_bps=downloaded_bytes / elapsed, current=name,
                )
                if completed == total or completed - last_logged >= 250:
                    logger.info(f'Asset prefetch {scope}: {completed}/{total}')
                    last_logged = completed
                if not ok:
                    logger.warning(
                        f'Asset prefetch failed for {scope}/{name}: {error}')

            result = mirror.prefetch(
                scope_language, platform, workers=workers,
                verify_existing=verify_existing, progress=progress,
                manifest_objects=manifest_names, durable_writes=False,
            )
            if result['failed']:
                examples = ', '.join(name for name, _ in result['failed'][:5])
                raise RuntimeError(
                    f'Local asset prefetch incomplete for {scope}: '
                    f'{len(result["failed"])} download(s) failed; '
                    f'examples: {examples}'
                )

            reporter.emit(
                force=True, phase='verify', language=scope_language,
                platform=platform, platform_index=scope_index,
                platform_count=scope_count, manifest_total=manifest_total,
                verify_completed=0, cached=result['already_cached'],
                downloaded=result['downloaded'], failed=0,
            )
            complete = store.complete_names(
                scope_language, platform, manifest_names,
                verify=verify_existing,
            )
            missing = [name for name in manifest_names if name not in complete]
            if missing:
                raise RuntimeError(
                    f'Local asset cache incomplete for {scope}: '
                    f'{len(missing)} object(s) missing or invalid; '
                    f'example: {missing[0]}'
                )

            summary_key = scope if configured_mode or scopes is not None else platform
            summary[summary_key] = {**result, 'complete': manifest_total}
            reporter.emit(
                force=True, phase='platform_complete', language=scope_language,
                platform=platform, platform_index=scope_index,
                platform_count=scope_count, manifest_total=manifest_total,
                cached=result['already_cached'], downloaded=result['downloaded'],
                failed=0,
            )
            logger.info(f'Local assets ready for {scope}: {manifest_total} objects.')

        reporter.emit(force=True, phase='complete', language='', platform='',
                      platform_index=scope_count, platform_count=scope_count)
    except Exception as exc:
        current = {}
        try:
            current = json.loads(reporter.path.read_text(encoding='utf-8'))
        except (OSError, ValueError):
            pass
        reporter.emit(
            force=True, phase='error',
            language=current.get('language', ''),
            platform=current.get('platform', ''),
            platform_index=current.get('platform_index', 0),
            platform_count=scope_count, message=str(exc),
        )
        raise

    if conn:
        conn.send(True)
        conn.close()
    return summary
