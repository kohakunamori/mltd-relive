import json
import random
from base64 import urlsafe_b64decode, urlsafe_b64encode
from datetime import datetime, timezone
from time import sleep
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import and_, delete, func, or_, select, update
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import (Achievement, Card, Item, Jewel, LastUpdateDate, Mission, MstCard, MstItem, MstMission,
                                Present, User)
from mltd.models.schemas import ItemSchema, JewelSchema, MissionSchema, PresentSchema
from mltd.servers.config import config
from mltd.servers.logging import logger
from mltd.services.utils import add_achievement, add_card, add_item
from mltd.services.mission import update_mission_progress

@dispatcher.add_method(name='PresentService.GetPresentCount',
                       context_arg='context')
def get_present_count(params, context):
    """Service for getting number of presents for a user.

    Invoked in the following situations.
    1. As part of the initial batch requests after logging in.
    2. When the game is transitioning to the theater screen.
    Args:
        params: An empty dict.
    Returns:
        A dict containing a single key 'value', whose value is the
        number of presents in user's present box. If the user has more
        than 100 presents, this value is set to 100.
    """
    with Session(engine) as session:
        value = session.scalar(
            select(func.count(Present.present_id))
            .where(Present.user_id == UUID(context['user_id']))
            .where(datetime.now(timezone.utc) < Present.end_date)
        )

    return {'value': min(value, 100)}


@dispatcher.add_method(name='PresentService.GetPresentList',
                       context_arg='context')
def get_present_list(params, context):
    """Service for getting a list of presents for a user.

    Invoked when the user presses Presents button.
    Args:
        params: A dict containing the following keys.
            cursor: Cursor returned by the previous invocation if the
                    user has just scrolled to the bottom to get the next
                    page (an empty string if no previous cursor).
            limit: 100.
            is_sort_asc: Whether the list should be sorted in ascending
                         order (default false).
            is_sort_end_date: Whether the list should be sorted by
                              'end_date' (default false, sorted by
                              'create_date').
            present_end_date_type: An int representing the expiration
                                   type (0-2).
                                   0=All presents
                                   1=Presents with no expiration
                                   2=Presents with expiration
            present_filter_type: An int representing the filter type
                                 (0-4).
                                 0=All presents
                                 1=Cards
                                 2=Money
                                 3=Items
                                 4=Others (Jewels/Achievements)
    Returns:
        A dict containing the following keys.
        present_list: A list of dicts containing the following keys.
            present_id: A unique present ID in UUID format.
            comment: Comment describing where the present came from.
            end_date: Date when this present expires
                      (2099-12-31T15:59:59+0000 if no expiration).
            create_date: Date when this present was created.
            amount: Amount of items the user will receive (1 for card
                    and achievement presents).
            present_type: An int representing the present type (1-3).
                          1=Item
                          2=Card
                          3=Achievement
            item: A dict representing the item to be received (empty
                  info if not an item present). See the return value
                  'item_list' of the method 'ItemService.GetItemList'
                  for the dict definition.
            card: A dict representing the card to be received (empty
                  info if not a card present). See the return value
                  'card_list' of the method 'CardService.GetCardList'
                  for the dict definition.
            achievement: A dict representing the achievement to be
                         received (empty info if not an achievement
                         present). See the return value
                         'achievement_list' of the method
                         'AchievementService.GetAchievementList' for the
                         dict definition.
            present_state: An int representing the present state (1-2).
                           1=Not yet received
                           2=Has been received
            exchange_item_list: null.
        cursor: Pagination cursor for the next invocation to fetch the
                next 100 items (an empty string if no items left).
    """
    user_id = UUID(context['user_id'])
    with Session(engine) as session:
        session.execute(
            delete(Present)
            .where(Present.user_id == user_id)
            .where(Present.end_date <= datetime.now(timezone.utc))
        )

        present_stmt = (
            select(Present)
            .where(Present.user_id == user_id)
            .where(Present.present_state == 1)
        )

        default_end_date = datetime(
            2099, 12, 31, 23, 59, 59, tzinfo=config.timezone
        ).astimezone(timezone.utc)
        if params['present_end_date_type'] == 1:
            present_stmt = present_stmt.where(
                Present.end_date == default_end_date)
        elif params['present_end_date_type'] == 2:
            present_stmt = present_stmt.where(
                Present.end_date < default_end_date)

        money_item_subq = (
            select(Item.mst_item_id)
            .join(MstItem)
            .where(Item.item_id == Present.item_id)
            .where(MstItem.item_type == 2)
        ).exists()
        if params['present_filter_type'] == 1:
            present_stmt = present_stmt.where(Present.present_type == 2)
        elif params['present_filter_type'] == 2:
            present_stmt = present_stmt.where(money_item_subq)
        elif params['present_filter_type'] == 3:
            present_stmt = (
                present_stmt
                .where(~money_item_subq)
                .where(Present.present_type == 1)
                .where(Present.item_id != f'{user_id}_3')
            )
        elif params['present_filter_type'] == 4:
            present_stmt = present_stmt.where(or_(
                Present.item_id == f'{user_id}_3',
                Present.present_type == 3
            ))

        if params['cursor']:
            cursor = json.loads(urlsafe_b64decode(params['cursor']))
            if not params['is_sort_end_date']:
                last_create_date = datetime.fromtimestamp(
                    cursor['create_date'], tz=timezone.utc)
                if params['is_sort_asc']:
                    present_stmt = present_stmt.where(
                        Present.create_date > last_create_date)
                else:
                    present_stmt = present_stmt.where(
                        Present.create_date < last_create_date)
            else:
                last_end_date = datetime.fromtimestamp(
                    cursor['end_date'], tz=timezone.utc)
                last_present_id = UUID(cursor['present_id'])
                if params['is_sort_asc']:
                    present_stmt = present_stmt.where(
                        or_(Present.end_date > last_end_date,
                            and_(Present.end_date == last_end_date,
                                 Present.present_id > last_present_id))
                    )
                else:
                    present_stmt = present_stmt.where(
                        or_(Present.end_date < last_end_date,
                            and_(Present.end_date == last_end_date,
                                 Present.present_id > last_present_id))
                    )

        if not params['is_sort_end_date']:
            if params['is_sort_asc']:
                present_stmt = present_stmt.order_by(Present.create_date)
            else:
                present_stmt = present_stmt.order_by(
                    Present.create_date.desc())
        else:
            if params['is_sort_asc']:
                present_stmt = present_stmt.order_by(
                    Present.end_date, Present.present_id)
            else:
                present_stmt = present_stmt.order_by(
                    Present.end_date.desc(), Present.present_id)

        present_stmt = present_stmt.limit(params['limit'])
        presents = session.scalars(present_stmt).all()

        present_schema = PresentSchema()
        present_list = present_schema.dump(presents, many=True)

        cursor = ''
        if len(presents) >= 100:
            last_present = presents[-1]
            cursor_dict = {}
            if not params['is_sort_end_date']:
                cursor_dict['create_date'] = datetime.timestamp(
                    last_present.create_date.replace(tzinfo=timezone.utc))
            else:
                cursor_dict['end_date'] = datetime.timestamp(
                    last_present.end_date.replace(tzinfo=timezone.utc))
                cursor_dict['present_id'] = str(last_present.present_id)
            cursor = urlsafe_b64encode(
                json.dumps(cursor_dict).encode()
            ).decode()

        session.commit()

    return {
        'present_list': present_list,
        'cursor': cursor
    }

@dispatcher.add_method(name='PresentService.ReceivePresent',
                       context_arg='context')
def receive_present(params, context):
    '''
    Invoked when the user presses Presents Receiving button.
    Args:
        params: A dict containing the following keys.
            id_list: present ids
    Returns:
        A dict containing the following keys.
        present_list: A list of dicts containing the following keys.
            present_id: A unique present ID in UUID format.
            comment: Comment describing where the present came from.
            end_date: Date when this present expires
                      (2099-12-31T15:59:59+0000 if no expiration).
            create_date: Date when this present was created.
            amount: Amount of items the user will receive (1 for card
                    and achievement presents).
            present_type: An int representing the present type (1-3).
                          1=Item
                          2=Card
                          3=Achievement
            item: A dict representing the item to be received (empty
                  info if not an item present). See the return value
                  'item_list' of the method 'ItemService.GetItemList'
                  for the dict definition.
            card: A dict representing the card to be received (empty
                  info if not a card present). See the return value
                  'card_list' of the method 'CardService.GetCardList'
                  for the dict definition.
            achievement: A dict representing the achievement to be
                         received (empty info if not an achievement
                         present). See the return value
                         'achievement_list' of the method
                         'AchievementService.GetAchievementList' for the
                         dict definition.
            present_state: An int representing the present state (1-2).
                           1=Not yet received
                           2=Has been received
            exchange_item_list: null.
        mission_process: A dict representing changes in mission states
                         after playing this song. Contains the following
                         keys.
            complete_mission_list: A list of dicts representing missions
                                   that have just been completed (empty
                                   if none). See the return value
                                   'mission_list' of the method
                                   'MissionService.GetMissionList' for
                                   the dict definition.
            open_mission_list: An empty list.
            training_point_diff: Unknown. Contains the following keys.
                before: 0.
                after: 0.
                total: 0.
        mission_list: A list of dicts representing missions with changed
                      states. This list is the same as
                      'complete_mission_list' above.
        updated_idol_list: A list of 10 dicts representing the final
                           states of the idols after playing this
                           song. The first 5 dicts contain empty idol
                           info. The last 5 dicts correspond to the
                           idols in the first 5 positions of the
                           selected unit. If multiple cards for the same
                           idol were selected in the unit, there will be
                           mulitple duplicated dicts for that idol in
                           this list. See the return value 'idol_list'
                           of the method 'IdolService.GetIdolList' for
                           the dict definition.
        updated_item_list: A list of dicts representing the final states
                           of user's items after playing this song. See
                           'item_list' of the method
                           'ItemService.GetItemList' for the dict
                           definition.
        jewel: jewel status
            free_jewel_amount
            paid_jewel_amount
        after_money: money amount after receiving
        after_training_point: training point amount after receiving
        another_appeal_release_idol_id_list: another_appeal_release
    '''
    id_list = [UUID(id) for id in params['id_list']]
    user_id = UUID(context['user_id'])
    with Session(engine) as session:
        user = session.scalars(
            select(User)
            .where(User.user_id == user_id)
        ).one()
        presents = session.scalars(
            select(Present)
            .where(Present.user_id == user_id)
            .where(Present.present_id.in_(id_list))
        ).all()

        present_schema = PresentSchema()
        present_list = []
        updated_item_ids = []
        for present in presents:
            present_result = present_schema.dump(present)
            # Item
            if present.present_type == 1:
                mst_item_id = present.item.mst_item_id
                max_amount = present.item.mst_item.max_amount
                before_amount = session.scalar(
                    select(Item.amount)
                    .where(Item.user_id == user_id)
                    .where(Item.mst_item_id == mst_item_id)
                )
                if before_amount is None:
                    before_amount = 0
                after_amount = before_amount + present.amount
                if max_amount != 0 and after_amount > max_amount:
                    # ovelimited, remaining in present box
                    present_result['present_state'] = 5
                else:
                    add_item(
                        session,
                        user,
                        mst_item_id,
                        present.item.mst_item.item_type,
                        present.amount,
                        present.item.expire_date
                    )
                    session.delete(present)
                    updated_item_ids.append(present.item.mst_item_id)
                    present_result['present_state'] = 2
            # Card
            elif present.present_type == 2:
                rarity = session.scalar(
                    select(MstCard.rarity)
                    .select_from(Card)
                    .join(MstCard)
                    .where(Card.user == user)
                    .where(Card.mst_card_id
                            == present.card.mst_card_id)
                )
                if rarity:
                    lesson_ticket_item_id = [
                        200,
                        201,
                        202,
                        203
                    ][rarity-1]
                    add_item(
                        session=session,
                        user=user,
                        mst_item_id=lesson_ticket_item_id,
                        item_type=8,
                        amount=1
                    )
                    updated_item_ids.append(lesson_ticket_item_id)
                    master_piece_item_id = [
                        300,
                        301,
                        302,
                        303
                    ][rarity-1]
                    add_item(
                        session=session,
                        user=user,
                        mst_item_id=master_piece_item_id,
                        item_type=9,
                        amount=1
                    )
                    item_schema = ItemSchema()
                    exchange_item_list = item_schema.dump(
                        [
                            Item(
                                item_id=f'{user_id}_{lesson_ticket_item_id}',
                                mst_item_id=lesson_ticket_item_id,
                                amount=1,
                            ),
                            Item(
                                item_id=f'{user_id}_{master_piece_item_id}',
                                mst_item_id=master_piece_item_id,
                                amount=1,
                            ),
                        ],
                        many=True
                    )

                    updated_item_ids.append(master_piece_item_id)
                    present_result['exchange_item_list'] = exchange_item_list
                else:
                    add_card(
                        session,
                        user,
                        present.card.mst_card_id
                    )
                session.delete(present)
                present_result['present_state'] = 2
            # Achievement
            elif present.present_type == 3:
                add_achievement(
                    session,
                    user,
                    present.mst_achievement_id
                )
                session.delete(present)
                present_result['present_state'] = 2
            # Costume
            elif present.present_type == 4:
                # the present status class don't include a 'costume' field
                raise NotImplementedError(present)
            else:
                raise NotImplementedError(present)
            
            present_list.append(present_result)
        updated_items = session.scalars(
            select(Item)
            .where(Item.user == user)
            .where(Item.mst_item_id.in_(updated_item_ids))
        ).all()
        updated_item_list = []
        if updated_items:
            item_schema = ItemSchema()
            updated_item_list = item_schema.dump(updated_items, many=True)
        after_money = user.money
        jewel = session.scalars(
            select(Jewel)
            .where(Jewel.user_id == user_id)
        ).one()
        free_jewel = jewel.free_jewel_amount
        paid_jewel = jewel.paid_jewel_amount

        #region Update mission info and give mission rewards to the
        #       user.
        mission_list = []
        mission_schema = MissionSchema()
        card_count = len(user.cards)
        card_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 5)
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in card_missions:
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=card_count
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))
        costume_count = len(user.costumes)
        costume_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 9)
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in costume_missions:
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=costume_count
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))
        costume_set_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 47)
            .where(Mission.mission_state == 1)
        ).all()
        for mission in costume_set_missions:
            costume_count = len([
                costume for costume in user.costumes
                if costume.mst_costume.mst_costume_group_id
                == int(mission.mst_mission.option)
            ])
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=costume_count
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))
        # TODO: other missions
        session.commit()
    return {
        'present_list': present_list,
        'mission_process': {
            'complete_mission_list': mission_list,
            'open_mission_list': [],
            'training_point_diff': {
                'before': 0,
                'after': 0,
                'total': 0
            }
        },
        'mission_list': mission_list,
        'updated_idol_list': [], # TODO: don't know when this list is not empty
        'updated_item_list': updated_item_list,
        'jewel': {
            'free_jewel_amount': free_jewel,
            'paid_jewel_amount': paid_jewel,
        },
        'after_money': after_money,
        'after_training_point': 0, # TODO
        'another_appeal_release_idol_id_list': [] #TODO
    }