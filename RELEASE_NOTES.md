# mltd-relive Standalone v0.1.4

本 Release 同时包含 **Standalone 服务器、修正版游戏客户端和可选 APK Patcher**。

## 下载哪个文件

| 文件 | 用途 | 怎么用 |
|---|---|---|
| `mltd-relive-standalone-v0.1.4-windows.exe` | Windows 服务器 | Windows 用户直接运行。推荐 `Asset Mode = hybrid`。 |
| `mltd-relive-standalone-v0.1.4-ubuntu` | Ubuntu/Linux 服务器 | `chmod +x` 后运行；监听 53/443 端口时通常需要 `sudo`。 |
| `mltd-relive-standalone-v0.1.4-macos.zip` | macOS 服务器 | 解压后运行 app。 |
| `mltd-relive-game-client-zh-fixed.apk` | 繁中修正版客户端 | 繁中玩家直接安装。已包含 Android 12L+ 兼容修正。 |
| `mltd-relive-game-client-ko-fixed.apk` | 韩文修正版客户端 | 韩文玩家直接安装。已包含 Android 12L+ 兼容修正。 |
| `mltd-relive-apk-patcher-v1.0.9-windows.exe` | Windows APK Patcher | **仅在需要自定义分辨率/FPS 时使用**。输入上面的修正版 APK。 |
| `mltd-relive-apk-patcher-v1.0.9-ubuntu` | Linux APK Patcher | 同上。 |
| `mltd-relive-apk-patcher-v1.0.9-macos.zip` | macOS APK Patcher | 同上。 |
| `SHA256SUMS.txt` | APK 校验值 | 用于校验两份修正版游戏 APK 是否下载完整。 |
| `LICENSE` | 许可证 | 一般用户无需操作。 |

## 最常见用法

**Windows + 繁中客户端：**只下载 `mltd-relive-standalone-v0.1.4-windows.exe` 和 `mltd-relive-game-client-zh-fixed.apk` 即可。

运行服务器，选择繁中和 `hybrid`，手机把 DNS 指向服务器窗口显示的 IPv4，然后启动游戏。

如果你不需要修改分辨率或 FPS，**不要下载 Patcher**。

## APK Patcher 额外要求

Patcher v1.0.9 需要：

- Apktool **2.12.1**
- Android Build Tools **29.0.3**（`zipalign` / `apksigner`）
- Java

Patcher 的输入请使用本 Release 提供的 `*-fixed.apk`，不要使用旧的未修正版客户端。
