from jsonrpc import dispatcher


def _flower_stand_count():
    """Return the offline-compatible flower stand counters.

    The standalone server does not currently persist flower stand history.
    Keep the historical count values used by relive for the login/theater
    display, while endpoints that require actual history return empty lists.
    """
    return {
        'send_count': 5,
        'recv_count': 5,
        'all_recv_count': 0,
    }


@dispatcher.add_method(name='FriendService.GetFlowerStandCount')
def get_flower_stand_count(params):
    """Service for getting flower stand counts for a user.

    The EoS client contract is GetFlowerStandCountReply, which contains
    exactly one FlowerStandCountStatus field named ``flower_stand_count``.
    Older relive builds incorrectly returned the counters at the top level.
    """
    return {'flower_stand_count': _flower_stand_count()}


@dispatcher.add_method(name='FriendService.GetFlowerStandList')
def get_flower_stand_list(params):
    """Return an empty flower stand history with the exact client shape.

    There is no flower-stand history/state table in the standalone database,
    so manufacturing sender/receiver rows would create fake social state.
    Empty arrays are the truthful offline fallback and avoid JSON-RPC -32601
    when the flower-stand page is opened.
    """
    return {
        'flower_stand_count': _flower_stand_count(),
        'sent_flower_stand_list': [],
        'received_flower_stand_list': [],
    }


@dispatcher.add_method(name='FriendService.ExecFlowerStandReward')
def exec_flower_stand_reward(params):
    """Safely report that no persisted flower-stand reward is available.

    The endpoint has an empty request. Without persisted received flower
    stands there is no legitimate reward to grant; returning the client's
    zero-reward state is both idempotent and avoids fabricating inventory.
    """
    return {
        'recv_count': 0,
        'is_received': False,
        'flower_stand_name_list': [],
    }


@dispatcher.add_method(name='FriendService.GetCommentList')
def get_comment_list(params):
    """Return the truthful empty offline comment history.

    GetCommentListArgs has no fields and GetCommentListReply contains only a
    CommentStatus array. The standalone schema has no persisted friend-comment
    table, so an empty array is preferable to fabricated comments and lets the
    comment page open without a Method-not-found error.
    """
    return {'comment_list': []}
