"""Runtime coverage for core FriendService relationship RPCs.

Run from ``standalone/`` after normal database setup.
"""
import unittest

from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Friend
from mltd.services.friend import (
    exec_flower_stand_reward,
    get_comment_list,
    get_flower_stand_count,
    get_flower_stand_list,
)
from mltd.services.friend_core import (
    FRIEND_ACCEPTED,
    FRIEND_RECEIVED,
    FRIEND_SENT,
    accept_friend,
    get_friend_list,
    remove_friend,
    request_friend,
)


class FriendCoreRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            edge = session.scalar(select(Friend).limit(1))
            if edge is None:
                raise AssertionError('standalone setup did not create friend rows')
            cls.user_id = edge.user_id
            cls.target_id = edge.friend_id
        cls.user_context = {'user_id': str(cls.user_id)}
        cls.target_context = {'user_id': str(cls.target_id)}

    def setUp(self):
        # Restore a known accepted relation before every test.
        with Session(engine) as session:
            for source, target in (
                (self.user_id, self.target_id),
                (self.target_id, self.user_id),
            ):
                row = session.scalar(
                    select(Friend)
                    .where(Friend.user_id == source)
                    .where(Friend.friend_id == target)
                )
                if row is None:
                    session.add(Friend(user_id=source, friend_id=target))
            session.commit()

    def _has_edge(self, source, target):
        with Session(engine) as session:
            return session.scalar(
                select(Friend)
                .where(Friend.user_id == source)
                .where(Friend.friend_id == target)
            ) is not None

    def test_flower_stand_and_comment_read_contracts(self):
        count_reply = get_flower_stand_count({})
        self.assertEqual(set(count_reply), {'flower_stand_count'})
        self.assertEqual(
            set(count_reply['flower_stand_count']),
            {'send_count', 'recv_count', 'all_recv_count'},
        )

        list_reply = get_flower_stand_list({})
        self.assertEqual(
            set(list_reply),
            {
                'flower_stand_count',
                'sent_flower_stand_list',
                'received_flower_stand_list',
            },
        )
        self.assertEqual(list_reply['sent_flower_stand_list'], [])
        self.assertEqual(list_reply['received_flower_stand_list'], [])

        reward_reply = exec_flower_stand_reward({})
        self.assertEqual(
            reward_reply,
            {
                'recv_count': 0,
                'is_received': False,
                'flower_stand_name_list': [],
            },
        )

        self.assertEqual(get_comment_list({}), {'comment_list': []})

    def test_get_friend_list_reports_existing_bidirectional_friend(self):
        reply = get_friend_list(
            {'friend_state': FRIEND_ACCEPTED, 'limit': 100, 'cursor': ''},
            self.user_context,
        )
        ids = {entry['user_id'] for entry in reply['friend_list']}
        self.assertIn(str(self.target_id), ids)
        target = next(
            entry for entry in reply['friend_list']
            if entry['user_id'] == str(self.target_id)
        )
        self.assertEqual(target['friend_state'], FRIEND_ACCEPTED)
        self.assertTrue(target['target_user']['is_friend'])
        self.assertGreaterEqual(reply['current_friend_count'], 1)
        self.assertEqual(reply['cursor'], '')

    def test_remove_request_accept_round_trip(self):
        removed = remove_friend(
            {'target_user_id': str(self.target_id)}, self.user_context
        )
        self.assertTrue(removed['is_success'])
        self.assertFalse(self._has_edge(self.user_id, self.target_id))
        self.assertFalse(self._has_edge(self.target_id, self.user_id))

        requested = request_friend(
            {'target_user_id': str(self.target_id)}, self.user_context
        )
        self.assertEqual(requested['friend']['friend_state'], FRIEND_SENT)
        self.assertTrue(self._has_edge(self.user_id, self.target_id))
        self.assertFalse(self._has_edge(self.target_id, self.user_id))

        sender_view = get_friend_list(
            {'friend_state': FRIEND_SENT, 'limit': 100, 'cursor': ''},
            self.user_context,
        )
        self.assertIn(
            str(self.target_id),
            {entry['user_id'] for entry in sender_view['sent_request_list']},
        )

        receiver_view = get_friend_list(
            {'friend_state': FRIEND_RECEIVED, 'limit': 100, 'cursor': ''},
            self.target_context,
        )
        self.assertIn(
            str(self.user_id),
            {entry['user_id'] for entry in receiver_view['received_request_list']},
        )

        accepted = accept_friend(
            {'target_user_id': str(self.user_id)}, self.target_context
        )
        self.assertEqual(accepted['friend']['friend_state'], FRIEND_ACCEPTED)
        self.assertTrue(self._has_edge(self.user_id, self.target_id))
        self.assertTrue(self._has_edge(self.target_id, self.user_id))

    def test_repeated_request_and_accept_are_idempotent(self):
        remove_friend({'target_user_id': str(self.target_id)}, self.user_context)
        first = request_friend(
            {'target_user_id': str(self.target_id)}, self.user_context
        )
        second = request_friend(
            {'target_user_id': str(self.target_id)}, self.user_context
        )
        self.assertEqual(first['friend']['friend_state'], FRIEND_SENT)
        self.assertEqual(second['friend']['friend_state'], FRIEND_SENT)

        first_accept = accept_friend(
            {'target_user_id': str(self.user_id)}, self.target_context
        )
        second_accept = accept_friend(
            {'target_user_id': str(self.user_id)}, self.target_context
        )
        self.assertEqual(first_accept['friend']['friend_state'], FRIEND_ACCEPTED)
        self.assertEqual(second_accept['friend']['friend_state'], FRIEND_ACCEPTED)


if __name__ == '__main__':
    unittest.main(verbosity=2)
