# mltd-relive Standalone v0.1.6

本 Release 同时包含 **Standalone v0.1.6 服务器、修正版游戏客户端和 APK Patcher v1.0.9**。

## v0.1.6 重点更新

- `local` 默认只准备 `zh-android`，不再自动下载 iOS / Korean 资源。
- 可在 `config.ini` 通过 `asset_local_scopes` 精确配置额外 scope，例如 `zh-android,ko-android` 或 `zh-android,zh-ios`。
- 默认 prefetch 并发提升到 **48 workers**；可通过 `asset_prefetch_workers` 自行调整。
- bulk prefetch 不再对每个对象执行 `fsync()`，仍保留 `.part`、Content-Length 校验、SHA-256 metadata、原子 rename；未完成/未登记对象会在下次启动重新获取。
- metadata 批量提交从 64 提升到 256，降低大量小文件预取时的 SQLite 提交频率。
- GUI 在 `Preparing Local Assets` 阶段即可使用 **Stop Server**，可立即中断正在进行的 local prefetch，并恢复到 Stopped 状态。
- GUI 的 Asset Preparation 面板显示实际 worker 数，便于确认 `config.ini` 配置是否生效。

## local 配置示例

```ini
[default]
asset_mode = local
asset_local_scopes = zh-android
asset_prefetch_workers = 48
```

如果需要额外资源：

```ini
asset_local_scopes = zh-android,ko-android,zh-ios
```

## 下载哪个文件

| 文件 | 用途 |
|---|---|
| `mltd-relive-standalone-v0.1.6-windows.exe` | Windows GUI/服务器 |
| `mltd-relive-standalone-v0.1.6-ubuntu` | Ubuntu/Linux 服务器 |
| `mltd-relive-standalone-v0.1.6-macos.zip` | macOS 服务器 |
| `mltd-relive-game-client-zh-fixed.apk` | 繁中修正版客户端 |
| `mltd-relive-game-client-ko-fixed.apk` | 韩文修正版客户端 |
| `mltd-relive-apk-patcher-v1.0.9-windows.exe` | Windows APK Patcher |

Windows + 繁中客户端使用 `mltd-relive-standalone-v0.1.6-windows.exe` 和 `mltd-relive-game-client-zh-fixed.apk` 即可。日常联网缓存仍推荐 `hybrid`；需要严格离线镜像时使用 `local`。
