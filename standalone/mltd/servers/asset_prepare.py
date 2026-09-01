from collections.abc import Iterable

from mltd.servers.asset_cache import (
    REMOTE_ASSET_ROOT,
    SUPPORTED_PLATFORMS,
    AssetMirror,
    AssetStore,
)
from mltd.servers.logging import logger


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
    summary = {}

    for platform in platforms:
        logger.info(
            f'Preparing complete local assets for {language}-{platform}...'
        )
        last_logged = 0

        def progress(completed, total, name, ok, error):
            nonlocal last_logged
            if completed == total or completed - last_logged >= 100:
                logger.info(
                    f'Asset prefetch {language}-{platform}: '
                    f'{completed}/{total}'
                )
                last_logged = completed
            if not ok:
                logger.warning(
                    f'Asset prefetch failed for {language}-{platform}/{name}: '
                    f'{error}'
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
            raise RuntimeError(
                f'Local asset prefetch incomplete for {language}-{platform}: '
                f'{len(result["failed"])} download(s) failed; examples: {examples}'
            )

        _, names = mirror.fetch_manifest(language, platform)
        check = store.verify if verify_existing else store.is_complete
        missing = [
            name for name in names
            if not check(language, platform, name)
        ]
        if missing:
            raise RuntimeError(
                f'Local asset cache incomplete for {language}-{platform}: '
                f'{len(missing)} object(s) missing or invalid; '
                f'example: {missing[0]}'
            )

        summary[platform] = {
            **result,
            'complete': len(names),
        }
        logger.info(
            f'Local assets ready for {language}-{platform}: '
            f'{len(names)} objects.'
        )

    if conn:
        conn.send(True)
        conn.close()
    return summary
