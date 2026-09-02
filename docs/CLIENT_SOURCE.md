# MLTD `zh-fixed.apk` 客户端源码化方案

## 目标

把 Release 中只有二进制形式保存的 `mltd-relive-game-client-zh-fixed.apk` 转换成可重复分析、可 diff、可维护的客户端基线，避免未来服务端更新需要再次从零逆向。

这不是把 APK 伪装成一个能直接用 Android Studio 编译的“原始工程”。MLTD 是 Unity IL2CPP 游戏，客户端需要分层维护：

1. **apktool / smali 视图**：Android/Dalvik 层的权威可编辑表示，适合精确补丁和重新打包。
2. **jadx 视图**：Java-like 阅读视图，方便定位 Android 壳逻辑，但反编译结果不能当作字节级真源。
3. **IL2CPP native 层**：`lib/arm64-v8a/libil2cpp.so` + `global-metadata.dat` 才包含大部分游戏逻辑。这里应维护命名后的 patch point、地址/签名和校验，而不是依赖 JADX。
4. **原始二进制关键资源**：保留原始 `AndroidManifest.xml` / `resources.arsc`，用于发现 apktool round-trip 是否造成无关变化。

## 当前已知客户端补丁面

现有 `tools/apk-patcher/apk-patcher.pyw` 已经表明客户端至少包含两类可维护补丁：

- `classes.dex`：替换 `OverrideActivity.smali`，用于刷新率相关行为。
- `lib/arm64-v8a/libil2cpp.so`：通过固定 ARM64 地址修改分辨率和多个场景帧率常量。

现有 patcher 有意使用 `apktool d -r` 避免重编码资源，并严格验证除 `classes.dex` 与 `libil2cpp.so` 外的 APK payload 不发生变化。这种“最小差分补丁”策略应继续保留。

## 自动提取

分支中的工作流：

```text
.github/workflows/extract-zh-fixed-client.yml
```

会：

1. 从仓库最新 Release 下载 `mltd-relive-game-client-zh-fixed.apk`；
2. 用 `release/game-client.env` 的 `ZH_SHA256` 校验输入；
3. 使用与现有 patcher 相同的 Apktool `2.12.1` 生成 smali/资源视图；
4. 使用 JADX `1.5.6` 生成阅读视图；
5. 输出 APK entry、DEX、ABI、IL2CPP、ELF、global-metadata、网络字符串等报告；
6. 尝试 apktool baseline rebuild，并记录是否成功；
7. 生成完整 `tar.zst` artifact 与较小的 report artifact。

也可本地执行：

```bash
chmod +x tools/client-source/extract-zh-fixed.sh
tools/client-source/extract-zh-fixed.sh /path/to/mltd-relive-game-client-zh-fixed.apk
```

## 为什么暂时不把全部反编译文件直接提交到 `main`

完整 APK 的 apktool + JADX 输出会产生大量文件，并包含体积很大的 native/Unity 资源。先以 Actions artifact 生成和检查真实结果，更容易判断：

- 哪些 Java/smali 包确实与服务器协议有关；
- 哪些资源需要纳入长期版本控制；
- 是否值得把 `libil2cpp.so` / metadata 放 Git LFS；
- 哪些改动应该转成声明式 patch，而不是提交整份二进制或反编译树。

建议最终主仓库长期维护的是：

```text
client/
  README.md
  baseline/
    hashes.json
    package-info.json
  android/
    smali-patches/
    manifest-patches/
  il2cpp/
    patch-points.yml
    signatures/
    notes/
  tools/
    extract
    analyze
    build
    verify
```

完整 JADX/apktool tree 可以继续作为按版本生成的 artifact，或者单独放到专用 reverse-engineering 分支/仓库。

## 下一步

拿到第一次 Actions 产物后，优先处理：

1. 搜索全部 API / asset / web host 与证书相关字符串；
2. 对 `zh-fixed.apk` 与能取得的原始繁中 APK 做文件级和 native 级 diff，反推出“Android 12L fixed”到底改了什么；
3. 对 `libil2cpp.so` + `global-metadata.dat` 跑 IL2CPP metadata 恢复工具，建立方法名到 native RVA 的映射；
4. 把现有分辨率/帧率固定 offset 改为带原始指令校验的 patch point，避免错误版本静默打坏客户端；
5. 把后续服务端需要客户端协同修改的内容收敛成声明式 patch 集，由 CI 从固定基线 APK 自动构建 Release 客户端。
