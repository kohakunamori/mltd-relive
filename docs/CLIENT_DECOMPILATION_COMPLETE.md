# MLTD `zh-fixed.apk` 完整反编译与客户端维护指南

本文档描述 `mltd-relive-game-client-zh-fixed.apk` 的完整可重复反编译、IL2CPP 元数据恢复、RPC 契约提取、服务端联动维护、原生补丁和重新打包流程。

目标不是声称恢复了 Bandai Namco / Unity 的“原始工程源码”，而是建立一个对后续维护足够稳定、可重现、可 diff 的客户端源码视图。

---

## 1. 基线客户端

当前繁中修正版基线：

| 字段 | 值 |
|---|---|
| Baseline ID | `zh-fixed-v1` |
| Release 文件 | `mltd-relive-game-client-zh-fixed.apk` |
| APK SHA-256 | `a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918` |
| Package | `com.bandainamcoent.imas_millionlive_theaterdays_ch.local` |
| Version code | `21000` |
| Version name | `2.1.000` |
| minSdk | `19` |
| targetSdk | `29` |
| ABI | `arm64-v8a` |
| DEX | `classes.dex` |
| `libil2cpp.so` SHA-256 | `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b` |
| `global-metadata.dat` SHA-256 | `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0` |

机器可读基线定义：

```text
client/baseline/zh-fixed-v1.json
```

Release 下载入口与 SHA-256 同时记录在：

```text
release/game-client.env
```

任何后续自动化首先都必须校验 APK SHA-256。不能把“文件名相同”视为同一基线。

---

## 2. “完整反编译”具体包含什么

MLTD 是 Unity IL2CPP 游戏，不能只用 JADX 导出 Java 就认为已经得到游戏源码。完整维护视图分为四层。

### 2.1 Apktool / smali 层

目录：

```text
apktool/
```

用途：

- AndroidManifest / resources 解码；
- `classes.dex` 的 smali 表示；
- Java/Android 壳逻辑的权威字节级维护视图；
- 原始 `assets/`、`lib/`、Unity 数据和 native library；
- 可以重新由 Apktool 构建成 unsigned APK。

对于需要保证“只改一个方法/一个 smali 文件”的工作，应以 Apktool 层为准，而不是 JADX Java 输出。

### 2.2 JADX 层

目录：

```text
jadx/
```

用途：

- 把 DEX 还原成更容易阅读的 Java-like 源码；
- 查看 Android Activity、Java bridge、SDK wrapper；
- 快速搜索字符串、调用关系和第三方库。

限制：

- JADX 输出不是原始 Java；
- 不保证能够作为 Android Studio / Gradle 工程直接编译；
- 少量复杂方法可能反编译失败或包含 `JADX ERROR`；
- 若 JADX 与 smali 语义冲突，应信任 smali。

当前基线约 2585 个 class，仅少量方法无法完全重建为 Java-like body，不影响整体阅读。

### 2.3 IL2CPP 层

目录：

```text
il2cpp-dump/
```

核心输入：

```text
apktool/lib/arm64-v8a/libil2cpp.so
apktool/assets/bin/Data/Managed/Metadata/global-metadata.dat
```

当前使用 Il2CppDumper `6.7.46`，识别为 Metadata / Il2Cpp `24.1`。

已恢复关键 registration：

```text
CodeRegistration     = 0x5b058a0
MetadataRegistration = 0x5b05920
```

主要输出：

```text
il2cpp-dump/dump.cs
il2cpp-dump/script.json
il2cpp-dump/il2cpp.h
il2cpp-dump/stringliteral.json
il2cpp-dump/DummyDll/
```

#### `dump.cs`

这是后续服务端/协议逆向最重要的阅读索引之一。它恢复：

- namespace；
- class / struct / enum；
- field；
- method signature；
- property；
- RVA / VA / file offset 注释；
- metadata token。

但它**不是原始 C# 源码**。IL2CPP 已经把原始 C# method body AOT 编译成 ARM64 native code，因此 `dump.cs` 只能恢复类型、签名和地址映射，无法自动恢复高层原始 method body。

需要理解具体算法时，应使用：

```text
dump.cs 方法名/RVA
       ↓
script.json / native offset
       ↓
libil2cpp.so ARM64 反汇编/反编译
```

#### `script.json`

用于 Ghidra / IDA 等工具把 native 地址重新标注成 IL2CPP 方法和字段名称。

#### `DummyDll/`

包含根据 metadata 生成的 dummy managed assemblies，例如：

```text
Assembly-CSharp.dll
mscorlib.dll
System.dll
MsgPack.dll
...
```

这些 DLL 的主要用途是 metadata/type inspection，不包含原始业务方法 IL body。

### 2.4 Exact binary / forensic 层

目录：

```text
raw-critical/
report/
```

`raw-critical/` 保存 APK 中原始二进制形式的关键 Android 文件，主要用于检测 Apktool round-trip 是否意外改变资源。

`report/` 保存：

- APK entry list；
- zip metadata；
- Apktool/JADX/Il2CppDumper 版本；
- decode / rebuild / decompile log；
- ELF header / section / program header；
- native 与 metadata SHA-256；
- network/server string hit；
- RPC contract；
- 客户端与当前 Python 服务端接口覆盖差异。

---

## 3. 完整反编译分支

完整生成树发布到专门 orphan 分支：

```text
client-decompiled-zh-fixed-v1
```

该分支不会与 `main` 共用提交历史。它的目的就是承载较大的完整反编译结果。

预期根目录：

```text
README.md
PROVENANCE.json
apktool/
jadx/
il2cpp-dump/
raw-critical/
report/
```

`rebuild-check/unsigned-rebuilt.apk` 不进入这个分支，因为它是验证阶段产生的构建结果，不属于反编译源码；Apktool rebuild 是否成功仍记录在 `report/` 中。

### 为什么使用 orphan + force update

完整提取树约数百 MiB，并包含接近 GitHub 常规 Git 单文件限制的大型 native 文件。如果每个客户端版本都在同一历史链上重复提交，则仓库会快速膨胀。

因此发布流程采用：

1. 从固定 APK 重新生成全部反编译结果；
2. 创建新的 orphan commit；
3. `git push --force` 更新 `client-decompiled-zh-fixed-v1`；
4. 只保存当前基线的完整生成树，不累积旧版本大文件 Git 历史。

需要长期保存旧版本时，建议：

- 固定 Release artifact；或
- 为旧版本建立单独 archive repo；或
- 把旧版本 `tar.zst` 放 GitHub Release，而不是让全部版本共存于 regular Git history。

---

## 4. 自动化入口

### 4.1 只生成 artifact

工作流：

```text
.github/workflows/extract-zh-fixed-client.yml
```

输出：

- compact report artifact；
- 完整 `tar.zst` 反编译 artifact。

适合 CI 检查和下载分析。

### 4.2 直接发布完整 Git 分支

工作流：

```text
.github/workflows/publish-zh-fixed-decompiled.yml
```

默认目标：

```text
client-decompiled-zh-fixed-v1
```

流程：

```text
Release zh-fixed.apk
  ↓ SHA-256 verify
Apktool 2.12.1
  ↓
JADX 1.5.6
  ↓
Il2CppDumper 6.7.46
  ↓
RPC contract extraction
  ↓
server contract comparison
  ↓
100 MiB per-file safety check
  ↓
orphan Git commit
  ↓
client-decompiled-zh-fixed-v1
```

工作流在 push 前会扫描全部文件。如果任何 regular Git object 达到或超过 100 MiB，会直接失败，而不是尝试产生一个 GitHub 拒绝的提交。

---

## 5. 本地从 APK 完整生成

推荐 Linux / WSL / Ubuntu。

依赖：

- Java 17；
- Python 3；
- .NET 6；
- `curl`；
- `unzip` / `zip`；
- `binutils`；
- `file`；
- `zstd`。

工具版本由脚本固定/下载：

```text
Apktool      2.12.1
JADX         1.5.6
Il2CppDumper 6.7.46
```

首先运行 Android 层：

```bash
chmod +x tools/client-source/extract-zh-fixed.sh

tools/client-source/extract-zh-fixed.sh \
  /path/to/mltd-relive-game-client-zh-fixed.apk \
  client-source-output
```

然后运行 IL2CPP metadata recovery：

```bash
chmod +x tools/client-source/extract-il2cpp.sh

tools/client-source/extract-il2cpp.sh client-source-output
```

然后比较当前服务端 RPC 注册：

```bash
python tools/client-source/compare-server-contract.py \
  client-source-output/report/client-rpc-methods.txt \
  standalone/mltd/services \
  client-source-output/report
```

---

## 6. APKTool rebuild

完整 decode 后自动进行 unsigned rebuild：

```text
apktool d ...
       ↓
apktool b ...
```

当前 `zh-fixed-v1` 已验证可以完成 unsigned rebuild。

注意：

“能 rebuild”不等于“生成 APK 与输入 APK 二进制完全相同”。APK 中 ZIP layout、resource serialization、signature block 等都可能变化。

现有正式 `tools/apk-patcher/` 为了避免无关变化，采用更保守的：

```text
apktool d -r
```

并且在重新打包前后检查 APK payload，规定正常 FPS/分辨率 patch 只能改变：

```text
classes.dex
lib/arm64-v8a/libil2cpp.so
```

因此：

- `apktool/` 完整树适合分析和大范围维护；
- 正式 Release patch 应继续尽量使用最小差分策略。

---

## 7. Android Java/smali 层重点

当前正式 patcher 会替换：

```text
com/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity.smali
```

长期维护基线还保存了：

```text
client/android/smali/com/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity.smali
client/android/smali/com/bandainamcoent/imas_millionlive_theaterdays/player/OverridePlayer.smali
```

这些文件应作为 Android player wrapper 的快速入口。

如果未来要修：

- Android 版本兼容；
- Activity 生命周期；
- refresh rate；
- Surface / display；
- Java ↔ native bridge；

优先从这里和 JADX 对应 Java-like class 开始。

---

## 8. IL2CPP native patch point

声明式 patch point：

```text
client/il2cpp/patch-points.yml
```

当前繁中 `zh-fixed-v1` 已记录：

### Resolution

```text
rendering.resolution
offset: 0x01950494
original bytes LE: 095a8052
baseline: MOVZ W9, #720
```

### Frame rate

```text
framerate.on_begin_scene                 0x01e35c94
framerate.setup_live_mv_special_level   0x01e3676c
framerate.setup_live_special_level      0x01e3617c
framerate.setup_theater_special_level   0x01e359ac
framerate.setup_commu_special_plus_level 0x01e35de4
framerate.setup_gasha_special_plus_level 0x01e35f8c
```

当前基线这些 frame-rate patch point 的 expected original bytes 均为：

```text
e00f1e32
```

### 正确 patch 规则

native patch 不应该只写：

```python
seek(0x01e35c94)
write(...)
```

而应该：

```text
verify whole-file SHA-256
  ↓
verify expected_original_bytes at patch point
  ↓
encode replacement ARM64 instruction
  ↓
write
  ↓
verify resulting bytes
```

只要 client 更新导致 binary hash 或原始指令不一致，就应拒绝 patch，并要求重新定位方法/RVA。

---

## 9. 服务端 URL / Connection 调查入口

从当前 IL2CPP dump 已经恢复出 `Imas.Connection.API` 相关方法。

关键 RVA：

```text
GetAuthURL        0x1AAC27C
GetRootURL        0x1AAC2EC
GetRpcURL         0x1AAC354
SetGameServerUrl  0x1AAC3C8
GetResponseJson   0x1AAC434
```

这组函数是后续研究以下问题的首选入口：

- Auth endpoint 如何生成；
- RPC endpoint 如何生成；
- root/game server 地址如何保存；
- 登录返回后客户端如何更新 server endpoint；
- response JSON 的解包/解析流程；
- 是否能够把网络 endpoint 进一步配置化。

实际分析方式：

1. 在 `dump.cs` 找到完整 class 和 method signature；
2. 获取 method RVA / offset；
3. 在 Ghidra/IDA 中加载 `libil2cpp.so`；
4. 使用 `script.json` 恢复 symbol name；
5. 追踪 ARM64 caller/callee；
6. 把确认后的地址和语义写回 `client/il2cpp/` 文档/patch point，而不是长期依赖人工笔记。

---

## 10. RPC 服务契约

当前从 `Assembly-CSharp` metadata 中恢复：

```text
75 services
309 Service.Method RPC constants
```

稳定排序快照：

```text
client/contract/rpc-methods-zh-fixed-v1.txt
```

其中包括：

```text
AuthService.Login
AssetService.GetAssetVersion
GameService.GetVersion
LiveService.StartSong
LiveService.FinishSong
OfferService.GetOfferList
StoryService.GetStoryList
UnitService.SetUnit
UserService.GetSelf
...
```

完整列表请直接看上述 contract 文件，不要在多处手工维护副本。

### 与 Python Server 自动比较

Standalone 服务端使用：

```python
@dispatcher.add_method(name='AssetService.GetAssetVersion')
```

这样的字符串注册方式，因此可以与客户端 metadata 恢复出的 `Service.Method` 直接做集合比较。

命令：

```bash
python tools/client-source/compare-server-contract.py \
  client-source-output/report/client-rpc-methods.txt \
  standalone/mltd/services \
  client-source-output/report
```

当前基线结果：

```text
Client RPC:      309
Server RPC:       22
Implemented:      22
Coverage:       7.12%
Client-only:     287
Server-only:       0
```

### 如何理解 7.12%

这不是游戏完成度，也不是“需要实现 287 个 RPC”。

客户端保留了停运前大量：

- 历史活动；
- 商城/支付；
- Lounge；
- 好友；
- 广告；
- 各代 EventType；
- 旧 campaign；
- 已停用 mini-game；

接口。

离线重生版只需要实现客户端实际会走到的路径。

这个 coverage report 的真正用途是**版本漂移检测**：

- 新客户端新增 RPC → 立即看到；
- 客户端删除/改名 RPC → 立即看到；
- 服务端注册了客户端不存在的方法 → 立即看到。

---

## 11. 服务端更新时的推荐流程

以后任何涉及客户端协议/兼容性的服务端更新，建议按以下顺序。

### Step 1：锁定客户端 baseline

确认：

```text
APK SHA-256
libil2cpp SHA-256
global-metadata SHA-256
```

### Step 2：先查 RPC contract

如果是某个请求报错，例如：

```text
OfferService.GetOfferList
```

先在：

```text
client/contract/rpc-methods-zh-fixed-v1.txt
```

确认客户端确实拥有该方法。

### Step 3：查 `dump.cs`

搜索相关 service / request / response model。

示例思路：

```bash
grep -n "OfferService" il2cpp-dump/dump.cs
grep -n "GetOfferList" il2cpp-dump/dump.cs
```

获取：

- request type；
- response type；
- field name；
- enum；
- method RVA。

### Step 4：需要 method body 时进入 native

根据 RVA 到 `libil2cpp.so` 查看 ARM64 implementation。

### Step 5：更新 Python service

在：

```text
standalone/mltd/services/
```

实现/修正 RPC。

### Step 6：重新跑 contract comparison 与现有 tests

不要只靠一次手工登录判断接口兼容。

---

## 12. 客户端升级流程

如果以后获得新的修正版/更高版本繁中客户端，不要覆盖 `zh-fixed-v1` 的定义后直接继续。

建议：

### 12.1 新建 baseline ID

例如：

```text
zh-fixed-v2
```

记录：

- APK SHA；
- package/version；
- libil2cpp SHA；
- metadata SHA；
- tool versions。

### 12.2 重新完整反编译

生成新：

```text
apktool/
jadx/
il2cpp-dump/
report/
```

### 12.3 RPC contract diff

```bash
comm -3 \
  client/contract/rpc-methods-zh-fixed-v1.txt \
  client/contract/rpc-methods-zh-fixed-v2.txt
```

### 12.4 native patch point 重新定位

即使函数语义没变，也不能假设 RVA/file offset 不变。

应通过：

- IL2CPP method name；
- dump RVA；
- ARM64 instruction context；
- pattern/signature；

重新确定地址。

### 12.5 网络方法比较

重点 diff：

```text
Imas.Connection.API
AuthService
AssetService
GameService
```

这样可以快速判断新客户端是否改变 endpoint、认证或 asset negotiation。

---

## 13. 原始 `zh` APK 与 `zh-fixed` 的差分

目前还有一个非常重要但尚未彻底解决的问题：

**我们已经拥有 corrected `zh-fixed-v1`，但还需要取得相同版本、未做 Android 12L 修复的原始繁中 APK。**

得到原始 APK 后应做四层 diff：

### ZIP entry level

比较每个 entry：

```text
name
size
compression method
SHA-256
```

### DEX level

如果 `classes.dex` 不同：

- baksmali/apktool diff；
- 找出实际修改 class/method。

### Android resource / Manifest level

比较：

- binary manifest；
- decoded manifest；
- resources.arsc；
- target/min SDK；
- exported / storage / cleartext / compatibility flag。

### Native level

如果 `.so` 不同：

- SHA；
- ELF section；
- binary diff；
- changed ARM64 function；
- IL2CPP RVA mapping。

最终应把“Android 12L fixed 到底改了什么”转换为**可重复 patch**，从而完全摆脱对神秘 corrected binary 的依赖。

---

## 14. 为什么不把 JADX 当作可编译 Android Studio 工程

APK 反编译经常出现一个错误目标：

> 把 JADX 输出整理成 `src/main/java`，然后希望 Gradle 能直接构建出原游戏。

对这个项目尤其不合适，因为：

1. 游戏主要逻辑是 IL2CPP native；
2. Java 层只是 Android/Unity 壳与第三方 SDK；
3. 原始 Gradle dependency graph 已丢失；
4. resource ID / generated classes / native packaging 是 APK 最终产物状态；
5. Unity 原始 ProjectSettings/Assets/C# source 不在 APK 中；
6. JADX 可能重构出不可编译的 Java syntax/control flow。

因此本项目的正确目标是：

```text
reproducible decompilation
+ exact smali edits
+ native symbol mapping
+ declarative binary patches
+ reproducible APK repack/sign
```

而不是伪造一个看起来像原始 Unity/Gradle repository 的工程。

---

## 15. Git 存储策略

完整生成树包含多个几十 MiB 文件，包括：

- `libil2cpp.so`；
- `script.json`；
- `il2cpp.h`；
- Unity data；
- `global-metadata.dat`；
- `Assembly-CSharp.dll`。

所以项目采用两层结构。

### `main` / maintenance branch

只保存：

```text
client/baseline/
client/android/smali/
client/contract/
client/il2cpp/patch-points.yml
tools/client-source/
docs/
.github/workflows/
```

这些内容体积小、适合 code review。

### generated decompiled branch

保存完整输出：

```text
client-decompiled-zh-fixed-v1
```

它是 generated branch，不应手工编辑。任何需要保留的研究结论都应回写到维护分支的 `client/` 或 `docs/`，否则下一次 force regenerate 会覆盖手工改动。

---

## 16. 哪些目录可以修改

### 推荐长期手工维护

```text
client/
tools/client-source/
docs/
standalone/
```

### 生成物，不推荐直接修改

```text
client-decompiled-zh-fixed-v1:apktool/
client-decompiled-zh-fixed-v1:jadx/
client-decompiled-zh-fixed-v1:il2cpp-dump/
client-decompiled-zh-fixed-v1:report/
```

如果在 generated tree 中发现重要结论：

1. 先验证；
2. 在维护分支新增 note / patch point / contract / test；
3. 不要把唯一知识留在 generated branch 的人工编辑里。

---

## 17. 常用调查命令

### 搜索 RPC

```bash
grep -RIna "AssetService.GetAssetVersion" client-decompiled/
```

### 搜索 URL/host

```bash
grep -RInaE 'https?://|cloudfront|rainbowunicorn|bandainamco' \
  jadx/ apktool/ il2cpp-dump/
```

### 查看 IL2CPP 方法

```bash
grep -n "SetGameServerUrl" il2cpp-dump/dump.cs
```

### 查看 native ELF

```bash
readelf -h apktool/lib/arm64-v8a/libil2cpp.so
readelf -S apktool/lib/arm64-v8a/libil2cpp.so
readelf -l apktool/lib/arm64-v8a/libil2cpp.so
```

### 验证 native hash

```bash
sha256sum apktool/lib/arm64-v8a/libil2cpp.so
```

### 比较 server coverage

```bash
cat report/server-contract-diff.md
```

---

## 18. 工具升级原则

不要为了“新版本看起来更好”随意升级 Apktool/JADX/Il2CppDumper。

### Apktool

正式 patcher 当前固定 `2.12.1`，原因是 legacy APK 的 manifest/resource round-trip 需要稳定可预测。

升级 Apktool 后必须重新验证：

- decode；
- rebuild；
- entry set；
- untouched payload hashes；
- resource compression metadata；
- final installability。

### JADX

JADX 是阅读工具，升级风险较低，但升级可能造成数千个文件产生无意义 textual diff，因此 generated branch 的 tool version 必须记录。

### Il2CppDumper

升级后必须确认：

- metadata version；
- registration address；
- dump.cs method RVA；
- script.json mapping；
- RPC extraction 数量。

如果 75 services / 309 methods 在相同 baseline 下突然大幅变化，应先视为工具/解析变化，而不是客户端协议变化。

---

## 19. 已知 Il2CppDumper CI 特性

Il2CppDumper 6.7.46 在无交互 CI 中可能在输出完成后执行 `Console.ReadKey()` 并以 `134` 退出。

本项目脚本不会仅根据 process exit code 判断失败，而会检查关键输出是否已经实际生成，例如：

```text
dump.cs
script.json
il2cpp.h
DummyDll/
```

如果这些输出存在且有效，就把该情况记录为“generated successfully but exited after generation”。

真正的解析失败仍应体现在 report/log 中，并阻止错误结果被误当作完整 IL2CPP baseline。

---

## 20. 当前状态总结

当前 `zh-fixed-v1` 已达到：

- [x] APK SHA 基线固定；
- [x] 完整 Apktool decode；
- [x] Apktool unsigned rebuild 验证；
- [x] JADX readability tree；
- [x] `libil2cpp.so` ELF inventory；
- [x] `global-metadata.dat` inventory；
- [x] IL2CPP 24.1 metadata recovery；
- [x] `dump.cs`；
- [x] `script.json`；
- [x] `il2cpp.h`；
- [x] DummyDll；
- [x] 75 services / 309 RPC contract snapshot；
- [x] 当前 Python server RPC 自动 coverage comparison；
- [x] Android smali maintenance baseline；
- [x] hash + original-byte-bound native patch point；
- [x] 完整 generated Git branch 自动发布流程；
- [ ] 相同版本原始未修 APK 与 `zh-fixed-v1` 的精确 binary diff；
- [ ] 把 Android 12L fix 完全转换为从原始 APK 可重复生成的 patch；
- [ ] native patch point 从固定 offset 进一步升级为 signature/pattern locator。

完成最后三项后，客户端维护链就可以从“依赖一份修正后的历史二进制”升级为：

```text
verified original baseline
  + declarative Android/native patches
  + reproducible build/sign
  + versioned client/server contract
```

这将是后续服务端继续更新时最稳定的客户端维护形态。
