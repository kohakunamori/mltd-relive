from jsonrpc import dispatcher

from mltd.servers.asset_cache import REMOTE_ASSET_ROOT, scope_name
from mltd.servers.asset_server import asset_port
from mltd.servers.config import config


@dispatcher.add_method(name='AssetService.GetAssetVersion')
def get_asset_version(params):
    """Service for getting current asset version.

    Invoked after logging in.
    Args:
        params: A dict containing the following keys.
            os_name: Which OS the game is designed to run on
                     (Android/iOS).
            unity_version: Unity version of the game (2018v1).
            environment: 'production'
            token: A 40-character hex value representing the game
                   version. This value is the same as header value
                   'X-Version-Hash' for all requests sent from the same
                   game client version.
    Returns:
        A dict containing the following keys.
        asset_url: The URL from which assets are downloaded.
        asset_index_name: The name of the index/manifest file containing
                          file names and other info of all other assets.
        asset_version: Asset version (last version before EoS is
                       120000).
    """
    os_name = 'android' if params['os_name'] == 'Android' else 'ios'
    scope = scope_name(config.language, os_name)

    if config.asset_mode == 'remote':
        asset_url = f'{REMOTE_ASSET_ROOT}/{scope}/'
    elif config.is_local:
        # Termux / same-device mode remains loopback HTTP. This path is not the
        # Desktop cleartext topology that the corrected client rejected with
        # data-download error -21990.
        asset_url = f'http://127.0.0.1:{asset_port}/{scope}/'
    else:
        base_url = config.asset_public_url
        if not base_url:
            raise RuntimeError(
                'Desktop hybrid/local requires asset_public_url pointing to '
                'a hostname with a publicly trusted TLS certificate.'
            )
        if not base_url.lower().startswith('https://'):
            raise RuntimeError(
                'Desktop hybrid/local asset_public_url must use HTTPS. '
                'The corrected client rejects the cleartext Asset transport.'
            )
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
