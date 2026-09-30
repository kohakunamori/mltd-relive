"""Runtime coverage for FriendService.GetRecommendUserList."""
from uuid import UUID
import unittest

from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Friend, Profile
from mltd.services.friend_recommend import get_recommend_user_list


ADMIN_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
CONTEXT = {'user_id': str(ADMIN_USER_ID)}
EXPECTED_USER_SUMMARY_KEYS = {
    'user_id', 'name', 'mst_achievement_id', 'mst_achievement_id_list',
    'comment', 'level', 'lp', 'helper_card_list', 'favorite_card',
    'favorite_card_before_awake', 'producer_rank', 'is_friend', 'lounge_id',
    'lounge_user_state', 'lounge_name', 'create_date', 'last_login_date',
}


class FriendRecommendRuntimeTest(unittest.TestCase):
    def setUp(self):
        with Session(engine) as session:
            session.execute(
                delete(Friend).where(Friend.user_id == ADMIN_USER_ID)
            )
            self.target_id = session.scalar(
                select(Profile.id_)
                .where(Profile.id_ != ADMIN_USER_ID)
                .order_by(Profile.id_)
            )
            if self.target_id is None:
                raise AssertionError('no recommendation candidate available')
            session.add(
                Friend(user_id=ADMIN_USER_ID, friend_id=self.target_id)
            )
            session.commit()

    def test_recommendations_exclude_self_and_existing_friends(self):
        reply = get_recommend_user_list({}, CONTEXT)
        self.assertEqual(set(reply), {'user_list'})
        users = reply['user_list']
        self.assertLessEqual(len(users), 20)
        ids = {UUID(user['user_id']) for user in users}
        self.assertNotIn(ADMIN_USER_ID, ids)
        self.assertNotIn(self.target_id, ids)
        self.assertTrue(all(user['is_friend'] is False for user in users))

    def test_recommendation_shape_matches_client_user_summary(self):
        users = get_recommend_user_list({}, CONTEXT)['user_list']
        self.assertTrue(users)
        self.assertEqual(set(users[0]), EXPECTED_USER_SUMMARY_KEYS)


if __name__ == '__main__':
    unittest.main(verbosity=2)
