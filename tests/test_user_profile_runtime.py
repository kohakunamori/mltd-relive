"""Runtime tests for UserService profile RPC compatibility.

Run from ``standalone/`` after the normal database ``setup()`` so the tests
exercise the real persisted save, relationships and marshmallow schemas.
"""
from uuid import UUID
import unittest

from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Card, HelperCard, Mission, MstMission, Profile, User
from mltd.services.user_profile import get_profile, set_self_profile


ADMIN_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
CONTEXT = {'user_id': str(ADMIN_USER_ID)}


class UserProfileRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            cls.card_ids = session.scalars(
                select(Card.card_id)
                .where(Card.user_id == ADMIN_USER_ID)
                .order_by(Card.card_id)
                .limit(4)
            ).all()
            if len(cls.card_ids) < 4:
                raise AssertionError('profile test requires at least four cards')

            cls.search_id = session.scalar(
                select(User.search_id).where(User.user_id == ADMIN_USER_ID)
            )

    def _reset_profile_mission(self):
        with Session(engine) as session:
            mission = session.scalar(
                select(Mission)
                .join(MstMission)
                .where(Mission.user_id == ADMIN_USER_ID)
                .where(MstMission.mst_mission_class_id == 27)
                .order_by(Mission.mst_mission_id)
                .limit(1)
            )
            if mission is None:
                return None
            mission.progress = 0
            mission.mission_state = 1
            mission.finish_date = None
            session.commit()
            return mission.mst_mission_id

    def _params(self):
        return {
            'name': 'OfflineP',
            'birthday': '0102',
            'is_birthday_public': False,
            'comment': 'offline profile persistence smoke',
            'favorite_card_id': self.card_ids[0],
            'favorite_card_before_awake': True,
            'helper_card_id_list': [
                {'idol_type': index + 1, 'card_id': card_id}
                for index, card_id in enumerate(self.card_ids)
            ],
            'mst_achievement_id': 1,
            'mst_achievement_id_list': [1, 2, 3],
        }

    def test_set_profile_persists_all_supported_fields_and_mission(self):
        mission_id = self._reset_profile_mission()
        params = self._params()

        first = set_self_profile(params, CONTEXT)
        self.assertEqual(
            set(first),
            {'mission_process', 'mission_list'},
        )
        self.assertIn('complete_mission_list', first['mission_process'])
        self.assertIn('open_mission_list', first['mission_process'])
        self.assertIn('training_point_diff', first['mission_process'])

        with Session(engine) as session:
            user = session.scalar(
                select(User).where(User.user_id == ADMIN_USER_ID)
            )
            profile = session.scalar(
                select(Profile).where(Profile.id_ == ADMIN_USER_ID)
            )
            self.assertEqual(user.name, params['name'])
            self.assertEqual(profile.name, params['name'])
            self.assertEqual(profile.birthday, params['birthday'])
            self.assertFalse(profile.is_birthday_public)
            self.assertEqual(profile.comment, params['comment'])
            self.assertEqual(profile.favorite_card_id, params['favorite_card_id'])
            self.assertTrue(profile.favorite_card_before_awake)
            self.assertEqual(profile.mst_achievement_id, 1)
            self.assertEqual(profile.mst_achievement_id_list, '1,2,3')

            helper_states = session.scalars(
                select(HelperCard)
                .where(HelperCard.id_ == ADMIN_USER_ID)
                .order_by(HelperCard.idol_type)
            ).all()
            self.assertEqual(
                [(state.idol_type, state.card_id) for state in helper_states],
                [(index + 1, card_id)
                 for index, card_id in enumerate(self.card_ids)],
            )

            if mission_id is not None:
                mission = session.scalar(
                    select(Mission)
                    .where(Mission.user_id == ADMIN_USER_ID)
                    .where(Mission.mst_mission_id == mission_id)
                )
                self.assertEqual(mission.mission_state, 3)
                self.assertGreaterEqual(mission.progress, mission.mst_mission.goal)

        second = set_self_profile(params, CONTEXT)
        if mission_id is not None:
            self.assertEqual(second['mission_list'], [])
            self.assertEqual(
                second['mission_process']['complete_mission_list'], []
            )

    def test_get_profile_matches_exact_client_reply_surface(self):
        set_self_profile(self._params(), CONTEXT)
        reply = get_profile({'user_id': str(ADMIN_USER_ID)}, CONTEXT)

        expected_keys = {
            'user_id', 'search_id', 'name', 'birthday',
            'is_birthday_public', 'comment', 'favorite_card_id',
            'favorite_card_before_awake', 'helper_card_id_list',
            'mst_achievement_id', 'mst_achievement_id_list', 'lp',
            'album_count', 'story_count', 'clear_song_count_list',
            'full_combo_song_count_list', 'helper_card_list', 'favorite_card',
            'friend_state', 'lounge_id', 'lounge_name', 'lounge_user_state',
            'producer_rank', 'plv', 'theater_fan', 'sendable',
            'user_recognition',
        }
        self.assertEqual(set(reply), expected_keys)
        self.assertEqual(reply['user_id'], str(ADMIN_USER_ID))
        self.assertEqual(reply['search_id'], self.search_id)
        self.assertEqual(reply['name'], 'OfflineP')
        self.assertEqual(reply['birthday'], '0102')
        self.assertFalse(reply['is_birthday_public'])
        self.assertFalse(reply['sendable'])
        self.assertEqual(len(reply['helper_card_id_list']), 4)
        self.assertEqual(len(reply['helper_card_list']), 4)
        self.assertIsInstance(reply['favorite_card'], dict)
        self.assertEqual(
            [item['live_course'] for item in reply['clear_song_count_list']],
            [1, 2, 3, 4, 5, 6],
        )

        by_search_id = get_profile(
            {'search_user_id': self.search_id}, CONTEXT
        )
        self.assertEqual(by_search_id['user_id'], str(ADMIN_USER_ID))

    def test_invalid_card_references_do_not_corrupt_profile(self):
        set_self_profile(self._params(), CONTEXT)
        with Session(engine) as session:
            before = session.scalar(
                select(Profile.favorite_card_id)
                .where(Profile.id_ == ADMIN_USER_ID)
            )

        set_self_profile({
            'favorite_card_id': 'not-owned',
            'helper_card_id_list': [
                {'idol_type': 1, 'card_id': 'not-owned'},
                {'idol_type': 99, 'card_id': self.card_ids[0]},
            ],
        }, CONTEXT)

        with Session(engine) as session:
            after = session.scalar(
                select(Profile.favorite_card_id)
                .where(Profile.id_ == ADMIN_USER_ID)
            )
            self.assertEqual(after, before)


if __name__ == '__main__':
    unittest.main(verbosity=2)
