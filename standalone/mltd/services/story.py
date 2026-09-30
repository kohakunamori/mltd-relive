from datetime import datetime, timezone
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import and_, func, or_, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import (
    Card,
    Costume,
    CostumeAdv,
    Episode,
    MainStoryChapter,
    Memorial,
    Mission,
    MstCard,
    MstComic,
    MstMainStoryChapter,
    MstMainStoryContactStatus,
    MstMemorial,
    MstMission,
    MstSpecialStory,
    MstTheaterCostumeBlog,
    MstTopics,
    MstWhiteBoard,
    Song,
    SpecialStory,
    User,
)
from mltd.models.schemas import (
    MainStoryChapterSchema,
    MissionSchema,
    MstComicSchema,
    MstMainStoryContactStatusSchema,
    MstRewardItemSchema,
    MstTopicsSchema,
    MstWhiteBoardSchema,
    SongSchema,
    SpecialStorySchema,
)
from mltd.servers.config import config
from mltd.servers.utilities import format_datetime
from mltd.services.mission import update_mission_progress
from mltd.services.utils import add_achievement, add_card, add_item


def _get_user(session, context):
    return session.scalars(
        select(User).where(User.user_id == UUID(context['user_id']))
    ).one()


def _reward_status_list(rewards):
    rewards = [reward for reward in rewards if reward is not None]
    if not rewards:
        return []
    return MstRewardItemSchema().dump(rewards, many=True)


def _grant_reward(session, user, reward):
    """Apply one MstRewardItem to the user's persistent state."""
    if reward.mst_card_id:
        card = session.scalar(
            select(Card)
            .where(Card.user_id == user.user_id)
            .where(Card.mst_card_id == reward.mst_card_id)
        )
        if card is None:
            add_card(session, user, reward.mst_card_id)

    if reward.mst_item_id:
        add_item(
            session=session,
            user=user,
            mst_item_id=reward.mst_item_id,
            item_type=reward.item_type,
            amount=reward.amount,
        )

    if reward.mst_costume_id:
        costume = session.scalar(
            select(Costume)
            .where(Costume.user_id == user.user_id)
            .where(Costume.mst_costume_id == reward.mst_costume_id)
        )
        if costume is None:
            session.add(Costume(
                costume_id=f'{user.user_id}_{reward.mst_costume_id}',
                user_id=user.user_id,
                mst_costume_id=reward.mst_costume_id,
            ))

    if reward.mst_achievement_id:
        add_achievement(session, user, reward.mst_achievement_id)


def _grant_rewards_once(session, user, state, rewards):
    """Mark a story state read and grant rewards exactly once."""
    if state.is_read:
        return []

    state.is_released = True
    state.is_read = True
    if hasattr(state, 'released_date') and state.released_date is None:
        state.released_date = datetime.now(timezone.utc)

    reward_list = [reward for reward in rewards if reward is not None]
    for reward in reward_list:
        _grant_reward(session, user, reward)
    return _reward_status_list(reward_list)


def _mission_reply(session, user, mission_class_id=None, progress=0,
                   option=None):
    """Update a small class of story-related missions and build API payloads."""
    if mission_class_id is None:
        return {
            'mission_process': {
                'complete_mission_list': [],
                'open_mission_list': [],
                'training_point_diff': {'before': 0, 'after': 0, 'total': 0},
            },
            'mission_list': [],
        }

    stmt = (
        select(Mission)
        .join(MstMission)
        .where(Mission.user == user)
        .where(MstMission.mst_mission_class_id == mission_class_id)
        .where(Mission.mission_state != 3)
    )
    if option is not None:
        stmt = stmt.where(MstMission.option == str(option))

    mission_schema = MissionSchema()
    changed = []
    completed = []
    for mission in session.scalars(stmt).all():
        before = (mission.progress, mission.mission_state)
        just_completed = update_mission_progress(
            session=session,
            user=user,
            mission=mission,
            progress=progress,
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
            'training_point_diff': {'before': 0, 'after': 0, 'total': 0},
        },
        'mission_list': changed,
    }


def _release_next_main_story(session, user_id, mst_main_story_id, chapter):
    next_state = session.scalar(
        select(MainStoryChapter)
        .where(MainStoryChapter.user_id == user_id)
        .where(or_(
            MainStoryChapter.mst_main_story_id > mst_main_story_id,
            and_(
                MainStoryChapter.mst_main_story_id == mst_main_story_id,
                MainStoryChapter.chapter > chapter,
            ),
        ))
        .order_by(
            MainStoryChapter.mst_main_story_id,
            MainStoryChapter.chapter,
        )
        .limit(1)
    )
    if next_state is None or next_state.is_released:
        return False, 0, 0

    next_state.is_released = True
    if next_state.released_date is None:
        next_state.released_date = datetime.now(timezone.utc)
    return True, next_state.mst_main_story_id, next_state.chapter


@dispatcher.add_method(name='StoryService.GetStoryList', context_arg='context')
def get_story_list(params, context):
    with Session(engine) as session:
        main_story_chapters = session.scalars(
            select(MainStoryChapter)
            .where(MainStoryChapter.user_id == UUID(context['user_id']))
        ).all()
        main_story_list = MainStoryChapterSchema().dump(
            main_story_chapters, many=True
        )

        contact_statuses = session.scalars(
            select(MstMainStoryContactStatus)
        ).all()
        contact_status_list = MstMainStoryContactStatusSchema().dump(
            contact_statuses, many=True
        )

    return {
        'main_story_list': main_story_list,
        'main_story_contact_status_list': contact_status_list,
    }


@dispatcher.add_method(name='StoryService.GetTopicsList')
def get_topics_list(params):
    with Session(engine) as session:
        recent_release_date = session.scalar(
            select(func.max(MstTopics.release_date))
        )
        if recent_release_date is not None:
            recent_release_date = recent_release_date.replace(
                tzinfo=timezone.utc
            ).astimezone(config.timezone)

        topics = session.scalars(select(MstTopics)).all()
        topics_status_list = MstTopicsSchema().dump(topics, many=True)

    return {
        'recent_release_date': (
            format_datetime(recent_release_date)
            if recent_release_date is not None else None
        ),
        'topics_status_list': topics_status_list,
    }


@dispatcher.add_method(name='StoryService.GetWhiteBoardList')
def get_white_board_list(params):
    with Session(engine) as session:
        recent_begin_date = session.scalar(
            select(func.max(MstWhiteBoard.begin_date))
        )
        if recent_begin_date is not None:
            recent_begin_date = recent_begin_date.replace(
                tzinfo=timezone.utc
            ).astimezone(config.timezone)

        white_boards = session.scalars(select(MstWhiteBoard)).all()
        white_board_status_list = MstWhiteBoardSchema().dump(
            white_boards, many=True
        )

    return {
        'recent_begin_date': (
            format_datetime(recent_begin_date)
            if recent_begin_date is not None else None
        ),
        'white_board_status_list': white_board_status_list,
    }


@dispatcher.add_method(
    name='StoryService.GetSpecialStoryList',
    context_arg='context',
)
def get_special_story_list(params, context):
    with Session(engine) as session:
        special_stories = session.scalars(
            select(SpecialStory)
            .where(SpecialStory.user_id == UUID(context['user_id']))
        ).all()
        status_list = SpecialStorySchema().dump(special_stories, many=True)

    return {'special_story_status_list': status_list}


@dispatcher.add_method(name='StoryService.GetOfferStoryList')
def get_offer_story_list(params):
    # Offer-story master/state tables are not present in the preserved
    # standalone database. The original list endpoint already exposes
    # this feature as unavailable.
    return {'offer_story_list': None}


@dispatcher.add_method(name='StoryService.GetComicList')
def get_comic_list(params):
    with Session(engine) as session:
        recent_begin_date = session.scalar(
            select(func.max(MstComic.begin_date))
        )
        if recent_begin_date is not None:
            recent_begin_date = recent_begin_date.replace(
                tzinfo=timezone.utc
            ).astimezone(config.timezone)

        comics = session.scalars(select(MstComic)).all()
        comic_status_list = MstComicSchema().dump(comics, many=True)

    return {
        'recent_begin_date': (
            format_datetime(recent_begin_date)
            if recent_begin_date is not None else None
        ),
        'comic_status_list': comic_status_list,
    }


@dispatcher.add_method(
    name='StoryService.FinishCostumeAdv',
    context_arg='context',
)
def finish_costume_adv(params, context):
    mst_id = params['mst_theater_costume_blog_id']
    with Session(engine) as session:
        user = _get_user(session, context)
        state = session.scalar(
            select(CostumeAdv)
            .where(CostumeAdv.user_id == user.user_id)
            .where(CostumeAdv.mst_theater_costume_blog_id == mst_id)
        )
        if state is None:
            master = session.get(MstTheaterCostumeBlog, mst_id)
            if master is None:
                return {'reward_item_status_list': []}
            state = CostumeAdv(
                user_id=user.user_id,
                mst_theater_costume_blog_id=mst_id,
                is_released=True,
                is_read=False,
                released_date=datetime.now(timezone.utc),
            )
            session.add(state)
            session.flush()

        rewards = [state.mst_theater_costume_blog.mst_reward_item]
        reward_statuses = _grant_rewards_once(
            session, user, state, rewards
        )
        session.commit()

    return {'reward_item_status_list': reward_statuses}


@dispatcher.add_method(
    name='StoryService.FinishEpisode',
    context_arg='context',
)
def finish_episode(params, context):
    mst_card_id = params['mst_card_id']
    with Session(engine) as session:
        user = _get_user(session, context)
        state = session.scalar(
            select(Episode)
            .where(Episode.user_id == user.user_id)
            .where(Episode.mst_card_id == mst_card_id)
        )
        if state is None:
            mst_card = session.get(MstCard, mst_card_id)
            if mst_card is None:
                result = {'reward_item_status_list': []}
                result.update(_mission_reply(session, user))
                return result
            state = Episode(
                user_id=user.user_id,
                mst_card_id=mst_card_id,
                is_released=True,
                is_read=False,
                released_date=datetime.now(timezone.utc),
                mst_reward_item_id=2 if mst_card.rarity == 1 else 3,
            )
            session.add(state)
            session.flush()

        was_read = state.is_read
        reward_statuses = _grant_rewards_once(
            session, user, state, [state.mst_reward_item]
        )
        mission_result = (
            _mission_reply(
                session,
                user,
                mission_class_id=54,
                progress=1,
                option=mst_card_id,
            )
            if not was_read
            else _mission_reply(session, user)
        )
        session.commit()

    result = {'reward_item_status_list': reward_statuses}
    result.update(mission_result)
    return result


@dispatcher.add_method(
    name='StoryService.FinishMemorial',
    context_arg='context',
)
def finish_memorial(params, context):
    ids = []
    single_id = params.get('mst_memorial_id', 0)
    if single_id:
        ids.append(single_id)
    ids.extend(params.get('mst_memorial_id_list') or [])
    ids = list(dict.fromkeys(ids))

    reward_statuses = []
    with Session(engine) as session:
        user = _get_user(session, context)
        for mst_memorial_id in ids:
            state = session.scalar(
                select(Memorial)
                .where(Memorial.user_id == user.user_id)
                .where(Memorial.mst_memorial_id == mst_memorial_id)
            )
            if state is None:
                master = session.get(MstMemorial, mst_memorial_id)
                if master is None:
                    continue
                state = Memorial(
                    user_id=user.user_id,
                    mst_memorial_id=mst_memorial_id,
                    is_released=True,
                    is_read=False,
                    released_date=datetime.now(timezone.utc),
                )
                session.add(state)
                session.flush()

            reward_statuses.extend(_grant_rewards_once(
                session,
                user,
                state,
                [state.mst_memorial.mst_reward_item],
            ))

        mission_result = _mission_reply(session, user)
        session.commit()

    result = {'reward_item_status_list': reward_statuses}
    result.update(mission_result)
    return result


@dispatcher.add_method(
    name='StoryService.FinishSpecialStory',
    context_arg='context',
)
def finish_special_story(params, context):
    ids = list(dict.fromkeys(params.get('mst_special_story_id_list') or []))
    reward_statuses = []

    with Session(engine) as session:
        user = _get_user(session, context)
        for mst_special_story_id in ids:
            state = session.scalar(
                select(SpecialStory)
                .where(SpecialStory.user_id == user.user_id)
                .where(
                    SpecialStory.mst_special_story_id == mst_special_story_id
                )
            )
            if state is None:
                master = session.get(MstSpecialStory, mst_special_story_id)
                if master is None:
                    continue
                state = SpecialStory(
                    user_id=user.user_id,
                    mst_special_story_id=mst_special_story_id,
                    is_released=True,
                    is_read=False,
                )
                session.add(state)
                session.flush()

            reward_statuses.extend(_grant_rewards_once(
                session,
                user,
                state,
                [state.mst_special_story.mst_reward_item],
            ))

        session.commit()

    return {'reward_item_status_list': reward_statuses}


@dispatcher.add_method(
    name='StoryService.FinishOfferStory',
    context_arg='context',
)
def finish_offer_story(params, context):
    # GetOfferStoryList returns None because this database snapshot has no
    # offer-story state/master tables. Register the RPC so old client paths
    # remain JSON-RPC compatible instead of failing with -32601.
    return {'reward_item_status_list': []}


@dispatcher.add_method(
    name='StoryService.FinishMainStory',
    context_arg='context',
)
def finish_main_story(params, context):
    mst_main_story_id = params['mst_main_story_id']
    chapter = params['chapter']

    with Session(engine) as session:
        user = _get_user(session, context)
        state = session.scalar(
            select(MainStoryChapter)
            .where(MainStoryChapter.user_id == user.user_id)
            .where(MainStoryChapter.mst_main_story_id == mst_main_story_id)
            .where(MainStoryChapter.chapter == chapter)
        )
        if state is None:
            master_chapter = session.scalar(
                select(MstMainStoryChapter)
                .where(
                    MstMainStoryChapter.mst_main_story_id == mst_main_story_id
                )
                .where(MstMainStoryChapter.chapter == chapter)
            )
            if master_chapter is None:
                result = {
                    'reward_item_status_list': [],
                    'reward_mst_song_id': 0,
                    'song': None,
                    'release_blog': None,
                    'is_release_next': False,
                    'next_mst_main_story_id': 0,
                    'next_chapter': 0,
                }
                result.update(_mission_reply(session, user))
                return result
            state = MainStoryChapter(
                user_id=user.user_id,
                mst_main_story_id=mst_main_story_id,
                chapter=chapter,
                released_date=datetime.now(timezone.utc),
                is_released=True,
                is_read=False,
            )
            session.add(state)
            session.flush()

        was_read = state.is_read
        state.is_released = True
        if state.released_date is None:
            state.released_date = datetime.now(timezone.utc)
        if not state.is_read:
            state.is_read = True

        is_release_next = False
        next_story_id = 0
        next_chapter = 0
        reward_statuses = []
        reward_song_id = 0
        song_status = None
        mission_result = _mission_reply(session, user)

        if not was_read:
            is_release_next, next_story_id, next_chapter = (
                _release_next_main_story(
                    session,
                    user.user_id,
                    mst_main_story_id,
                    chapter,
                )
            )

            last_chapter = session.scalar(
                select(func.max(MstMainStoryChapter.chapter))
                .where(
                    MstMainStoryChapter.mst_main_story_id == mst_main_story_id
                )
            )
            if last_chapter is None:
                last_chapter = chapter

            if chapter == last_chapter:
                rewards = list(state.mst_main_story.mst_reward_items)
                for reward in rewards:
                    _grant_reward(session, user, reward)
                reward_statuses = _reward_status_list(rewards)

                reward_song_id = state.mst_main_story.reward_song_id
                if reward_song_id:
                    song = session.scalar(
                        select(Song)
                        .where(Song.user_id == user.user_id)
                        .where(Song.mst_song_id == reward_song_id)
                    )
                    if song is not None:
                        song.is_disable = False
                        song_status = SongSchema().dump(song)
                    else:
                        reward_song_id = 0

                mission_result = _mission_reply(
                    session,
                    user,
                    mission_class_id=20,
                    progress=mst_main_story_id,
                )

        session.commit()

    result = {
        'reward_item_status_list': reward_statuses,
        'reward_mst_song_id': reward_song_id,
        'song': song_status,
        'release_blog': None,
        'is_release_next': is_release_next,
        'next_mst_main_story_id': next_story_id,
        'next_chapter': next_chapter,
    }
    result.update(mission_result)
    return result


@dispatcher.add_method(
    name='StoryService.PlayStoryMV',
    context_arg='context',
)
def play_story_mv(params, context):
    # Reverse-engineered PlayStoryMvReply has no fields. Story/MV assets are
    # client-side; this request only needs an acknowledged RPC response.
    return {}
