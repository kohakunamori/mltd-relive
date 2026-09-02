from jsonrpc import dispatcher


@dispatcher.add_method(name='FriendService.GetFlowerStandCount')
def get_flower_stand_count(params):
    """Service for getting flower stand counts for a user.

    Invoked as part of the initial batch requests after logging in.
    Args:
        params: An empty dict.
    Returns:
        A dict containing a single key 'flower_stand_count', whose value
        is a dict that represents flower stand count info and contains
        the following keys.
            send_count: Number of flower stands sent by the user on the
                        previous day.
            recv_count: Number of flower stands received by the user on
                        previous day.
            all_recv_count: Total receive count used by the client.

    The original relive implementation returned the three counters at the
    top level. The EoS client contract is GetFlowerStandCountReply, which
    contains exactly one FlowerStandCountStatus field named
    ``flower_stand_count``. Keep the static compatibility values for now,
    but preserve the wire shape expected by the client.
    """
    return {
        'flower_stand_count': {
            'send_count': 5,
            'recv_count': 5,
            'all_recv_count': 0,
        }
    }
