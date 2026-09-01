import logging
from configparser import ConfigParser
from datetime import timedelta, timezone

version = '0.1.6'
api_port = 7650
# 'zh' for Traditional Chinese, 'ko' for Korean
_language = 'zh'
_log_level = logging.INFO
_is_local = False
_asset_mode = 'hybrid'
_asset_cache_root = 'asset-cache'
_asset_prefetch_workers = 48
_asset_upstream_proxy = ''
_asset_local_scopes = 'zh-android'

ASSET_MODES = ('remote', 'hybrid', 'local')
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
                'asset_cache_root': _asset_cache_root,
                'asset_prefetch_workers': _asset_prefetch_workers,
                'asset_upstream_proxy': _asset_upstream_proxy,
                'asset_local_scopes': _asset_local_scopes,
            }
        })
        if not self.read('config.ini'):
            self.write_config()
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
        mode = self['default'].get('asset_mode', _asset_mode).lower()
        return mode if mode in ASSET_MODES else _asset_mode

    @asset_mode.setter
    def asset_mode(self, value):
        value = value.lower()
        if value not in ASSET_MODES:
            raise ValueError(f'Unsupported asset mode: {value}')
        self['default']['asset_mode'] = value
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
        """Compatibility view used by the current GUI progress text."""
        return tuple(dict.fromkeys(
            scope.split('-', 1)[1] for scope in self.asset_local_scopes
        ))

    def write_config(self):
        with open('config.ini', 'w') as config_file:
            self.write(config_file)


config = CustomConfigParser()
