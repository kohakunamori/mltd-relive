from asyncio import sleep
from datetime import datetime, timezone
import random
from venv import logger

from sqlalchemy import func, select, update
from sqlalchemy.orm import Session
from mltd.models.models import Achievement, Card, GashaMedalExpireDate, Item, Jewel, LastUpdateDate, MstCard, MstItem, Present, User
from mltd.servers.config import config


def add_card(session: Session, user: User, mst_card_id):
    """Give a new card to a user.

    Args:
        session: Existing SQLAlchemy session.
        user: A User object.
        mst_card_id: Master card ID.
    Returns:
        None.
    """
    mst_card = session.scalar(
        select(MstCard)
        .where(MstCard.mst_card_id == mst_card_id)
    )
    level_max = mst_card.level_max
    vocal_base = mst_card.vocal_base
    dance_base = mst_card.dance_base
    visual_base = mst_card.visual_base
    vocal_max = mst_card.vocal_max
    dance_max = mst_card.dance_max
    visual_max = mst_card.visual_max
    card = Card(
        card_id=f'{user.user_id}_{mst_card_id}',
        mst_card_id=mst_card_id,
        vocal_diff=vocal_max / (2*level_max),
        dance_diff=dance_max / (2*level_max),
        visual_diff=visual_max / (2*level_max),
        skill_probability=(None if not mst_card.mst_card_skill_id
                           else mst_card.mst_card_skill.probability_base + 1),
    )
    card.before_awakened_vocal = vocal_base + round(card.vocal_diff)
    card.before_awakened_dance = dance_base + round(card.dance_diff)
    card.before_awakened_visual = visual_base + round(card.visual_diff)
    card.after_awakened_vocal = vocal_base + round(
        card.vocal_diff + vocal_max*10/(2*level_max*level_max))
    card.after_awakened_dance = dance_base + round(
        card.dance_diff + dance_max*10/(2*level_max*level_max))
    card.after_awakened_visual = visual_base + round(
        card.visual_diff + visual_max*10/(2*level_max*level_max))
    card.vocal = card.before_awakened_vocal
    card.dance = card.before_awakened_dance
    card.visual = card.before_awakened_visual
    user.cards.append(card)

def add_item(
        session: Session,
        user: User,
        mst_item_id,
        item_type,
        amount=1,
        expire_date=datetime(
            2099, 12, 31, 23, 59, 59, tzinfo=config.timezone
        ).astimezone(timezone.utc)):
    """Give specified amount of an item to a user.

    Args:
        session: Existing SQLAlchemy session.
        user: A User object.
        mst_item_id: Master item ID of the item to be added.
        item_type: Item type.
        amount: Amount of the item to be added (default 1).
        expire_date: Expiry date of the item (default 2099-12-31
                     23:59:59).
    Returns:
        None.
    """
    if item_type == 1:      # Jewel
        session.execute(
            update(Jewel)
            .where(Jewel.user_id == user.user_id)
            .values(free_jewel_amount=Jewel.free_jewel_amount + amount)
        )
    elif item_type == 2:    # Money
        session.execute(
            update(User)
            .where(User.user_id == user.user_id)
            .values(money=func.min(User.money + amount, User.max_money))
        )
    elif item_type == 4:    # Gasha medal pt
        point_amonut = session.scalar(
            select(MstItem.value1)
            .where(MstItem.mst_item_id == mst_item_id)
        )
        gasha_medal = user.gasha_medal
        if len(gasha_medal.gasha_medal_expire_dates) >= 10:
            return
        gasha_medal.point_amount += point_amonut
        if gasha_medal.point_amount >= 100:
            gasha_medal.gasha_medal_expire_dates.append(GashaMedalExpireDate())
            gasha_medal.point_amount -= 100
        if len(gasha_medal.gasha_medal_expire_dates) >= 10:
            gasha_medal.point_amount = 0
    else:
        item = session.scalar(
            select(Item)
            .where(Item.user_id == user.user_id)
            .where(Item.mst_item_id == mst_item_id)
        )
        if not item:
            user.items.append(Item(
                item_id=f'{user.user_id}_{mst_item_id}',
                mst_item_id=mst_item_id,
                amount=amount,
                expire_date=expire_date
            ))
        else:
            item.amount += amount
            item.expire_date = expire_date

def add_present(session: Session, user: User, present: Present):
    """Give present to a user.

    Args:
        session: Existing SQLAlchemy session.
        user: A User object.
        present: A Present object representing the present to be given
                 to the user.
    Returns:
        None.
    """
    if present.present_type == 1:
        item_id = session.scalar(
            select(Item.item_id)
            .where(Item.item_id == present.item_id)
        )
        if not item_id:
            user.items.append(Item(
                item_id=present.item_id,
                mst_item_id=int(present.item_id.split('_')[1]),
                amount=0
            ))
    elif present.present_type == 3:
        achievement_id = session.scalar(
            select(Achievement.mst_achievement_id)
            .where(Achievement.user_id == user.user_id)
            .where(Achievement.mst_achievement_id
                   == present.mst_achievement_id)
        )
        if not achievement_id:
            session.add(Achievement(
                user_id=user.user_id,
                mst_achievement_id=present.mst_achievement_id,
                is_released=False
            ))

    # Make sure create_date is unique.
    while True:
        create_date = datetime.now(timezone.utc)
        duplicate_count = session.scalar(
            select(func.count(Present.present_id))
            .where(Present.create_date == create_date)
        )
        if not duplicate_count:
            break
        # TODO: Reproduce before deleting this log
        logger.info('Found duplicate create_date')
        sleep(random.uniform(0.001, 0.020))
    present.create_date = create_date
    session.add(present)
    session.expire(user, ['presents'])

    session.execute(
        update(LastUpdateDate)
        .where(LastUpdateDate.user_id == user.user_id)
        .where(LastUpdateDate.last_update_date_type == 1)
        .values(last_update_date=datetime.now(timezone.utc))
    )

def add_achievement(session: Session, user: User, mst_achievement_id):
    achievement_id = session.scalar(
        select(Achievement.mst_achievement_id)
        .where(Achievement.user_id == user.user_id)
        .where(Achievement.mst_achievement_id
                == mst_achievement_id)
    )
    if not achievement_id:
        session.add(Achievement(
            user_id=user.user_id,
            mst_achievement_id=mst_achievement_id,
            is_released=True
        ))
    else:
        session.execute(
            update(Achievement)
            .where(Achievement.user_id == user.user_id)
            .where(Achievement.mst_achievement_id == mst_achievement_id)
            .values(is_released=True)
        )