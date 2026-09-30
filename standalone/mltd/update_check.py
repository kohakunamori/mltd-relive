from dataclasses import dataclass
import json
import re
import sys
from urllib.request import Request, urlopen

from mltd.build_info import BUILD_COMMIT

REPOSITORY = 'kohakunamori/mltd-relive'
ROLLING_RELEASE_TAG = 'standalone-latest'
RELEASE_API_URL = (
    f'https://api.github.com/repos/{REPOSITORY}/releases/tags/{ROLLING_RELEASE_TAG}'
)
RELEASE_PAGE_URL = (
    f'https://github.com/{REPOSITORY}/releases/tag/{ROLLING_RELEASE_TAG}'
)
_USER_AGENT = 'mltd-relive-standalone-update-check'
_VERSION_RE = re.compile(r'Standalone source version:\s*`v([^`]+)`')


@dataclass(frozen=True)
class UpdateInfo:
    current_commit: str | None
    latest_commit: str | None
    current_version: str
    latest_version: str | None
    download_url: str
    release_url: str

    @property
    def current_build_known(self):
        return bool(self.current_commit)

    @property
    def update_available(self):
        return bool(
            self.current_commit
            and self.latest_commit
            and self.current_commit.lower() != self.latest_commit.lower()
        )


def platform_asset_name(platform=None):
    platform = platform or sys.platform
    if platform.startswith('win'):
        return 'mltd-relive-standalone-latest-windows.exe'
    if platform.startswith('linux'):
        return 'mltd-relive-standalone-latest-ubuntu'
    if platform == 'darwin':
        return 'mltd-relive-standalone-latest-macos.zip'
    return None


def _release_version(body):
    match = _VERSION_RE.search(body or '')
    return match.group(1) if match else None


def _asset_download_url(release, platform=None):
    wanted = platform_asset_name(platform)
    if wanted:
        for asset in release.get('assets', []):
            if asset.get('name') == wanted and asset.get('browser_download_url'):
                return asset['browser_download_url']
    return release.get('html_url') or RELEASE_PAGE_URL


def check_for_updates(current_version, timeout=8, platform=None):
    """Check the rolling release only when explicitly requested by the user.

    This function performs no installation and never blocks server startup.
    Packaged builds compare their CI-injected source commit against the rolling
    Release target commit. Source checkouts have no embedded commit and are
    reported as an unknown build rather than being treated as outdated.
    """
    request = Request(
        RELEASE_API_URL,
        headers={
            'Accept': 'application/vnd.github+json',
            'User-Agent': _USER_AGENT,
        },
    )
    with urlopen(request, timeout=timeout) as response:
        release = json.load(response)

    latest_commit = release.get('target_commitish')
    if latest_commit and latest_commit in {'main', 'master'}:
        latest_commit = None

    return UpdateInfo(
        current_commit=BUILD_COMMIT,
        latest_commit=latest_commit,
        current_version=current_version,
        latest_version=_release_version(release.get('body')),
        download_url=_asset_download_url(release, platform),
        release_url=release.get('html_url') or RELEASE_PAGE_URL,
    )
