"""Legacy GUI compatibility helpers for removed local Asset modes.

The standalone runtime no longer downloads or serves Asset data.  Preservation
is handled explicitly by ``tools/cache_assets.py`` while the game client uses a
normal HTTPS remote Asset URL.
"""

from pathlib import Path

PROGRESS_STATUS_NAME = '.asset-prepare-status.json'
READY_STATUS_DIR = '.ready'


def progress_status_path(root: str = 'asset-cache') -> Path:
    return Path(root) / PROGRESS_STATUS_NAME


def ready_status_path(root: str, scope: str) -> Path:
    return Path(root) / READY_STATUS_DIR / f'{scope}.json'


def prepare_local_assets(*args, **kwargs):
    raise RuntimeError(
        'Local/hybrid Asset runtime modes were removed. '
        'Use tools/cache_assets.py sync for durable Asset preservation.'
    )
