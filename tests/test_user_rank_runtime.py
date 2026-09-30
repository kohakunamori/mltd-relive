"""Runtime coverage for UserService.GetProducerRankList.

Run from ``standalone/`` after normal database setup.
"""
from uuid import UUID
import unittest

from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import User
from mltd.services.user_rank import get_producer_rank_list


ADMIN_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
CONTEXT = {'user_id': str(ADMIN_USER_ID)}


class UserRankRuntimeTest(unittest.TestCase):
    def setUp(self):
        with Session(engine) as session:
            user = session.scalar(
                select(User).where(User.user_id == ADMIN_USER_ID)
            )
            user.producer_rank = 8
            session.commit()

    def test_full_rank_table_matches_finish_job_progression(self):
        reply = get_producer_rank_list({}, CONTEXT)
        self.assertEqual(set(reply), {'producer_rank_list'})
        ranks = reply['producer_rank_list']
        self.assertEqual(len(ranks), 8)
        self.assertEqual(
            [rank['mst_producer_rank_id'] for rank in ranks],
            list(range(1, 9)),
        )
        self.assertEqual(
            [rank['fan'] for rank in ranks],
            [0, 1000, 10000, 50000, 100000, 300000, 500000, 1000000],
        )
        self.assertTrue(all(rank['is_released'] for rank in ranks))
        self.assertEqual(
            [rank['reward_item']['amount'] for rank in ranks],
            [0, 50, 50, 50, 50, 50, 100, 150],
        )
        self.assertEqual(
            [rank['reward_item']['mst_item_id'] for rank in ranks],
            [0, 3, 3, 3, 3, 3, 3, 3],
        )

    def test_release_flags_follow_current_rank(self):
        with Session(engine) as session:
            user = session.scalar(
                select(User).where(User.user_id == ADMIN_USER_ID)
            )
            user.producer_rank = 4
            session.commit()

        ranks = get_producer_rank_list({}, CONTEXT)['producer_rank_list']
        self.assertEqual(
            [rank['is_released'] for rank in ranks],
            [True, True, True, True, False, False, False, False],
        )


if __name__ == '__main__':
    unittest.main(verbosity=2)
