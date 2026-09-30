from datetime import datetime, timedelta, timezone
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Item, Jewel, MstGameSetting, User
from mltd.models.schemas import ItemSchema
from mltd.servers.utilities import format_datetime


def _user_id(context):
    return UUID(context['user_id'])


def _empty_mission_process():
    return {
        'complete_mission_list': [],
        'open_mission_list': [],
        'training_point_diff': {
            'before': 0,
            'after': 0,
            'total': 0,
        },
    }


def _utc(dt):
    return dt.replace(tzinfo=timezone.utc) if dt.tzinfo is None else dt.astimezone(timezone.utc)


def _recovery_points(user, item):
    """Return vitality restored by one recovery item.

    MstItem documents value1 as a fixed recovery amount and value2 as a
    percentage of max vitality. Current data uses one or the other (10/20/30
    drinks use value1; MAX-equivalent items use value2=100).
    """
    mst_item = item.mst_item
    if mst_item.item_type != 6:
        raise RuntimeError('item is not a vitality recovery item')
    return mst_item.value1 + (user.max_vitality * mst_item.value2 // 100)


def _apply_recovery(user, amount, now=None):
    """Apply recovery while preserving the game's overflow/timer rules."""
    if amount < 0:
        raise RuntimeError('recovery amount cannot be negative')

    now = now or datetime.now(timezone.utc)
    now = _utc(now)
    before = user.vitality
    after = min(before + amount, user.max_vitality * 2)
    restored = after - before

    if after >= user.max_vitality:
        # Natural recovery stops while vitality is at/above the normal cap.
        user.full_recover_date = now
    elif restored:
        previous_full = _utc(user.full_recover_date)
        user.full_recover_date = max(
            now,
            previous_full - timedelta(
                seconds=restored * user.auto_recover_interval
            ),
        )

    user.vitality = after
    return before, after


def _get_user(session, context):
    user = session.scalar(
        select(User).where(User.user_id == _user_id(context))
    )
    if user is None:
        raise LookupError('user not found')
    return user


def _get_owned_item(session, user, item_id):
    """Resolve the single-item RPC's inventory-row ``item_id``."""
    item = session.scalar(
        select(Item)
        .where(Item.user_id == user.user_id)
        .where(Item.item_id == item_id)
    )
    if item is None:
        raise LookupError('item not found')
    if item.mst_item.item_type != 6:
        raise RuntimeError('item is not a vitality recovery item')
    return item


def _get_owned_item_by_mst_id(session, user, mst_item_id, item_type=None):
    """Resolve an ItemAmount entry used by RecoverVitalityByItemMulti.

    The preserved client contract is ItemAmount{mst_item_id, item_type,
    amount}.  It does *not* send the user's inventory-row ``item_id`` here.
    Resolve the row by (user_id, mst_item_id), then verify that the redundant
    wire ``item_type`` agrees with master data before any mutation occurs.
    """
    item = session.scalar(
        select(Item)
        .where(Item.user_id == user.user_id)
        .where(Item.mst_item_id == mst_item_id)
    )
    if item is None:
        raise LookupError('item not found')

    actual_type = item.mst_item.item_type
    if item_type is not None and int(item_type) != actual_type:
        raise RuntimeError('item type does not match master item')
    if actual_type != 6:
        raise RuntimeError('item is not a vitality recovery item')
    return item


def _consume_item(user, item, amount):
    if amount <= 0:
        raise RuntimeError('item amount must be positive')
    if item.amount < amount:
        raise RuntimeError('insufficient item amount')

    points = _recovery_points(user, item) * amount
    item.amount -= amount
    return points


@dispatcher.add_method(
    name='UserService.RecoverVitalityByItem', context_arg='context'
)
def recover_vitality_by_item(params, context):
    """Use one recovery item and return RecoverVitalityByItemReply."""
    params = params or {}
    with Session(engine) as session:
        user = _get_user(session, context)
        item = _get_owned_item(session, user, params.get('item_id'))

        before_item_amount = item.amount
        before_live_ticket = user.live_ticket
        points = _consume_item(user, item, 1)
        before_vitality, after_vitality = _apply_recovery(user, points)

        result = {
            'before_vitality': before_vitality,
            'after_vitality': after_vitality,
            # Since the 2018 overflow change, recovery no longer converts
            # surplus vitality into live tickets.
            'before_live_ticket': before_live_ticket,
            'after_live_ticket': user.live_ticket,
            'mst_item_id': item.mst_item_id,
            'item_type': item.mst_item.item_type,
            'before_item_amount': before_item_amount,
            'after_item_amount': item.amount,
            'full_recover_date': format_datetime(_utc(user.full_recover_date)),
        }
        session.commit()
        return result


@dispatcher.add_method(
    name='UserService.RecoverVitalityByItemMulti', context_arg='context'
)
def recover_vitality_by_item_multi(params, context):
    """Use a client-selected set of recovery items atomically."""
    params = params or {}
    requested = params.get('item_amount_list') or []
    if not requested:
        raise RuntimeError('item_amount_list cannot be empty')

    with Session(engine) as session:
        user = _get_user(session, context)
        entries = []
        total_points = 0
        seen = set()

        # The client sends ItemAmount entries, whose identifier is mst_item_id
        # rather than Item.item_id. Validate every entry before mutating any
        # amount so a malformed/insufficient entry keeps the call atomic.
        for entry in requested:
            if 'mst_item_id' not in entry:
                raise RuntimeError('mst_item_id is required')
            mst_item_id = int(entry['mst_item_id'])
            if mst_item_id <= 0:
                raise RuntimeError('mst_item_id must be positive')
            if mst_item_id in seen:
                raise RuntimeError('duplicate mst_item_id in item_amount_list')
            seen.add(mst_item_id)

            amount = int(entry.get('amount', 0))
            if amount <= 0:
                raise RuntimeError('item amount must be positive')
            item = _get_owned_item_by_mst_id(
                session,
                user,
                mst_item_id,
                item_type=entry.get('item_type'),
            )
            if item.amount < amount:
                raise RuntimeError('insufficient item amount')
            entries.append((item, amount))
            total_points += _recovery_points(user, item) * amount

        before_vitality = user.vitality
        for item, amount in entries:
            item.amount -= amount
        _, after_vitality = _apply_recovery(user, total_points)

        item_schema = ItemSchema()
        result = {
            'before_vitality': before_vitality,
            'after_vitality': after_vitality,
            'full_recover_date': format_datetime(_utc(user.full_recover_date)),
            'updated_item_list': item_schema.dump(
                [item for item, _ in entries], many=True
            ),
            # The reply type contains MissionProcessStatus but not mission_list.
            # No recovery-specific mission class is currently represented by
            # the standalone save, so preserve the canonical empty process.
            'mission_process': _empty_mission_process(),
        }
        session.commit()
        return result


@dispatcher.add_method(
    name='UserService.RecoverVitalityByJewel', context_arg='context'
)
def recover_vitality_by_jewel(params, context):
    """Spend the configured jewel cost and restore max-vitality points."""
    now = datetime.now(timezone.utc)
    with Session(engine) as session:
        user = _get_user(session, context)
        jewel = session.scalar(
            select(Jewel).where(Jewel.user_id == user.user_id)
        )
        if jewel is None:
            raise LookupError('jewel balance not found')

        setting = session.scalars(select(MstGameSetting)).first()
        if setting is None:
            raise LookupError('game setting not found')

        begin = _utc(setting.recover_jewel_begin_date)
        end = _utc(setting.recover_jewel_end_date)
        if not begin <= now <= end:
            raise RuntimeError('jewel vitality recovery is not available')

        cost = setting.recover_jewel_amount
        before_free = jewel.free_jewel_amount
        before_paid = jewel.paid_jewel_amount
        before_jewel = before_free + before_paid
        if before_jewel < cost:
            raise RuntimeError('insufficient jewels')

        # General/non-paid-only Million Jewel spending consumes free currency
        # first, then paid currency for the remainder.
        free_cost = min(before_free, cost)
        jewel.free_jewel_amount -= free_cost
        jewel.paid_jewel_amount -= cost - free_cost

        before_live_ticket = user.live_ticket
        before_vitality, after_vitality = _apply_recovery(
            user, user.max_vitality, now=now
        )
        after_jewel = jewel.free_jewel_amount + jewel.paid_jewel_amount

        result = {
            'before_vitality': before_vitality,
            'after_vitality': after_vitality,
            'before_live_ticket': before_live_ticket,
            'after_live_ticket': user.live_ticket,
            'before_jewel': before_jewel,
            'after_jewel': after_jewel,
            'after_free_jewel': jewel.free_jewel_amount,
            'after_paid_jewel': jewel.paid_jewel_amount,
            'full_recover_date': format_datetime(_utc(user.full_recover_date)),
        }
        session.commit()
        return result