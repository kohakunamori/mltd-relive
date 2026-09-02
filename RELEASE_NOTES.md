# mltd-relive Standalone v0.1.10

本版本修复 v0.1.9 的 Asset 登录回归与 `UnitService.SetUnit` 演唱会入口异常，并将 Asset 架构收敛为更简单、兼容性更高的 **remote-only HTTPS** 模式。

> 当前文件为 `fix/live-asset-compat` 分支的发布候选说明；最终 Release 仍以合并后的构建与设备 smoke test 为准。

## Asset：移除 hybrid/local 运行模式

v0.1.9 的本地 self-signed HTTPS Asset 路径已被设备测试确认不兼容：

```text
hybrid -> 登录 ErrorCode [-404 / 0]
remote -> 登录正常
```

v0.1.10 曾进一步测试独立 cleartext HTTP Asset 路径，设备返回：

```text
資料下載失敗
ErrorCode -21990
```

因此 Standalone runtime 不再运行 Asset Server，也不再支持 `hybrid/local`。

最终运行模型：

```text
client -> remote HTTPS Asset storage
```

默认：

```text
https://assets.rainbowunicorn7297.com/
```

可通过：

```ini
asset_remote_url = https://assets.example.com
```

切换到其它受信任 HTTPS 对象存储。

DNS interception 只负责 MLTD API hostname，不再接管 Asset hostname。

## Asset 灾备：新增独立 cache tool

为了防止当前 remote/R2 将来失联，新增：

```text
tools/cache_assets.py
```

同步完整繁中 Android Asset：

```bash
python tools/cache_assets.py sync \
  --scope zh-android \
  --root /path/to/durable/mltd-assets \
  --workers 48
```

功能包括：

- 当前 manifest 驱动的全量缓存；
- 48 workers 默认并发；
- `.part` + HTTP Range 断点续传；
- size / SHA256 / ETag / Last-Modified 等元数据；
- 已完成对象复用；
- 可选 `--verify-existing`；
- 可选 `--proxy`；
- 可直接保存到 NAS 挂载目录；
- `cache-snapshot.json` 保存每次同步快照信息。

即使原始 remote/R2 已完全不可访问，也可以纯本地验证：

```bash
python tools/cache_assets.py verify \
  --scope zh-android \
  --root /path/to/durable/mltd-assets
```

详细说明见 `ASSET_CACHE.md`。

## 修复 Live：SQLAlchemy 2.x SetUnit

设备日志定位到：

```text
UnitService.SetUnit
TypeError: 'ChunkedIteratorResult' object is not subscriptable
```

优化后的 SetUnit 将 SQLAlchemy 2.x Result 直接传给 `dict()`，触发 mapping/subscript 接口冲突。

修复为：

```python
card_rows = session.execute(...).all()
card_to_idol = dict(card_rows)
```

修复后设备已确认完整 Live 流程可以正常进入、完成并返回。

## API compatibility

保留：

- v0.1.6 已验证的 listener-wrapped TLS accept path；
- direct WSGI API dispatch；
- TCP_NODELAY / keepalive / backlog 优化；
- 当前测试分支中的 API `Connection: close` 与串行 dispatch 兼容措施。

后两项并不是本次 Live 故障根因，将在最终发布前或后续版本独立 A/B，以决定是否恢复更高 API 并发。

## 配置迁移

v0.1.10 会把旧 `hybrid/local` 自动迁移为：

```ini
asset_mode = remote
```

并从 server runtime config 删除以下旧字段：

```text
asset_cache_root
asset_prefetch_workers
asset_upstream_proxy
asset_local_scopes
asset_public_url
asset_tls_cert
asset_tls_key
```

这些缓存相关参数改由 `tools/cache_assets.py` 自己的 CLI 管理。

## 客户端

继续使用现有修正版：

- `mltd-relive-game-client-zh-fixed.apk`
- `mltd-relive-game-client-ko-fixed.apk`

无需为了 v0.1.10 的 remote-only Asset 架构重新修改 APK。
