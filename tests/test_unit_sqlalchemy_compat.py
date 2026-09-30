import unittest
from pathlib import Path

from sqlalchemy import create_engine, literal, select
from sqlalchemy.orm import Session


REPO_ROOT = Path(__file__).resolve().parents[1]
UNIT_SERVICE = REPO_ROOT / 'standalone' / 'mltd' / 'services' / 'unit.py'


class UnitSQLAlchemyCompatibilityTest(unittest.TestCase):
    def test_sqlalchemy_result_requires_row_materialization_before_dict(self):
        engine = create_engine('sqlite://')
        with Session(engine) as session:
            result = session.execute(select(literal(1), literal(52)))
            with self.assertRaisesRegex(TypeError, 'not subscriptable'):
                dict(result)

        with Session(engine) as session:
            result = session.execute(select(literal(1), literal(52)))
            self.assertEqual(dict(result.all()), {1: 52})

    def test_set_unit_materializes_two_column_result(self):
        source = UNIT_SERVICE.read_text(encoding='utf-8')
        self.assertIn('card_rows = session.execute(', source)
        self.assertIn(').all()\n        card_to_idol = dict(card_rows)', source)
        self.assertNotIn('card_to_idol = dict(session.execute(', source)


if __name__ == '__main__':
    unittest.main()
