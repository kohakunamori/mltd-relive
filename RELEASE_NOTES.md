# mltd-relive Standalone v0.1.8

本 Release 同时包含 **Standalone v0.1.8 服务器、修正版游戏客户端和 APK Patcher**。

## v0.1.8 重点更新

### Asset Server 高性能传输

- 为已缓存 Asset 建立内存 serving index；正常 `GET` / `HEAD` 热路径不再逐请求查询 SQLite，也不再重复执行文件 `stat`。
- hybrid 或外部 prefetch 在运行时新增的 Asset 会自动自愈进入 serving index；之后的请求继续走零 SQLite 热路径。
- HTTP/1.1 keep-alive 保持开启，连接 backlog 提升到 512，并启用 `TCP_NODELAY`、TCP keepalive 和连接超时控制。
- 桌面 443 TLS listener 改为 **accept 后在线程内执行 TLS handshake**，避免新连接突发时在 accept 路径串行握手，提高并发连接建立能力。
- 明文 Asset listener 可使用内核 `sendfile()` 零拷贝传输；TLS 路径使用 1 MiB `readinto(memoryview)` 缓冲，减少 Python 临时对象和复制开销。
- Range、HEAD、ETag / If-None-Match、Last-Modified / If-Modified-Since 等行为继续保留。
- 新增 Asset 热路径并发回归测试：重复命中明确要求不得再次调用 SQLite metadata 查询，并覆盖 96 个并发 GET / Range 请求。

GitHub Actions 合成基准（Ubuntu runner，64 KiB Asset，32 个 HTTP/1.1 持久客户端）：

- **1600 requests / 100 MiB / 1.074 s**
- **1489.4 req/s**
- **93.1 MiB/s**

该数字用于比较服务器实现的相对吞吐；实际游戏速度仍取决于客户端、TLS、磁盘和本机网络环境。

### API Server 性能与诊断

- 保留 direct WSGI API dispatch，不再经过 localhost HTTP hop。
- 合成 API transport benchmark：direct WSGI 约 **4557 req/s，median 0.217 ms，p95 0.244 ms**。
- 优化 `UnitService.SetUnit` ORM 读取，显式 eager-load 目标 Unit / UnitIdol，减少 relationship lazy-load。
- Slow API 日志现在可以识别 JSON-RPC batch，并显示 batch 内的方法预览，不再只显示 `?`。

### 合并 yuyueryuyu Standalone 新功能

已合并 `yuyueryuyu/mltd-relive` 的新 Standalone 功能（PR #4），同时保留本 fork 的 Asset/API/GUI/配置性能改造，包括：

- 偶像详情相关功能。
- 工作（Job）相关补全。
- 礼物领取相关功能。
- 剧场中与偶像互动相关功能。
- 对应 model、schema、master data、繁中 locale 及相关 service 更新。
- DNS 补充 `theaterdays.appspot.com` 本地解析支持。

上游调试残留及会破坏本 fork 配置语义的 server 改动没有机械覆盖；`config.py`、高性能 `handler.py`、logging、encryption 和 Asset/TLS server 保留本 fork 实现。

### Local Asset 延续优化

继续包含 v0.1.7 / v0.1.6 的 local 优化：

- 默认只准备 `zh-android`，额外 scope 可通过 `asset_local_scopes` 单独配置。
- 默认 48 workers，`asset_prefetch_workers` 可在 `config.ini` 修改。
- bulk metadata transaction、批量 cache snapshot、减少重复 manifest 解析。
- Preparing Local Assets 阶段支持 Stop Server 中断。
- strict-local 完成后使用可自动失效的 ready stamp；未改变 cache 时后续启动直接走常数级 fast-start。

## local 配置示例

```ini
[default]
asset_mode = local
asset_local_scopes = zh-android
asset_prefetch_workers = 48
```

## 下载哪个文件

| 文件 | 用途 |
|---|---|
| `mltd-relive-standalone-v0.1.8-windows.exe` | Windows GUI/服务器 |
| `mltd-relive-standalone-v0.1.8-ubuntu` | Ubuntu/Linux 服务器 |
| `mltd-relive-standalone-v0.1.8-macos.zip` | macOS 服务器 |
| `mltd-relive-game-client-zh-fixed.apk` | 繁中修正版客户端 |
| `mltd-relive-game-client-ko-fixed.apk` | 韩文修正版客户端 |
| `mltd-relive-apk-patcher-*-windows.exe` | Windows APK Patcher |

Windows + 繁中客户端通常使用 `mltd-relive-standalone-v0.1.8-windows.exe` 和 `mltd-relive-game-client-zh-fixed.apk`。
