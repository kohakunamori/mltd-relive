"""Runtime coverage for UserService vitality recovery RPCs.

Run from ``standalone/`` after the normal database ``setup()``. Tests mutate
only the offline admin producer and reset the relevant balances per case.
"""
from datetime import datetime, timedelta, timezone
from uuid import UUID
import unittest

from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Item, Jewel, MstItem, User
from mltd.services.user_vitality import (
    recover_vitality_by_item,
    recover_vitality_by_item_multi,
    recover_vitality_by_jewel,
)
from mltd.servers.utilities import str_to_datetime


ADMIN_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
CONTEXT = {'user_id': str(ADMIN_USER_ID)}


class UserVitalityRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            rows = session.execute(
                select(Item.item_id, MstItem.mst_item_id)
                .join(MstItem, MstItem.mst_item_id == Item.mst_item_id)
                .where(Item.user_id == ADMIN_USER_ID)
                .where(MstItem.item_type == 6)
            ).all()
            cls.items_by_mst = {mst_id: item_id for item_id, mst_id in rows}
        for required in (20, 22, 23):
            if required not in cls.items_by_mst:
                raise AssertionError(f'missing recovery item {required}')

    def _reset(self, vitality=30, spark30=5, sparkmax=5,
               spark10=5, free_jewel=100, paid_jewel=100,
               live_ticket=77):
        now = datetime.now(timezone.utc)
        with Session(engine) as session:
            user = session.scalar(
                select(User).where(User.user_id == ADMIN_USER_ID)
            )
            user.max_vitality = 60
            user.auto_recover_interval = 300
            user._vitality = vitality
            if vitality < user.max_vitality:
                # The User.vitality hybrid derives the current value from this
                # timestamp while natural recovery is active.
                user.full_recover_date = (
                    now
                    + timedelta(
                        seconds=(user.max_vitality - vitality) * 300
                    )
                )
            else:
                user.full_recover_date = now
            user.live_ticket = live_ticket

            amounts = {
                20: spark10,
                22: spark30,
                23: sparkmax,
            }
            for mst_item_id, amount in amounts.items():
                item = session.scalar(
                    select(Item)
                    .where(Item.user_id == ADMIN_USER_ID)
                    .where(Item.mst_item_id == mst_item_id)
                )
                item.amount = amount

            jewel = session.scalar(
                select(Jewel).where(Jewel.user_id == ADMIN_USER_ID)
            )
            jewel.free_jewel_amount = free_jewel
            jewel.paid_jewel_amount = paid_jewel
            session.commit()

    def _stored(self):
        with Session(engine) as session:
            user = session.scalar(
                select(User).where(User.user_id == ADMIN_USER_ID)
            )
            jewel = session.scalar(
                select(Jewel).where(Jewel.user_id == ADMIN_USER_ID)
            )
            items = {
                mst_id: session.scalar(
                    select(Item.amount)
                    .where(Item.user_id == ADMIN_USER_ID)
                    .where(Item.mst_item_id == mst_id)
                )
                for mst_id in (20, 22, 23)
            }
            return {
                'vitality': user.vitality,
                'stored_vitality': user._vitality,
                'full_recover_date': user.full_recover_date,
                'live_ticket': user.live_ticket,
                'free_jewel': jewel.free_jewel_amount,
                'paid_jewel': jewel.paid_jewel_amount,
                'items': items,
            }

    def assertFullRecoveryStopped(self, value):
        dt = str_to_datetime(value)
        self.assertIsNotNone(dt)
        self.assertLess(
            abs((datetime.now(timezone.utc) - dt).total_seconds()),
            5,
        )

    def test_single_spark30_recovers_and_consumes_one(self):
        self._reset(vitality=30)
        reply = recover_vitality_by_item(
            {'item_id': self.items_by_mst[22]}, CONTEXT
        )
        self.assertEqual(set(reply), {
            'before_vitality', 'after_vitality',
            'before_live_ticket', 'after_live_ticket',
            'mst_item_id', 'item_type',
            'before_item_amount', 'after_item_amount',
            'full_recover_date',
        })
        self.assertEqual(reply['before_vitality'], 30)
        self.assertEqual(reply['after_vitality'], 60)
        self.assertEqual(reply['mst_item_id'], 22)
        self.assertEqual(reply['item_type'], 6)
        self.assertEqual(reply['before_item_amount'], 5)
        self.assertEqual(reply['after_item_amount'], 4)
        self.assertEqual(reply['before_live_ticket'], 77)
        self.assertEqual(reply['after_live_ticket'], 77)
        self.assertFullRecoveryStopped(reply['full_recover_date'])
        stored = self._stored()
        self.assertEqual(stored['stored_vitality'], 60)
        self.assertEqual(stored['items'][22], 4)
        self.assertEqual(stored['live_ticket'], 77)

    def test_item_overflow_is_kept_up_to_twice_max(self):
        self._reset(vitality=50)
        reply = recover_vitality_by_item(
            {'item_id': self.items_by_mst[22]}, CONTEXT
        )
        self.assertEqual(reply['before_vitality'], 50)
        self.assertEqual(reply['after_vitality'], 80)
        self.assertFullRecoveryStopped(reply['full_recover_date'])

        # A recovery that would pass the game-owned vitality cap is truncated.
        self._reset(vitality=110)
        reply = recover_vitality_by_item(
            {'item_id': self.items_by_mst[22]}, CONTEXT
        )
        self.assertEqual(reply['before_vitality'], 110)
        self.assertEqual(reply['after_vitality'], 120)

    def test_max_item_adds_one_max_vitality_not_fill_to_cap(self):
        self._reset(vitality=30)
        reply = recover_vitality_by_item(
            {'item_id': self.items_by_mst[23]}, CONTEXT
        )
        self.assertEqual(reply['before_vitality'], 30)
        self.assertEqual(reply['after_vitality'], 90)
        self.assertEqual(reply['after_item_amount'], 4)

    def test_multi_is_atomic_and_returns_item_statuses(self):
        self._reset(vitality=20, spark10=5, sparkmax=5)
        reply = recover_vitality_by_item_multi({
            'item_amount_list': [
                {'item_id': self.items_by_mst[20], 'amount': 2},
                {'item_id': self.items_by_mst[23], 'amount': 1},
            ],
            'request_check_token': 'offline-test',
        }, CONTEXT)
        self.assertEqual(set(reply), {
            'before_vitality', 'after_vitality', 'full_recover_date',
            'updated_item_list', 'mission_process',
        })
        self.assertEqual(reply['before_vitality'], 20)
        self.assertEqual(reply['after_vitality'], 100)
        self.assertEqual(
            reply['mission_process'],
            {
                'complete_mission_list': [],
                'open_mission_list': [],
                'training_point_diff': {
                    'before': 0, 'after': 0, 'total': 0,
                },
            },
        )
        self.assertEqual(len(reply['updated_item_list']), 2)
        required_item_keys = {
            'item_id', 'mst_item_id', 'name', 'item_navi_type', 'amount',
            'max_amount', 'item_type', 'sort_id', 'value1', 'value2',
            'expire_date', 'expire_date_list', 'is_extend',
        }
        for item in reply['updated_item_list']:
            self.assertEqual(set(item), required_item_keys)
        stored = self._stored()
        self.assertEqual(stored['items'][20], 3)
        self.assertEqual(stored['items'][23], 4)

        before = self._stored()
        with self.assertRaises(RuntimeError):
            recover_vitality_by_item_multi({
                'item_amount_list': [
                    {'item_id': self.items_by_mst[20], 'amount': 1},
                    {'item_id': self.items_by_mst[23], 'amount': 999},
                ],
                'request_check_token': 'invalid-test',
            }, CONTEXT)
        after = self._stored()
        self.assertEqual(after['items'], before['items'])
        self.assertEqual(after['stored_vitality'], before['stored_vitality'])

    def test_jewel_recovery_costs_50_free_first_and_overflows(self):
        self._reset(vitality=50, free_jewel=30, paid_jewel=100)
        reply = recover_vitality_by_jewel({}, CONTEXT)
        self.assertEqual(set(reply), {
            'before_vitality', 'after_vitality',
            'before_live_ticket', 'after_live_ticket',
            'before_jewel', 'after_jewel',
            'after_free_jewel', 'after_paid_jewel',
            'full_recover_date',
        })
        self.assertEqual(reply['before_vitality'], 50)
        self.assertEqual(reply['after_vitality'], 110)
        self.assertEqual(reply['before_jewel'], 130)
        self.assertEqual(reply['after_jewel'], 80)
        self.assertEqual(reply['after_free_jewel'], 0)
        self.assertEqual(reply['after_paid_jewel'], 80)
        self.assertEqual(reply['before_live_ticket'], 77)
        self.assertEqual(reply['after_live_ticket'], 77)
        self.assertFullRecoveryStopped(reply['full_recover_date'])

    def test_jewel_insufficient_fails_without_mutation(self):
        self._reset(vitality=30, free_jewel=10, paid_jewel=20)
        before = self._stored()
        with self.assertRaises(RuntimeError):
            recover_vitality_by_jewel({}, CONTEXT)
        after = self._stored()
        self.assertEqual(after['free_jewel'], before['free_jewel'])
        self.assertEqual(after['paid_jewel'], before['paid_jewel'])
        self.assertEqual(after['stored_vitality'], before['stored_vitality'])


if __name__ == '__main__':
    unittest.main(verbosity=2)
