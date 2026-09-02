from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Card, HelperCard, Mission, MstMission, Profile, User
from mltd.models.schemas import MissionSchema, ProfileSchema
from mltd.services.mission import update_mission_progress


_PROFILE_REPLY_FIELDS = (
    'name',
    'birthday',
    'is_birthday_public',
    'comment',
    'favorite_card_id',
    'favorite_card_before_awake',
    'helper_card_id_list',
    'mst_achievement_id',
    'mst_achievement_id_list',
    'lp',
    'album_count',
    'story_count',
    'clear_song_count_list',
    'full_combo_song_count_list',
    'helper_card_list',
    'favorite_card',
)


def _requester_id(context):
    return UUID(context['user_id'])


def _find_profile(session, params, requester_id):
    """Resolve GetProfileArgs to one persisted profile.

    The client can address a profile using either the UUID ``user_id`` or
    the public eight-character ``search_user_id``. ``name_card_url`` and
    ``from_page`` are routing/analytics inputs and do not alter the profile
    payload itself.
    """
    requested_user_id = (params or {}).get('user_id') or ''
    search_user_id = (params or {}).get('search_user_id') or ''

    if requested_user_id:
        try:
            user_id = UUID(requested_user_id)
        except (TypeError, ValueError):
            user_id = None
        if user_id is not None:
            profile = session.scalar(
                select(Profile).where(Profile.id_ == user_id)
            )
            if profile is not None:
                return profile

    if search_user_id:
        profile = session.scalar(
            select(Profile)
            .join(User, User.user_id == Profile.id_)
            .where(User.search_id == search_user_id)
        )
        if profile is not None:
            return profile

    # Offline saves normally contain one local producer. Falling back to the
    # authenticated producer keeps QR/name-card/profile entry points usable
    # even when obsolete routing arguments are supplied by the client.
    return session.scalar(
        select(Profile).where(Profile.id_ == requester_id)
    )


def _mission_reply(session, user):
    """Advance the normal 'change self-introduction' mission class once."""
    mission_schema = MissionSchema()
    changed = []
    completed = []

    missions = session.scalars(
        select(Mission)
        .join(MstMission)
        .where(Mission.user == user)
        .where(MstMission.mst_mission_class_id == 27)
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
            dumped = mission_schema.dump(mission)
            changed.append(dumped)
            if just_completed:
                completed.append(dumped)

    return {
        'mission_process': {
            'complete_mission_list': completed,
            'open_mission_list': [],
            'training_point_diff': {
                'before': 0,
                'after': 0,
                'total': 0,
            },
        },
        'mission_list': changed,
    }


def _owned_card(session, user_id, card_id):
    if not card_id:
        return None
    return session.scalar(
        select(Card)
        .where(Card.user_id == user_id)
        .where(Card.card_id == card_id)
    )


def _store_achievement_list(profile, values):
    achievement_ids = [int(value) for value in (values or [])][:52]
    profile.mst_achievement_id_list = (
        ','.join(str(value) for value in achievement_ids)
        if achievement_ids else None
    )


@dispatcher.add_method(name='UserService.GetProfile', context_arg='context')
def get_profile(params, context):
    """Return the client-exact GetProfileReply shape from local save data."""
    requester_id = _requester_id(context)
    with Session(engine) as session:
        profile = _find_profile(session, params or {}, requester_id)
        if profile is None:
            # A healthy standalone database always has the authenticated
            # producer profile. Preserve a deterministic failure rather than
            # inventing a remote producer.
            raise LookupError('profile not found')

        user = session.scalar(
            select(User).where(User.user_id == profile.id_)
        )
        profile_dict = ProfileSchema().dump(profile)

        result = {
            'user_id': str(user.user_id),
            'search_id': user.search_id,
        }
        for key in _PROFILE_REPLY_FIELDS:
            result[key] = profile_dict[key]

        # Birthday visibility only matters when another local producer is
        # viewed. The normal standalone save contains one producer.
        if user.user_id != requester_id and not profile.is_birthday_public:
            result['birthday'] = ''

        result.update({
            # Friend persistence is not modelled by the standalone database;
            # state 0 is the client's neutral/not-friend state. Do not expose a
            # send action for the authenticated producer itself.
            'friend_state': 0,
            'lounge_id': '' if user.lounge_id is None else str(user.lounge_id),
            'lounge_name': user.lounge_name,
            'lounge_user_state': user.lounge_user_state,
            'producer_rank': user.producer_rank,
            'plv': user.level,
            'theater_fan': user.theater_fan,
            'sendable': user.user_id != requester_id,
            'user_recognition': user.map_level.user_recognition,
        })
        return result


@dispatcher.add_method(name='UserService.SetSelfProfile', context_arg='context')
def set_self_profile(params, context):
    """Persist SetSelfProfileArgs and return mission processing status."""
    user_id = _requester_id(context)
    params = params or {}

    with Session(engine) as session:
        user = session.scalar(
            select(User).where(User.user_id == user_id)
        )
        profile = session.scalar(
            select(Profile).where(Profile.id_ == user_id)
        )
        if user is None or profile is None:
            raise LookupError('self profile not found')

        if 'name' in params:
            profile.name = params['name']
            user.name = params['name']
        if 'birthday' in params:
            profile.birthday = params['birthday']
        if 'is_birthday_public' in params:
            profile.is_birthday_public = bool(params['is_birthday_public'])
        if 'comment' in params:
            profile.comment = params['comment']
        if 'favorite_card_before_awake' in params:
            profile.favorite_card_before_awake = bool(
                params['favorite_card_before_awake']
            )

        favorite_card_id = params.get('favorite_card_id')
        favorite_card = _owned_card(session, user_id, favorite_card_id)
        if favorite_card is not None:
            profile.favorite_card_id = favorite_card.card_id

        if 'mst_achievement_id' in params:
            profile.mst_achievement_id = int(params['mst_achievement_id'])
        if 'mst_achievement_id_list' in params:
            _store_achievement_list(profile, params.get('mst_achievement_id_list'))

        for helper in params.get('helper_card_id_list') or []:
            idol_type = int(helper.get('idol_type', 0))
            if idol_type not in (1, 2, 3, 4):
                continue
            card = _owned_card(session, user_id, helper.get('card_id'))
            if card is None:
                continue
            helper_state = session.scalar(
                select(HelperCard)
                .where(HelperCard.id_ == user_id)
                .where(HelperCard.idol_type == idol_type)
            )
            if helper_state is None:
                session.add(HelperCard(
                    id_=user_id,
                    idol_type=idol_type,
                    card_id=card.card_id,
                ))
            else:
                helper_state.card_id = card.card_id

        result = _mission_reply(session, user)
        session.commit()
        return result


@dispatcher.add_method(name='UserService.SetAchievementList', context_arg='context')
def set_achievement_list(params, context):
    """Persist the producer-card achievement list.

    The current client defines SetAchievementListReply as an empty class, so
    the exact successful wire payload is simply ``{}``.
    """
    user_id = _requester_id(context)
    with Session(engine) as session:
        profile = session.scalar(
            select(Profile).where(Profile.id_ == user_id)
        )
        if profile is None:
            raise LookupError('self profile not found')
        _store_achievement_list(
            profile,
            (params or {}).get('mst_achievement_id_list'),
        )
        session.commit()
    return {}
