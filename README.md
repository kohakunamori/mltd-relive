# 偶像大師百萬人演唱會！劇場時光（重生版）

THE iDOLM@STER Million (RE)Live!: Theater Days

本專案通过本地服务器让已停止运营的《偶像大师 百万人演唱会！剧场时光》繁中版/韩版客户端继续运行。

本仓库基于 [RainbowUnicorn7297/mltd-relive](https://github.com/RainbowUnicorn7297/mltd-relive) 继续维护。Prototype 已移除，当前只维护 **Standalone** 服务器及配套工具。

## 当前版本

- **Standalone Server:** `v0.1.4`
- **APK Patcher:** `v1.0.9`
- **Asset Mode 默认值:** `hybrid`

最新二进制、修正版游戏客户端和 APK Patcher 统一放在：

**[GitHub Releases](https://github.com/kohakunamori/mltd-relive/releases/latest)**

Release 页面已经逐项注明每个文件的用途。一般 Windows + 繁中用户只需要：

- `mltd-relive-standalone-v0.1.4-windows.exe`
- `mltd-relive-game-client-zh-fixed.apk`

不修改分辨率/FPS时无需下载 Patcher。

## Standalone 功能

- 支持繁体中文和韩文客户端
- 游戏数据保存在本地 SQLite 数据库 `mltd-relive.db`
- 支持登录、任务、偶像编成、演唱会等现有 Standalone 功能
- 本地 DNS + TLS/API 服务，让客户端连接本机服务器
- Asset Server 支持 `remote` / `hybrid` / `local` 三种模式
- Asset 上游请求支持 HTTP/HTTPS proxy

## Asset Mode

### `hybrid`（推荐）

优先从本地缓存读取资源；缓存缺失时从上游下载并保存到本地。兼顾首次使用方便和后续加载速度。

### `remote`

资源按需从上游获取，不要求提前准备完整资源库。

### `local`

严格本地模式。服务器启动前会预下载所需 Android/iOS 资源，运行阶段只依赖本地缓存。

## 电脑运行服务器

### Windows

1. 从 Release 下载 `mltd-relive-standalone-v0.1.4-windows.exe`。
2. 运行程序。
3. 选择繁中/韩文客户端。
4. `Asset Mode` 建议保持 `hybrid`。
5. 等待窗口显示 `Server Status: Started`。
6. 将手机 DNS 指向窗口显示的电脑 LAN IPv4。
7. 安装 Release 中对应的 `*-fixed.apk` 后启动游戏。

首次运行会在程序目录生成数据库、配置和日志文件。Windows 防火墙弹窗出现时需要允许访问局域网。

### Ubuntu/Linux

```bash
chmod +x mltd-relive-standalone-v0.1.4-ubuntu
sudo ./mltd-relive-standalone-v0.1.4-ubuntu
```

DNS/TLS 默认需要监听 53/443 端口，因此通常需要 root 权限或等效 capability。

### macOS

下载并解压 `mltd-relive-standalone-v0.1.4-macos.zip`，然后运行其中的 app。

## 修正版游戏客户端

Release 只提供修正版客户端：

- `mltd-relive-game-client-zh-fixed.apk`：繁中版
- `mltd-relive-game-client-ko-fixed.apk`：韩文版

旧的未修正版 APK 不再作为默认下载提供。原始 APK 在 Android 12L+ 存在兼容问题，因此正常使用请直接选择 Release 中的 `*-fixed.apk`。

## APK Patcher

APK Patcher **只用于修改 Android 客户端分辨率和 FPS**。不需要这些功能时不要使用。

Patcher v1.0.9 的输入请使用本 Release 的 `*-fixed.apk`。

Windows 版需要准备：

- Apktool **2.12.1**
- Android Build Tools **29.0.3**（`zipalign` / `apksigner`）
- Java

Patcher 会直接调用 Build Tools 中的 `lib/apksigner.jar` 完成签名与验证，避免旧版 Windows `apksigner.bat` wrapper 静默失败后生成未签名 APK。

## 配置

首次运行后生成 `config.ini`。常用配置包括：

```ini
[default]
language = zh
asset_mode = hybrid
asset_cache_root = asset-cache
asset_prefetch_workers = 8
asset_upstream_proxy =
```

`asset_upstream_proxy` 仅用于 Asset Server 访问上游，例如：

```ini
asset_upstream_proxy = http://127.0.0.1:7890
```

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

- `standalone/`：当前 Standalone 服务器源码
- `tools/apk-patcher/`：APK 分辨率/FPS Patcher
- `tests/`：测试
- `.github/workflows/`：CI / Release 构建定义
- `ASSET_MIRROR.md`：Asset mirror/local cache 相关说明
- `RELEASE_NOTES.md`：Release 文件用途说明

## 致谢

原项目及大量游戏数据整理工作来自 [RainbowUnicorn7297/mltd-relive](https://github.com/RainbowUnicorn7297/mltd-relive)。本 fork 在其基础上继续维护服务器性能、Asset Server、本地缓存/代理和客户端工具链。
