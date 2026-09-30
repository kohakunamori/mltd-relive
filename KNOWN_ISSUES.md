# 当前兼容性结论与排查记录

> 最后更新：2026-09-02
>
> 本文保留已经完成的关键 A/B 结果，避免后续维护重新走回已经证伪的方向。

## 当前测试基线

- Server：`kohakunamori/mltd-relive` `fix/live-asset-compat` / Standalone v0.1.10。
- Client：`mltd-relive-game-client-zh-fixed.apk`。
- Client API 基址：`https://theaterdays-zh.appspot.com/`。
- Asset 默认基址：`https://assets.rainbowunicorn7297.com/`。

## Issue 1：Hybrid 登录 `ErrorCode [-404 / 0]`

### 已确认现象

相同 Server、APK、数据库和 TheaterService：

```text
asset_mode = hybrid -> 登录失败 [-404 / 0]
asset_mode = remote -> 登录正常
```

因此根因被隔离在 Asset transport，而不是 Auth/Login、数据库迁移或 Theater API 本身。

v0.1.9 hybrid 返回本地 API hostname 下的 self-signed HTTPS Asset URL。修正版客户端接受这张证书用于 API RPC，但 Asset/Web 下载栈无法可靠接受该拓扑。

### cleartext HTTP 复测

v0.1.10 曾测试独立 cleartext Asset URL：

```text
http://theaterdays-zh.appspot.com:7651/zh-android/
```

设备结果：

```text
資料下載失敗
ErrorCode -21990
```

该方案同样淘汰。

### 最终处理

`hybrid/local` 已从 Standalone runtime 移除。

当前只保留：

```ini
asset_mode = remote
asset_remote_url =
```

空 `asset_remote_url` 使用原 Rainbow remote HTTPS endpoint；也可以配置另一个正常受信任的 HTTPS 对象存储。

Standalone 不再运行 Asset Server、Relay 或 fetch-on-miss cache。

为了防止当前 remote/R2 将来失联，使用独立：

```text
tools/cache_assets.py
```

进行 manifest 驱动的全量灾备缓存和纯本地 SHA256 校验。详见 `ASSET_CACHE.md`。

## Issue 2：Remote 可登录但 Live 进入失败

### 已定位根因

设备日志直接给出：

```text
UnitService.SetUnit
TypeError: 'ChunkedIteratorResult' object is not subscriptable
```

优化后的代码曾将 SQLAlchemy 2.x `Session.execute()` 返回的 Result 直接传给 `dict()`：

```python
card_to_idol = dict(session.execute(...))
```

Result 对象暴露 `keys()`，`dict()` 会将其误判为 mapping 并尝试执行下标访问，最终触发：

```text
'ChunkedIteratorResult' object is not subscriptable
```

修复为先物化 rows：

```python
card_rows = session.execute(...).all()
card_to_idol = dict(card_rows)
```

修复 commit：

```text
351161e8df288fce8ab478953c34701010106ca0
```

### 设备验证

修复后保持 remote Asset transport：

```text
登录 -> Unit -> Guest -> StartSong -> Live -> FinishSong -> 返回
```

已确认正常。

因此本次实际 Live 故障根因不是 `live.py`、Asset、TLS handshake 或 API keep-alive，而是 `UnitService.SetUnit` 的 SQLAlchemy 2.x Result 转换 bug。

## API transport 兼容措施

当前分支仍暂时保留：

- listener-wrapped TLS；
- API `Connection: close`；
- API POST 全局串行 dispatch；
- direct WSGI。

其中 listener-wrapped TLS 是已知 corrected-client 兼容路径。

`Connection: close` 与全局串行化并不是已确认的 Live 根因，后续可独立 A/B 测试是否能够安全移除，以恢复更高 API 并发。

## Remote Asset 完整性证据

排查期间观察到繁中 Android manifest 约 4.27 MB、33,676 条记录。

对于 Theater 资源：

- 53 个 Theater resource ID 中 52 个可直接映射到 manifest；
- 已识别的 104 个 Theater Asset 对象上游 HEAD 均返回 200。

因此没有证据表明当前 remote/R2 缺失导致 Theater/Login 失败。

## 当前状态

已确认：

- remote 登录：正常；
- Theater 当前测试流程：正常；
- Live：修复 SetUnit 后正常；
- self-signed local HTTPS Asset：不兼容；
- Desktop cleartext HTTP Asset：不兼容；
- runtime Asset 架构：remote-only；
- 远端资源灾备：独立 cache tool。

当前剩余工作是 CI、最终 smoke test，以及评估是否可移除 API 串行化/Connection-close 兼容措施。
