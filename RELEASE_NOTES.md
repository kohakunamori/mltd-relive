# mltd-relive Standalone v0.1.5

本 Release 同时包含 **Standalone v0.1.5 服务器、修正版游戏客户端和 APK Patcher v1.0.9**。

## v0.1.5 重点更新

- GUI 新增实时 **Server Log** 窗口，可直接查看 Asset / Proxy / DNS / API 子进程日志。
- `local` 模式新增原生 **Asset Preparation** 进度区，显示平台、缓存命中、下载数量、失败数量、百分比和近似吞吐。
- strict-local prefetch 进行激进性能优化：默认并发从 8 提升到 **24 workers**。
- 缓存完整性扫描从“每个对象单独 SQLite 查询”改为 **单次 SQLite snapshot + 单次目录扫描**。
- 下载 metadata 从“每个文件一个 SQLite 事务”改为 **64 条批量提交**。
- prefetch 过程中不再重复执行已完成对象检查，也不再重复读取/解析 manifest。
- 最终 strict-local 完整性检查同样使用批量 cache snapshot，保留离线完整镜像语义。
- 旧配置如果仍是历史默认 `asset_prefetch_workers = 8`，升级到 v0.1.5 时会自动迁移到 24；用户自行设置过其他值则保持不变。

本地 3000 个已缓存对象的 micro-benchmark 中，cache scan 从约 **0.94 s** 降至约 **0.011 s**（约 84×）；实际机器收益取决于磁盘、SQLite 缓存状态和 Asset 数量。首次全量下载的提升主要来自更高并发和批量 metadata 落库，最终速度仍受 CDN、代理和本地磁盘限制。

## 下载哪个文件

| 文件 | 用途 | 怎么用 |
|---|---|---|
| `mltd-relive-standalone-v0.1.5-windows.exe` | Windows 服务器 | Windows 用户直接运行。推荐日常使用 `hybrid`；需要完整离线镜像时选择 `local`。 |
| `mltd-relive-standalone-v0.1.5-ubuntu` | Ubuntu/Linux 服务器 | `chmod +x` 后运行；监听 53/443 端口时通常需要 `sudo`。 |
| `mltd-relive-standalone-v0.1.5-macos.zip` | macOS 服务器 | 解压后运行 app。 |
| `mltd-relive-game-client-zh-fixed.apk` | 繁中修正版客户端 | 繁中玩家直接安装。已包含 Android 12L+ 兼容修正。 |
| `mltd-relive-game-client-ko-fixed.apk` | 韩文修正版客户端 | 韩文玩家直接安装。已包含 Android 12L+ 兼容修正。 |
| `mltd-relive-apk-patcher-v1.0.9-windows.exe` | Windows APK Patcher | **仅在需要自定义分辨率/FPS 时使用**。输入上面的修正版 APK。 |
| `mltd-relive-apk-patcher-v1.0.9-ubuntu` | Linux APK Patcher | 同上。 |
| `mltd-relive-apk-patcher-v1.0.9-macos.zip` | macOS APK Patcher | 同上。 |
| `SHA256SUMS.txt` | APK 校验值 | 用于校验两份修正版游戏 APK 是否下载完整。 |
| `LICENSE` | 许可证 | 一般用户无需操作。 |

## 最常见用法

**Windows + 繁中客户端：**只下载 `mltd-relive-standalone-v0.1.5-windows.exe` 和 `mltd-relive-game-client-zh-fixed.apk` 即可。

运行服务器，选择繁中和 `hybrid`，手机把 DNS 指向服务器窗口显示的 IPv4，然后启动游戏。

如果希望服务器启动后完全不依赖 Asset CDN，可以选择 `local`。首次启动会预下载当前语言的 Android + iOS 完整资源；GUI 会显示实时预取进度。完成后运行期 cache miss 不会访问上游网络。

如果你不需要修改分辨率或 FPS，**不要下载 Patcher**。

## APK Patcher 额外要求

Patcher v1.0.9 需要：

- Apktool **2.12.1**
- Android Build Tools **29.0.3**（`zipalign` / `apksigner`）
- Java

Patcher 的输入请使用本 Release 提供的 `*-fixed.apk`，不要使用旧的未修正版客户端。
