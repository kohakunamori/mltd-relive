# mltd-relive 更新记录

下载与首次使用请查看[最新发布页](https://github.com/kohakunamori/mltd-relive/releases/tag/standalone-latest)，配置和账户说明见 [README](README.md)，当前限制见[已知问题](KNOWN_ISSUES.md)。发布附件按需更新，以发布页的构建编号为准。

## v0.1.11

- 支持多个独立账户，可在服务器界面的用户管理窗口创建用户，再通过客户端标题画面的“密码继承 / 引继”登录。
- 内置 DNS 改为单独启停；使用它连接客户端时，需要另外点击 `Start DNS Server`。
- 增加手动检查更新与打开下载页的入口，不会在启动服务器时自动检查或下载。
- Ubuntu 程序补齐 Tcl/Tk 运行库，并随程序提供第三方许可说明文件。
- 继续修复剧情、任务、个人资料、体力、好友、工作和服装等功能的兼容问题。

升级前完全退出服务器并备份原运行目录，保留 `mltd-relive.db` 与 `config.ini`，不要点击 `Reset Data`。

## v0.1.10

- 资源下载统一为远端 HTTPS，移除不兼容的 `hybrid/local` 运行方式。旧配置中的模式会迁移到 `remote`；可通过 `asset_remote_url` 指定其他可用的 HTTPS 资源地址。
- 新增独立资源保存工具 `tools/cache_assets.py`，支持断点续传和完整性校验。缓存不会由服务器自动提供给客户端，使用方法见 [ASSET_CACHE.md](ASSET_CACHE.md)。
- 修复 `UnitService.SetUnit` 的 SQLAlchemy 结果转换错误，解决对应演唱会入口异常。回归测试见 `tests/test_unit_sqlalchemy_compat.py`。
- 保留修正版客户端需要的 TLS 接入方式，恢复 HTTP/1.1 长连接和并发请求处理，移除排障期间的全局串行锁与强制断连措施。
- 继续使用繁体中文和韩文修正版客户端；不需要为资源传输方式的变化重新修改 APK。

## 维护调整

发布页改为中文下载与使用指南。构建、发布和验证均按需手动执行；当前仅保留 `ci.yml` 与 `build-and-release.yml` 两个工作流入口。

阶段性交接、旧实验报告和过时工具已从主分支移除。客户端基线与可复用维护命令集中在 [client/README.md](client/README.md)，历史材料可从 Git 提交记录查阅。文档和目录整理不会单独重新发布程序附件。
