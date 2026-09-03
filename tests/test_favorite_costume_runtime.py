
"""Runtime coverage for IdolService.SetFavoriteCostume persistence."""
import unittest

from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Costume, FavoriteCostume, Idol, MstCostume
from mltd.models.schemas import IdolSchema
from mltd.services.idol import set_favorite_costume


class FavoriteCostumeRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with Session(engine) as session:
            candidates = session.execute(
                select(Costume.user_id, MstCostume.mst_idol_id)
                .join(MstCostume, Costume.mst_costume_id == MstCostume.mst_costume_id)
                .group_by(Costume.user_id, MstCostume.mst_idol_id)
                .having(__import__('sqlalchemy').func.count() >= 2)
                .limit(1)
            ).first()
            if candidates is None:
                raise AssertionError('standalone setup has no idol with two costumes')
            cls.user_id, cls.mst_idol_id = candidates
            cls.idol = session.scalar(
                select(Idol)
                .where(Idol.user_id == cls.user_id)
                .where(Idol.mst_idol_id == cls.mst_idol_id)
            )
            cls.costume_ids = list(session.scalars(
                select(MstCostume.mst_costume_id)
                .join(Costume, Costume.mst_costume_id == MstCostume.mst_costume_id)
                .where(Costume.user_id == cls.user_id)
                .where(MstCostume.mst_idol_id == cls.mst_idol_id)
                .order_by(MstCostume.mst_costume_id)
                .limit(2)
            ))
        cls.context = {'user_id': str(cls.user_id)}

    def setUp(self):
        with Session(engine) as session:
            session.execute(delete(FavoriteCostume).where(
                FavoriteCostume.idol_id == self.idol.idol_id))
            session.commit()

    def _stored_ids(self):
        with Session(engine) as session:
            return list(session.scalars(
                select(FavoriteCostume.mst_costume_id)
                .where(FavoriteCostume.idol_id == self.idol.idol_id)
                .order_by(FavoriteCostume.sort_order)
            ))

    def test_replace_replay_persist_and_clear(self):
        params = {
            'mst_idol_id': self.mst_idol_id,
            'mst_costume_id_list': list(reversed(self.costume_ids)),
        }
        first = set_favorite_costume(params, self.context)
        second = set_favorite_costume(params, self.context)
        self.assertEqual(
            [v['mst_costume_id'] for v in first['favorite_costume_list']],
            params['mst_costume_id_list'],
        )
        self.assertEqual(first, second)
        self.assertEqual(self._stored_ids(), params['mst_costume_id_list'])

        with Session(engine) as session:
            idol = session.scalar(select(Idol).where(Idol.idol_id == self.idol.idol_id))
            serialized = IdolSchema().dump(idol)
        self.assertEqual(
            [v['mst_costume_id'] for v in serialized['favorite_costume_list']],
            params['mst_costume_id_list'],
        )

        cleared = set_favorite_costume(
            {'mst_idol_id': self.mst_idol_id, 'mst_costume_id_list': []},
            self.context,
        )
        self.assertEqual(cleared, {'favorite_costume_list': []})
        self.assertEqual(self._stored_ids(), [])

    def test_invalid_request_does_not_destroy_prior_state(self):
        set_favorite_costume({
            'mst_idol_id': self.mst_idol_id,
            'mst_costume_id_list': [self.costume_ids[0]],
        }, self.context)
        with self.assertRaises(ValueError):
            set_favorite_costume({
                'mst_idol_id': self.mst_idol_id,
                'mst_costume_id_list': [self.costume_ids[0], 2147483647],
            }, self.context)
        self.assertEqual(self._stored_ids(), [self.costume_ids[0]])

    def test_duplicate_is_rejected_without_mutation(self):
        with self.assertRaises(ValueError):
            set_favorite_costume({
                'mst_idol_id': self.mst_idol_id,
                'mst_costume_id_list': [self.costume_ids[0], self.costume_ids[0]],
            }, self.context)
        self.assertEqual(self._stored_ids(), [])


if __name__ == '__main__':
    unittest.main(verbosity=2)
