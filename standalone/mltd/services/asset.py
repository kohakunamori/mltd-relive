from jsonrpc import dispatcher

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT, scope_name
from mltd.servers.config import config


@dispatcher.add_method(name='AssetService.GetAssetVersion')
def get_asset_version(params):
    """Service for getting current asset version.

    Standalone always returns a normal HTTPS remote Asset endpoint. By default
    that is Rainbow's CDN. ``asset_remote_url`` can point at a trusted HTTPS
    relay/mirror which performs its own caching or proxied upstream fetches.
    """
    os_name = 'android' if params['os_name'] == 'Android' else 'ios'
    scope = scope_name(config.language, os_name)

    base_url = config.asset_remote_url or REMOTE_ASSET_ROOT
    asset_url = f'{base_url}/{scope}/'

    return {
        'asset_url': asset_url,
        'asset_index_name': (
            '85822153578df611a4f852d4e02660f6f34401e4.data'
            if config.language == 'zh'
            else '25c292462510f60200eecd8080f4680114b8c576.data'
        ),
        'asset_version': 120000
    }
