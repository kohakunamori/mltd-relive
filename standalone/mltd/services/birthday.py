from datetime import datetime, timezone
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import (Birthday, Idol, Item, Memorial, Mission,
                                MstBirthdayCalendar, MstIdol, MstItem,
                                MstMemorial, MstMission, Present, User)
from mltd.models.schemas import (BirthdaySchema, IdolSchema, MemorialSchema,
                                 MissionSchema, MstBirthdayCalendarSchema,
                                 PresentSchema)
from mltd.servers.config import config
from mltd.services.mission import update_mission_progress
from mltd.services.utils import add_item, add_present


BIRTHDAY_AFFECTION_REWARD = 100
BIRTHDAY_MACARON_BY_IDOL_TYPE = {
    1: 26,  # 感謝のマカロン[Princess]
    2: 27,  # 感謝のマカロン[Fairy]
    3: 28,  # 感謝のマカロン[Angel]
    0: 29,  # 感謝のマカロン[Attendant]
}


def get_birthday_entrance_direction_resource(
        session: Session,
        mst_character_id,
        birthday_month):
    """Get the entrance direction resource ID for a birthday character.

    Args:
        session: Existing SQLAlchemy session.
        mst_character_id: Master idol ID (1-11, 13-52) or Master
                          secretary ID (101-102) of the birthday
                          character.
        birthday_month: Birthday month.
    Returns:
        A string representing the latest available entrance direction
        resource ID for the birthday character.
    """
    if mst_character_id == 12:      # 雙海真美
        raise ValueError('No resource for mst_character_id=12')
    elif mst_character_id == 101:   # 音無小鳥
        return '101kot,003'
    elif mst_character_id == 102:   # 青羽美咲
        return '102mis,2018'
    else:
        idol_resource_id = session.scalars(
            select(MstIdol.resource_id)
            .where(MstIdol.mst_idol_id == mst_character_id)
        ).one()
        if 7 <= birthday_month and birthday_month <= 9:
            # Return 2019 resource for birthdays between Jul and Sep.
            return f'{idol_resource_id},003'
        else:
            # Return 2018 resource for birthdays in other months.
            return f'{idol_resource_id},2018'


def _empty_memorial_status():
    """Return the null MemorialStatus shape used by other affection RPCs."""
    return {
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
        'begin_date': None,
    }


def _mission_process(mission_list):
    return {
        'complete_mission_list': mission_list,
        'open_mission_list': [],
        'training_point_diff': {
            'before': 0,
            'after': 0,
            'total': 0,
        },
    }


def _update_affection_missions(session, user, result_idol):
    """Apply the same affection mission rules used by Live/Job/Theater."""
    mission_schema = MissionSchema()
    completed = []

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
        threshold = int(mission.mst_mission.option)
        if (result_idol['before_affection'] < threshold
                <= result_idol['after_affection']):
            progress += 1
        if update_mission_progress(session, user, mission, progress):
            completed.append(mission_schema.dump(mission))

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
        progress = max(mission.progress, result_idol['after_affection'])
        if update_mission_progress(session, user, mission, progress):
            completed.append(mission_schema.dump(mission))

    return completed


def _grant_birthday_macaron(session, user, mst_item_id):
    """Grant one macaron immediately, preserving overflow in Present box.

    Birthday's client contract returns PresentStatus[] even though the normal
    path receives the item immediately. Creating a real Present first and then
    applying the same receive/over-limit semantics as PresentService keeps the
    reply and persistent state consistent.
    """
    mst_item = session.scalar(
        select(MstItem).where(MstItem.mst_item_id == mst_item_id)
    )
    if mst_item is None:
        raise ValueError(f'missing birthday reward item {mst_item_id}')

    present = Present(
        user_id=user.user_id,
        comment='',
        amount=1,
        item_id=f'{user.user_id}_{mst_item_id}',
    )
    add_present(session, user, present)
    session.flush()

    # Re-load through the mapped relationship so PresentSchema emits the same
    # nested ItemStatus shape as PresentService.
    present = session.scalar(
        select(Present).where(Present.present_id == present.present_id)
    )
    present_result = PresentSchema().dump(present)

    item = session.scalar(
        select(Item)
        .where(Item.user_id == user.user_id)
        .where(Item.mst_item_id == mst_item_id)
    )
    before_amount = 0 if item is None else item.amount
    over_limit = (
        mst_item.max_amount != 0
        and before_amount + 1 > mst_item.max_amount
    )
    if over_limit:
        # Keep the arrival in the real present box for later receipt.
        present_result['present_state'] = 5
    else:
        add_item(
            session=session,
            user=user,
            mst_item_id=mst_item_id,
            item_type=mst_item.item_type,
            amount=1,
        )
        session.delete(present)
        present_result['present_state'] = 2

    return present_result


@dispatcher.add_method(name='BirthdayService.GetBirthday',
                       context_arg='context')
def get_birthday(params, context):
    """Service for getting character birthday info for a user.

    Invoked in the following situations.
    1. As part of the initial batch requests after logging in.
    2. When the game is transitioning to the theater screen.
    """
    user_id = UUID(context['user_id'])
    now = datetime.now(timezone.utc)
    server_year = now.astimezone(config.timezone).year
    server_month = now.astimezone(config.timezone).month
    server_day = now.astimezone(config.timezone).day

    with Session(engine) as session:
        birthday_calendars = session.scalars(
            select(MstBirthdayCalendar)
        ).all()

        birthday_calendar_schema = MstBirthdayCalendarSchema()
        birthday_calendar_list = (
            birthday_calendar_schema.dump(birthday_calendars, many=True))

        birthday_list = None
        entrance_direction_resource_id_list = None
        birthday_character_ids = []
        for birthday in birthday_calendars:
            if (server_month == birthday.birthday_month
                    and server_day == birthday.birthday_day):
                birthday_character_ids.append(birthday.mst_character_id)
        if birthday_character_ids:
            inserted_character_ids = session.scalars(
                select(Birthday.mst_character_id)
                .where(Birthday.user_id == user_id)
                .where(Birthday.year == server_year)
                .where(Birthday.mst_character_id.in_(birthday_character_ids))
            ).all()
            for character_id in birthday_character_ids:
                if character_id not in inserted_character_ids:
                    session.add(Birthday(
                        user_id=user_id,
                        year=server_year,
                        mst_character_id=character_id
                    ))
            birthdays = session.scalars(
                select(Birthday)
                .where(Birthday.user_id == user_id)
                .where(Birthday.year == server_year)
                .where(Birthday.mst_character_id.in_(birthday_character_ids))
            ).all()

            birthday_schema = BirthdaySchema()
            birthday_list = birthday_schema.dump(birthdays, many=True)

            entrance_direction_resource_id_list = []
            for character_id in birthday_character_ids:
                if character_id == 12:
                    # Mami uses the same resources as Ami
                    continue
                entrance_direction_resource_id_list.append(
                    get_birthday_entrance_direction_resource(
                        session=session,
                        mst_character_id=character_id,
                        birthday_month=server_month))

        session.commit()

    return {
        'birthday_list': birthday_list,
        'birthday_calendar_list': birthday_calendar_list,
        'entrance_direction_resource_id_list': (
            entrance_direction_resource_id_list)
    }


@dispatcher.add_method(name='BirthdayService.ExecuteBirthdayPresent',
                       context_arg='context')
def execute_birthday_present(params, context):
    """Execute the legacy BirthDayParty reward exactly once per year.

    The preserved client consumes one PresentStatus reward plus a ResultIdol
    affection delta. The bundled master data identifies reward items 26-29 as
    the four legacy type-specific ``感謝のマカロン`` items. The historical
    BirthDayParty contract awards one macaron and +100 affection to idols;
    attendants receive the Attendant macaron without idol state mutation.
    """
    user_id = UUID(context['user_id'])
    mst_character_id = int(params['mst_character_id'])
    now = datetime.now(timezone.utc).astimezone(config.timezone)

    with Session(engine) as session:
        user = session.scalar(select(User).where(User.user_id == user_id))
        if user is None:
            raise ValueError('user does not exist')

        calendar = session.scalar(
            select(MstBirthdayCalendar)
            .where(MstBirthdayCalendar.mst_character_id == mst_character_id)
        )
        if calendar is None:
            raise ValueError('unknown birthday character')
        if (calendar.birthday_month != now.month
                or calendar.birthday_day != now.day):
            raise ValueError('birthday reward is only available today')

        birthday = session.scalar(
            select(Birthday)
            .where(Birthday.user_id == user_id)
            .where(Birthday.year == now.year)
            .where(Birthday.mst_character_id == mst_character_id)
        )
        if birthday is None:
            birthday = Birthday(
                user_id=user_id,
                year=now.year,
                mst_character_id=mst_character_id,
            )
            session.add(birthday)
            session.flush()

        idol = None
        if calendar.idol_type in (1, 2, 3):
            idol = session.scalar(
                select(Idol)
                .where(Idol.user_id == user_id)
                .where(Idol.mst_idol_id == mst_character_id)
            )
            if idol is None:
                raise ValueError('birthday idol is not initialized for user')

        birthday_schema = BirthdaySchema()
        if birthday.is_executed:
            update_idol = None if idol is None else IdolSchema().dump(idol)
            return {
                'birthday': birthday_schema.dump(birthday),
                'present_list': [],
                'result_idol': None,
                'mission_process': _mission_process([]),
                'mission_list': [],
                'update_idol': update_idol,
            }

        macaron_id = BIRTHDAY_MACARON_BY_IDOL_TYPE.get(calendar.idol_type)
        if macaron_id is None:
            raise ValueError(
                f'unsupported birthday idol_type={calendar.idol_type}')

        present_result = _grant_birthday_macaron(session, user, macaron_id)
        result_idol = None
        update_idol = None
        mission_list = []

        if idol is not None:
            before_affection = idol.affection
            after_affection = before_affection + BIRTHDAY_AFFECTION_REWARD
            result_idol = {
                'mst_idol_id': idol.mst_idol_id,
                'before_awake_gauge': 0,
                'after_awake_gauge': 0,
                'max_awake_gauge': 0,
                'before_fan': idol.fan,
                'after_fan': idol.fan,
                'before_affection': before_affection,
                'after_affection': after_affection,
                'memorial_status': _empty_memorial_status(),
                'memorial_list': None,
            }

            crossed_memorials = session.scalars(
                select(MstMemorial)
                .where(MstMemorial.mst_idol_id == idol.mst_idol_id)
                .where(before_affection < MstMemorial.release_affection)
                .where(MstMemorial.release_affection <= after_affection)
                .order_by(MstMemorial.release_affection)
            ).all()
            if crossed_memorials:
                memorial_rows = []
                for mst_memorial in crossed_memorials:
                    memorial = session.scalar(
                        select(Memorial)
                        .where(Memorial.user == user)
                        .where(Memorial.mst_memorial_id
                               == mst_memorial.mst_memorial_id)
                    )
                    if memorial is not None:
                        memorial.is_released = True
                        memorial_rows.append(memorial)
                if memorial_rows:
                    memorial_list = MemorialSchema().dump(
                        memorial_rows, many=True)
                    result_idol['memorial_status'] = memorial_list[0]
                    result_idol['memorial_list'] = memorial_list

            idol.affection = after_affection
            mission_list = _update_affection_missions(
                session, user, result_idol)
            session.flush()
            update_idol = IdolSchema().dump(idol)

        birthday.is_executed = True
        session.flush()
        birthday_result = birthday_schema.dump(birthday)
        session.commit()

    return {
        'birthday': birthday_result,
        'present_list': [present_result],
        'result_idol': result_idol,
        'mission_process': _mission_process(mission_list),
        'mission_list': mission_list,
        'update_idol': update_idol,
    }
