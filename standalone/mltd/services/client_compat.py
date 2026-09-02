from jsonrpc import dispatcher

from mltd.servers.logging import logger


@dispatcher.add_method(name='UserService.ReadDirectMessage')
def read_direct_message(params):
    """Acknowledge a direct-message read request.

    The offline server currently returns ``message_list=None`` from
    ``UserService.GetDirectMessage``, so there is no server-side message state
    to mutate.  Accepting the client acknowledgement keeps the RPC contract
    complete without inventing message data.
    """
    # Access the field so malformed requests still fail rather than being
    # silently accepted as a different contract.
    _ = params['id']
    return {}


@dispatcher.add_method(name='LiveService.PostLog')
def post_live_log(params):
    """Accept diagnostic logs posted by the game client.

    The original endpoint is telemetry-only from the standalone server's
    perspective.  Keep it at DEBUG level so normal offline play does not add
    noisy disk I/O while retaining diagnostics when debug logging is enabled.
    """
    log_id = params['id']
    data = params['data']
    logger.debug('Client live log [%s]: %s', log_id, data)
    return {}
