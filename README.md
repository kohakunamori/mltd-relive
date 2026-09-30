# 偶像大師百萬人演唱會！劇場時光（重生版）

**THE iDOLM@STER Million (RE)Live!: Theater Days**

> 一个面向已停止运营的《偶像大师 百万人演唱会！剧场时光》繁体中文版 / 韩文版客户端的**非官方本地服务器、兼容层与数字保存项目**。

本项目通过本地 Standalone Server 重新实现客户端所需的一部分 API、DNS/TLS 接入、状态持久化与兼容逻辑，使原客户端能够在官方服务结束后继续进入部分游戏内容。

本仓库基于 [RainbowUnicorn7297/mltd-relive](https://github.com/RainbowUnicorn7297/mltd-relive) 继续维护。原有 Prototype 已移除，目前只维护 **Standalone Server** 及其配套工具。

> [!IMPORTANT]
> 本项目不是官方复服，也不是原服务器的完整镜像。当前实现仍属于兼容性重建工程：部分功能已经具备真实持久化语义，部分历史/在线功能因缺少原始服务器数据无法完整还原；也存在“服务器请求成功但客户端 UI / 流程仍异常”的已知情况。

## 项目能做什么

当前 Standalone 主要提供：

- 本地 MLTD API 服务；
- 本地 DNS 接管与 API TLS 接入；
- SQLite 本地存档；
- 繁体中文 / 韩文客户端支持；
- 登录、Home / Theater 基础流程；
- Story 完成、读取状态与重复请求幂等处理；
- Profile、系统设置、Producer Rank；
- Mission 进度与部分奖励逻辑；
- Unit / SongUnit / Costume 等编成相关状态；
- Vitality 道具 / Jewel 恢复；
- Friend 请求、接受、删除、推荐及部分花篮/评论页面兼容；
- Job 正常流程与中断恢复兼容；
- Birthday Present；
- Favorite Costume 持久化；
- Live 所需的现有基础服务；
- 远端 HTTPS Asset 地址下发；
- Asset 灾备缓存工具；
- Android 客户端分辨率 / FPS APK Patcher。

其中部分 RPC 为兼容客户端页面而提供“无数据”返回。例如当前 preserved database 中没有完整的 Sales Costume 商店目录或历史 Present ledger，因此对应页面只提供不伪造数据的空结果，而不是虚构商品、奖励或历史记录。

## 当前状态

### Public Release

当前最新公开 Release：

- **Standalone Server:** `v0.1.10`
- **APK Patcher:** `v1.0.9`
- **Asset Transport:** `remote HTTPS only`

下载：**[GitHub Releases](https://github.com/kohakunamori/mltd-relive/releases/latest)**

> [!NOTE]
> `main` 可能包含比最新 Release 更新的兼容修复。需要最新 `main` 行为时，请从源码构建；Release 更适合希望直接运行已发布二进制的用户。

### 当前 main 的兼容性进度

当前 `main` 已合并一轮较大的服务器兼容性重建，包括 Story、Mission、Profile、Vitality、Friend、Job、Birthday、Favorite Costume 等状态逻辑，并建立了 fresh SQLite runtime regression suite。

这不代表原版所有功能已经恢复。以下类型仍可能不完整：

- 活动 / Event；
- Gasha / Shop / Payment；
- Lounge 等大型在线社交系统；
- 已停止服务后无法获得的服务器侧历史数据；
- 依赖缺失 Master / catalog / ledger 的功能；
- 部分客户端 UI、动画或状态机兼容问题；
- 仅存在于旧客户端字符串表、但没有实际业务 callsite 的 legacy RPC。

项目原则是：**宁可明确返回“没有可用数据”，也不伪造不存在的持久化状态、奖励或消费结果。**

## 工作原理

运行时数据路径大致如下：

```text
Android client
  │
  ├─ MLTD API hostname
  │    └─ local DNS -> Standalone Server
  │                      └─ local HTTPS / JSON-RPC API
  │                            └─ SQLite: mltd-relive.db
  │
  └─ Asset download
       └─ remote HTTPS Asset storage
```

当前 Asset runtime 为 **remote-only**：Standalone Server 不代理、不缓存、也不直接托管游戏 Asset。

默认 Asset 根地址：

```text
https://assets.rainbowunicorn7297.com/
```

可以通过 `config.ini` 中的 `asset_remote_url` 改为其它正常 HTTPS 静态存储 / 对象存储地址。

## 快速开始

### 你需要准备

一般需要：

1. 一台运行 Standalone Server 的 Windows / Linux / macOS 电脑；
2. 一台可安装对应客户端的 Android 设备；
3. 电脑和 Android 设备处于可以互相访问的网络中；
4. 对应语言的修正版客户端；
5. Standalone Server 能够监听本地 DNS / HTTPS 所需端口。

推荐直接使用 Release 中提供的修正版客户端：

- `mltd-relive-game-client-zh-fixed.apk`：繁体中文版；
- `mltd-relive-game-client-ko-fixed.apk`：韩文版。

### Windows

1. 从 [Releases](https://github.com/kohakunamori/mltd-relive/releases/latest) 下载 Windows Standalone Server；
2. 启动服务器；
3. 在 GUI 中选择客户端语言；
4. 等待服务器显示已启动；
5. 记录 GUI 中显示的电脑 LAN IPv4；
6. 将 Android 当前 Wi-Fi 的 DNS 指向该 IPv4；
7. 安装对应的 `*-fixed.apk`；
8. 启动游戏。

如果服务器无法绑定 DNS / HTTPS 端口，可尝试以管理员权限运行。Windows 防火墙询问时，需要允许服务器在当前局域网通信。

### Ubuntu / Linux

Release 二进制示例：

```bash
chmod +x mltd-relive-standalone-*-ubuntu
sudo ./mltd-relive-standalone-*-ubuntu
```

DNS / TLS 通常需要监听 53 / 443 等特权端口，因此 Linux 上通常需要 root 或对应 capability。

### macOS

下载 Release 中的 macOS Standalone 压缩包并解压，启动其中的应用。系统首次运行第三方下载程序时可能要求确认权限。

随后同样将 Android Wi-Fi DNS 指向运行服务器的 Mac LAN IPv4。

### Android 网络注意事项

客户端必须能够真正使用你指定的本地 DNS。如果设备同时启用了会绕过局域网 DNS 的 Private DNS、VPN、代理软件或其它网络接管功能，可能导致请求仍然前往原地址或无法命中 Standalone Server。

排障时建议先使用最简单的同一局域网环境。

## 完整存档用户与一般用户

Standalone `v0.1.11` 起支持多个彼此独立的玩家账户。客户端不需要新增自定义登录页面：账户选择继续使用原客户端标题画面的“密码继承 / 引继”流程。服务端把该界面的 8 位 `user_id` 输入解释为 Standalone 用户名，通过 `AuthService.TransferPassword` 验证用户名和密码，再向客户端返回该账户实际的 UUID / secret；之后客户端使用保存的 UUID / secret 调用 `AuthService.Login`。

当前有两类使用方式：

| 类型 | 用途 | 是否需要先注册 | 初始存档 | UUID / search_id |
| --- | --- | --- | --- | --- |
| **完整存档用户** | 直接使用项目保留的原有全解锁 / 完整存档 | 否 | 数据库中原来的 preserved full-save | 固定 UUID `ffffffff-ffff-ffff-ffff-ffffffffffff`，`search_id=00000000` |
| **一般用户** | 给不同玩家建立彼此独立的账户 | 是 | 注册时从完整存档用户的持久化状态复制一份 | 每个账户独立生成 UUID 和 8 位 `search_id` |

> [!IMPORTANT]
> 当前“一般用户”**不是从教程开始的空白新号**。新账户会复制注册当时的完整存档模板，再成为独立存档。如果需要真正的 Lv.1 / 未完成教程新号，目前还没有对应初始化模板。

### 使用完整存档用户

完整存档用户就是项目一直以来使用的默认 preserved save。首次初始化新数据库时会自动创建它；从旧版 Standalone 升级到 `v0.1.11` 时，也只会为已有完整存档增加账户凭据绑定，不会重新创建或覆盖该用户的游戏数据。

默认登录凭据：

```text
用户名：MLTD0000
密码：relive2026
```

在一个尚未绑定 Standalone 账户的客户端上使用它：

1. 正常启动 Standalone Server；
2. 如果你是从旧版服务器升级并希望保留旧存档，把原来的 `mltd-relive.db` 放在新版服务器运行目录中；
3. **不要点击 `Reset Data`，也不要使用 `--reset`**；
4. 启动游戏，在标题画面进入“密码继承 / 引继”；
5. 用户名 / User ID 输入 `MLTD0000`；
6. 密码输入 `relive2026`；
7. 继承成功后，服务端会把固定完整存档 UUID 和登录 secret 返回给客户端；
8. 之后客户端即可按正常标题登录流程进入这份完整存档。

如果旧客户端本地已经保存了这个默认完整存档的 UUID / historical secret，`v0.1.11` 仍保留兼容验证，因此通常可以继续直接登录，不要求先清除客户端数据重新继承。

完整存档用户的游戏内修改会正常持久化到 `mltd-relive.db`。它同时也是**以后注册一般用户时的复制源**：一般用户复制的是“注册发生那一刻”完整存档用户的持久化状态，而不是一个永远不变的内置快照。因此：

- 已经创建的一般用户不会因为完整存档用户后来发生变化而同步改变；
- 完整存档用户后来获得的新状态，只会影响之后新注册账户的初始复制结果；
- 如果希望多名玩家从完全相同的基线开始，建议先备份数据库并在修改完整存档用户之前批量创建这些账户。

> [!WARNING]
> `MLTD0000 / relive2026` 是公开的默认凭据，不应视为私密账户密码。不要把 Standalone API / DNS / TLS 服务直接暴露给不受信任的公网客户端。

### 使用一般用户

一般用户必须先由服务器管理员创建。每次注册都会生成新的 UUID 和 `search_id`，并把完整存档用户当前的持久化状态复制为该账户自己的独立数据。

会复制并重新绑定到新 UUID 的内容包括 Card、Idol、Costume、Unit、SongUnit、Profile、FavoriteCostume 等用户持久化状态。Friend、PendingSong、PendingJob、PendingJobAnswer、Present 等社交、进行中流程或瞬态记录不会从完整存档模板继承。

注册后，不同一般用户之间、一般用户与完整存档用户之间的后续修改互不覆盖。

用户名规则：

- 必须正好 **8 位 ASCII 字母或数字**；
- 服务端统一转换为大写；
- 例如 `USER0001`。

密码规则：

- 长度 **8–64 个字符**；
- 数据库只保存 salted PBKDF2-HMAC-SHA256 派生值，不保存密码明文。

游戏内显示名 `display_name` 为 1–10 个字符；省略时默认使用用户名。

#### 方法一：服务器本机 CLI 注册

从源码运行时，在仓库中执行：

```bash
cd standalone
python manage_users.py register USER0001 password123 --display-name Producer
```

成功后会输出该账户的用户名、UUID、`search_id` 和显示名。

然后让该玩家在客户端上：

1. 连接到这台 Standalone Server；
2. 启动游戏并进入标题画面的“密码继承 / 引继”；
3. 用户名 / User ID 输入注册时的 8 位用户名，例如 `USER0001`；
4. 密码输入注册时设置的密码，例如 `password123`；
5. 继承成功后，客户端会取得该账户自己的 UUID / secret；
6. 后续登录和所有受支持的持久化操作都会落到该用户自己的数据库记录。

#### 方法二：注册 API

也可以通过服务器的注册 API 创建一般用户：

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

来自 `127.0.0.1` / `::1` 的注册请求可直接使用；非 loopback 请求必须先在 `config.ini` 中设置 `registration_api_key`，并携带对应 Bearer Token。

不要把没有认证保护的注册入口暴露到公网。建议只允许受信任的 LAN / VPN 管理端访问注册接口。

### 旧数据库升级与用户数据安全

服务器使用的数据库文件仍然是：

```text
mltd-relive.db
```

正常 **Start Server** 时，如果该文件已经存在，服务器会运行兼容 migration，而不是重新执行完整初始化。`v0.1.11` 升级会创建 `account_credential` 表并把已有完整存档用户绑定到 `MLTD0000`；更老数据库还可能执行历史 schema migration。

因此“保留旧用户存档”和“数据库文件完全不发生变化”是两件事：升级会原地修改 schema / 兼容数据，但不会主动把已有完整存档用户重置为初始状态。

升级前建议至少备份：

```text
mltd-relive.db
config.ini
```

真正会清空玩家数据的是 GUI 的 **Reset Data** 或命令行 `--reset`：确认后会删除数据库中的现有表并重新初始化。已有长期存档时不要使用它。

## 本地数据与备份

首次运行后，服务器会在运行目录生成或使用本地配置、数据库和日志。

最重要的存档文件是：

```text
mltd-relive.db
```

这是 SQLite 数据库，保存当前 Standalone 的玩家状态。

如果已经长期游玩，升级程序前建议先备份：

```text
mltd-relive.db
config.ini
```

数据库 schema 的兼容升级由项目代码处理，但备份仍然是最安全的做法。

## 配置

典型 `config.ini`：

```ini
[default]
language = zh
asset_mode = remote
asset_remote_url =
registration_api_key =
```

其中：

- `language`：客户端语言；
- `asset_mode`：当前只支持 `remote`；
- `asset_remote_url`：留空时使用默认 remote endpoint；设置时必须是正常 HTTPS URL。
- `registration_api_key`：非本机调用外部账户注册 API 时使用的 Bearer Token；留空则只允许 loopback 注册。

`asset_remote_url` 只决定**游戏客户端从哪里下载 Asset**，不会让 Standalone Server 变成 Asset Proxy。

## Asset 保存 / 灾备

Standalone runtime 不保存 Asset，但仓库提供独立工具：

```text
tools/cache_assets.py
```

它的用途是数字保存和灾备：在当前远端仍可访问时，把 manifest 所需资源完整保存到本地磁盘或 NAS。

同步繁中 Android Asset：

```bash
python tools/cache_assets.py sync \
  --scope zh-android \
  --root /path/to/durable/mltd-assets \
  --workers 48
```

通过本地代理访问上游：

```bash
python tools/cache_assets.py sync \
  --root /path/to/durable/mltd-assets \
  --proxy http://127.0.0.1:7890
```

离线完整性检查：

```bash
python tools/cache_assets.py verify \
  --scope zh-android \
  --root /path/to/durable/mltd-assets
```

缓存工具支持断点续传、SHA-256、ETag、manifest snapshot 和已有对象复用。

完整说明见 [`ASSET_CACHE.md`](ASSET_CACHE.md)。

> [!IMPORTANT]
> 本地 cache **不会被当前 Standalone 自动提供给游戏客户端**。如果原 remote endpoint 失效，需要把保存的 Asset 部署到正常 HTTPS 静态存储 / 对象存储，再把 `asset_remote_url` 指向新的 endpoint。

## APK Patcher

`tools/apk-patcher/` 中的 APK Patcher 只用于修改客户端的：

- 分辨率；
- FPS / 帧率相关设置。

它不是运行本地服务器的必要组件。

如果不需要修改画面参数，直接使用 Release 中的 `*-fixed.apk` 即可。

当前 Patcher `v1.0.9` 在 Windows 环境需要：

- Apktool `2.12.1`；
- Android Build Tools `29.0.3`；
- Java。

Patcher 输入建议使用项目 Release 中对应的修正版 APK。

## 从源码运行 / 构建

推荐 Python **3.11**。

```bash
git clone https://github.com/kohakunamori/mltd-relive.git
cd mltd-relive
python -m venv env
```

### Windows

```powershell
.\env\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
cd standalone
python gui.pyw
```

构建单文件 GUI：

```powershell
..\env\Scripts\pyinstaller gui_windows.spec
```

### Ubuntu / Linux

```bash
source env/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
cd standalone
sudo ../env/bin/python gui.pyw
```

构建：

```bash
../env/bin/pyinstaller gui_ubuntu.spec
```

### macOS

```bash
source env/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
cd standalone
python gui.pyw
```

构建：

```bash
../env/bin/pyinstaller gui_macos.spec
```

PyInstaller 产物位于 `standalone/build/` / `standalone/dist/`。

## 开发与测试

核心服务位于：

```text
standalone/mltd/services/
```

数据库模型位于：

```text
standalone/mltd/models/
```

测试位于：

```text
tests/
```

项目目前特别重视“真实状态语义”而不只是返回一个不会报错的 JSON：

- Stateful RPC 应有 SQLite / SQLAlchemy runtime test；
- 应验证正常路径、持久化、重复请求、非法请求和事务原子性；
- 客户端 DTO / RPC 应优先以 preserved client / reverse evidence 为准；
- 不因为 dump 中存在一个字符串常量就自动实现对应服务。

如果你遇到问题，最有价值的信息通常是：

- 客户端具体操作步骤；
- 客户端错误画面；
- Standalone 服务器 traceback / 最后几十行日志；
- 使用的客户端语言和版本；
- 使用的 Standalone commit / Release 版本。

## 仓库结构

```text
standalone/                 Standalone API / DNS / TLS 服务器
standalone/mltd/services/   JSON-RPC / 游戏服务实现
standalone/mltd/models/     SQLite / SQLAlchemy 数据模型
standalone/*.spec           PyInstaller 构建定义
tools/cache_assets.py       Asset 灾备缓存 / 完整性验证
tools/apk-patcher/          分辨率 / FPS APK Patcher
tests/                      兼容性与 runtime regression tests
.github/workflows/          CI / Release / compatibility audit
ASSET_CACHE.md              Asset 保存工具详细文档
RELEASE_NOTES.md            当前公开 Release 说明
LICENSE                     软件、依赖和第三方内容许可声明
```

## 鸣谢

本项目能够继续维护，建立在许多既有工作的基础上。

特别感谢：

- **[RainbowUnicorn7297/mltd-relive](https://github.com/RainbowUnicorn7297/mltd-relive)**：本仓库的直接上游项目，提供了最初的本地服务器、客户端兼容工作、大量数据整理以及项目基础；
- 原项目及本 fork 的所有贡献者、测试者和逆向分析参与者；
- Python、SQLAlchemy、PyInstaller、Marshmallow、PyCryptodome 等开源项目及其维护者；
- 对游戏资料进行保存、验证和整理的社区成员；
- 《THE IDOLM@STER MILLION LIVE! THEATER DAYS》的原开发、运营和内容制作团队，为作品本身留下了值得保存的内容。

第三方组件的完整版权与许可信息以仓库 [`LICENSE`](LICENSE) 为准。

## 法律、版权与商标声明

### 非官方项目

本项目是由社区维护的**非官方、非商业关联的兼容性 / 数字保存项目**。

本项目及其维护者与 **BANDAI NAMCO Entertainment Inc.**、THE IDOLM@STER 官方运营方及其它相关权利人之间不存在授权、赞助、认可、代理或其它官方关系，除非权利人另有明确书面声明。

### 游戏内容与商标

`THE IDOLM@STER MILLION LIVE! THEATER DAYS` 及相关游戏内容的权利归相应权利人所有。

仓库现有 [`LICENSE`](LICENSE) 明确记载：

```text
THE IDOLM@STER MILLION LIVE! THEATER DAYS
Copyright (c) 2017-2022 BANDAI NAMCO Entertainment Inc. All rights reserved.
```

游戏名称、角色、图像、音频、剧情、Logo、商标、原始客户端程序及其它第三方素材的权利**不会因为出现在本仓库、Release、补丁或兼容环境中而转移给本项目**。

本项目不授予任何超出原权利人许可范围的游戏内容使用权、商标权或再分发权。

### 本项目源代码

按照仓库现有 [`LICENSE`](LICENSE)：

- 除 BANDAI NAMCO Entertainment Inc. 所拥有内容以及其它第三方组件外，本项目源代码和对应可执行程序采用 **MIT License**；
- 上游 `mltd-relive` 的版权声明为 `Copyright © 2022-2024 RainbowUnicorn7297`；
- 本 fork 后续贡献的著作权由各贡献者依其实际贡献和提交历史保留，并在适用许可下提供；
- Python、PyInstaller 及其它依赖分别适用其自身许可证；完整 notice 见 [`LICENSE`](LICENSE)。

如果你复制、修改或再分发本项目，请同时保留适用的版权、许可和第三方 notice。

### 修正版客户端与第三方数据

修正版 APK、游戏 Asset、Master 数据或其它来源于原游戏的内容可能包含第三方受版权保护材料。

仓库的软件许可证**不等于**对这些第三方材料授予许可。下载、使用、备份、修改或再分发相关内容时，请自行确认其行为符合所在地法律、原软件许可协议及相关权利人的要求。

### 无担保

本项目按现状（**AS IS**）提供，不承诺：

- 所有客户端功能都可以工作；
- 数据绝不会损坏；
- 与未来 Android / OS / 网络环境持续兼容；
- 第三方 Asset endpoint 永久可用；
- 项目适合任何特定用途。

在法律允许的最大范围内，项目作者和贡献者不对因使用、修改、运行或分发本项目造成的数据损失、设备问题、网络问题或其它直接/间接损失承担保证责任。具体条款以 [`LICENSE`](LICENSE) 为准。

### 权利人联系

如果你是相关内容的权利人，并认为本仓库中的具体内容需要移除、修改归属说明或补充授权信息，请通过本 GitHub 仓库的公开联系渠道与维护者联系，并尽量指出具体文件 / Release Asset / 内容位置，便于核查和处理。

---

**本项目的目标是保存和研究已经停止运营客户端的软件行为，并尽可能以可验证、可持久化、不过度伪造服务器语义的方式恢复其本地可运行性。**