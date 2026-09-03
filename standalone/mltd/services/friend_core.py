from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import and_, delete, or_, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Friend, Mission, MstMission, Profile, User
from mltd.models.schemas import GuestSchema, MissionSchema
from mltd.services.mission import update_mission_progress


FRIEND_NONE = 0
FRIEND_SENT = 1
FRIEND_RECEIVED = 2
FRIEND_ACCEPTED = 3
_ZERO_DATE = '0001-01-01T00:00:00+0000'


def _empty_mission_process():
    return {
        'complete_mission_list': [],
        'open_mission_list': [],
        'training_point_diff': {'before': 0, 'after': 0, 'total': 0},
    }


def _edge_sets(session, user_id):
    outgoing = set(session.scalars(
        select(Friend.friend_id).where(Friend.user_id == user_id)
    ).all())
    incoming = set(session.scalars(
        select(Friend.user_id).where(Friend.friend_id == user_id)
    ).all())
    return outgoing, incoming


def _state_for(outgoing, incoming, target_id):
    has_out = target_id in outgoing
    has_in = target_id in incoming
    if has_out and has_in:
        return FRIEND_ACCEPTED
    if has_out:
        return FRIEND_SENT
    if has_in:
        return FRIEND_RECEIVED
    return FRIEND_NONE


def _friend_status(session, requester_id, target_id, state=None):
    profile = session.scalar(select(Profile).where(Profile.id_ == target_id))
    user = session.scalar(select(User).where(User.user_id == target_id))
    if profile is None or user is None:
        raise LookupError('target user not found')

    if state is None:
        outgoing, incoming = _edge_sets(session, requester_id)
        state = _state_for(outgoing, incoming, target_id)

    target_user = GuestSchema().dump(profile)
    target_user['is_friend'] = state == FRIEND_ACCEPTED

    # The legacy Friend table has no relationship timestamps. Use the target
    # producer's stable first-login timestamp as a parseable fallback rather
    # than fabricating a changing timestamp on every request.
    relation_date = (
        user.first_time_date.isoformat()
        if user.first_time_date is not None
        else _ZERO_DATE
    )
    return {
        'user_id': str(target_id),
        'target_user': target_user,
        'friend_state': state,
        'accept_date': relation_date if state == FRIEND_ACCEPTED else _ZERO_DATE,
        'apply_date': relation_date if state in (FRIEND_SENT, FRIEND_RECEIVED, FRIEND_ACCEPTED) else _ZERO_DATE,
        'sendable': target_id != requester_id,
    }


def _friend_request_missions(session, user):
    """Advance mission class 26 (send a friend request) once."""
    changed = []
    completed = []
    schema = MissionSchema()
    missions = session.scalars(
        select(Mission)
        .join(MstMission)
        .where(Mission.user == user)
        .where(MstMission.mst_mission_class_id == 26)
        .where(Mission.mission_state != 3)
    ).all()
    for mission in missions:
        before = (mission.progress, mission.mission_state)
        just_completed = update_mission_progress(
            session=session,
            user=user,
            mission=mission,
            progress=mission.mst_mission.goal,
        )
        if (mission.progress, mission.mission_state) != before:
            dumped = schema.dump(mission)
            changed.append(dumped)
            if just_completed:
                completed.append(dumped)

    process = _empty_mission_process()
    process['complete_mission_list'] = completed
    return process, changed


@dispatcher.add_method(name='FriendService.GetFriendList', context_arg='context')
def get_friend_list(params, context):
    user_id = UUID(context['user_id'])
    params = params or {}
    limit = max(0, int(params.get('limit', 100)))

    with Session(engine) as session:
        outgoing, incoming = _edge_sets(session, user_id)
        accepted_ids = sorted(outgoing & incoming, key=str)
        sent_ids = sorted(outgoing - incoming, key=str)
        received_ids = sorted(incoming - outgoing, key=str)

        # max_friend is 50 in bundled saves, so a normal standalone result is
        # always one page. Respect a smaller explicit limit without inventing
        # an opaque cursor format the client does not need for local data.
        page = lambda values: values[:limit] if limit else []
        friend_list = [
            _friend_status(session, user_id, target, FRIEND_ACCEPTED)
            for target in page(accepted_ids)
        ]
        sent_request_list = [
            _friend_status(session, user_id, target, FRIEND_SENT)
            for target in page(sent_ids)
        ]
        received_request_list = [
            _friend_status(session, user_id, target, FRIEND_RECEIVED)
            for target in page(received_ids)
        ]

    return {
        'friend_list': friend_list,
        'sent_request_list': sent_request_list,
        'received_request_list': received_request_list,
        'current_friend_count': len(accepted_ids),
        'sent_friend_count': len(sent_ids),
        'cursor': '',
    }


@dispatcher.add_method(name='FriendService.RequestFriend', context_arg='context')
def request_friend(params, context):
    user_id = UUID(context['user_id'])
    target_id = UUID(params['target_user_id'])
    if target_id == user_id:
        raise ValueError('cannot request self as friend')

    with Session(engine) as session:
        user = session.scalar(select(User).where(User.user_id == user_id))
        target = session.scalar(select(User).where(User.user_id == target_id))
        if user is None or target is None:
            raise LookupError('target user not found')

        outgoing, incoming = _edge_sets(session, user_id)
        state_before = _state_for(outgoing, incoming, target_id)
        if state_before == FRIEND_NONE:
            session.add(Friend(user_id=user_id, friend_id=target_id))
            state_after = FRIEND_SENT
            mission_process, mission_list = _friend_request_missions(session, user)
        else:
            # Repeated requests are idempotent. A received request remains
            # received until AcceptFriend is explicitly invoked.
            state_after = state_before
            mission_process, mission_list = _empty_mission_process(), []

        session.flush()
        friend = _friend_status(session, user_id, target_id, state_after)
        session.commit()

    return {
        'friend': friend,
        'mission_process': mission_process,
        'mission_list': mission_list,
    }


@dispatcher.add_method(name='FriendService.AcceptFriend', context_arg='context')
def accept_friend(params, context):
    user_id = UUID(context['user_id'])
    target_id = UUID(params['target_user_id'])
    if target_id == user_id:
        raise ValueError('cannot accept self as friend')

    with Session(engine) as session:
        target = session.scalar(select(User).where(User.user_id == target_id))
        if target is None:
            raise LookupError('target user not found')

        # A pending request from target -> caller must already exist.
        incoming = session.scalar(
            select(Friend)
            .where(Friend.user_id == target_id)
            .where(Friend.friend_id == user_id)
        )
        if incoming is None:
            # If the pair is already accepted, keep AcceptFriend idempotent.
            reverse = session.scalar(
                select(Friend)
                .where(Friend.user_id == user_id)
                .where(Friend.friend_id == target_id)
            )
            if reverse is None:
                raise LookupError('friend request not found')
        else:
            reverse = session.scalar(
                select(Friend)
                .where(Friend.user_id == user_id)
                .where(Friend.friend_id == target_id)
            )
            if reverse is None:
                session.add(Friend(user_id=user_id, friend_id=target_id))

        session.flush()
        friend = _friend_status(session, user_id, target_id, FRIEND_ACCEPTED)
        session.commit()

    return {'friend': friend}


@dispatcher.add_method(name='FriendService.RemoveFriend', context_arg='context')
def remove_friend(params, context):
    user_id = UUID(context['user_id'])
    target_id = UUID(params['target_user_id'])
    if target_id == user_id:
        return {'is_success': False}

    with Session(engine) as session:
        result = session.execute(
            delete(Friend).where(or_(
                and_(Friend.user_id == user_id, Friend.friend_id == target_id),
                and_(Friend.user_id == target_id, Friend.friend_id == user_id),
            ))
        )
        session.commit()
        removed = bool(result.rowcount)

    return {'is_success': removed}
