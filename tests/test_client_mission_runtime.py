"""Runtime coverage for MissionService.DoClientMission.

Run from ``standalone/`` after normal database setup.
"""
from datetime import datetime
import unittest

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Mission, Present
from mltd.services.mission_client import do_client_mission


class ClientMissionRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            cls.user_id = session.scalar(
                select(Mission.user_id)
                .where(Mission.mst_mission_id == 20107)
                .limit(1)
            )
        if cls.user_id is None:
            raise AssertionError('no user with client training missions found')
        cls.context = {'user_id': str(cls.user_id)}
        cls.reward_item_id = f'{cls.user_id}_5101'

    def setUp(self):
        with Session(engine) as session:
            for mission_id in (20107, 20108, 20109, 20110):
                mission = session.scalar(
                    select(Mission)
                    .where(Mission.user_id == self.user_id)
                    .where(Mission.mst_mission_id == mission_id)
                )
                if mission is None:
                    raise AssertionError(
                        f'missing client training mission {mission_id}'
                    )
                mission.progress = 0
                mission.mission_state = 1
                mission.finish_date = datetime(1, 1, 1)
            session.commit()

    def _present_count(self):
        with Session(engine) as session:
            return session.scalar(
                select(func.count(Present.present_id))
                .where(Present.user_id == self.user_id)
                .where(Present.item_id == self.reward_item_id)
            )

    def _mission_state(self, mission_id):
        with Session(engine) as session:
            mission = session.scalar(
                select(Mission)
                .where(Mission.user_id == self.user_id)
                .where(Mission.mst_mission_id == mission_id)
            )
            return mission.mission_state, mission.progress

    def test_batch_completes_and_rewards_exactly_once(self):
        before_present = self._present_count()
        reply = do_client_mission(
            {
                'client_mission_list': [
                    {'option': 'dress', 'option2': '1', 'progress': 1.0},
                    {'option': 'thirteen', 'option2': '1', 'progress': 1.0},
                ]
            },
            self.context,
        )

        process = reply['mission_process']
        self.assertEqual(
            {m['mst_mission_id'] for m in process['complete_mission_list']},
            {20107, 20108},
        )
        self.assertEqual(
            process['training_point_diff'],
            {'before': 0, 'after': 0, 'total': 0},
        )
        self.assertEqual(self._mission_state(20107), (3, 1))
        self.assertEqual(self._mission_state(20108), (3, 1))
        self.assertEqual(self._present_count(), before_present + 2)

        duplicate = do_client_mission(
            {
                'client_mission_list': [
                    {'option': 'dress', 'option2': '1', 'progress': 1.0},
                    {'option': 'thirteen', 'option2': '1', 'progress': 1.0},
                ]
            },
            self.context,
        )
        self.assertEqual(
            duplicate['mission_process']['complete_mission_list'], []
        )
        self.assertEqual(self._present_count(), before_present + 2)

    def test_all_verified_option_families_map_to_expected_missions(self):
        reply = do_client_mission(
            {
                'client_mission_list': [
                    {'option': 'mobile', 'option2': '1', 'progress': 1},
                    {'option': '25,26', 'option2': '1', 'progress': 1},
                ]
            },
            self.context,
        )
        self.assertEqual(
            {m['mst_mission_id'] for m in reply['mission_process'][
                'complete_mission_list'
            ]},
            {20109, 20110},
        )
        self.assertEqual(self._mission_state(20109), (3, 1))
        self.assertEqual(self._mission_state(20110), (3, 1))

    def test_unknown_or_stale_reports_are_noops(self):
        with Session(engine) as session:
            mission = session.scalar(
                select(Mission)
                .where(Mission.user_id == self.user_id)
                .where(Mission.mst_mission_id == 20109)
            )
            mission.mission_state = 0
            session.commit()

        before_present = self._present_count()
        reply = do_client_mission(
            {
                'client_mission_list': [
                    {'option': 'unknown', 'option2': '1', 'progress': 99},
                    {'option': 'mobile', 'option2': '1', 'progress': 1},
                    {'option': 'dress', 'option2': '999', 'progress': 1},
                ]
            },
            self.context,
        )
        self.assertEqual(reply['mission_process']['complete_mission_list'], [])
        self.assertEqual(self._mission_state(20109), (0, 0))
        self.assertEqual(self._present_count(), before_present)

    def test_invalid_progress_rejects_batch_without_mutation(self):
        before_present = self._present_count()
        with self.assertRaises(ValueError):
            do_client_mission(
                {
                    'client_mission_list': [
                        {'option': 'dress', 'option2': '1', 'progress': -1},
                    ]
                },
                self.context,
            )
        self.assertEqual(self._mission_state(20107), (1, 0))
        self.assertEqual(self._present_count(), before_present)


if __name__ == '__main__':
    unittest.main(verbosity=2)
