import logging
from configparser import ConfigParser
from datetime import timedelta, timezone
from urllib.parse import urlsplit

version = '0.1.11'
api_port = 7650
# 'zh' for Traditional Chinese, 'ko' for Korean
_language = 'zh'
_log_level = logging.INFO
_is_local = False
_asset_mode = 'remote'
_asset_remote_url = ''
_registration_api_key = ''

ASSET_MODES = ('remote',)
_LEGACY_ASSET_KEYS = (
    'asset_cache_root',
    'asset_prefetch_workers',
    'asset_upstream_proxy',
    'asset_local_scopes',
    'asset_public_url',
    'asset_tls_cert',
    'asset_tls_key',
)


def version_tuple(v):
    return tuple(map(int, v.split('.')))


def _normalize_remote_url(value):
    value = (value or '').strip().rstrip('/')
    if not value:
        return ''
    parsed = urlsplit(value)
    if parsed.scheme.lower() != 'https' or not parsed.hostname:
        raise ValueError(
            'asset_remote_url must be an HTTPS URL, for example '
            'https://assets.example.com'
        )
    return value


class CustomConfigParser(ConfigParser):

    def __init__(self):
        super().__init__()
        self.read_dict({
            'default': {
                'version': version,
                'language': _language,
                'log_level': _log_level,
                'is_local': _is_local,
                'asset_mode': _asset_mode,
                'asset_remote_url': _asset_remote_url,
                'registration_api_key': _registration_api_key,
            }
        })
        if not self.read('config.ini'):
            self.write_config()
            return

        changed = False
        section = self['default']
        stored_version = section.get('version', '0.0.0')

        # v0.1.9/v0.1.10 experiments exposed local/hybrid Asset transport.
        # Device testing rejected both the self-signed HTTPS and cleartext
        # HTTP variants, so every legacy configuration migrates to remote.
        if section.get('asset_mode', '').lower() != 'remote':
            section['asset_mode'] = 'remote'
            changed = True

        try:
            normalized_remote = _normalize_remote_url(
                section.get('asset_remote_url', '')
            )
        except ValueError:
            normalized_remote = ''
        if section.get('asset_remote_url', '') != normalized_remote:
            section['asset_remote_url'] = normalized_remote
            changed = True

        # Cache/prefetch/proxy settings now belong exclusively to
        # tools/cache_assets.py CLI and must not remain server runtime config.
        for key in _LEGACY_ASSET_KEYS:
            if key in section:
                del section[key]
                changed = True

        if version_tuple(stored_version) < version_tuple(version):
            section['version'] = version
            changed = True

        if changed:
            self.write_config()

    @property
    def language(self):
        return self['default']['language']

    @language.setter
    def language(self, value):
        self['default']['language'] = value
        self.write_config()

    @property
    def timezone(self):
        return timezone(timedelta(hours=8 if self.language == 'zh' else 9))

    @property
    def log_level(self):
        return self.getint('default', 'log_level')

    @property
    def is_local(self):
        return self.getboolean('default', 'is_local')

    @is_local.setter
    def is_local(self, value):
        self['default']['is_local'] = str(value)
        self.write_config()

    @property
    def registration_api_key(self):
        return self['default'].get('registration_api_key', '').strip()

    @registration_api_key.setter
    def registration_api_key(self, value):
        self['default']['registration_api_key'] = str(value or '').strip()
        self.write_config()

    @property
    def asset_mode(self):
        return 'remote'

    @asset_mode.setter
    def asset_mode(self, value):
        if str(value).lower() != 'remote':
            raise ValueError(
                'hybrid/local Asset modes were removed; use remote with '
                'asset_remote_url and tools/cache_assets.py for preservation'
            )
        self['default']['asset_mode'] = 'remote'
        self.write_config()

    @property
    def asset_remote_url(self):
        return _normalize_remote_url(
            self['default'].get('asset_remote_url', _asset_remote_url)
        )

    @asset_remote_url.setter
    def asset_remote_url(self, value):
        self['default']['asset_remote_url'] = _normalize_remote_url(value)
        self.write_config()

    # Temporary GUI compatibility views. They are not persisted and do not
    # enable any local Asset runtime behavior.
    @property
    def asset_cache_root(self):
        return 'asset-cache'

    @property
    def asset_prefetch_workers(self):
        return 0

    def write_config(self):
        with open('config.ini', 'w') as config_file:
            self.write(config_file)


config = CustomConfigParser()
