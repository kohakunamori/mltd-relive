.class final Lextern/okhttp3/RealCall;
.super Ljava/lang/Object;
.source "RealCall.java"

# interfaces
.implements Lextern/okhttp3/Call;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/RealCall$AsyncCall;
    }
.end annotation


# instance fields
.field final client:Lextern/okhttp3/OkHttpClient;

.field private eventListener:Lextern/okhttp3/EventListener;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field private executed:Z

.field final forWebSocket:Z

.field final originalRequest:Lextern/okhttp3/Request;

.field final retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

.field final timeout:Lextern/okio/AsyncTimeout;


# direct methods
.method private constructor <init>(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)V
    .locals 2

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    iput-object p1, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    .line 62
    iput-object p2, p0, Lextern/okhttp3/RealCall;->originalRequest:Lextern/okhttp3/Request;

    .line 63
    iput-boolean p3, p0, Lextern/okhttp3/RealCall;->forWebSocket:Z

    .line 64
    new-instance p2, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-direct {p2, p1, p3}, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;-><init>(Lextern/okhttp3/OkHttpClient;Z)V

    iput-object p2, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    .line 65
    new-instance p2, Lextern/okhttp3/RealCall$1;

    invoke-direct {p2, p0}, Lextern/okhttp3/RealCall$1;-><init>(Lextern/okhttp3/RealCall;)V

    iput-object p2, p0, Lextern/okhttp3/RealCall;->timeout:Lextern/okio/AsyncTimeout;

    .line 70
    iget-object p2, p0, Lextern/okhttp3/RealCall;->timeout:Lextern/okio/AsyncTimeout;

    invoke-virtual {p1}, Lextern/okhttp3/OkHttpClient;->callTimeoutMillis()I

    move-result p1

    int-to-long v0, p1

    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p2, v0, v1, p1}, Lextern/okio/AsyncTimeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lextern/okio/Timeout;

    return-void
.end method

.method static synthetic access$000(Lextern/okhttp3/RealCall;)Lextern/okhttp3/EventListener;
    .locals 0

    .line 42
    iget-object p0, p0, Lextern/okhttp3/RealCall;->eventListener:Lextern/okhttp3/EventListener;

    return-object p0
.end method

.method private captureCallStackTrace()V
    .locals 2

    .line 117
    invoke-static {}, Lextern/okhttp3/internal/platform/Platform;->get()Lextern/okhttp3/internal/platform/Platform;

    move-result-object v0

    const-string v1, "response.body().close()"

    invoke-virtual {v0, v1}, Lextern/okhttp3/internal/platform/Platform;->getStackTraceForCloseable(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 118
    iget-object v1, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-virtual {v1, v0}, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;->setCallStackTrace(Ljava/lang/Object;)V

    return-void
.end method

.method static newRealCall(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)Lextern/okhttp3/RealCall;
    .locals 1

    .line 75
    new-instance v0, Lextern/okhttp3/RealCall;

    invoke-direct {v0, p0, p1, p2}, Lextern/okhttp3/RealCall;-><init>(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)V

    .line 76
    invoke-virtual {p0}, Lextern/okhttp3/OkHttpClient;->eventListenerFactory()Lextern/okhttp3/EventListener$Factory;

    move-result-object p0

    invoke-interface {p0, v0}, Lextern/okhttp3/EventListener$Factory;->create(Lextern/okhttp3/Call;)Lextern/okhttp3/EventListener;

    move-result-object p0

    iput-object p0, v0, Lextern/okhttp3/RealCall;->eventListener:Lextern/okhttp3/EventListener;

    return-object v0
.end method


# virtual methods
.method public cancel()V
    .locals 1

    .line 132
    iget-object v0, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-virtual {v0}, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;->cancel()V

    return-void
.end method

.method public bridge synthetic clone()Lextern/okhttp3/Call;
    .locals 1

    .line 42
    invoke-virtual {p0}, Lextern/okhttp3/RealCall;->clone()Lextern/okhttp3/RealCall;

    move-result-object v0

    return-object v0
.end method

.method public clone()Lextern/okhttp3/RealCall;
    .locals 3

    .line 149
    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    iget-object v1, p0, Lextern/okhttp3/RealCall;->originalRequest:Lextern/okhttp3/Request;

    iget-boolean v2, p0, Lextern/okhttp3/RealCall;->forWebSocket:Z

    invoke-static {v0, v1, v2}, Lextern/okhttp3/RealCall;->newRealCall(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)Lextern/okhttp3/RealCall;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic clone()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/CloneNotSupportedException;
        }
    .end annotation

    .line 42
    invoke-virtual {p0}, Lextern/okhttp3/RealCall;->clone()Lextern/okhttp3/RealCall;

    move-result-object v0

    return-object v0
.end method

.method public enqueue(Lextern/okhttp3/Callback;)V
    .locals 2

    .line 122
    monitor-enter p0

    .line 123
    :try_start_0
    iget-boolean v0, p0, Lextern/okhttp3/RealCall;->executed:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    .line 124
    iput-boolean v0, p0, Lextern/okhttp3/RealCall;->executed:Z

    .line 125
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 126
    invoke-direct {p0}, Lextern/okhttp3/RealCall;->captureCallStackTrace()V

    .line 127
    iget-object v0, p0, Lextern/okhttp3/RealCall;->eventListener:Lextern/okhttp3/EventListener;

    invoke-virtual {v0, p0}, Lextern/okhttp3/EventListener;->callStart(Lextern/okhttp3/Call;)V

    .line 128
    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->dispatcher()Lextern/okhttp3/Dispatcher;

    move-result-object v0

    new-instance v1, Lextern/okhttp3/RealCall$AsyncCall;

    invoke-direct {v1, p0, p1}, Lextern/okhttp3/RealCall$AsyncCall;-><init>(Lextern/okhttp3/RealCall;Lextern/okhttp3/Callback;)V

    invoke-virtual {v0, v1}, Lextern/okhttp3/Dispatcher;->enqueue(Lextern/okhttp3/RealCall$AsyncCall;)V

    return-void

    .line 123
    :cond_0
    :try_start_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Already Executed"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    .line 125
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public execute()Lextern/okhttp3/Response;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 85
    monitor-enter p0

    .line 86
    :try_start_0
    iget-boolean v0, p0, Lextern/okhttp3/RealCall;->executed:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    .line 87
    iput-boolean v0, p0, Lextern/okhttp3/RealCall;->executed:Z

    .line 88
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 89
    invoke-direct {p0}, Lextern/okhttp3/RealCall;->captureCallStackTrace()V

    .line 90
    iget-object v0, p0, Lextern/okhttp3/RealCall;->timeout:Lextern/okio/AsyncTimeout;

    invoke-virtual {v0}, Lextern/okio/AsyncTimeout;->enter()V

    .line 91
    iget-object v0, p0, Lextern/okhttp3/RealCall;->eventListener:Lextern/okhttp3/EventListener;

    invoke-virtual {v0, p0}, Lextern/okhttp3/EventListener;->callStart(Lextern/okhttp3/Call;)V

    .line 93
    :try_start_1
    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->dispatcher()Lextern/okhttp3/Dispatcher;

    move-result-object v0

    invoke-virtual {v0, p0}, Lextern/okhttp3/Dispatcher;->executed(Lextern/okhttp3/RealCall;)V

    .line 94
    invoke-virtual {p0}, Lextern/okhttp3/RealCall;->getResponseWithInterceptorChain()Lextern/okhttp3/Response;

    move-result-object v0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v0, :cond_0

    .line 102
    iget-object v1, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v1}, Lextern/okhttp3/OkHttpClient;->dispatcher()Lextern/okhttp3/Dispatcher;

    move-result-object v1

    invoke-virtual {v1, p0}, Lextern/okhttp3/Dispatcher;->finished(Lextern/okhttp3/RealCall;)V

    return-object v0

    .line 95
    :cond_0
    :try_start_2
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Canceled"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :catchall_0
    move-exception v0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 98
    :try_start_3
    invoke-virtual {p0, v0}, Lextern/okhttp3/RealCall;->timeoutExit(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object v0

    .line 99
    iget-object v1, p0, Lextern/okhttp3/RealCall;->eventListener:Lextern/okhttp3/EventListener;

    invoke-virtual {v1, p0, v0}, Lextern/okhttp3/EventListener;->callFailed(Lextern/okhttp3/Call;Ljava/io/IOException;)V

    .line 100
    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 102
    :goto_0
    iget-object v1, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v1}, Lextern/okhttp3/OkHttpClient;->dispatcher()Lextern/okhttp3/Dispatcher;

    move-result-object v1

    invoke-virtual {v1, p0}, Lextern/okhttp3/Dispatcher;->finished(Lextern/okhttp3/RealCall;)V

    throw v0

    .line 86
    :cond_1
    :try_start_4
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Already Executed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :catchall_1
    move-exception v0

    .line 88
    monitor-exit p0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw v0
.end method

.method getResponseWithInterceptorChain()Lextern/okhttp3/Response;
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 243
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 244
    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->interceptors()Ljava/util/List;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 245
    iget-object v0, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 246
    new-instance v0, Lextern/okhttp3/internal/http/BridgeInterceptor;

    iget-object v2, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v2}, Lextern/okhttp3/OkHttpClient;->cookieJar()Lextern/okhttp3/CookieJar;

    move-result-object v2

    invoke-direct {v0, v2}, Lextern/okhttp3/internal/http/BridgeInterceptor;-><init>(Lextern/okhttp3/CookieJar;)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 247
    new-instance v0, Lextern/okhttp3/internal/cache/CacheInterceptor;

    iget-object v2, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v2}, Lextern/okhttp3/OkHttpClient;->internalCache()Lextern/okhttp3/internal/cache/InternalCache;

    move-result-object v2

    invoke-direct {v0, v2}, Lextern/okhttp3/internal/cache/CacheInterceptor;-><init>(Lextern/okhttp3/internal/cache/InternalCache;)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 248
    new-instance v0, Lextern/okhttp3/internal/connection/ConnectInterceptor;

    iget-object v2, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-direct {v0, v2}, Lextern/okhttp3/internal/connection/ConnectInterceptor;-><init>(Lextern/okhttp3/OkHttpClient;)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 249
    iget-boolean v0, p0, Lextern/okhttp3/RealCall;->forWebSocket:Z

    if-nez v0, :cond_0

    .line 250
    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->networkInterceptors()Ljava/util/List;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 252
    :cond_0
    new-instance v0, Lextern/okhttp3/internal/http/CallServerInterceptor;

    iget-boolean v2, p0, Lextern/okhttp3/RealCall;->forWebSocket:Z

    invoke-direct {v0, v2}, Lextern/okhttp3/internal/http/CallServerInterceptor;-><init>(Z)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 254
    new-instance v12, Lextern/okhttp3/internal/http/RealInterceptorChain;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    iget-object v6, p0, Lextern/okhttp3/RealCall;->originalRequest:Lextern/okhttp3/Request;

    iget-object v8, p0, Lextern/okhttp3/RealCall;->eventListener:Lextern/okhttp3/EventListener;

    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    .line 255
    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->connectTimeoutMillis()I

    move-result v9

    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    .line 256
    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->readTimeoutMillis()I

    move-result v10

    iget-object v0, p0, Lextern/okhttp3/RealCall;->client:Lextern/okhttp3/OkHttpClient;

    invoke-virtual {v0}, Lextern/okhttp3/OkHttpClient;->writeTimeoutMillis()I

    move-result v11

    move-object v0, v12

    move-object v7, p0

    invoke-direct/range {v0 .. v11}, Lextern/okhttp3/internal/http/RealInterceptorChain;-><init>(Ljava/util/List;Lextern/okhttp3/internal/connection/StreamAllocation;Lextern/okhttp3/internal/http/HttpCodec;Lextern/okhttp3/internal/connection/RealConnection;ILextern/okhttp3/Request;Lextern/okhttp3/Call;Lextern/okhttp3/EventListener;III)V

    .line 258
    iget-object v0, p0, Lextern/okhttp3/RealCall;->originalRequest:Lextern/okhttp3/Request;

    invoke-interface {v12, v0}, Lextern/okhttp3/Interceptor$Chain;->proceed(Lextern/okhttp3/Request;)Lextern/okhttp3/Response;

    move-result-object v0

    .line 259
    iget-object v1, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-virtual {v1}, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;->isCanceled()Z

    move-result v1

    if-nez v1, :cond_1

    return-object v0

    .line 260
    :cond_1
    invoke-static {v0}, Lextern/okhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 261
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Canceled"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public isCanceled()Z
    .locals 1

    .line 144
    iget-object v0, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-virtual {v0}, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;->isCanceled()Z

    move-result v0

    return v0
.end method

.method public declared-synchronized isExecuted()Z
    .locals 1

    monitor-enter p0

    .line 140
    :try_start_0
    iget-boolean v0, p0, Lextern/okhttp3/RealCall;->executed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method redactedUrl()Ljava/lang/String;
    .locals 1

    .line 238
    iget-object v0, p0, Lextern/okhttp3/RealCall;->originalRequest:Lextern/okhttp3/Request;

    invoke-virtual {v0}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object v0

    invoke-virtual {v0}, Lextern/okhttp3/HttpUrl;->redact()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public request()Lextern/okhttp3/Request;
    .locals 1

    .line 81
    iget-object v0, p0, Lextern/okhttp3/RealCall;->originalRequest:Lextern/okhttp3/Request;

    return-object v0
.end method

.method streamAllocation()Lextern/okhttp3/internal/connection/StreamAllocation;
    .locals 1

    .line 153
    iget-object v0, p0, Lextern/okhttp3/RealCall;->retryAndFollowUpInterceptor:Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;

    invoke-virtual {v0}, Lextern/okhttp3/internal/http/RetryAndFollowUpInterceptor;->streamAllocation()Lextern/okhttp3/internal/connection/StreamAllocation;

    move-result-object v0

    return-object v0
.end method

.method public timeout()Lextern/okio/Timeout;
    .locals 1

    .line 136
    iget-object v0, p0, Lextern/okhttp3/RealCall;->timeout:Lextern/okio/AsyncTimeout;

    return-object v0
.end method

.method timeoutExit(Ljava/io/IOException;)Ljava/io/IOException;
    .locals 2
    .param p1    # Ljava/io/IOException;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 107
    iget-object v0, p0, Lextern/okhttp3/RealCall;->timeout:Lextern/okio/AsyncTimeout;

    invoke-virtual {v0}, Lextern/okio/AsyncTimeout;->exit()Z

    move-result v0

    if-nez v0, :cond_0

    return-object p1

    .line 109
    :cond_0
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v1, "timeout"

    invoke-direct {v0, v1}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    if-eqz p1, :cond_1

    .line 111
    invoke-virtual {v0, p1}, Ljava/io/InterruptedIOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    :cond_1
    return-object v0
.end method

.method toLoggableString()Ljava/lang/String;
    .locals 2

    .line 232
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lextern/okhttp3/RealCall;->isCanceled()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "canceled "

    goto :goto_0

    :cond_0
    const-string v1, ""

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 233
    iget-boolean v1, p0, Lextern/okhttp3/RealCall;->forWebSocket:Z

    if-eqz v1, :cond_1

    const-string v1, "web socket"

    goto :goto_1

    :cond_1
    const-string v1, "call"

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " to "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 234
    invoke-virtual {p0}, Lextern/okhttp3/RealCall;->redactedUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
