# MLTD `zh-fixed.apk` 客户端源码化与维护基线

## 目标

把 Release 中只有二进制形式保存的 `mltd-relive-game-client-zh-fixed.apk` 转换成可重复分析、可 diff、可维护的客户端基线，避免未来服务端更新时再次从零逆向。

这里的“源码化”分三层，不把反编译输出误称为原始工程：

1. **apktool / smali**：Android/Dalvik 层的权威可编辑表示，可重新打包。
2. **JADX**：Java-like 阅读视图，方便理解 Android 壳；它不是可靠的可编译源代码。
3. **IL2CPP metadata source view**：由 `libil2cpp.so` + `global-metadata.dat` 恢复 C# 类型/字段/方法签名以及 native RVA/VA/offset。方法体仍然是 ARM64 机器码，不可能仅靠 metadata 还原成原始 C# 实现。

## 已验证基线：`zh-fixed-v1`

Release `standalone-v0.1.10` 中的繁中 corrected client：

- APK SHA-256：`a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918`
- package：`com.bandainamcoent.imas_millionlive_theaterdays_ch.local`
- version：`2.1.000` / versionCode `21000`
- minSdk：19
- targetSdk：29
- ABI：仅 `arm64-v8a`
- DEX：`classes.dex` 一个
- `libil2cpp.so` SHA-256：`52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- `global-metadata.dat` SHA-256：`0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

详细机器可读信息保存在 `client/baseline/zh-fixed-v1.json`。

## 实际提取结果

第一次完整流水线已验证：

- Apktool `2.12.1` 完整 decode 成功；
- 未修改的 apktool baseline rebuild 成功；
- Apktool 视图约 5858 个文件；
- JADX `1.5.6` 处理约 2585 个 class，仅 8 个反编译错误，仍成功产出约 3936 个阅读视图文件；
- 游戏自己的 Android wrapper 很小，关键类主要是 `OverrideActivity` / `OverridePlayer`，说明核心逻辑确实位于 IL2CPP native 层；
- Il2CppDumper 成功识别 metadata / IL2CPP version `24.1`；
- 自动定位 `CodeRegistration = 0x5b058a0`、`MetadataRegistration = 0x5b05920`；
- 成功生成 `dump.cs`、`script.json`、`il2cpp.h` 与 DummyDll；
- `dump.cs` 中恢复出了客户端 RPC 契约：**75 个 Service / 309 个 `Service.Method` 常量**。

例如恢复出的核心连接代码包括：

```text
Imas.Connection.API.GetAuthURL       RVA 0x1AAC27C
Imas.Connection.API.GetRootURL       RVA 0x1AAC2EC
Imas.Connection.API.GetRpcURL        RVA 0x1AAC354
Imas.Connection.API.SetGameServerUrl RVA 0x1AAC3C8
Imas.Connection.API.GetResponseJson  RVA 0x1AAC434
```

并能直接恢复：

```text
AuthService.GetConnectURLAndToken
AuthService.Login
AssetService.GetAssetVersion
OfferService.GetOfferList
LiveService.StartSong
UserService.GetSelf
...
```

当前完整 RPC 快照保存在 `client/contract/rpc-methods-zh-fixed-v1.txt`，保持排序，因此未来换 APK 后可以直接做文本 diff。

## 当前已知客户端补丁面

现有 `tools/apk-patcher/apk-patcher.pyw` 修改两类 payload：

- `classes.dex`：替换 `OverrideActivity.smali`，用于刷新率相关 Android 层行为；
- `lib/arm64-v8a/libil2cpp.so`：修改分辨率以及多个场景帧率指令。

现有 patcher 有意使用 `apktool d -r` 避免无关资源 round-trip，并验证只有 `classes.dex` 与 `libil2cpp.so` 发生变化。这个最小差分原则应保留。

已把繁中 native offset 整理到 `client/il2cpp/patch-points.yml`，每个 patch point 同时绑定：

- 精确 `libil2cpp.so` SHA-256；
- 命名后的逻辑用途；
- file offset；
- expected original instruction bytes；
- replacement instruction 语义。

后续 patcher 应在写入前同时验证文件哈希和原始字节，避免客户端换版后旧 offset 静默破坏二进制。

## 自动提取

工作流：

```text
.github/workflows/extract-zh-fixed-client.yml
```

执行流程：

1. 从指定/最新 Release 下载 `mltd-relive-game-client-zh-fixed.apk`；
2. 用 `release/game-client.env` 的 `ZH_SHA256` 校验；
3. Apktool 生成完整 smali/resources 维护视图，并做 baseline rebuild test；
4. JADX 生成 Java-like 阅读视图；
5. 记录 APK entry、DEX、ABI、ELF、metadata、网络字符串等报告；
6. Il2CppDumper 生成 `dump.cs` / `script.json` / `il2cpp.h` / DummyDll；
7. 从 `API.Method.*` 自动提取稳定排序的客户端 RPC 清单；
8. 把客户端 RPC 清单与 `standalone/mltd/services` 中 `@dispatcher.add_method(...)` 注册项做集合差异，输出服务端覆盖报告；
9. 上传 compact report artifact 与完整 `tar.zst` source artifact。

本地也可执行：

```bash
chmod +x tools/client-source/extract-zh-fixed.sh
chmod +x tools/client-source/extract-il2cpp.sh

tools/client-source/extract-zh-fixed.sh \
  /path/to/mltd-relive-game-client-zh-fixed.apk \
  client-source-output

tools/client-source/extract-il2cpp.sh client-source-output

python tools/client-source/compare-server-contract.py \
  client-source-output/report/client-rpc-methods.txt \
  standalone/mltd/services \
  client-source-output/report
```

## 为什么不把完整反编译树提交到 `main`

完整产物包含：

- 数千个 Apktool/JADX 文件；
- `libil2cpp.so` 与 Unity/native 资源；
- 约 35 MB 的 `dump.cs`；
- 约 90 MB 的 `script.json`；
- 约 67 MB 的 `il2cpp.h`；
- 大量 DummyDll。

这些文件适合由 CI 根据确定的 APK hash 重建，不适合污染主仓库 Git history。主仓库只长期保存真正需要 review/diff 的小型真源：

```text
client/
  README.md
  baseline/
    zh-fixed-v1.json
  android/
    smali/...
  contract/
    rpc-methods-zh-fixed-v1.txt
  il2cpp/
    patch-points.yml

tools/client-source/
  extract-zh-fixed.sh
  extract-il2cpp.sh
  compare-server-contract.py
```

## 后续最有价值的工作

1. **取得原始未修正繁中 APK**，与 `zh-fixed-v1` 做 entry / manifest / DEX / native 二进制差分，精确还原所谓 Android 12L fix，而不是猜测；
2. 将固定 native file offset 进一步升级为 signature/pattern 定位，便于同一逻辑跨客户端版本迁移；
3. 对 `Imas.Connection.API`、`ConnectionManager`、`AssetBundleDownloader` 等关键类型继续做 ARM64 反汇编与调用图恢复，定位 URL、加解密、请求 envelope、asset 下载逻辑；
4. 每次替换客户端基线时由 CI 自动生成 RPC diff，优先处理新增的 `Service.Method`；
5. 如以后服务端协议必须客户端协同修改，把改动收敛为声明式 patch set，由固定基线 APK 自动构建并签名，而不是人工修改 APK。
