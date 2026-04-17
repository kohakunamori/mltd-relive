from datetime import datetime, timedelta, timezone
from enum import Enum
import random
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import func, or_, select
from sqlalchemy.orm import Session
from mltd.models.engine import engine
from mltd.models.models import Card, Costume, Idol, Item, Memorial, Mission, MstCard, MstMemorial, MstMission, MstRewardItem, MstTheaterContact, Present, User
from mltd.models.schemas import GashaMedalSchema, IdolSchema, ItemSchema, MemorialSchema, MissionSchema, MstRewardItemSchema
from mltd.services.utils import add_item, add_present
from mltd.services.mission import update_mission_progress
from mltd.services.idol import localize_character_name
from mltd.servers.i18n import translation
_ = translation.gettext
def init_main_story_contact(
        session,
        available_room_list
):
    # TODO: main commu contact
    return None

def init_guest_main_story_contact(
        session,
        available_room_list
):
    # TODO: guest main commu contact
    return None

def init_theater_blog_contact(
        session,
        available_room_list
):
    # TODO: theater blog contact
    return None

def init_costume_blog_contact(
        session,
        available_room_list
):
    #TODO
    return None

def get_theater_display_room(
        
):
    #TODO: misaki's motion
    return {
        'mst_room_id': 0,
        'balloon': {
            'theater_contact_category_type': 0,
            'room_idol_list': None,
            'resource_id': '',
            'mst_theater_contact_schedule_id': 0,
            'mst_theater_contact_id': 0,
            'mst_theater_main_story_id': 0,
            'mst_theater_guest_main_story_id': 0,
            'guest_main_story_has_intro': False,
            'mst_guest_main_story_id': 0,
            'mst_theater_blog_id': 0,
            'mst_theater_costume_blog_id': 0,
            'mst_costume_id': 0,
            'mst_theater_event_story_id': 0,
            'mst_event_story_id': 0,
            'mst_event_id': 0
        }
    }

def get_theater_status(
    session: Session,
    user: User,
    now: datetime
):
    room_status_list = []
    idol_booking_list = []
    available_room_list = [1, 2, 3, 4]
    main_story_room_status = init_main_story_contact(session, available_room_list)
    if main_story_room_status is not None:
        available_room_list.remove(main_story_room_status['mst_room_id'])
        room_status_list.append(main_story_room_status)
        idol_booking_list.extend(
            [
                idol_status['mst_idol_id'] 
                    for idol_status in
                        main_story_room_status['balloon']['room_idol_list']
            ]
        )

    guest_story_room_status = init_guest_main_story_contact(session, available_room_list)
    if guest_story_room_status is not None:
        available_room_list.remove(guest_story_room_status['mst_room_id'])
        room_status_list.append(guest_story_room_status)
        idol_booking_list.extend(
            [
                idol_status['mst_idol_id'] 
                    for idol_status in
                        guest_story_room_status['balloon']['room_idol_list']
            ]
        )
    
    theater_blog_room_status = init_theater_blog_contact(session, available_room_list)
    if theater_blog_room_status is not None:
        available_room_list.remove(theater_blog_room_status['mst_room_id'])
        room_status_list.append(theater_blog_room_status)
        idol_booking_list.extend(
            [
                idol_status['mst_idol_id'] 
                    for idol_status in
                        theater_blog_room_status['balloon']['room_idol_list']
            ]
        )
    
    costume_blog_room_status = init_costume_blog_contact(session, available_room_list)
    if costume_blog_room_status is not None:
        available_room_list.remove(costume_blog_room_status['mst_room_id'])
        room_status_list.append(costume_blog_room_status)
        idol_booking_list.extend(
            [
                idol_status['mst_idol_id'] 
                    for idol_status in
                        costume_blog_room_status['balloon']['room_idol_list']
            ]
        )

    contact_schedules = [user.contact_schedule_5, user.contact_schedule_10, user.contact_schedule_20]
    available_contact_schedule_ids = []
    for i, schedule in enumerate(contact_schedules):
        if now >= schedule.replace(tzinfo=timezone.utc):
            available_contact_schedule_ids.append(i+1)
    
    if len(available_contact_schedule_ids) > len(available_room_list):
        available_contact_schedule_ids = random.sample(
            available_contact_schedule_ids, 
            k=len(available_room_list)
        )
    
    if len(available_room_list) > len(available_contact_schedule_ids):
        available_room_list = random.sample(
            available_room_list,
            k=len(available_contact_schedule_ids)
        )
    
    owned_card_ids = session.scalars(
        select(Card.mst_card_id)
        .where(Card.user_id == user.user_id)
    ).all()


    if (len(available_contact_schedule_ids) > 0
        and len(idol_booking_list) > 0):
        idol_booking_list.append(0)

    for i, room_id in enumerate(available_room_list):
        random_contact = session.query(MstTheaterContact).filter(
            or_(MstTheaterContact.mst_card_id.in_(owned_card_ids),
                MstTheaterContact.mst_card_id == 0),
            or_(MstTheaterContact.room_id == room_id,    
                MstTheaterContact.room_id == 0)
        ).order_by(func.random()).first()
        mst_costume_id = 0
        if random_contact.mst_card_id != 0 and random_contact.room_id == 3:
            mst_card = session.scalars(
                select(MstCard)
                .where(MstCard.mst_card_id == random_contact.mst_card_id)
            ).one()
            mst_card_costumes = [
                mst_card.mst_costume_id,
                mst_card.bonus_costume_id,
                mst_card.rank5_costume_id
            ]

            available_costumes = []
            for costume in mst_card_costumes:
                if costume != 0:
                    available_costumes.append(costume)
            if len(available_costumes) > 0:        
                available_costumes = session.scalars(
                    select(Costume.mst_costume_id)
                    .where(Costume.user_id == user.user_id)
                    .where(Costume.mst_costume_id.in_(available_costumes))
                ).all()
                
                mst_costume_id = random.choice(available_costumes)
        idol_booking_list.append(random_contact.mst_idol_id)
        room_status_list.append({
            "mst_room_id": room_id,
            "balloon": {
                "theater_contact_category_type": 1,
                "room_idol_list": [
                    {
                        "mst_idol_id": random_contact.mst_idol_id,
                        "position_id": random_contact.position_id,
                        "motion_id": random_contact.motion_id,
                        "reaction_id": random_contact.reaction_id,
                        "reaction_id_2": random_contact.reaction_id2
                    }
                ],
                "resource_id": random_contact.resource_id,
                "mst_theater_contact_schedule_id": available_contact_schedule_ids[i],
                "mst_theater_contact_id": random_contact.mst_theater_contact_id,
                "mst_theater_main_story_id": 0,
                "mst_theater_guest_main_story_id": 0,
                "guest_main_story_has_intro": False,
                "mst_guest_main_story_id": 0,
                "mst_theater_blog_id": 0,
                "mst_theater_costume_blog_id": 0,
                "mst_costume_id": mst_costume_id,
                "mst_theater_event_story_id": 0,
                "mst_event_story_id": 0,
                "mst_event_id": 0
            }
        })
    
    return {
        'room_list': room_status_list,
        'idol_booking_list': idol_booking_list,
        'theater_display_room': get_theater_display_room(),
    }

@dispatcher.add_method(name='TheaterService.GetTheater', context_arg='context')
def get_theater(params, context):
    """Service for getting theater info.

    Invoked in the following situations.
    1. After logging in.
    2. When the game is transitioning back to the theater screen after a
       long period of time (at least 15 minutes after the last
       invocation).
    Args:
        params: A empty dict.
    Returns:
        A dict containing the following keys.
        theater_opening:
    """
    # TODO: Returning empty theater info for now. Replace this with
    # actual implementation.
    now = datetime.now(timezone.utc)
    with Session(engine) as session:
        user = session.scalars(
            select(User)
            .where(User.user_id == UUID(context['user_id']))
        ).one()
        theater_status = get_theater_status(session, user, now)

    return {
        'theater_opening': {
            'mst_theater_opening_id': 0,
            'opening_type': 0,
            'resource_id': '',
            'jump_type': '',
            'cue_sheet': '',
            'cue_name': '',
            'mv_status': {
                'mst_song_id': 0,
                'mv_unit_idol_list': None
            }
        },
        'theater_opening_list': None,
        'theater': theater_status
    }

@dispatcher.add_method(name='TheaterService.FinishContact', context_arg='context')
def finish_contact(params, context):
    """Service for finishing a contact.

    Invoked when the user completes a contact.
    Args:
        params: A dict containing the following keys.
            theater_contact_category_type: 
                None: 0
                Constant: 1
                MainStory: 2
                EventStory: 3
                CostumeBlog: 4
                Blog: 5
                GuestMainStory: 6
            mst_theater_contact_schedule_id: 
                contact schedule id for constant contact, int value in [1, 2, 3]
                1 for 5-affection contact
                2 for 10-affection contact
                3 for 20-affection contact
            mst_theater_contact_id: master contact id
	        mst_theater_main_story_id: master theater main story id
	        mst_theater_blog_id: master theater blog id
	        mst_theater_costume_blog_id:    master theater constume blog id
	        mst_theater_event_story_id: master theater event story id
	        mst_theater_guest_main_story_id: master theater guest main story id

    Returns:
        A dict containing the following keys.
        theater:
        result_idol_list:
        before_produce_gauge:
        after_produce_gauge:
        contact_fixed_reward:
        contact_drop_reward:
        contact_gasha_medal:
        produce_gauge_max_drop_reward:
        produce_gauge_max_gasha_medal:
        result_drop_reward:
        mission_process:
        mission_list:
        updated_idol_list:
        updated_item_list:
        gasha_medal:
        produce_gauge:
        has_new_present:
    """
    now = datetime.now(timezone.utc)
    mst_theater_contact_schedule_id = params['mst_theater_contact_schedule_id']
    with Session(engine) as session:
        user = session.scalars(
            select(User)
            .where(User.user_id == UUID(context['user_id']))
        ).one()
        mst_idol_id = session.scalars(
            select(MstTheaterContact.mst_idol_id)
            .where(MstTheaterContact.mst_theater_contact_id == params['mst_theater_contact_id'])
        ).one()
        
        gained_affection = [0, 5, 10, 20][mst_theater_contact_schedule_id]
        before_produce_gauge = user.produce_gauge
        after_produce_gauge = before_produce_gauge + gained_affection
        produce_gauge_max = after_produce_gauge >= 100
        if produce_gauge_max:
            after_produce_gauge -= 100
        has_new_present = False

        #region Update idol info.
        memorial_schema = MemorialSchema()
        idol = session.scalars(
            select(Idol)
            .where(Idol.user_id == user.user_id)
            .where(Idol.mst_idol_id == mst_idol_id)
        ).one()
        before_affection = idol.affection
        after_affection = before_affection + gained_affection
        result_idol = {
            'mst_idol_id': mst_idol_id,
            'before_awake_gauge': 0,
            'after_awake_gauge': 0,
            'max_awake_gauge': 0,
            'before_fan': idol.fan,
            'after_fan': idol.fan,
            'before_affection': before_affection,
            'after_affection': after_affection,
            'memorial_status': {
                'mst_memorial_id': 0,
                'scenario_id': '',
                'mst_idol_id': 0,
                'release_affection': 0,
                'number': 0,
                'is_released': False,
                'is_read': False,
                'released_date': None,
                'reward_item_list': None,
                'is_available': False,
                'begin_date': None
            },
            'memorial_list': None
        }
        memorial_id = session.scalar(
            select(MstMemorial.mst_memorial_id)
            .where(MstMemorial.mst_idol_id == idol.mst_idol_id)
            .where(before_affection < MstMemorial.release_affection)
            .where(MstMemorial.release_affection <= after_affection)
        )
        if memorial_id:
            memorial = session.scalars(
                select(Memorial)
                .where(Memorial.user == user)
                .where(Memorial.mst_memorial_id == memorial_id)
            ).one()
            memorial_dict = memorial_schema.dump(memorial)
            result_idol['memorial_status'] = memorial_dict
            result_idol['memorial_list'] = [memorial_dict]
        idol.fan = result_idol['after_fan']
        idol.affection = result_idol['after_affection']
        if memorial_id:
            memorial.is_released = True
        idol_schema = IdolSchema()
        updated_idol_list = [idol_schema.dump(idol)]

        #endregion
        #region Pick random drop rewards and give them to the user.
        card_status_list = []
        # The drop rates are an approximation based on the following
        # 1309 items dropped across 245 songs.
        # Stage dress           105 ( 73 on non-item days)
        # Mini crown            116 ( 84 on non-item days)
        # Lipstick              187 (107 on non-item days)
        # Perfume               229 (150 on non-item days)
        # Mirror                112 ( 64 on non-item days)
        # Gasha medal 10pt       66
        # Gasha medal 15pt       79
        # Gasha medal 20pt       66
        # Lesson ticket N        74
        # Lesson ticket R        65
        # Throat lozenges         4
        # Tapioca drink           9
        # High cocoa chocolate    9
        # Roll cake               6
        # Fan letter              9
        # Single flower          10
        # Hand cream             10
        # Bath additive           5
        # Auto live pass         10
        # N cards               113
        # R cards                17
        # Costumes                8
        class DropType(Enum):
            AWAKENING_ITEM = 55.0
            GASHA_MEDAL_PT = 15.0
            LESSON_TICKET = 20.0
            SPARK_DRINK = 10.0

        class AwakeningDropType(Enum):
            STAGE_DRESS = (4, 100, 15.7)
            MINI_CROWN = (4, 101, 17.7)
            PRINCESS_LIPSTICK = (1, 110, 7.4)
            PRINCESS_PERFUME = (1, 111, 10.4)
            PRINCESS_MIRROR = (1, 112, 4.4)
            FAIRY_LIPSTICK = (2, 120, 7.4)
            FAIRY_PERFUME = (2, 121, 10.4)
            FAIRY_MIRROR = (2, 122, 4.4)
            ANGEL_LIPSTICK = (3, 130, 7.4)
            ANGEL_PERFUME = (3, 131, 10.4)
            ANGEL_MIRROR = (3, 132, 4.4)
            def __init__(self, idol_type, mst_item_id, weight):
                self.idol_type = idol_type
                self.mst_item_id = mst_item_id
                self.weight = weight

        old_gasha_medals = len(user.gasha_medal.gasha_medal_expire_dates)
        old_gasha_medal_pt = user.gasha_medal.point_amount
        dropped_gasha_medal_pt = 0
        dropped_gasha_medal_pt_produce_gauge = 0
        drop_reward_box_list = None
        updated_item_ids = []
        drop_reward_box_list = []
        drop_reward_box_list_produce_gauge = []
        allowed_drops = [
            DropType.AWAKENING_ITEM,
            DropType.GASHA_MEDAL_PT,
            DropType.LESSON_TICKET,
            DropType.SPARK_DRINK
        ]
        reward_item_schema = MstRewardItemSchema()
        drop_count = random.randint(1, 5)
        drop_count_produce_gauge = 4 if produce_gauge_max else 0
        selected_drops = random.choices(
            allowed_drops, [x.value for x in allowed_drops], k=drop_count)
        selected_drops_produce_gauge = random.choices(
            allowed_drops, [x.value for x in allowed_drops], k=drop_count_produce_gauge)
        for i, drop_type in enumerate(selected_drops + selected_drops_produce_gauge):
            if drop_type is DropType.AWAKENING_ITEM:
                allowed_awakening_drops = [
                    AwakeningDropType.STAGE_DRESS,
                    AwakeningDropType.MINI_CROWN,
                    AwakeningDropType.PRINCESS_LIPSTICK,
                    AwakeningDropType.PRINCESS_PERFUME,
                    AwakeningDropType.PRINCESS_MIRROR,
                    AwakeningDropType.FAIRY_LIPSTICK,
                    AwakeningDropType.FAIRY_PERFUME,
                    AwakeningDropType.FAIRY_MIRROR,
                    AwakeningDropType.ANGEL_LIPSTICK,
                    AwakeningDropType.ANGEL_PERFUME,
                    AwakeningDropType.ANGEL_MIRROR
                ]
                selected_awakening_drop = random.choices(
                    allowed_awakening_drops,
                    [x.weight for x in allowed_awakening_drops], k=1)[0]
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_awakening_drop.mst_item_id,
                    item_type=7,
                    amount=1
                )
            elif drop_type is DropType.GASHA_MEDAL_PT:
                selected_item_id = random.choice([502, 503, 504])
                pt = (
                    10 if selected_item_id == 502
                    else 15 if selected_item_id == 503
                    else 20)
                if i < drop_count:
                    dropped_gasha_medal_pt += pt
                else:
                    dropped_gasha_medal_pt_produce_gauge += pt
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_item_id,
                    item_type=4,
                    amount=1
                )
            elif drop_type is DropType.LESSON_TICKET:
                selected_item_id = random.choice([200, 201])
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_item_id,
                    item_type=8,
                    amount=1
                )
            elif drop_type is DropType.SPARK_DRINK:
                selected_item_id = random.choices(
                    [20, 21, 22],
                    [6, 3, 2], k=1)[0]
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_item_id,
                    item_type=6,
                    amount=1
                )
            if i < drop_count:
                drop_reward_box_list.append({
                    'drop_reward_item': reward_item_schema.dump(
                        drop_reward_item),
                    'substitute_list': None,
                    'drop_reward_group_type': 1
                })
            else:
                drop_reward_box_list_produce_gauge.append({
                    'drop_reward_item': reward_item_schema.dump(
                        drop_reward_item),
                    'substitute_list': None,
                    'drop_reward_group_type': 1
                })
            if drop_reward_item.mst_item_id and drop_type is not DropType.SPARK_DRINK:
                add_item(
                    session=session,
                    user=user,
                    mst_item_id=drop_reward_item.mst_item_id,
                    item_type=drop_reward_item.item_type)
                if drop_type is not DropType.GASHA_MEDAL_PT:
                    updated_item_ids.append(drop_reward_item.mst_item_id)
            elif drop_type is DropType.SPARK_DRINK:
                has_new_present = True
                add_present(
                    session=session,
                    user=user,
                    present=Present(
                        user_id=user.user_id,
                        comment=_(
                            'Reward obtained from interacting with {idol_name}'
                        ).format(idol_name=localize_character_name(int(mst_idol_id))),
                        amount=1,
                        item_id=f'{user.user_id}_{drop_reward_item.mst_item_id}'
                    )
                )

        result_gasha_medal = {
            'before_gauge': 0,
            'after_gauge': 0,
            'get_point': 0,
            'count': 0,
            'expire_date': None,
            'is_over': False
        }
        result_gasha_medal_produce_gauge = {
            'before_gauge': 0,
            'after_gauge': 0,
            'get_point': 0,
            'count': 0,
            'expire_date': None,
            'is_over': False
        }
        if dropped_gasha_medal_pt:
            old_total_pt = old_gasha_medals*100 + old_gasha_medal_pt
            new_total_pt = min(old_total_pt + dropped_gasha_medal_pt, 1000)
            new_gasha_medals = new_total_pt // 100
            new_gasha_medal_pt = new_total_pt - old_total_pt
            result_gasha_medal['before_gauge'] = old_gasha_medal_pt
            result_gasha_medal['after_gauge'] = new_gasha_medal_pt
            result_gasha_medal['get_point'] = dropped_gasha_medal_pt
            result_gasha_medal['count'] = new_gasha_medals - old_gasha_medals
            if new_gasha_medals > old_gasha_medals:
                result_gasha_medal['expire_date'] = now + timedelta(days=7)
            else:
                result_gasha_medal['expire_date'] = datetime(1, 1, 1)
            result_gasha_medal['is_over'] = (
                new_gasha_medal_pt < dropped_gasha_medal_pt)
            old_gasha_medals = new_gasha_medals
            old_gasha_medal_pt = new_gasha_medal_pt
        if dropped_gasha_medal_pt_produce_gauge:
            old_total_pt = old_gasha_medals*100 + old_gasha_medal_pt
            new_total_pt = min(old_total_pt + dropped_gasha_medal_pt_produce_gauge, 1000)
            new_gasha_medals = new_total_pt // 100
            new_gasha_medal_pt = new_total_pt - old_total_pt
            result_gasha_medal_produce_gauge['before_gauge'] = old_gasha_medal_pt
            result_gasha_medal_produce_gauge['after_gauge'] = new_gasha_medal_pt
            result_gasha_medal_produce_gauge['get_point'] = dropped_gasha_medal_pt
            result_gasha_medal_produce_gauge['count'] = new_gasha_medals - old_gasha_medals
            if new_gasha_medals > old_gasha_medals:
                result_gasha_medal_produce_gauge['expire_date'] = now + timedelta(days=7)
            else:
                result_gasha_medal_produce_gauge['expire_date'] = datetime(1, 1, 1)
            result_gasha_medal_produce_gauge['is_over'] = (
                new_gasha_medal_pt < dropped_gasha_medal_pt)
        drop_reward = {
            'drop_reward_box_list': drop_reward_box_list
        }
        drop_reward_produce_gauge = {
            'drop_reward_box_list': drop_reward_box_list_produce_gauge
        }
        updated_items = session.scalars(
            select(Item)
            .where(Item.user == user)
            .where(Item.mst_item_id.in_(updated_item_ids))
        ).all()
        updated_item_list = []
        if updated_items:
            item_schema = ItemSchema()
            updated_item_list = item_schema.dump(updated_items, many=True)
        gasha_medal_schema = GashaMedalSchema()
        gasha_medal = gasha_medal_schema.dump(user.gasha_medal)
        #endregion

        mission_list = []
        mission_schema = MissionSchema()
        # Update weekly mission progress.
        daily_contact_mission = session.scalar(
            select(Mission)
            .where(Mission.user == user)
            .where(Mission.mst_mission_id == 73)
            .where(Mission.mission_state == 1)
        )
        if daily_contact_mission:
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=daily_contact_mission,
                progress=daily_contact_mission.progress + 1
            )
            if is_complete:
                mission_list.append(mission_schema.dump(daily_contact_mission))
                daily_total_mission = session.scalar(
                    select(Mission)
                    .where(Mission.user == user)
                    .where(Mission.mst_mission_id == 75)
                    .where(Mission.mission_state == 1)
                )
                if daily_total_mission:
                    is_complete = update_mission_progress(
                        session=session,
                        user=user,
                        mission=daily_total_mission,
                        progress=daily_total_mission.progress + 1
                    )
                    if is_complete:
                        mission_list.append(
                            mission_schema.dump(daily_total_mission))

        affection_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 6)
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in affection_missions:
            progress = mission.progress
            if (result_idol['before_affection']
                    < int(mission.mst_mission.option)
                    and int(mission.mst_mission.option)
                    <= result_idol['after_affection']):
                progress += 1
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=progress
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))

        # Update idol mission progress.
        idol_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 36)
            .where(MstMission.option == str(result_idol['mst_idol_id']))
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in idol_missions:
            progress = mission.progress
            if (result_idol['mst_idol_id']
                    == int(mission.mst_mission.option)
                    and result_idol['after_affection'] > progress):
                progress = result_idol['after_affection']
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=progress
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))

        # TODO: time-limited missions

        user.produce_gauge = after_produce_gauge
        #endregion
        # update user contact schedule
        if mst_theater_contact_schedule_id == 1:
            user.contact_schedule_5 = now + timedelta(hours=0.5)
        elif mst_theater_contact_schedule_id == 2:
            user.contact_schedule_10 = now + timedelta(hours=1)
        else:
            user.contact_schedule_15 = now + timedelta(hours=2)
        # get new theater status at last
        theater_status = get_theater_status(session, user, now) 
        session.commit()
    return {
        'theater': theater_status,
        'result_idol_list': [result_idol],
        'before_produce_gauge': before_produce_gauge,
        'after_produce_gauge': after_produce_gauge,
        'contact_fixed_reward': {
            "drop_reward_box_list":[]
        },
        'contact_drop_reward': drop_reward,
        'contact_gasha_medal': result_gasha_medal,
        'produce_gauge_max_drop_reward': drop_reward_produce_gauge,
        'produce_gauge_max_gasha_medal': result_gasha_medal_produce_gauge,
        'result_drop_reward': {
            "drop_reward_box_list":None
        },
        'mission_process': {
            'complete_mission_list': mission_list,
            'open_mission_list': [],
            'training_point_diff': {
                'before': 0,
                'after': 0,
                'total': 0
            }
        },
        'mission_list':  mission_list,
        'updated_idol_list': updated_idol_list,
        'updated_item_list': updated_item_list,
        'gasha_medal': gasha_medal,
        'produce_gauge': after_produce_gauge,
        'has_new_present': has_new_present,
    }