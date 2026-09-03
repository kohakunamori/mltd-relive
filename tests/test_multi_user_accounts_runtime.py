"""Runtime coverage for external registration and password-transfer accounts."""
import io
import json
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
    register_account,
    verify_login_secret,
)
from mltd.models.engine import engine
from mltd.models.models import (
    AccountCredential,
    Card,
    Idol,
    Item,
    Profile,
    Unit,
    User,
)
from mltd.servers import handler
from mltd.services.auth import login, transfer_password


class MultiUserAccountsRuntimeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.created_usernames = []

    def _register(self, username, password='password123', display_name=None):
        result = register_account(
            username, password, display_name=display_name or username
        )
        self.created_usernames.append(username)
        return result

    def test_01_default_full_save_account_credentials(self):
        with Session(engine) as session:
            account = session.get(AccountCredential, DEFAULT_USERNAME)
            user = session.get(User, DEFAULT_USER_ID)
            self.assertIsNotNone(account)
            self.assertIsNotNone(user)
            self.assertEqual(account.user_id, DEFAULT_USER_ID)
            self.assertEqual(user.search_id, '00000000')
            self.assertEqual(user.name, 'MLTDrelive')
            self.assertEqual(user.level, 900)
            self.assertEqual(user.money, 9_999_999)

        reply = transfer_password({
            'user_id': DEFAULT_USERNAME,
            'password': DEFAULT_PASSWORD,
            'platform': 'google',
            'platform_user_id': '0123456789abcdef',
            'device_name': 'test-device',
        })
        self.assertEqual(reply, {
            'success': True,
            'user_id': str(DEFAULT_USER_ID),
            'secret': LEGACY_DEFAULT_SECRET,
        })
        self.assertTrue(verify_login_secret(DEFAULT_USER_ID, reply['secret']))

    def test_02_bad_password_does_not_transfer(self):
        reply = transfer_password({
            'user_id': DEFAULT_USERNAME,
            'password': 'wrong-password',
            'platform': 'google',
            'platform_user_id': '0123456789abcdef',
            'device_name': 'test-device',
        })
        self.assertEqual(reply, {'success': False, 'user_id': '', 'secret': ''})

    def test_03_external_registration_creates_independent_full_save(self):
        result = self._register('USER0001', display_name='ProducerA')
        new_user_id = UUID(result['user_id'])
        self.assertNotEqual(new_user_id, DEFAULT_USER_ID)
        self.assertEqual(len(result['search_id']), 8)

        with Session(engine) as session:
            new_user = session.get(User, new_user_id)
            default_user = session.get(User, DEFAULT_USER_ID)
            self.assertEqual(new_user.name, 'ProducerA')
            self.assertEqual(new_user.level, default_user.level)
            self.assertEqual(new_user.money, default_user.money)

            for model in (Card, Idol, Item, Unit):
                owner = model.user_id
                default_count = session.scalar(
                    select(func.count()).select_from(model)
                    .where(owner == DEFAULT_USER_ID)
                )
                new_count = session.scalar(
                    select(func.count()).select_from(model)
                    .where(owner == new_user_id)
                )
                self.assertEqual(new_count, default_count, model.__name__)

            new_profile = session.get(Profile, new_user_id)
            default_profile = session.get(Profile, DEFAULT_USER_ID)
            self.assertEqual(new_profile.name, 'ProducerA')
            self.assertNotEqual(new_profile.favorite_card_id,
                                default_profile.favorite_card_id)
            self.assertTrue(new_profile.favorite_card_id.startswith(str(new_user_id)))

            # Mutating one account must not touch the default save.
            new_user.money = 12345
            new_profile.name = 'Changed'
            session.commit()

        with Session(engine) as session:
            self.assertEqual(session.get(User, new_user_id).money, 12345)
            self.assertEqual(session.get(Profile, new_user_id).name, 'Changed')
            self.assertEqual(session.get(User, DEFAULT_USER_ID).money, 9_999_999)
            self.assertEqual(session.get(Profile, DEFAULT_USER_ID).name,
                             'MLTDrelive')

    def test_04_registered_account_password_transfer_and_login(self):
        result = self._register('USER0002', 'correct-pass', 'ProducerB')
        user_id = UUID(result['user_id'])
        self.assertIsNone(authenticate_transfer('USER0002', 'bad-pass'))
        authenticated = authenticate_transfer('user0002', 'correct-pass')
        self.assertIsNotNone(authenticated)
        auth_user_id, secret = authenticated
        self.assertEqual(auth_user_id, user_id)
        self.assertTrue(verify_login_secret(user_id, secret))
        self.assertFalse(verify_login_secret(user_id, secret + 'x'))

        reply = login({
            'user_id': str(user_id),
            'secret': secret,
            'device_name': 'test-device',
            'os_name': 'android',
            'os_version': '16',
            'ad_id': '',
            'space': 123456789,
        })
        self.assertEqual(reply['user']['user_id'], str(user_id))
        self.assertEqual(reply['user']['name'], 'ProducerB')
        self.assertIn('token', reply)

        with self.assertRaises(LookupError):
            login({
                'user_id': str(user_id),
                'secret': 'not-the-secret',
                'device_name': 'test-device',
                'os_name': 'android',
                'os_version': '16',
                'ad_id': '',
                'space': 123456789,
            })

    def test_05_duplicate_registration_is_atomic(self):
        self._register('USER0003', 'password123', 'ProducerC')
        with Session(engine) as session:
            user_count_before = session.scalar(select(func.count()).select_from(User))
            account_count_before = session.scalar(
                select(func.count()).select_from(AccountCredential)
            )
        with self.assertRaisesRegex(ValueError, 'already exists'):
            register_account('USER0003', 'different-pass')
        with Session(engine) as session:
            self.assertEqual(
                session.scalar(select(func.count()).select_from(User)),
                user_count_before,
            )
            self.assertEqual(
                session.scalar(select(func.count()).select_from(AccountCredential)),
                account_count_before,
            )

    def test_06_two_registered_users_have_distinct_save_ids(self):
        first = self._register('USER0004', 'password123', 'ProducerD')
        second = self._register('USER0005', 'password123', 'ProducerE')
        first_id = UUID(first['user_id'])
        second_id = UUID(second['user_id'])
        self.assertNotEqual(first_id, second_id)
        self.assertNotEqual(first['search_id'], second['search_id'])
        with Session(engine) as session:
            first_card = session.scalar(
                select(Card.card_id).where(Card.user_id == first_id).limit(1)
            )
            second_card = session.scalar(
                select(Card.card_id).where(Card.user_id == second_id).limit(1)
            )
            self.assertTrue(first_card.startswith(str(first_id) + '_'))
            self.assertTrue(second_card.startswith(str(second_id) + '_'))
            self.assertNotEqual(first_card, second_card)

    def test_07_registration_http_endpoint_loopback_and_remote_guard(self):
        payload = json.dumps({
            'username': 'HTTP0001',
            'password': 'password123',
            'display_name': 'HttpUser',
        }).encode('utf-8')

        def call(remote_addr):
            status = []
            headers = []
            environ = {
                'PATH_INFO': '/relive/accounts/register',
                'REQUEST_METHOD': 'POST',
                'REMOTE_ADDR': remote_addr,
                'CONTENT_LENGTH': str(len(payload)),
                'wsgi.input': io.BytesIO(payload),
            }

            def start_response(value, value_headers):
                status.append(value)
                headers.extend(value_headers)

            body = b''.join(handler.application(environ, start_response))
            return status[0], json.loads(body.decode('utf-8'))

        status, response = call('127.0.0.1')
        self.assertEqual(status, '201 Created')
        self.assertEqual(response['username'], 'HTTP0001')

        # No registration_api_key is configured in the fresh test config, so
        # a non-loopback caller is denied before any account mutation.
        remote_payload = json.dumps({
            'username': 'HTTP0002',
            'password': 'password123',
        }).encode('utf-8')
        status_holder = []
        environ = {
            'PATH_INFO': '/relive/accounts/register',
            'REQUEST_METHOD': 'POST',
            'REMOTE_ADDR': '192.0.2.10',
            'CONTENT_LENGTH': str(len(remote_payload)),
            'wsgi.input': io.BytesIO(remote_payload),
        }
        body = b''.join(handler.application(
            environ, lambda status, headers: status_holder.append(status)
        ))
        self.assertEqual(status_holder[0], '403 Forbidden')
        self.assertEqual(json.loads(body.decode('utf-8'))['error'],
                         'registration_not_authorized')
        with Session(engine) as session:
            self.assertIsNone(session.get(AccountCredential, 'HTTP0002'))


if __name__ == '__main__':
    unittest.main(verbosity=2)
