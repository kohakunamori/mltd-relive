.class public abstract Lextern/okhttp3/internal/Internal;
.super Ljava/lang/Object;
.source "Internal.java"


# static fields
.field public static instance:Lextern/okhttp3/internal/Internal;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static initializeInstanceForTests()V
    .locals 1

    .line 45
    new-instance v0, Lextern/okhttp3/OkHttpClient;

    invoke-direct {v0}, Lextern/okhttp3/OkHttpClient;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract addLenient(Lextern/okhttp3/Headers$Builder;Ljava/lang/String;)V
.end method

.method public abstract addLenient(Lextern/okhttp3/Headers$Builder;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public abstract apply(Lextern/okhttp3/ConnectionSpec;Ljavax/net/ssl/SSLSocket;Z)V
.end method

.method public abstract code(Lextern/okhttp3/Response$Builder;)I
.end method

.method public abstract connectionBecameIdle(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/internal/connection/RealConnection;)Z
.end method

.method public abstract deduplicate(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/Address;Lextern/okhttp3/internal/connection/StreamAllocation;)Ljava/net/Socket;
.end method

.method public abstract equalsNonHost(Lextern/okhttp3/Address;Lextern/okhttp3/Address;)Z
.end method

.method public abstract get(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/Address;Lextern/okhttp3/internal/connection/StreamAllocation;Lextern/okhttp3/Route;)Lextern/okhttp3/internal/connection/RealConnection;
.end method

.method public abstract isInvalidHttpUrlHost(Ljava/lang/IllegalArgumentException;)Z
.end method

.method public abstract newWebSocketCall(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;)Lextern/okhttp3/Call;
.end method

.method public abstract put(Lextern/okhttp3/ConnectionPool;Lextern/okhttp3/internal/connection/RealConnection;)V
.end method

.method public abstract routeDatabase(Lextern/okhttp3/ConnectionPool;)Lextern/okhttp3/internal/connection/RouteDatabase;
.end method

.method public abstract setCache(Lextern/okhttp3/OkHttpClient$Builder;Lextern/okhttp3/internal/cache/InternalCache;)V
.end method

.method public abstract streamAllocation(Lextern/okhttp3/Call;)Lextern/okhttp3/internal/connection/StreamAllocation;
.end method

.method public abstract timeoutExit(Lextern/okhttp3/Call;Ljava/io/IOException;)Ljava/io/IOException;
    .param p2    # Ljava/io/IOException;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end method
