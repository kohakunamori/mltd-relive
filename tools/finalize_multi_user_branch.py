from pathlib import Path


README_SECTION = """## 多用户账户与外部注册

Standalone `v0.1.11` 起支持多个彼此独立的玩家存档。客户端不需要修改登录 DTO：在标题画面的“密码继承 / 引继”界面输入 **8 位用户名 + 密码**，服务端会通过 `AuthService.TransferPassword` 验证凭据并返回该账户自己的 UUID / secret，随后 `AuthService.Login` 会继续验证该 secret。

### 默认全存档账户

首次初始化数据库时会保留原来的全解锁存档，并为它创建固定登录凭据：

```text
用户名：MLTD0000
密码：relive2026
```

它仍然绑定原来的 `ffffffff-ffff-ffff-ffff-ffffffffffff` 存档，游戏内 `search_id` 仍为 `00000000`；升级旧数据库不会重建或覆盖这份存档内容。

> [!IMPORTANT]
> 默认密码是公开的开箱即用凭据。如果服务器会被不受信任的设备访问，请不要把默认账户当作私密账户使用，并应限制服务器网络暴露范围。

### 注册新用户

新注册账户会从默认全存档模板复制出一份**独立**存档，并为 Card / Idol / Unit / SongUnit / Profile / FavoriteCostume 等用户状态重映射 UUID。后续任何状态修改都只写入该用户自己的记录。Friend、PendingSong、PendingJob、Present 等社交或瞬态记录不会从模板继承。

用户名必须是 8 位 ASCII 字母或数字（服务端统一转换为大写），密码长度为 8–64 个字符。密码只保存 salted PBKDF2-HMAC-SHA256 派生值，不保存明文。

本机管理员可直接使用 CLI：

```bash
cd standalone
python manage_users.py register USER0001 password123 --display-name Producer
```

也可以通过外部注册 API 创建账户：

```http
POST /relive/accounts/register
Content-Type: application/json
Authorization: Bearer <registration_api_key>

{
  "username": "USER0001",
  "password": "password123",
  "display_name": "Producer"
}
```

来自 `127.0.0.1` / `::1` 的注册请求可直接使用；非 loopback 请求必须在 `config.ini` 设置 `registration_api_key` 并携带对应 Bearer Token。不要把未设置 API key 的注册接口直接暴露到公网。

注册完成后，在原客户端的密码继承界面输入注册时的用户名和密码即可进入该用户的独立存档。

"""

HANDOFF_SECTION = """

## 15. Multi-user account architecture (2026-09-03)

A separate compatibility pass added real multi-user authentication while preserving the original client DTOs. Runtime implementation lives primarily in `standalone/mltd/accounts.py`, `standalone/mltd/services/auth.py`, `standalone/mltd/servers/handler.py`, and the additive `AccountCredential` model. Server/config schema version is now `0.1.11`.

Confirmed design:

- Client `AuthService.TransferPassword.user_id` is treated as the external 8-character account username. No client DTO change is required.
- `TransferPassword` validates the salted PBKDF2-HMAC-SHA256 password and returns the account's real UUID plus a login secret.
- `AuthService.Login` validates the UUID/secret pair instead of accepting arbitrary values.
- The original full-save user remains `ffffffff-ffff-ffff-ffff-ffffffffffff`, `search_id=00000000`, game name `MLTDrelive`.
- Default public compatibility credentials are `MLTD0000 / relive2026`. They are intentionally documented as convenience credentials, not private credentials.
- Existing databases migrate additively from v0.1.10 to v0.1.11: `account_credential` is created and the default credential is attached without rewriting the existing save.
- External users receive a unique UUID/search_id and an independent clone of the full-save baseline. UUID-prefixed IDs/references are remapped.
- Direct user-owned tables plus indirect Profile children and `FavoriteCostume -> Idol` state are cloned.
- Friend, PendingSong, PendingJob, PendingJobAnswer and Present state are intentionally not cloned.
- CLI registration is available through `standalone/manage_users.py register`.
- HTTP registration is `POST /relive/accounts/register`; loopback is allowed directly, while non-loopback calls require `config.ini` `registration_api_key` as a Bearer token.

Targeted multi-user acceptance already covers default credentials, bad-password rejection, external registration, independent full-save state, TransferPassword/Login secret authentication, duplicate-registration atomicity, two-user UUID separation, HTTP registration authorization, FK-regression comparison, and v0.1.10 -> v0.1.11 migration preservation.

The final branch acceptance workflow must be run from the cleanup HEAD before merge/release. A real-client password-transfer smoke is still the final device-dependent gate because this environment cannot operate the user's Android device directly.
"""


def update_readme() -> None:
    path = Path('README.md')
    text = path.read_text(encoding='utf-8')
    marker = '## 本地数据与备份\n'
    if '## 多用户账户与外部注册\n' not in text:
        if marker not in text:
            raise RuntimeError('README insertion marker not found')
        text = text.replace(marker, README_SECTION + marker, 1)

    old_cfg = '[default]\nlanguage = zh\nasset_mode = remote\nasset_remote_url =\n'
    new_cfg = old_cfg + 'registration_api_key =\n'
    if old_cfg in text and 'registration_api_key =\n' not in text:
        text = text.replace(old_cfg, new_cfg, 1)

    bullet = '- `asset_remote_url`：留空时使用默认 remote endpoint；设置时必须是正常 HTTPS URL。\n'
    registration_bullet = '- `registration_api_key`：非本机调用外部账户注册 API 时使用的 Bearer Token；留空则只允许 loopback 注册。\n'
    if bullet in text and registration_bullet not in text:
        text = text.replace(bullet, bullet + registration_bullet, 1)
    path.write_text(text, encoding='utf-8')


def update_handoff() -> None:
    path = Path('docs/SERVER_COMPAT_AGENT_HANDOFF.md')
    text = path.read_text(encoding='utf-8')
    if '## 15. Multi-user account architecture' not in text:
        path.write_text(text + HANDOFF_SECTION, encoding='utf-8')


def update_workflows() -> None:
    old = Path('.github/workflows/final-story-compat-acceptance.yml')
    new = Path('.github/workflows/final-standalone-acceptance.yml')
    wf = old.read_text(encoding='utf-8')
    wf = wf.replace('name: Final story compatibility acceptance', 'name: Final standalone acceptance', 1)
    wf = wf.replace('# Reusable acceptance gate; rerun after the vitality multi device regression fix.\n', '')
    wf = wf.replace('branches: [fix/story-service-compat]', 'branches: [feature/multi-user-accounts]', 1)
    wf = wf.replace("paths: ['.github/workflows/final-story-compat-acceptance.yml']", "paths: ['.github/workflows/final-standalone-acceptance.yml']", 1)
    wf = wf.replace('name: mltd-relive-story-compat-ubuntu-${{ github.sha }}', 'name: mltd-relive-final-ubuntu-${{ github.sha }}', 1)
    new.write_text(wf, encoding='utf-8')
    old.unlink()

    targeted = Path('.github/workflows/test-multi-user-accounts.yml')
    text = targeted.read_text(encoding='utf-8')
    old_branches = '    branches:\n      - feature/multi-user-accounts\n'
    new_branches = '    branches:\n      - main\n      - feature/multi-user-accounts\n'
    if old_branches in text:
        text = text.replace(old_branches, new_branches, 1)
    targeted.write_text(text, encoding='utf-8')


def main() -> None:
    update_readme()
    update_handoff()
    update_workflows()


if __name__ == '__main__':
    main()
