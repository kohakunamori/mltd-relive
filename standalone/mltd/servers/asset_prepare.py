import json
import os
import time
from collections.abc import Iterable
from pathlib import Path

from mltd.servers.asset_cache import (
    REMOTE_ASSET_ROOT,
    SUPPORTED_PLATFORMS,
    AssetMirror,
    AssetStore,
)
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
        payload = {
            'updated_at': now,
            **payload,
        }
        temporary = self.path.with_name(
            f'{self.path.name}.{os.getpid()}.tmp'
        )
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
                         workers: int = 8,
                         verify_existing: bool = False,
                         remote_root: str = REMOTE_ASSET_ROOT,
                         upstream_proxy: str | None = None,
                         conn=None) -> dict:
    """Ensure a strict local mirror exists before serving local mode."""
    platforms = tuple(sorted(platforms or SUPPORTED_PLATFORMS))
    store = AssetStore(root)
    mirror = AssetMirror(
        store,
        remote_root=remote_root,
        upstream_proxy=upstream_proxy,
    )
    reporter = _ProgressReporter(root)
    summary = {}

    reporter.emit(
        force=True,
        phase='starting',
        language=language,
        platform='',
        platform_index=0,
        platform_count=len(platforms),
    )

    try:
        for platform_index, platform in enumerate(platforms, start=1):
            scope = f'{language}-{platform}'
            logger.info(f'Preparing complete local assets for {scope}...')
            reporter.emit(
                force=True,
                phase='manifest',
                language=language,
                platform=platform,
                platform_index=platform_index,
                platform_count=len(platforms),
                manifest_total=0,
            )

            _, manifest_names = mirror.fetch_manifest(language, platform)
            manifest_total = len(manifest_names)
            reporter.emit(
                force=True,
                phase='scan',
                language=language,
                platform=platform,
                platform_index=platform_index,
                platform_count=len(platforms),
                manifest_total=manifest_total,
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
                            language, platform, name
                        ).stat().st_size
                    except OSError:
                        pass
                else:
                    failed_count += 1

                downloaded_count = completed - failed_count
                cached_count = max(0, manifest_total - total)
                elapsed = max(time.monotonic() - started_at, 0.001)
                rate_bps = downloaded_bytes / elapsed

                reporter.emit(
                    force=completed == total,
                    phase='prefetch',
                    language=language,
                    platform=platform,
                    platform_index=platform_index,
                    platform_count=len(platforms),
                    manifest_total=manifest_total,
                    pending_total=total,
                    completed=completed,
                    cached=cached_count,
                    downloaded=downloaded_count,
                    failed=failed_count,
                    bytes_downloaded=downloaded_bytes,
                    rate_bps=rate_bps,
                    current=name,
                )

                if completed == total or completed - last_logged >= 100:
                    logger.info(
                        f'Asset prefetch {scope}: {completed}/{total}'
                    )
                    last_logged = completed
                if not ok:
                    logger.warning(
                        f'Asset prefetch failed for {scope}/{name}: {error}'
                    )

            result = mirror.prefetch(
                language,
                platform,
                workers=workers,
                verify_existing=verify_existing,
                progress=progress,
            )
            if result['failed']:
                examples = ', '.join(name for name, _ in result['failed'][:5])
                reporter.emit(
                    force=True,
                    phase='error',
                    language=language,
                    platform=platform,
                    platform_index=platform_index,
                    platform_count=len(platforms),
                    manifest_total=manifest_total,
                    cached=result['already_cached'],
                    downloaded=result['downloaded'],
                    failed=len(result['failed']),
                    message=(
                        f'{len(result["failed"])} asset download(s) failed; '
                        f'examples: {examples}'
                    ),
                )
                raise RuntimeError(
                    f'Local asset prefetch incomplete for {scope}: '
                    f'{len(result["failed"])} download(s) failed; examples: {examples}'
                )

            _, names = mirror.fetch_manifest(language, platform)
            check = store.verify if verify_existing else store.is_complete
            missing = []
            verify_total = len(names)
            reporter.emit(
                force=True,
                phase='verify',
                language=language,
                platform=platform,
                platform_index=platform_index,
                platform_count=len(platforms),
                manifest_total=verify_total,
                verify_completed=0,
                cached=result['already_cached'],
                downloaded=result['downloaded'],
                failed=0,
            )
            for verify_completed, name in enumerate(names, start=1):
                if not check(language, platform, name):
                    missing.append(name)
                if verify_completed == verify_total or verify_completed % 250 == 0:
                    reporter.emit(
                        force=verify_completed == verify_total,
                        phase='verify',
                        language=language,
                        platform=platform,
                        platform_index=platform_index,
                        platform_count=len(platforms),
                        manifest_total=verify_total,
                        verify_completed=verify_completed,
                        cached=result['already_cached'],
                        downloaded=result['downloaded'],
                        failed=0,
                    )

            if missing:
                reporter.emit(
                    force=True,
                    phase='error',
                    language=language,
                    platform=platform,
                    platform_index=platform_index,
                    platform_count=len(platforms),
                    manifest_total=verify_total,
                    cached=result['already_cached'],
                    downloaded=result['downloaded'],
                    failed=len(missing),
                    message=(
                        f'{len(missing)} object(s) missing or invalid; '
                        f'example: {missing[0]}'
                    ),
                )
                raise RuntimeError(
                    f'Local asset cache incomplete for {scope}: '
                    f'{len(missing)} object(s) missing or invalid; '
                    f'example: {missing[0]}'
                )

            summary[platform] = {
                **result,
                'complete': len(names),
            }
            reporter.emit(
                force=True,
                phase='platform_complete',
                language=language,
                platform=platform,
                platform_index=platform_index,
                platform_count=len(platforms),
                manifest_total=len(names),
                cached=result['already_cached'],
                downloaded=result['downloaded'],
                failed=0,
            )
            logger.info(
                f'Local assets ready for {scope}: {len(names)} objects.'
            )

        reporter.emit(
            force=True,
            phase='complete',
            language=language,
            platform='',
            platform_index=len(platforms),
            platform_count=len(platforms),
        )
    except Exception as exc:
        current = {}
        try:
            current = json.loads(
                reporter.path.read_text(encoding='utf-8')
            )
        except (OSError, ValueError):
            pass
        if current.get('phase') != 'error':
            reporter.emit(
                force=True,
                phase='error',
                language=language,
                platform=current.get('platform', ''),
                platform_index=current.get('platform_index', 0),
                platform_count=len(platforms),
                message=str(exc),
            )
        raise

    if conn:
        conn.send(True)
        conn.close()
    return summary
