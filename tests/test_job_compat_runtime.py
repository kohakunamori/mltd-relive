"""Runtime coverage for interrupted JobService cleanup RPCs.

Run from ``standalone/`` after normal database setup.
"""
import unittest
from datetime import datetime, timedelta, timezone

from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import PendingJob, PendingJobAnswer, User
from mltd.services.job import start_job
from mltd.services.job_compat import break_job, cancel_job


class JobCompatRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            cls.user_id = session.scalar(
                select(User.user_id).where(User.search_id == '00000000')
            )
        if cls.user_id is None:
            raise AssertionError('standalone setup did not create admin user')
        cls.context = {'user_id': str(cls.user_id)}

    def setUp(self):
        self._reset_user()

    def tearDown(self):
        self._reset_user()

    def _reset_user(self):
        with Session(engine) as session:
            # Delete answer rows explicitly first so the reset is robust even
            # if a previous test aborted before ORM cascade cleanup.
            session.execute(
                delete(PendingJobAnswer)
                .where(PendingJobAnswer.user_id == self.user_id)
            )
            session.execute(
                delete(PendingJob).where(PendingJob.user_id == self.user_id)
            )
            user = session.get(User, self.user_id)
            user._vitality = user.max_vitality
            user.full_recover_date = datetime.now(timezone.utc) - timedelta(seconds=1)
            session.commit()

    def _start_normal_job(self, token):
        with Session(engine) as session:
            user = session.get(User, self.user_id)
            before_vitality = user.vitality

        reply = start_job(
            {
                'mst_job_id': 1,
                'is_event_tour': False,
                'tour_count': 0,
                'macaroon_count': 0,
                'job_token': token,
            },
            self.context,
        )
        self.assertIn('token', reply)

        with Session(engine) as session:
            user = session.get(User, self.user_id)
            pending = session.get(PendingJob, self.user_id)
            self.assertIsNotNone(pending)
            self.assertEqual(pending.job_token, token)
            after_vitality = user.vitality
            after_full_recover = user.full_recover_date
            self.assertEqual(after_vitality, before_vitality - 20)

            # Ensure cascade cleanup is tested even when StartJob happened to
            # choose a non-chance job with no answer rows.
            existing = session.scalar(
                select(PendingJobAnswer)
                .where(PendingJobAnswer.user_id == self.user_id)
                .where(PendingJobAnswer.answer_key == 'compat_test')
            )
            if existing is None:
                session.add(PendingJobAnswer(
                    user_id=self.user_id,
                    scenario_id='compat_test',
                    answer_key='compat_test',
                    count=1,
                ))
            session.commit()

        return after_vitality, after_full_recover

    def _assert_cleanup_preserves_consumed_vitality(
        self, expected_vitality, expected_full_recover
    ):
        with Session(engine) as session:
            user = session.get(User, self.user_id)
            self.assertIsNone(session.get(PendingJob, self.user_id))
            answer_count = session.scalar(
                select(PendingJobAnswer)
                .where(PendingJobAnswer.user_id == self.user_id)
                .limit(1)
            )
            self.assertIsNone(answer_count)
            self.assertEqual(user.vitality, expected_vitality)
            self.assertEqual(user.full_recover_date, expected_full_recover)

    def test_break_job_clears_interrupted_job_without_refund(self):
        vitality, full_recover = self._start_normal_job('break-test')
        self.assertEqual(break_job({}, self.context), {})
        self._assert_cleanup_preserves_consumed_vitality(vitality, full_recover)

        # Restart recovery can be retried safely after the pending row is gone.
        self.assertEqual(break_job({}, self.context), {})
        self._assert_cleanup_preserves_consumed_vitality(vitality, full_recover)

    def test_cancel_job_clears_normal_job_and_reports_not_event_tour(self):
        vitality, full_recover = self._start_normal_job('cancel-test')
        self.assertEqual(
            cancel_job({}, self.context),
            {'is_event_tour': False},
        )
        self._assert_cleanup_preserves_consumed_vitality(vitality, full_recover)

        self.assertEqual(
            cancel_job({}, self.context),
            {'is_event_tour': False},
        )
        self._assert_cleanup_preserves_consumed_vitality(vitality, full_recover)


if __name__ == '__main__':
    unittest.main(verbosity=2)
