# 偶像大師百萬人演唱會！劇場時光（重生版）

THE iDOLM@STER Million (RE)Live!: Theater Days

本專案通过本地服务器让已停止运营的《偶像大师 百万人演唱会！剧场时光》繁中版/韩版客户端继续运行。

本仓库基于 [RainbowUnicorn7297/mltd-relive](https://github.com/RainbowUnicorn7297/mltd-relive) 继续维护。Prototype 已移除，当前只维护 **Standalone** 服务器及配套工具。

## 当前版本

- **Standalone Server:** `v0.1.10`（当前兼容性修复分支）
- **APK Patcher:** `v1.0.9`
- **Asset Transport:** `remote` HTTPS only

正式二进制、修正版游戏客户端和 APK Patcher 统一放在：

**[GitHub Releases](https://github.com/kohakunamori/mltd-relive/releases/latest)**

Release 页面会逐项注明每个文件的用途。一般 Windows + 繁中用户需要 Standalone Server 与对应的 `*-fixed.apk`。

## Standalone 功能

- 支持繁体中文和韩文客户端
- 游戏数据保存在本地 SQLite 数据库 `mltd-relive.db`
- 支持登录、任务、偶像编成、演唱会等现有 Standalone 功能
- 本地 DNS + TLS/API 服务，让客户端连接本机服务器
- Asset 使用正常 HTTPS remote endpoint，不再由本地服务器转发或缓存
- 可通过 `asset_remote_url` 切换到其它受信任的 HTTPS 对象存储
- 独立 Asset Cache 工具可将当前远端/R2 资源完整保存到本地或 NAS

## Asset 架构

运行游戏时：

```text
client
  -> local MLTD API server
  -> AssetService.GetAssetVersion
  -> remote HTTPS Asset storage
```

默认 Asset 根地址：

```text
https://assets.rainbowunicorn7297.com/
```

Standalone 不再提供 `hybrid/local` Asset 模式，也不再运行 Asset HTTP/HTTPS Server。

这样可以避免已确认的客户端兼容问题：

- 本地 self-signed HTTPS Asset 路径会导致 `-404 / 0`；
- Desktop cleartext HTTP Asset 路径会导致资料下载失败 `-21990`。

如果需要切换到其它 HTTPS Asset 存储，可在 `config.ini` 中设置：

```ini
[default]
asset_mode = remote
asset_remote_url = https://assets.example.com
```

留空 `asset_remote_url` 即使用默认 Rainbow remote endpoint。

## Asset 灾备缓存

为了避免现有远端/R2 未来失联，可以在源站仍可访问时主动保存完整资源：

```bash
python tools/cache_assets.py sync \
  --scope zh-android \
  --root /path/to/durable/mltd-assets \
  --workers 48
```

缓存工具支持：

- 根据当前 manifest 全量下载 Asset；
- 多线程并发；
- `.part` 断点续传；
- size + SHA256 + ETag 等元数据；
- 已有缓存跳过；
- 可选 `--verify-existing` 强制检查已有文件；
- 可选 `--proxy` 让缓存工具访问远端时走代理；
- 可将 `--root` 直接指向 NAS 挂载目录。

源站完全不可用后仍可进行纯本地完整性校验：

```bash
python tools/cache_assets.py verify \
  --scope zh-android \
  --root /path/to/durable/mltd-assets
```

`verify` 不访问网络，只根据保存的 manifest、文件大小和 SHA256 检查完整性。

详细说明见 [`ASSET_CACHE.md`](ASSET_CACHE.md)。

## 电脑运行服务器

### Windows

1. 从 Release 下载对应的 Windows Standalone Server。
2. 运行程序。
3. 选择繁中/韩文客户端。
4. 等待窗口显示 `Server Status: Started`。
5. 将手机 DNS 指向窗口显示的电脑 LAN IPv4。
6. 安装 Release 中对应的 `*-fixed.apk` 后启动游戏。

首次运行会在程序目录生成数据库、配置和日志文件。Windows 防火墙弹窗出现时需要允许访问局域网。

### Ubuntu/Linux

```bash
chmod +x mltd-relive-standalone-*-ubuntu
sudo ./mltd-relive-standalone-*-ubuntu
```

DNS/TLS 默认需要监听 53/443 端口，因此通常需要 root 权限或等效 capability。

### macOS

下载并解压对应的 macOS 构建，然后运行其中的 app。

## 修正版游戏客户端

Release 只提供修正版客户端：

- `mltd-relive-game-client-zh-fixed.apk`：繁中版
- `mltd-relive-game-client-ko-fixed.apk`：韩文版

旧的未修正版 APK 不再作为默认下载提供。原始 APK 在 Android 12L+ 存在兼容问题，因此正常使用请直接选择 Release 中的 `*-fixed.apk`。

## APK Patcher

APK Patcher **只用于修改 Android 客户端分辨率和 FPS**。不需要这些功能时不要使用。

Patcher v1.0.9 的输入请使用 Release 中的 `*-fixed.apk`。

Windows 版需要准备：

- Apktool **2.12.1**
- Android Build Tools **29.0.3**（`zipalign` / `apksigner`）
- Java

Patcher 会直接调用 Build Tools 中的 `lib/apksigner.jar` 完成签名与验证，避免旧版 Windows `apksigner.bat` wrapper 静默失败后生成未签名 APK。

## 配置

首次运行后生成 `config.ini`。主要配置：

```ini
[default]
language = zh
asset_mode = remote
asset_remote_url =
```

`asset_remote_url` 必须是正常 HTTPS URL。它只决定客户端从哪里下载 Asset；缓存工具的保存目录、并发数和代理均通过 `tools/cache_assets.py` 自己的 CLI 参数设置，不属于游戏服务器运行配置。

## 从源码构建

需要 Python 3.11。

```bash
git clone https://github.com/kohakunamori/mltd-relive.git
cd mltd-relive
python -m venv env
```

Windows：

```powershell
.\env\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
cd standalone
..\env\Scripts\pyinstaller gui_windows.spec
```

Ubuntu/Linux：

```bash
source env/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
cd standalone
../env/bin/pyinstaller gui_ubuntu.spec
```

macOS：

```bash
source env/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
cd standalone
../env/bin/pyinstaller gui_macos.spec
```

构建结果生成在本地 `build/` / `dist/` 中，这些目录和二进制产物均被 `.gitignore` 排除，不应提交到仓库。

## 仓库结构

- `standalone/`：Standalone API/DNS/TLS 服务器源码
- `tools/cache_assets.py`：远端/R2 Asset 灾备缓存与离线校验工具
- `tools/apk-patcher/`：APK 分辨率/FPS Patcher
- `tests/`：测试
- `.github/workflows/`：CI / Release 构建定义
- `ASSET_CACHE.md`：Asset 缓存格式与使用说明
- `RELEASE_NOTES.md`：Release 文件用途说明

## 致谢

原项目及大量游戏数据整理工作来自 [RainbowUnicorn7297/mltd-relive](https://github.com/RainbowUnicorn7297/mltd-relive)。本 fork 在其基础上继续维护服务器兼容性、性能、资源灾备和客户端工具链。
