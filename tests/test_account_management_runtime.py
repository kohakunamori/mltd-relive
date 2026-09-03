"""Runtime coverage for standalone GUI account administration primitives."""
import unittest
from uuid import UUID

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from mltd.accounts import (
    DEFAULT_PASSWORD,
    DEFAULT_USER_ID,
    DEFAULT_USERNAME,
    LEGACY_DEFAULT_SECRET,
    authenticate_transfer,
    delete_account,
    list_accounts,
    register_account,
    set_account_enabled,
    verify_login_secret,
)
from mltd.models.engine import engine
from mltd.models.models import AccountCredential, Card, User


class AccountManagementRuntimeTest(unittest.TestCase):

    def test_01_default_account_can_be_disabled_and_reenabled(self):
        set_account_enabled(DEFAULT_USERNAME, False)
        accounts = {row['username']: row for row in list_accounts()}
        self.assertFalse(accounts[DEFAULT_USERNAME]['is_enabled'])
        self.assertTrue(accounts[DEFAULT_USERNAME]['is_default'])
        self.assertIsNone(authenticate_transfer(DEFAULT_USERNAME, DEFAULT_PASSWORD))
        self.assertFalse(
            verify_login_secret(DEFAULT_USER_ID, LEGACY_DEFAULT_SECRET)
        )

        set_account_enabled(DEFAULT_USERNAME, True)
        accounts = {row['username']: row for row in list_accounts()}
        self.assertTrue(accounts[DEFAULT_USERNAME]['is_enabled'])
        self.assertIsNotNone(
            authenticate_transfer(DEFAULT_USERNAME, DEFAULT_PASSWORD)
        )
        self.assertTrue(
            verify_login_secret(DEFAULT_USER_ID, LEGACY_DEFAULT_SECRET)
        )

    def test_02_regular_account_disable_blocks_transfer_and_login(self):
        result = register_account(
            'ADMIN001', 'password123', display_name='ManagedA'
        )
        user_id = UUID(result['user_id'])
        transferred = authenticate_transfer('ADMIN001', 'password123')
        self.assertIsNotNone(transferred)
        _, secret = transferred
        self.assertTrue(verify_login_secret(user_id, secret))

        set_account_enabled('ADMIN001', False)
        self.assertIsNone(authenticate_transfer('ADMIN001', 'password123'))
        self.assertFalse(verify_login_secret(user_id, secret))

        set_account_enabled('ADMIN001', True)
        self.assertTrue(verify_login_secret(user_id, secret))
        self.assertIsNotNone(authenticate_transfer('ADMIN001', 'password123'))

    def test_03_delete_regular_account_removes_independent_save(self):
        result = register_account(
            'ADMIN002', 'password123', display_name='ManagedB'
        )
        user_id = UUID(result['user_id'])
        with Session(engine) as session:
            self.assertIsNotNone(session.get(User, user_id))
            self.assertGreater(
                session.scalar(
                    select(func.count()).select_from(Card)
                    .where(Card.user_id == user_id)
                ),
                0,
            )

        reply = delete_account('ADMIN002')
        self.assertTrue(reply['deleted'])
        self.assertEqual(reply['user_id'], str(user_id))

        with Session(engine) as session:
            self.assertIsNone(session.get(AccountCredential, 'ADMIN002'))
            self.assertIsNone(session.get(User, user_id))
            self.assertEqual(
                session.scalar(
                    select(func.count()).select_from(Card)
                    .where(Card.user_id == user_id)
                ),
                0,
            )
        self.assertNotIn(
            'ADMIN002', {row['username'] for row in list_accounts()}
        )

    def test_04_default_full_save_account_cannot_be_deleted(self):
        with self.assertRaisesRegex(ValueError, 'cannot be deleted'):
            delete_account(DEFAULT_USERNAME)
        with Session(engine) as session:
            self.assertIsNotNone(session.get(User, DEFAULT_USER_ID))
            self.assertIsNotNone(
                session.get(AccountCredential, DEFAULT_USERNAME)
            )


if __name__ == '__main__':
    unittest.main(verbosity=2)
