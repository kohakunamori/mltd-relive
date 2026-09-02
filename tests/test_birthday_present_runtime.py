"""Runtime coverage for BirthdayService.ExecuteBirthdayPresent."""
import unittest
from datetime import datetime as RealDatetime, timezone
from unittest.mock import patch

from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import (Birthday, Idol, Item, MstBirthdayCalendar,
                                MstItem, Present, User)
from mltd.servers.config import config
import mltd.services.birthday as birthday_service


class BirthdayPresentRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            cls.user_id = session.scalar(select(User.user_id).limit(1))
            if cls.user_id is None:
                raise AssertionError('standalone setup did not create a user')

            calendars = session.scalars(
                select(MstBirthdayCalendar)
                .where(MstBirthdayCalendar.idol_type.in_([1, 2, 3]))
                .order_by(MstBirthdayCalendar.mst_character_id)
            ).all()
            cls.idol_calendar = next(
                (
                    row for row in calendars
                    if session.scalar(
                        select(Idol)
                        .where(Idol.user_id == cls.user_id)
                        .where(Idol.mst_idol_id == row.mst_character_id)
                    ) is not None
                ),
                None,
            )
            if cls.idol_calendar is None:
                raise AssertionError('no birthday idol initialized for user')

            cls.other_calendar = next(
                row for row in calendars
                if (row.birthday_month, row.birthday_day)
                != (cls.idol_calendar.birthday_month,
                    cls.idol_calendar.birthday_day)
            )
            cls.attendant_calendar = session.scalar(
                select(MstBirthdayCalendar)
                .where(MstBirthdayCalendar.idol_type == 0)
                .order_by(MstBirthdayCalendar.mst_character_id)
                .limit(1)
            )
            if cls.attendant_calendar is None:
                raise AssertionError('no attendant birthday calendar row')

        cls.context = {'user_id': str(cls.user_id)}

    def _frozen_datetime(self, calendar, year):
        month = calendar.birthday_month
        day = calendar.birthday_day

        class FrozenDatetime(RealDatetime):
            @classmethod
            def now(cls, tz=None):
                local = RealDatetime(
                    year, month, day, 12, 0, 0,
                    tzinfo=config.timezone,
                )
                value = local.astimezone(timezone.utc)
                return value if tz is None else value.astimezone(tz)

        return FrozenDatetime

    def _reset_reward_item(self, mst_item_id, amount=0):
        with Session(engine) as session:
            item = session.scalar(
                select(Item)
                .where(Item.user_id == self.user_id)
                .where(Item.mst_item_id == mst_item_id)
            )
            if item is None:
                session.add(Item(
                    item_id=f'{self.user_id}_{mst_item_id}',
                    user_id=self.user_id,
                    mst_item_id=mst_item_id,
                    amount=amount,
                ))
            else:
                item.amount = amount
            session.execute(
                delete(Present)
                .where(Present.user_id == self.user_id)
                .where(Present.item_id == f'{self.user_id}_{mst_item_id}')
            )
            session.commit()

    def _item_amount(self, mst_item_id):
        with Session(engine) as session:
            return session.scalar(
                select(Item.amount)
                .where(Item.user_id == self.user_id)
                .where(Item.mst_item_id == mst_item_id)
            )

    def test_idol_reward_persists_and_replay_is_idempotent(self):
        calendar = self.idol_calendar
        year = 2035
        mst_item_id = birthday_service.BIRTHDAY_MACARON_BY_IDOL_TYPE[
            calendar.idol_type]
        self._reset_reward_item(mst_item_id)

        with Session(engine) as session:
            session.execute(
                delete(Birthday)
                .where(Birthday.user_id == self.user_id)
                .where(Birthday.year == year)
                .where(Birthday.mst_character_id == calendar.mst_character_id)
            )
            idol = session.scalar(
                select(Idol)
                .where(Idol.user_id == self.user_id)
                .where(Idol.mst_idol_id == calendar.mst_character_id)
            )
            before_affection = idol.affection
            session.commit()

        with patch.object(
            birthday_service,
            'datetime',
            self._frozen_datetime(calendar, year),
        ):
            first = birthday_service.execute_birthday_present(
                {'mst_character_id': calendar.mst_character_id},
                self.context,
            )
            second = birthday_service.execute_birthday_present(
                {'mst_character_id': calendar.mst_character_id},
                self.context,
            )

        self.assertTrue(first['birthday']['is_executed'])
        self.assertEqual(len(first['present_list']), 1)
        self.assertEqual(first['present_list'][0]['present_state'], 2)
        self.assertEqual(
            first['present_list'][0]['item']['mst_item_id'], mst_item_id)
        self.assertEqual(
            first['result_idol']['after_affection']
            - first['result_idol']['before_affection'],
            birthday_service.BIRTHDAY_AFFECTION_REWARD,
        )
        self.assertEqual(
            first['update_idol']['affection'],
            before_affection + birthday_service.BIRTHDAY_AFFECTION_REWARD,
        )
        self.assertEqual(second['present_list'], [])
        self.assertIsNone(second['result_idol'])
        self.assertEqual(self._item_amount(mst_item_id), 1)

        with Session(engine) as session:
            birthday = session.scalar(
                select(Birthday)
                .where(Birthday.user_id == self.user_id)
                .where(Birthday.year == year)
                .where(Birthday.mst_character_id == calendar.mst_character_id)
            )
            idol = session.scalar(
                select(Idol)
                .where(Idol.user_id == self.user_id)
                .where(Idol.mst_idol_id == calendar.mst_character_id)
            )
            self.assertTrue(birthday.is_executed)
            self.assertEqual(
                idol.affection,
                before_affection + birthday_service.BIRTHDAY_AFFECTION_REWARD,
            )

    def test_attendant_gets_attendant_macaron_without_idol_mutation(self):
        calendar = self.attendant_calendar
        year = 2036
        mst_item_id = 29
        self._reset_reward_item(mst_item_id)
        with Session(engine) as session:
            session.execute(
                delete(Birthday)
                .where(Birthday.user_id == self.user_id)
                .where(Birthday.year == year)
                .where(Birthday.mst_character_id == calendar.mst_character_id)
            )
            session.commit()

        with patch.object(
            birthday_service,
            'datetime',
            self._frozen_datetime(calendar, year),
        ):
            reply = birthday_service.execute_birthday_present(
                {'mst_character_id': calendar.mst_character_id},
                self.context,
            )

        self.assertEqual(reply['present_list'][0]['item']['mst_item_id'], 29)
        self.assertEqual(reply['present_list'][0]['present_state'], 2)
        self.assertIsNone(reply['result_idol'])
        self.assertIsNone(reply['update_idol'])
        self.assertEqual(self._item_amount(29), 1)

    def test_non_birthday_target_is_rejected_without_state(self):
        today = self.idol_calendar
        target = self.other_calendar
        year = 2037
        with Session(engine) as session:
            session.execute(
                delete(Birthday)
                .where(Birthday.user_id == self.user_id)
                .where(Birthday.year == year)
                .where(Birthday.mst_character_id == target.mst_character_id)
            )
            session.commit()

        with patch.object(
            birthday_service,
            'datetime',
            self._frozen_datetime(today, year),
        ):
            with self.assertRaises(ValueError):
                birthday_service.execute_birthday_present(
                    {'mst_character_id': target.mst_character_id},
                    self.context,
                )

        with Session(engine) as session:
            self.assertIsNone(session.scalar(
                select(Birthday)
                .where(Birthday.user_id == self.user_id)
                .where(Birthday.year == year)
                .where(Birthday.mst_character_id == target.mst_character_id)
            ))

    def test_full_inventory_keeps_reward_in_present_box(self):
        calendar = self.idol_calendar
        year = 2038
        mst_item_id = birthday_service.BIRTHDAY_MACARON_BY_IDOL_TYPE[
            calendar.idol_type]
        with Session(engine) as session:
            max_amount = session.scalar(
                select(MstItem.max_amount)
                .where(MstItem.mst_item_id == mst_item_id)
            )
        self.assertGreater(max_amount, 0)
        self._reset_reward_item(mst_item_id, max_amount)
        with Session(engine) as session:
            session.execute(
                delete(Birthday)
                .where(Birthday.user_id == self.user_id)
                .where(Birthday.year == year)
                .where(Birthday.mst_character_id == calendar.mst_character_id)
            )
            session.commit()

        with patch.object(
            birthday_service,
            'datetime',
            self._frozen_datetime(calendar, year),
        ):
            reply = birthday_service.execute_birthday_present(
                {'mst_character_id': calendar.mst_character_id},
                self.context,
            )

        self.assertEqual(reply['present_list'][0]['present_state'], 5)
        self.assertEqual(self._item_amount(mst_item_id), max_amount)
        with Session(engine) as session:
            pending = session.scalars(
                select(Present)
                .where(Present.user_id == self.user_id)
                .where(Present.item_id == f'{self.user_id}_{mst_item_id}')
            ).all()
            self.assertEqual(len(pending), 1)
            self.assertEqual(pending[0].present_state, 1)


if __name__ == '__main__':
    unittest.main(verbosity=2)
