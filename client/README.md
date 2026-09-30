# 客户端维护资料

本目录保存繁体中文修正版客户端的小型基线资料，供维护服务端协议和画面补丁时核对。普通用户无需操作这些文件，安装与连接方法见[项目说明](../README.md)。

## 保留的资料

| 路径 | 用途 |
| --- | --- |
| [baseline/zh-fixed-v1.json](baseline/zh-fixed-v1.json) | APK、原生库和元数据的校验值，以及包名、版本和提取工具记录。 |
| [android/smali/](android/smali/) | Android 外壳类的基线代码片段，供比较修改前后的行为。 |
| [contract/rpc-methods-zh-fixed-v1.txt](contract/rpc-methods-zh-fixed-v1.txt) | 从客户端恢复的接口名称清单。它包含字符串常量，不能直接当作实际调用清单或功能完成率。 |
| [il2cpp/patch-points.yml](il2cpp/patch-points.yml) | 绑定到特定原生库校验值和原始字节的画面补丁位置。 |

实际画面补丁工具在 [tools/apk-patcher/](../tools/apk-patcher/)，使用自身的代码与资源；这里的基线片段不是替代它的构建入口。客户端版本变化后，应重新核对原始文件和补丁位置，不能直接套用旧偏移。

历史完整生成结果仍保留在 [`client-decompiled-zh-fixed-v1`](https://github.com/kohakunamori/mltd-relive/tree/client-decompiled-zh-fixed-v1) 分支。本次仓库整理不改动该分支，也不重写 Git 历史。

## 本地提取

在具备 Java、.NET 和脚本所需命令的 Linux / WSL 环境中，从仓库根目录执行。工具会按脚本中的版本下载提取依赖，因此该步骤需要网络。

**提取会重建输出目录。** 请使用专门的生成目录，不要指定仓库根目录、存档目录或已有资料目录。

```bash
bash tools/client-source/extract-zh-fixed.sh \
  /path/to/mltd-relive-game-client-zh-fixed.apk \
  client-source-output

bash tools/client-source/extract-il2cpp.sh client-source-output

python tools/client-source/compare-server-contract.py \
  client-source-output/report/client-rpc-methods.txt \
  standalone/mltd/services \
  client-source-output/report
```

输入 APK 的校验值见基线文件，发布用客户端来源与校验值由 [release/game-client.env](../release/game-client.env) 管理。`client-source-output/` 是本地生成物，已被 Git 忽略。

不重新提取 APK、只比较现有接口清单时，可以执行：

```bash
python tools/client-source/compare-server-contract.py \
  client/contract/rpc-methods-zh-fixed-v1.txt \
  standalone/mltd/services \
  contract-report
```

输出在被忽略的 `contract-report/` 中。比较结果只反映脚本可静态识别的接口名称差异，不等同于运行时全部注册项或客户端流程测试。

## 如何使用生成结果

`apktool/` 用于检查 Android 资源和 smali，`jadx/` 提供便于阅读的 Java 视图，`il2cpp-dump/` 保存类型、方法签名、地址和元数据映射。它们不等同于原始 Unity 工程，`dump.cs` 也不包含恢复后的完整 C# 方法实现。

需要确认具体游戏逻辑时，结合原生库与方法地址分析；修改服务端后，用 `tests/` 中相应测试检查，再区分记录接口结果和安卓客户端实际流程结果。

更新客户端基线时，保留旧基线的身份，使用新的基线编号，重新生成并比较校验值、接口和补丁位置。不要手工修改历史生成分支来代替维护源码和脚本。
