import hashlib
import hmac
import re
import secrets
from base64 import b64encode
from uuid import UUID, uuid4

from sqlalchemy import Boolean, Column, String, Table, select
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

# Account enable/disable state deliberately lives outside AccountCredential so
# existing v0.1.11 databases do not need a destructive/rebuilding migration.
# Missing rows mean enabled, preserving old installations automatically.
_ACCOUNT_CONTROL = Table(
    'account_control',
    Base.metadata,
    Column('username', String(8), primary_key=True),
    Column('is_enabled', Boolean, nullable=False, default=True),
)

# These rows describe a live/transient session or social relationship rather
# than the reusable full-save baseline. A newly registered account starts with
# a clean state for them even when the default account currently has rows.
_CLONE_SKIP_TABLES = {
    'account_control',
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


def _ensure_account_control_table(session: Session) -> None:
    _ACCOUNT_CONTROL.create(bind=session.get_bind(), checkfirst=True)


def _account_enabled(session: Session, username: str) -> bool:
    _ensure_account_control_table(session)
    value = session.scalar(
        select(_ACCOUNT_CONTROL.c.is_enabled)
        .where(_ACCOUNT_CONTROL.c.username == username)
    )
    return True if value is None else bool(value)


def _store_account_enabled(
    session: Session,
    username: str,
    enabled: bool,
) -> None:
    _ensure_account_control_table(session)
    existing = session.scalar(
        select(_ACCOUNT_CONTROL.c.username)
        .where(_ACCOUNT_CONTROL.c.username == username)
    )
    if existing is None:
        session.execute(
            _ACCOUNT_CONTROL.insert().values(
                username=username,
                is_enabled=bool(enabled),
            )
        )
    else:
        session.execute(
            _ACCOUNT_CONTROL.update()
            .where(_ACCOUNT_CONTROL.c.username == username)
            .values(is_enabled=bool(enabled))
        )


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


def _source_filter(table, source_user_id: UUID):
    # FavoriteCostume has no user_id. Ownership is encoded in Idol.idol_id,
    # whose project-wide format is <user_uuid>_<mst_idol_id>.
    if table.name == 'favorite_costume':
        return table.c.idol_id.like(f'{source_user_id}_%')
    owner = _owner_column(table)
    if owner is None:
        return None
    return owner == source_user_id


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
        source_filter = _source_filter(table, source_user_id)
        if source_filter is None:
            continue
        source_rows = session.execute(
            select(table).where(source_filter)
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
    _ensure_account_control_table(session)
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
    # A database reset may leave an old control row when an older console
    # process did not have account_control in its metadata. Re-enable the newly
    # created default account explicitly so stale state cannot survive reset.
    _store_account_enabled(session, DEFAULT_USERNAME, True)
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
        # New accounts are always enabled, including a username reused after
        # an earlier database reset left stale account_control metadata.
        _store_account_enabled(session, username, True)
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


def list_accounts(*, session: Session | None = None) -> list[dict]:
    """Return GUI-safe account summaries without exposing password material."""
    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        ensure_default_account(session)
        accounts = session.scalars(
            select(AccountCredential).order_by(AccountCredential.username)
        ).all()
        result = []
        for account in accounts:
            user = session.get(User, account.user_id)
            result.append({
                'username': account.username,
                'user_id': str(account.user_id),
                'search_id': '' if user is None else user.search_id,
                'display_name': '' if user is None else user.name,
                'is_enabled': _account_enabled(session, account.username),
                'is_default': account.user_id == DEFAULT_USER_ID,
            })
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


def set_account_enabled(
    username: str,
    enabled: bool,
    *,
    session: Session | None = None,
) -> dict:
    username = normalize_username(username)
    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        account = session.get(AccountCredential, username)
        if account is None:
            raise ValueError('account does not exist')
        _store_account_enabled(session, username, bool(enabled))
        if owns_session:
            session.commit()
        else:
            session.flush()
        return {
            'username': username,
            'user_id': str(account.user_id),
            'is_enabled': bool(enabled),
            'is_default': account.user_id == DEFAULT_USER_ID,
        }
    except Exception:
        if owns_session:
            session.rollback()
        raise
    finally:
        if owns_session:
            session.close()


def delete_account(
    username: str,
    *,
    session: Session | None = None,
) -> dict:
    """Permanently delete one non-default account and its independent save."""
    username = normalize_username(username)
    if username == DEFAULT_USERNAME:
        raise ValueError('default full-save account cannot be deleted')

    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        account = session.get(AccountCredential, username)
        if account is None:
            raise ValueError('account does not exist')
        if account.user_id == DEFAULT_USER_ID:
            raise ValueError('default full-save account cannot be deleted')
        user_id = account.user_id

        # Remove incoming friend references first. The generic ownership filter
        # below covers rows where this account is the owning user_id.
        friend_table = Base.metadata.tables.get('friend')
        if friend_table is not None and 'friend_id' in friend_table.c:
            session.execute(
                friend_table.delete().where(friend_table.c.friend_id == user_id)
            )

        # The credential itself references user.user_id, so delete it before
        # walking user-owned tables in reverse dependency order.
        session.execute(
            AccountCredential.__table__.delete()
            .where(AccountCredential.username == username)
        )
        _ensure_account_control_table(session)
        session.execute(
            _ACCOUNT_CONTROL.delete()
            .where(_ACCOUNT_CONTROL.c.username == username)
        )

        for table in reversed(Base.metadata.sorted_tables):
            if table.name in {'account_control', 'account_credential'}:
                continue
            owner_filter = _source_filter(table, user_id)
            if owner_filter is None:
                continue
            session.execute(table.delete().where(owner_filter))

        if session.get(User, user_id) is not None:
            raise RuntimeError('could not fully delete user save')
        if owns_session:
            session.commit()
        else:
            session.flush()
        return {
            'username': username,
            'user_id': str(user_id),
            'deleted': True,
        }
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
        if (account is None
                or not _account_enabled(session, username)
                or not _verify_password(account, password)):
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

    owns_session = session is None
    if owns_session:
        session = Session(engine)
    try:
        account = session.scalar(
            select(AccountCredential).where(AccountCredential.user_id == user_id)
        )
        if account is not None and not _account_enabled(session, account.username):
            return False

        # Preserve compatibility for already configured installations that
        # used the historical static full-save secret before multi-user
        # support, while still honoring GUI disable state.
        if user_id == DEFAULT_USER_ID and hmac.compare_digest(
            secret, LEGACY_DEFAULT_SECRET
        ):
            if account is None:
                return _account_enabled(session, DEFAULT_USERNAME)
            return True

        if account is None or not account.secret_hash:
            return False
        return hmac.compare_digest(account.secret_hash, _secret_digest(secret))
    finally:
        if owns_session:
            session.close()
