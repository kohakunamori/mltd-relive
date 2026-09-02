# mltd-relive Standalone v0.1.9

本 Release 是 **Standalone v0.1.9 登录兼容性 Hotfix**，同时重新构建 Windows / Ubuntu / macOS Standalone、APK Patcher，并继续附带既有修正版繁中/韩文游戏客户端。

## v0.1.9 Hotfix

### 恢复 v0.1.6 TLS 客户端兼容路径

- 回退 v0.1.8 新引入的“accept 明文 socket 后在线程内执行 TLS handshake”实现。
- 恢复已经由 v0.1.6 修正版客户端验证过的 listener-wrapped TLS accept 路径：443 监听 socket 在进入 `serve_forever()` 前直接由 `SSLContext.wrap_socket(..., server_side=True)` 包装。
- 此修复只调整 TLS 接入方式，不修改客户端请求、JSON-RPC 请求体、加密协议或 API 路径。
- 保留 v0.1.8 的连接 backlog 512、`TCP_NODELAY`、TCP keepalive、连接超时、direct WSGI API dispatch 等其余性能优化。

### 修复 DNS / API Host 不一致

- v0.1.8 已将 `theaterdays.appspot.com` 加入本地 DNS 映射，但 API handler 此前仍只接受：
  - `theaterdays-zh.appspot.com`
  - `theaterdays-ko.appspot.com`
  - `127.0.0.1`
- 这会导致被本地 DNS 接管的 `theaterdays.appspot.com` 请求进入本地 443 后收到 `503 Service Unavailable`。
- v0.1.9 将 `theaterdays.appspot.com` 纳入允许列表，使 DNS interception 与 API handler 保持一致。
- Host 校验同时由 substring matching 改为标准化后的严格 hostname matching，并兼容 `:443` 端口与大小写差异。

### 回归验证

新增自动化覆盖：

- TLS server 必须保持 v0.1.6 listener-wrapped compatibility model。
- 三个 Theater Days Appspot hostname 均必须被 API handler 接受。
- 伪造的后缀/前缀 hostname 不得因 substring matching 被误接受。

修复分支在合并前已通过：

- local asset / transport tests
- API runtime import 与 SQLite runtime 检查
- remote asset compatibility
- API transport benchmark
- Asset serving benchmark

## 保留的 v0.1.8 功能

v0.1.9 除上述兼容性修复外继续包含 v0.1.8 的功能和性能改造，包括：

- Asset serving index 与缓存热路径零 SQLite 查询。
- hybrid/local Asset mirror、prefetch 与 self-heal serving index。
- HTTP/1.1 keep-alive、backlog 512、TCP keepalive / `TCP_NODELAY`。
- 明文 Asset `sendfile()` 与 TLS 大缓冲传输路径。
- direct WSGI API dispatch。
- `UnitService.SetUnit` eager-load 优化与 JSON-RPC batch slow-log 诊断。
- yuyueryuyu Standalone 的偶像详情、Job、Present、Theater interaction、model/schema/master data/locale/service 更新。
- local Asset fast-start、48 workers 与 configurable scopes。

## 客户端兼容性

本次 Hotfix **不修改游戏客户端请求行为**。Release 中继续提供既有修正版客户端：

- `mltd-relive-game-client-zh-fixed.apk`
- `mltd-relive-game-client-ko-fixed.apk`

服务器侧恢复与修正版客户端兼容的 TLS 行为，并修复 Host routing。

## 下载哪个文件

| 文件 | 用途 |
|---|---|
| `mltd-relive-standalone-v0.1.9-windows.exe` | Windows GUI/服务器 |
| `mltd-relive-standalone-v0.1.9-ubuntu` | Ubuntu/Linux 服务器 |
| `mltd-relive-standalone-v0.1.9-macos.zip` | macOS 服务器 |
| `mltd-relive-game-client-zh-fixed.apk` | 繁中修正版客户端 |
| `mltd-relive-game-client-ko-fixed.apk` | 韩文修正版客户端 |
| `mltd-relive-apk-patcher-*-windows.exe` | Windows APK Patcher |

Windows + 繁中客户端通常使用 `mltd-relive-standalone-v0.1.9-windows.exe` 和 `mltd-relive-game-client-zh-fixed.apk`。
