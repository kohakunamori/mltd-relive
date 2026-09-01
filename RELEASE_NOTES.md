# mltd-relive Standalone v0.1.7

本 Release 同时包含 **Standalone v0.1.7 服务器、修正版游戏客户端和 APK Patcher v1.0.9**。

## v0.1.7 重点更新

- 修复 `local` cache 已完整后每次启动仍长时间停留在 `Preparing Local Assets` 的问题。
- 每个完整 strict-local scope 现在会生成可自动失效的 **ready stamp**。
- 后续启动只进行常数级状态检查：scope 目录时间戳、manifest 时间戳/大小和 ready stamp；命中后直接跳过 SQLite 初始化、manifest 解析和全目录完整性扫描。
- cache 中发生新增、删除、重命名或 manifest 替换/修改时，ready stamp 会自动失效，下一次启动回退到完整扫描并重新建立 stamp。
- `verify_existing` 会强制绕过 fast-start，仍可执行完整 SHA-256 验证。
- fast-start 回归测试明确要求命中 ready stamp 时不得实例化 `AssetStore`，从而保证不会暗中执行 SQLite/cache scan。
- 保留 v0.1.6 的激进 prefetch：默认 `zh-android`、48 workers、可通过 `config.ini` 配置并发和额外 scope、bulk metadata commit、可在 Preparing 阶段 Stop Server。

首次使用 v0.1.7 且已有旧版完整 cache 时，需要进行一次正常完整性扫描以建立 ready stamp；之后未改动 cache 的启动将直接走 fast-start。

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
| `mltd-relive-standalone-v0.1.7-windows.exe` | Windows GUI/服务器 |
| `mltd-relive-standalone-v0.1.7-ubuntu` | Ubuntu/Linux 服务器 |
| `mltd-relive-standalone-v0.1.7-macos.zip` | macOS 服务器 |
| `mltd-relive-game-client-zh-fixed.apk` | 繁中修正版客户端 |
| `mltd-relive-game-client-ko-fixed.apk` | 韩文修正版客户端 |
| `mltd-relive-apk-patcher-v1.0.9-windows.exe` | Windows APK Patcher |

Windows + 繁中客户端使用 `mltd-relive-standalone-v0.1.7-windows.exe` 和 `mltd-relive-game-client-zh-fixed.apk` 即可。
