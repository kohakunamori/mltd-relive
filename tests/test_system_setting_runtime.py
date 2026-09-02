"""Runtime coverage for SystemSettingService.SetSystemSetting.

Run from ``standalone/`` after the normal database ``setup()``.
"""
from uuid import UUID
import unittest

from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import LessonWearConfig, MstLessonWearConfig
from mltd.services.system_setting import set_system_setting


ADMIN_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
CONTEXT = {'user_id': str(ADMIN_USER_ID)}


class SystemSettingRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            cls.setting_ids = session.scalars(
                select(MstLessonWearConfig.mst_lesson_wear_setting_id)
                .order_by(MstLessonWearConfig.mst_lesson_wear_setting_id)
            ).all()
        if not cls.setting_ids:
            raise AssertionError('no lesson-wear master settings found')

    def setUp(self):
        with Session(engine) as session:
            session.execute(
                delete(LessonWearConfig)
                .where(LessonWearConfig.user_id == ADMIN_USER_ID)
            )
            session.add(
                LessonWearConfig(
                    user_id=ADMIN_USER_ID,
                    mst_lesson_wear_setting_id=self.setting_ids[0],
                )
            )
            session.commit()

    def _current_rows(self):
        with Session(engine) as session:
            return session.scalars(
                select(LessonWearConfig.mst_lesson_wear_setting_id)
                .where(LessonWearConfig.user_id == ADMIN_USER_ID)
                .order_by(LessonWearConfig.mst_lesson_wear_setting_id)
            ).all()

    def test_set_system_setting_replaces_current_row(self):
        target = self.setting_ids[-1]
        reply = set_system_setting(
            {'lesson_wear_setting_id': target}, CONTEXT
        )
        self.assertEqual(reply, {})
        self.assertEqual(self._current_rows(), [target])

    def test_invalid_setting_is_rejected_without_mutation(self):
        before = self._current_rows()
        invalid = max(self.setting_ids) + 1_000_000
        with self.assertRaises(RuntimeError):
            set_system_setting(
                {'lesson_wear_setting_id': invalid}, CONTEXT
            )
        self.assertEqual(self._current_rows(), before)


if __name__ == '__main__':
    unittest.main(verbosity=2)
