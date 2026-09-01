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
_asset_local_platforms = 'android'

ASSET_MODES = ('remote', 'hybrid', 'local')
ASSET_PLATFORMS = ('android', 'ios')


def version_tuple(v):
    return tuple(map(int, v.split('.')))


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
                'asset_local_platforms': _asset_local_platforms,
            }
        })
        if not self.read('config.ini'):
            self.write_config()
        stored_version = self['default']['version']
        if version_tuple(stored_version) < version_tuple(version):
            # v0.1.6 moves the performance-oriented default from 24 to 48.
            # Preserve explicit user tuning while upgrading untouched defaults.
            workers = self.getint(
                'default', 'asset_prefetch_workers', fallback=24
            )
            if (version_tuple(stored_version) < (0, 1, 6)
                    and workers in {8, 24}):
                self['default']['asset_prefetch_workers'] = str(
                    _asset_prefetch_workers
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
    def asset_local_platforms(self):
        raw = self['default'].get(
            'asset_local_platforms', _asset_local_platforms
        )
        values = []
        for item in raw.replace(';', ',').split(','):
            platform = item.strip().lower()
            if not platform or platform in values:
                continue
            if platform not in ASSET_PLATFORMS:
                continue
            values.append(platform)
        return tuple(values or ('android',))

    @asset_local_platforms.setter
    def asset_local_platforms(self, value):
        if isinstance(value, str):
            raw_values = value.replace(';', ',').split(',')
        else:
            raw_values = value
        values = []
        for item in raw_values:
            platform = str(item).strip().lower()
            if not platform or platform in values:
                continue
            if platform not in ASSET_PLATFORMS:
                raise ValueError(f'Unsupported asset platform: {platform}')
            values.append(platform)
        if not values:
            raise ValueError('At least one local asset platform is required')
        self['default']['asset_local_platforms'] = ','.join(values)
        self.write_config()

    def write_config(self):
        with open('config.ini', 'w') as config_file:
            self.write(config_file)


config = CustomConfigParser()
