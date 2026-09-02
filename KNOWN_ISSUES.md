# 当前已知兼容性问题与排查记录

> 最后更新：2026-09-02
>
> 本文记录当前 `kohakunamori/mltd-relive` 与繁中修正版 Android 客户端之间已经复现的问题、已完成的 A/B 验证、当前判断以及下一步排查顺序。目的是避免后续调试重复回到已经排除的方向。

## 当前测试基线

- Server：`kohakunamori/mltd-relive` `main` / Standalone v0.1.9 及其后续 main 改动。
- Client：`mltd-relive-game-client-zh-fixed.apk`。
- 该 APK 与 `yuyueryuyu/mltd-relive` README 中“电脑运行服务器”所指定的繁中 Android 12L+ 修正版客户端来源相同。
- Client API 基址仍为 `https://theaterdays-zh.appspot.com/`。
- `yuyueryuyu/mltd-relive` 没有为其新增 Theater / Job / Idol Detail 功能提供另一套专用 APK。
- `yuyueryuyu/mltd-relive` 也没有提供新的 Theater 专用 Asset CDN；其 `AssetService.GetAssetVersion` 仍返回 `https://assets.rainbowunicorn7297.com/zh-android/`。

因此目前不应再把问题优先归因于“客户端只能对应 RainbowUnicorn 原版 Server、不能对应 yuyu Server”。

---

## Issue 1：Hybrid Asset 模式登录时报 `ErrorCode [-404 / 0]`

### 现象

使用当前修正版繁中 APK：

- `asset_mode = hybrid`：登录阶段出现“連線失敗 / ErrorCode [-404 / 0]”。
- `asset_mode = remote`：可以正常通过登录并进入游戏。

这是目前最有价值的 A/B 结果。

### 已知客户端信息

对实际 Release APK 的静态检查发现客户端包含：

```text
[AssetBundle] NotFoundError(-404)
```

因此 `-404` 很可能是客户端 AssetBundle 层的 NotFound，而不是 `AuthService.Login` 返回 HTTP 404。

### 与 yuyu Server 的差异

`yuyueryuyu/mltd-relive` 的 AssetService 在繁中 Android 上直接返回：

```text
https://assets.rainbowunicorn7297.com/zh-android/
```

而当前 fork 的 hybrid 模式返回本地 TLS/API hostname 下的 Asset 路径，大致为：

```text
https://theaterdays-zh.appspot.com/__mltd_assets/zh-android/
```

随后由本地 `AssetHTTPRequestHandler` / `AssetMirror` 处理 cache miss，再向 RainbowUnicorn CDN 拉取。

因此 `remote` 能登录而 `hybrid` 不能登录，已经把问题范围显著缩小到：

**当前 hybrid/local Asset 路由、路径映射、缓存或响应兼容层，以及它与客户端新增 Theater 资源请求之间的交互。**

### Theater 与登录阶段的关系

`yuyueryuyu/mltd-relive` 新增的 Theater contact 实现会在 `TheaterService.GetTheater` 中返回真实 `resource_id`，例如：

```text
theater_001har
theater_002chi
theater_003mik
...
```

`TheaterService.GetTheater` 本身就是登录后的初始化链路之一，所以客户端可能在“仍显示登录过程”时已经开始加载 Theater AssetBundle。

这解释了为什么 UI 看起来像 `AuthService.Login` 失败，但真正失败点可能已经进入 Theater Asset 加载。

### 已排除 / 降低优先级的方向

1. **“yuyu Server 需要另一版 APK”**：基本排除。
2. **`AuthService.Login` 被移植改坏**：低优先级。当前 fork 与 yuyu 的 Auth/Login 代码没有观察到与该问题匹配的分叉。
3. **v0.1.8 的 TLS worker-handshake 问题**：v0.1.9 已恢复 listener-wrapped TLS；remote 模式能成功登录也进一步降低了 TLS 作为当前 `-404` 主因的可能性。

### 下一步应做的验证

优先对 hybrid 模式增加游戏侧 Asset 请求诊断，至少记录：

- 请求 method（GET / HEAD）
- 原始 path
- 解析后的 language / platform / object name
- local cache hit / miss
- upstream URL
- upstream HTTP status
- 最终返回给客户端的 HTTP status
- Range / Content-Range
- Content-Length
- ETag / Last-Modified（如有）

目标是直接抓到**第一个导致登录失败的 Asset 请求及其 object name**，不要再通过 UI 错误码猜测。

还需要检查当前 Asset 路由是否错误假设所有 object 都是单层文件名。`_safe_component()` 当前拒绝 `/` 和 `\\`；如果客户端实际存在带子路径的 Asset 请求，这一设计会直接导致本地 mirror 无法完全模拟原 CDN。

---

## Issue 2：Remote 模式可登录，但演唱会功能似乎不能正确运作

### 当前状态

该问题与 hybrid 登录 `-404` 应视为**两个独立问题**。

目前只有现象“remote 可以正常登录，但演唱会似乎无法正确运作”，尚未记录完整失败步骤、客户端错误码或具体失败 RPC。因此现在不能把根因直接定为某一个 LiveService 方法。

### 已完成的代码对比

`standalone/mltd/services/live.py`：

- 当前 `kohakunamori/mltd-relive/main`
- `yuyueryuyu/mltd-relive/main`

两者 blob SHA 相同：

```text
64aa18d8fa543fdd072508cb4c67f7458560b9b8
```

因此以下 LiveService 逻辑并不是本 fork 后续性能优化时重新实现的：

- `LiveService.GetRandomLive`
- `LiveService.StartSong`
- `LiveService.FinishSong`
- `LiveService.BreakSong`
- 以及同文件内其它 Live 相关服务

数据库初始化 `standalone/mltd/models/setup.py` 也与 yuyu 版本保持相同 blob（当前观察为 `2454c126...`）。

所以当前不应优先修改 `live.py`。

### 当前高优先级嫌疑：API transport 语义变化

`yuyueryuyu/mltd-relive` 原始 Proxy 行为：

```text
HTTPServer（单线程）
TLS listener wrap
每个 API 请求转发到 localhost API
close_connection = True
响应明确 Connection: close
```

当前 fork 为性能优化后变成：

```text
ThreadingHTTPServer
TLS listener wrap
HTTP/1.1
API direct WSGI dispatch
默认允许 keep-alive
API 请求可并发执行
TCP_NODELAY / keepalive / backlog 优化
```

其中 v0.1.9 已经修复了 TLS handshake 模型，但**没有恢复原 Server 的“每个 API 请求后关闭连接”语义，也没有恢复 API 串行执行语义**。

演唱会会触发一系列强状态相关 RPC，例如：

```text
GetRandomLive / GetRandomGuestList
        ↓
StartSong
        ↓
创建 PendingSong / 扣除资源
        ↓
FinishSong 或 BreakSong
        ↓
更新 Song / Mission / Idol / Item / Reward / PendingSong
        ↓
后续 BatchRequest
```

如果 corrected client 或服务端状态实现隐含依赖原来的请求顺序，HTTP keep-alive + 并发 dispatch 可能改变时序，尤其涉及 SQLite 写入时。

目前这是演唱会异常的主要排查方向，但**尚未通过 A/B 验证定案**。

### 推荐 A/B 顺序

#### A. 只恢复 API `Connection: close`

保持：

- `ThreadingHTTPServer`
- listener-wrapped TLS
- direct WSGI
- TCP_NODELAY
- backlog 512
- Asset GET/HEAD 高并发

只让 API POST：

```text
close_connection = True
Connection: close
```

如果 Live 恢复，则说明客户端/API 连接复用存在兼容性问题。

#### B. API POST 串行化

若 A 无效，则保持 Asset 高并发，只给 API POST 加全局 compatibility lock：

```text
Asset GET/HEAD -> 继续并发
API POST       -> 串行执行
```

这样可以验证 Live 状态机是否依赖原 Server 的严格请求顺序，同时不会牺牲大文件 Asset 传输并发。

#### C. 恢复 localhost HTTP hop

若 A/B 均无效，再把 API 从 direct WSGI 临时切回：

```text
TLS Proxy
   ↓
localhost:7650 HTTP API
```

用于验证 direct WSGI 构造的 environ / header / connection 行为是否与旧 Server 有细微差异。

只有上述 transport A/B 都失败后，才应该重新深入 `LiveService` 业务返回结构。

---

## 当前推荐架构方向

长期不建议为了兼容客户端直接回退全部性能优化。

更合理的目标是把两条数据面分开：

```text
API POST
  -> 保留 corrected client 所需的兼容连接/顺序语义
  -> 请求体较小，性能损失可接受

Asset GET/HEAD
  -> 高并发
  -> keep-alive
  -> Range
  -> 本地缓存 / hybrid fetch-on-miss
  -> 大文件高速传输
```

即：**API compatibility transport + high-performance Asset transport**。

---

## 后续调试时不要重复做的事情

在出现新证据前，不要优先：

- 再更换 APK 版本来解决 yuyu Theater 兼容问题；
- 把 `AuthService.Login` 当作 `-404/0` 的直接来源；
- 再次把 v0.1.8 worker TLS handshake 当作当前主要问题；
- 在没有 transport A/B 结果前重写 `LiveService`；
- 在没有记录具体 404 Asset object name 前盲目修改 Theater master data。

下一轮应先获取**精确失败请求**，再修改代码。
