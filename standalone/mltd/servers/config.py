import logging
from configparser import ConfigParser
from datetime import timedelta, timezone
from urllib.parse import urlsplit

version = '0.1.10'
api_port = 7650
# 'zh' for Traditional Chinese, 'ko' for Korean
_language = 'zh'
_log_level = logging.INFO
_is_local = False
_asset_mode = 'remote'
_asset_remote_url = ''
_asset_cache_root = 'asset-cache'
_asset_prefetch_workers = 48
_asset_upstream_proxy = ''
_asset_local_scopes = 'zh-android'

# Standalone now exposes one client-facing asset mode: remote HTTPS.
# The URL may point directly at Rainbow's CDN or at a trusted HTTPS relay.
ASSET_MODES = ('remote',)
ASSET_LANGUAGES = ('zh', 'ko')
ASSET_PLATFORMS = ('android', 'ios')


def version_tuple(v):
    return tuple(map(int, v.split('.')))


def _normalize_asset_scope(value):
    value = str(value).strip().lower()
    if '-' not in value:
        raise ValueError(f'Unsupported asset scope: {value}')
    language, platform = value.split('-', 1)
    if language not in ASSET_LANGUAGES or platform not in ASSET_PLATFORMS:
        raise ValueError(f'Unsupported asset scope: {value}')
    return f'{language}-{platform}'


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
                # Kept for optional relay/cache tooling and backwards config
                # compatibility. Standalone remote client traffic does not
                # traverse asset_upstream_proxy.
                'asset_cache_root': _asset_cache_root,
                'asset_prefetch_workers': _asset_prefetch_workers,
                'asset_upstream_proxy': _asset_upstream_proxy,
                'asset_local_scopes': _asset_local_scopes,
            }
        })
        if not self.read('config.ini'):
            self.write_config()

        changed = False
        stored_version = self['default']['version']
        if version_tuple(stored_version) < version_tuple(version):
            workers = self.getint(
                'default', 'asset_prefetch_workers', fallback=24
            )
            if (version_tuple(stored_version) < (0, 1, 6)
                    and workers in {8, 24}):
                self['default']['asset_prefetch_workers'] = str(
                    _asset_prefetch_workers
                )
            self['default']['asset_local_scopes'] = self['default'].get(
                'asset_local_scopes', _asset_local_scopes
            )
            self['default']['version'] = version
            changed = True

        # v0.1.9/v0.1.10 experiments exposed hybrid/local modes which require
        # local Asset interception. Device tests showed both self-signed HTTPS
        # and cleartext HTTP are unsuitable for the corrected client. Collapse
        # every existing config back to remote regardless of stored version so
        # a previously-tested v0.1.10 config cannot remain stuck on hybrid.
        if self['default'].get('asset_mode', '').lower() != 'remote':
            self['default']['asset_mode'] = 'remote'
            changed = True

        # Validate an explicitly configured relay URL. Invalid legacy/manual
        # values fail safe to the default Rainbow CDN rather than breaking
        # client login or data download.
        try:
            normalized_remote = _normalize_remote_url(
                self['default'].get('asset_remote_url', '')
            )
        except ValueError:
            normalized_remote = ''
        if self['default'].get('asset_remote_url', '') != normalized_remote:
            self['default']['asset_remote_url'] = normalized_remote
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
    def asset_mode(self):
        # Compatibility property for existing GUI/config users. There is now
        # only one standalone client-facing Asset mode.
        return 'remote'

    @asset_mode.setter
    def asset_mode(self, value):
        if str(value).lower() != 'remote':
            raise ValueError(
                'hybrid/local asset modes were removed; use remote with '
                'asset_remote_url for an HTTPS relay'
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

    @property
    def asset_cache_root(self):
        return self['default'].get('asset_cache_root', _asset_cache_root)

    @asset_cache_root.setter
    def asset_cache_root(self, value):
        self['default']['asset_cache_root'] = value
        self.write_config()

    @property
    def asset_prefetch_workers(self):
        workers = self.getint(
            'default', 'asset_prefetch_workers', fallback=_asset_prefetch_workers
        )
        return max(1, workers)

    @asset_prefetch_workers.setter
    def asset_prefetch_workers(self, value):
        self['default']['asset_prefetch_workers'] = str(max(1, int(value)))
        self.write_config()

    @property
    def asset_upstream_proxy(self):
        value = self['default'].get(
            'asset_upstream_proxy', _asset_upstream_proxy
        ).strip()
        return value or None

    @asset_upstream_proxy.setter
    def asset_upstream_proxy(self, value):
        self['default']['asset_upstream_proxy'] = (value or '').strip()
        self.write_config()

    @property
    def asset_local_scopes(self):
        raw = self['default'].get('asset_local_scopes', _asset_local_scopes)
        values = []
        for item in raw.replace(';', ',').split(','):
            item = item.strip()
            if not item:
                continue
            try:
                scope = _normalize_asset_scope(item)
            except ValueError:
                continue
            if scope not in values:
                values.append(scope)
        return tuple(values or (_asset_local_scopes,))

    @asset_local_scopes.setter
    def asset_local_scopes(self, value):
        if isinstance(value, str):
            raw_values = value.replace(';', ',').split(',')
        else:
            raw_values = value
        values = []
        for item in raw_values:
            scope = _normalize_asset_scope(item)
            if scope not in values:
                values.append(scope)
        if not values:
            raise ValueError('At least one local asset scope is required')
        self['default']['asset_local_scopes'] = ','.join(values)
        self.write_config()

    @property
    def asset_local_platforms(self):
        """Compatibility view retained for optional relay/prefetch tooling."""
        return tuple(dict.fromkeys(
            scope.split('-', 1)[1] for scope in self.asset_local_scopes
        ))

    def write_config(self):
        with open('config.ini', 'w') as config_file:
            self.write(config_file)


config = CustomConfigParser()
