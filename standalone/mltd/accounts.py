import hashlib
import hmac
import re
import secrets
from base64 import b64encode
from uuid import UUID, uuid4

from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import AccountCredential, Base, User

DEFAULT_USER_ID = UUID('ffffffff-ffff-ffff-ffff-ffffffffffff')
DEFAULT_USERNAME = 'MLTD0000'
DEFAULT_PASSWORD = 'relive2026'
LEGACY_DEFAULT_SECRET = 'abcdefghijklmnopqrstuvwxyz012345'
_PASSWORD_ITERATIONS = 160_000
_USERNAME_RE = re.compile(r'^[A-Z0-9]{8}$')
_USER_HASH_SUFFIX = bytes.fromhex(
    'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
)

# These rows describe a live/transient session or social relationship rather
# than the reusable full-save baseline. A newly registered account starts with
# a clean state for them even when the default account currently has rows.
_CLONE_SKIP_TABLES = {
    'account_credential',
    'friend',
    'pending_job',
    'pending_job_answer',
    'pending_song',
    'present',
    'user',
}


def normalize_username(username: str) -> str:
    value = (username or '').strip().upper()
    if not _USERNAME_RE.fullmatch(value):
        raise ValueError('username must be exactly 8 ASCII letters or digits')
    return value


def validate_password(password: str) -> str:
    if not isinstance(password, str) or not 8 <= len(password) <= 64:
        raise ValueError('password must contain 8 to 64 characters')
    if '\x00' in password:
        raise ValueError('password contains an invalid character')
    return password


def _password_digest(password: str, salt: bytes) -> str:
    return hashlib.pbkdf2_hmac(
        'sha256', password.encode('utf-8'), salt, _PASSWORD_ITERATIONS
    ).hex()


def _make_password_record(password: str) -> tuple[str, str]:
    salt = secrets.token_bytes(16)
    return salt.hex(), _password_digest(password, salt)


def _verify_password(account: AccountCredential, password: str) -> bool:
    try:
        salt = bytes.fromhex(account.password_salt)
    except (TypeError, ValueError):
        return False
    actual = _password_digest(password, salt)
    return hmac.compare_digest(actual, account.password_hash)


def _secret_digest(secret: str) -> str:
    return hashlib.sha256(secret.encode('utf-8')).hexdigest()


def _user_id_hash(user_id: UUID):
    return b64encode(str(user_id).encode('ascii') + _USER_HASH_SUFFIX)


def _owner_column(table):
    if 'user_id' in table.c:
        return table.c.user_id
    if 'id_' in table.c:
        column = table.c.id_
        targets = {fk.target_fullname for fk in column.foreign_keys}
        # Profile helper/stat tables are user-owned indirectly through
        # profile.id_; their id_ value is still exactly the user's UUID.
        if targets & {'user.user_id', 'profile.id_'}:
            return column
    return None


def _remap_value(value, source_user_id: UUID, target_user_id: UUID):
    if value == source_user_id:
        return target_user_id
    if isinstance(value, str):
        source = str(source_user_id)
        target = str(target_user_id)
        if value == source:
            return target
        prefix = source + '_'
        if value.startswith(prefix):
            return target + value[len(source):]
    return value


def _unique_search_id(session: Session) -> str:
    for _ in range(100):
        candidate = f'{secrets.randbelow(100_000_000):08d}'
        if session.scalar(select(User.user_id).where(User.search_id == candidate)) is None:
            return candidate
    raise RuntimeError('could not allocate a unique search ID')


def clone_full_save(
    session: Session,
    *,
    target_user_id: UUID,
    search_id: str,
    display_name: str,
    source_user_id: UUID = DEFAULT_USER_ID,
) -> None:
    """Clone the persistent full-save baseline into an independent user.

    User-specific string IDs in this project use ``<uuid>_<master-id>``.
    They and all references to them are remapped to the destination UUID.
    Transient session, present and friend rows are intentionally not copied.
    """
    user_table = Base.metadata.tables['user']
    source_row = session.execute(
        select(user_table).where(user_table.c.user_id == source_user_id)
    ).mappings().one_or_none()
    if source_row is None:
        raise RuntimeError('default full-save template user is missing')

    user_row = dict(source_row)
    user_row['user_id'] = target_user_id
    user_row['search_id'] = search_id
    user_row['name'] = display_name
    user_row['user_id_hash'] = _user_id_hash(target_user_id)
    session.execute(user_table.insert(), user_row)

    for table in Base.metadata.sorted_tables:
        if table.name in _CLONE_SKIP_TABLES:
            continue
        owner = _owner_column(table)
        if owner is None:
            continue
        source_rows = session.execute(
            select(table).where(owner == source_user_id)
        ).mappings().all()
        if not source_rows:
            continue
        cloned = []
        for row in source_rows:
            values = {
                key: _remap_value(value, source_user_id, target_user_id)
                for key, value in dict(row).items()
            }
            cloned.append(values)
        session.execute(table.insert(), cloned)

    profile = Base.metadata.tables.get('profile')
    if profile is not None:
        session.execute(
            profile.update()
            .where(profile.c.id_ == target_user_id)
            .values(name=display_name)
        )


def ensure_default_account(session: Session) -> AccountCredential:
    account = session.get(AccountCredential, DEFAULT_USERNAME)
    if account is not None:
        return account
    if session.get(User, DEFAULT_USER_ID) is None:
        raise RuntimeError('default full-save user is missing')
    salt, password_hash = _make_password_record(DEFAULT_PASSWORD)
    account = AccountCredential(
        username=DEFAULT_USERNAME,
        user_id=DEFAULT_USER_ID,
        password_salt=salt,
        password_hash=password_hash,
        secret_hash=_secret_digest(LEGACY_DEFAULT_SECRET),
    )
    session.add(account)
    return account


def register_account(
    username: str,
    password: str,
    *,
    display_name: str | None = None,
    session: Session | None = None,
) -> dict:
    username = normalize_username(username)
    password = validate_password(password)
    display_name = (display_name or username).strip()
    if not display_name or len(display_name) > 10:
        raise ValueError('display_name must contain 1 to 10 characters')

    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        if session.get(AccountCredential, username) is not None:
            raise ValueError('username already exists')
        ensure_default_account(session)
        user_id = uuid4()
        search_id = _unique_search_id(session)
        clone_full_save(
            session,
            target_user_id=user_id,
            search_id=search_id,
            display_name=display_name,
        )
        salt, password_hash = _make_password_record(password)
        account = AccountCredential(
            username=username,
            user_id=user_id,
            password_salt=salt,
            password_hash=password_hash,
            secret_hash='',
        )
        session.add(account)
        session.flush()
        result = {
            'username': username,
            'user_id': str(user_id),
            'search_id': search_id,
            'display_name': display_name,
        }
        if owns_session:
            session.commit()
        return result
    except Exception:
        if owns_session:
            session.rollback()
        raise
    finally:
        if owns_session:
            session.close()


def authenticate_transfer(
    username: str,
    password: str,
    *,
    session: Session | None = None,
) -> tuple[UUID, str] | None:
    try:
        username = normalize_username(username)
        password = validate_password(password)
    except ValueError:
        return None

    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        account = session.get(AccountCredential, username)
        if account is None or not _verify_password(account, password):
            return None
        if account.user_id == DEFAULT_USER_ID:
            secret = LEGACY_DEFAULT_SECRET
        else:
            secret = secrets.token_urlsafe(24)
        account.secret_hash = _secret_digest(secret)
        if owns_session:
            session.commit()
        else:
            session.flush()
        return account.user_id, secret
    finally:
        if owns_session:
            session.close()


def verify_login_secret(
    user_id: UUID | str,
    secret: str,
    *,
    session: Session | None = None,
) -> bool:
    try:
        user_id = UUID(str(user_id))
    except (TypeError, ValueError):
        return False
    if not isinstance(secret, str):
        return False

    # Preserve compatibility for already configured installations that used
    # the historical static full-save secret before multi-user support.
    if user_id == DEFAULT_USER_ID and hmac.compare_digest(
        secret, LEGACY_DEFAULT_SECRET
    ):
        return True

    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        account = session.scalar(
            select(AccountCredential).where(AccountCredential.user_id == user_id)
        )
        if account is None or not account.secret_hash:
            return False
        return hmac.compare_digest(account.secret_hash, _secret_digest(secret))
    finally:
        if owns_session:
            session.close()
