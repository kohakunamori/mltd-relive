.class Lextern/okhttp3/OkHttpClient$1;
.super Lextern/okhttp3/internal/Internal;
.source "OkHttpClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/OkHttpClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 132
    invoke-direct {p0}, Lextern/okhttp3/internal/Internal;-><init>()V

    return-void
.end method


# virtual methods
.method public addLenient(Lextern/okhttp3/Headers$Builder;Ljava/lang/String;)V
    .locals 0

    .line 134
    invoke-virtual {p1, p2}, Lextern/okhttp3/Headers$Builder;->addLenient(Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    return-void
.end method

.method public addLenient(Lextern/okhttp3/Headers$Builder;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 138
    invoke-virtual {p1, p2, p3}, Lextern/okhttp3/Headers$Builder;->addLenient(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    return-void
.end method

.method public apply(Lextern/okhttp3/ConnectionSpec;Ljavax/net/ssl/SSLSocket;Z)V
    .locals 0

    .line 178
    invoke-virtual {p1, p2, p3}, Lextern/okhttp3/ConnectionSpec;->apply(Ljavax/net/ssl/SSLSocket;Z)V

    return-void
.end method

.method public code(Lextern/okhttp3/Response$Builder;)I
    .locals 0

    .line 173
    iget p1, p1, Lextern/okhttp3/Response$Builder;->code:I

    return p1
.end method

.method public connectionBecameIdle(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/internal/connection/RealConnection;)Z
    .locals 0

    .line 147
    invoke-virtual {p1, p2}, Lextern/okhttp3/ConnectionPool;->connectionBecameIdle(Lextern/okhttp3/internal/connection/RealConnection;)Z

    move-result p1

    return p1
.end method

.method public deduplicate(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/Address;Lextern/okhttp3/internal/connection/StreamAllocation;)Ljava/net/Socket;
    .locals 0

    .line 161
    invoke-virtual {p1, p2, p3}, Lextern/okhttp3/ConnectionPool;->deduplicate(Lextern/okhttp3/Address;Lextern/okhttp3/internal/connection/StreamAllocation;)Ljava/net/Socket;

    move-result-object p1

    return-object p1
.end method

.method public equalsNonHost(Lextern/okhttp3/Address;Lextern/okhttp3/Address;)Z
    .locals 0

    .line 156
    invoke-virtual {p1, p2}, Lextern/okhttp3/Address;->equalsNonHost(Lextern/okhttp3/Address;)Z

    move-result p1

    return p1
.end method

.method public get(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/Address;Lextern/okhttp3/internal/connection/StreamAllocation;Lextern/okhttp3/Route;)Lextern/okhttp3/internal/connection/RealConnection;
    .locals 0

    .line 152
    invoke-virtual {p1, p2, p3, p4}, Lextern/okhttp3/ConnectionPool;->get(Lextern/okhttp3/Address;Lextern/okhttp3/internal/connection/StreamAllocation;Lextern/okhttp3/Route;)Lextern/okhttp3/internal/connection/RealConnection;

    move-result-object p1

    return-object p1
.end method

.method public isInvalidHttpUrlHost(Ljava/lang/IllegalArgumentException;)Z
    .locals 1

    .line 182
    invoke-virtual {p1}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Invalid URL host"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public newWebSocketCall(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;)Lextern/okhttp3/Call;
    .locals 1

    const/4 v0, 0x1

    .line 194
    invoke-static {p1, p2, v0}, Lextern/okhttp3/RealCall;->newRealCall(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)Lextern/okhttp3/RealCall;

    move-result-object p1

    return-object p1
.end method

.method public put(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/internal/connection/RealConnection;)V
    .locals 0

    .line 165
    invoke-virtual {p1, p2}, Lextern/okhttp3/ConnectionPool;->put(Lextern/okhttp3/internal/connection/RealConnection;)V

    return-void
.end method

.method public routeDatabase(Lextern/okhttp3/ConnectionPool;)Lextern/okhttp3/internal/connection/RouteDatabase;
    .locals 0

    .line 169
    iget-object p1, p1, Lextern/okhttp3/ConnectionPool;->routeDatabase:Lextern/okhttp3/internal/connection/RouteDatabase;

    return-object p1
.end method

.method public setCache(Lextern/okhttp3/OkHttpClient$Builder;Lextern/okhttp3/internal/cache/InternalCache;)V
    .locals 0

    .line 142
    invoke-virtual {p1, p2}, Lextern/okhttp3/OkHttpClient$Builder;->setInternalCache(Lextern/okhttp3/internal/cache/InternalCache;)V

    return-void
.end method

.method public streamAllocation(Lextern/okhttp3/Call;)Lextern/okhttp3/internal/connection/StreamAllocation;
    .locals 0

    .line 186
    check-cast p1, Lextern/okhttp3/RealCall;

    invoke-virtual {p1}, Lextern/okhttp3/RealCall;->streamAllocation()Lextern/okhttp3/internal/connection/StreamAllocation;

    move-result-object p1

    return-object p1
.end method

.method public timeoutExit(Lextern/okhttp3/Call;Ljava/io/IOException;)Ljava/io/IOException;
    .locals 0
    .param p2    # Ljava/io/IOException;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 190
    check-cast p1, Lextern/okhttp3/RealCall;

    invoke-virtual {p1, p2}, Lextern/okhttp3/RealCall;->timeoutExit(Ljava/io/IOException;)Ljava/io/IOException;

    move-result-object p1

    return-object p1
.end method
