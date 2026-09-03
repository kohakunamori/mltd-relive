"""Runtime smoke tests for reverse-engineered StoryService RPCs.

This script is intentionally run from ``standalone/`` after ``setup()`` has
created the normal SQLite database. It exercises the real SQLAlchemy models,
relationships, schemas and service functions instead of only checking source
shape.
"""
from uuid import UUID
import unittest

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import (
    CostumeAdv,
    Episode,
    MainStoryChapter,
    Memorial,
    MstMainStoryChapter,
    SpecialStory,
)
from mltd.services.story import (
    finish_costume_adv,
    finish_episode,
    finish_main_story,
    finish_memorial,
    finish_special_story,
    play_story_mv,
)
from mltd.services.story_legacy import get_special_list


ADMIN_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
CONTEXT = {'user_id': str(ADMIN_USER_ID)}


class StoryServiceRuntimeTest(unittest.TestCase):
    def _reset_read_state(self, model, *criteria):
        with Session(engine) as session:
            stmt = select(model).where(model.user_id == ADMIN_USER_ID)
            for criterion in criteria:
                stmt = stmt.where(criterion)
            state = session.scalar(stmt)
            self.assertIsNotNone(state)
            state.is_released = True
            state.is_read = False
            session.commit()

    def test_legacy_get_special_list_empty_reply(self):
        self.assertEqual(get_special_list({}), {})

    def test_play_story_mv_empty_reply(self):
        self.assertEqual(play_story_mv({}, CONTEXT), {})

    def test_finish_episode_is_persistent_and_idempotent(self):
        with Session(engine) as session:
            state = session.scalar(
                select(Episode)
                .where(Episode.user_id == ADMIN_USER_ID)
                .order_by(Episode.mst_card_id)
                .limit(1)
            )
            self.assertIsNotNone(state)
            mst_card_id = state.mst_card_id

        self._reset_read_state(Episode, Episode.mst_card_id == mst_card_id)

        first = finish_episode({'mst_card_id': mst_card_id}, CONTEXT)
        self.assertIn('reward_item_status_list', first)
        self.assertIn('mission_process', first)
        self.assertIn('mission_list', first)

        with Session(engine) as session:
            state = session.scalar(
                select(Episode)
                .where(Episode.user_id == ADMIN_USER_ID)
                .where(Episode.mst_card_id == mst_card_id)
            )
            self.assertTrue(state.is_read)

        second = finish_episode({'mst_card_id': mst_card_id}, CONTEXT)
        self.assertEqual(second['reward_item_status_list'], [])

    def test_finish_memorial_accepts_list_and_is_idempotent(self):
        with Session(engine) as session:
            state = session.scalar(
                select(Memorial)
                .where(Memorial.user_id == ADMIN_USER_ID)
                .order_by(Memorial.mst_memorial_id)
                .limit(1)
            )
            self.assertIsNotNone(state)
            mst_memorial_id = state.mst_memorial_id

        self._reset_read_state(
            Memorial,
            Memorial.mst_memorial_id == mst_memorial_id,
        )

        first = finish_memorial(
            {'mst_memorial_id_list': [mst_memorial_id]},
            CONTEXT,
        )
        self.assertIn('reward_item_status_list', first)
        self.assertIn('mission_process', first)
        self.assertIn('mission_list', first)

        second = finish_memorial(
            {'mst_memorial_id': mst_memorial_id},
            CONTEXT,
        )
        self.assertEqual(second['reward_item_status_list'], [])

    def test_finish_costume_adv_is_idempotent(self):
        with Session(engine) as session:
            state = session.scalar(
                select(CostumeAdv)
                .where(CostumeAdv.user_id == ADMIN_USER_ID)
                .order_by(CostumeAdv.mst_theater_costume_blog_id)
                .limit(1)
            )
            self.assertIsNotNone(state)
            mst_id = state.mst_theater_costume_blog_id

        self._reset_read_state(
            CostumeAdv,
            CostumeAdv.mst_theater_costume_blog_id == mst_id,
        )

        first = finish_costume_adv(
            {'mst_theater_costume_blog_id': mst_id}, CONTEXT
        )
        self.assertIn('reward_item_status_list', first)
        second = finish_costume_adv(
            {'mst_theater_costume_blog_id': mst_id}, CONTEXT
        )
        self.assertEqual(second['reward_item_status_list'], [])

    def test_finish_special_story_is_idempotent(self):
        with Session(engine) as session:
            state = session.scalar(
                select(SpecialStory)
                .where(SpecialStory.user_id == ADMIN_USER_ID)
                .where(SpecialStory.mst_special_story_id != 0)
                .order_by(SpecialStory.mst_special_story_id)
                .limit(1)
            )
            self.assertIsNotNone(state)
            mst_id = state.mst_special_story_id

        self._reset_read_state(
            SpecialStory,
            SpecialStory.mst_special_story_id == mst_id,
        )

        first = finish_special_story(
            {'mst_special_story_id_list': [mst_id]}, CONTEXT
        )
        self.assertIn('reward_item_status_list', first)
        second = finish_special_story(
            {'mst_special_story_id_list': [mst_id]}, CONTEXT
        )
        self.assertEqual(second['reward_item_status_list'], [])

    def test_finish_main_story_last_chapter_is_idempotent(self):
        with Session(engine) as session:
            story_id = session.scalar(
                select(MainStoryChapter.mst_main_story_id)
                .where(MainStoryChapter.user_id == ADMIN_USER_ID)
                .order_by(MainStoryChapter.mst_main_story_id)
                .limit(1)
            )
            self.assertIsNotNone(story_id)
            last_chapter = session.scalar(
                select(func.max(MstMainStoryChapter.chapter))
                .where(MstMainStoryChapter.mst_main_story_id == story_id)
            )
            self.assertIsNotNone(last_chapter)

        self._reset_read_state(
            MainStoryChapter,
            MainStoryChapter.mst_main_story_id == story_id,
            MainStoryChapter.chapter == last_chapter,
        )

        params = {
            'mst_main_story_id': story_id,
            'chapter': last_chapter,
        }
        first = finish_main_story(params, CONTEXT)
        for key in (
            'reward_item_status_list',
            'reward_mst_song_id',
            'song',
            'release_blog',
            'is_release_next',
            'next_mst_main_story_id',
            'next_chapter',
            'mission_process',
            'mission_list',
        ):
            self.assertIn(key, first)

        second = finish_main_story(params, CONTEXT)
        self.assertEqual(second['reward_item_status_list'], [])
        self.assertEqual(second['reward_mst_song_id'], 0)


if __name__ == '__main__':
    unittest.main(verbosity=2)
