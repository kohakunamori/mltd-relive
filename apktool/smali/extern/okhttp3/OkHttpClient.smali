.class public Lextern/okhttp3/OkHttpClient;
.super Ljava/lang/Object;
.source "OkHttpClient.java"

# interfaces
.implements Lextern/okhttp3/Call$Factory;
.implements Lextern/okhttp3/WebSocket$Factory;
.implements Ljava/lang/Cloneable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/OkHttpClient$Builder;
    }
.end annotation


# static fields
.field static final DEFAULT_CONNECTION_SPECS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/ConnectionSpec;",
            ">;"
        }
    .end annotation
.end field

.field static final DEFAULT_PROTOCOLS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/Protocol;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field final authenticator:Lextern/okhttp3/Authenticator;

.field final cache:Lextern/okhttp3/Cache;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field final callTimeout:I

.field final certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

.field final certificatePinner:Lextern/okhttp3/CertificatePinner;

.field final connectTimeout:I

.field final connectionPool:Lextern/okhttp3/ConnectionPool;

.field final connectionSpecs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/ConnectionSpec;",
            ">;"
        }
    .end annotation
.end field

.field final cookieJar:Lextern/okhttp3/CookieJar;

.field final dispatcher:Lextern/okhttp3/Dispatcher;

.field final dns:Lextern/okhttp3/Dns;

.field final eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

.field final followRedirects:Z

.field final followSslRedirects:Z

.field final hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

.field final interceptors:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/Interceptor;",
            ">;"
        }
    .end annotation
.end field

.field final internalCache:Lextern/okhttp3/internal/cache/InternalCache;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field final networkInterceptors:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/Interceptor;",
            ">;"
        }
    .end annotation
.end field

.field final pingInterval:I

.field final protocols:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/Protocol;",
            ">;"
        }
    .end annotation
.end field

.field final proxy:Ljava/net/Proxy;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field final proxyAuthenticator:Lextern/okhttp3/Authenticator;

.field final proxySelector:Ljava/net/ProxySelector;

.field final readTimeout:I

.field final retryOnConnectionFailure:Z

.field final socketFactory:Ljavax/net/SocketFactory;

.field final sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

.field final writeTimeout:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const/4 v0, 0x2

    .line 125
    new-array v1, v0, [Lextern/okhttp3/Protocol;

    sget-object v2, Lextern/okhttp3/Protocol;->HTTP_2:Lextern/okhttp3/Protocol;

    const/4 v3, 0x0

    aput-object v2, v1, v3

    sget-object v2, Lextern/okhttp3/Protocol;->HTTP_1_1:Lextern/okhttp3/Protocol;

    const/4 v4, 0x1

    aput-object v2, v1, v4

    invoke-static {v1}, Lextern/okhttp3/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    sput-object v1, Lextern/okhttp3/OkHttpClient;->DEFAULT_PROTOCOLS:Ljava/util/List;

    .line 128
    new-array v0, v0, [Lextern/okhttp3/ConnectionSpec;

    sget-object v1, Lextern/okhttp3/ConnectionSpec;->MODERN_TLS:Lextern/okhttp3/ConnectionSpec;

    aput-object v1, v0, v3

    sget-object v1, Lextern/okhttp3/ConnectionSpec;->CLEARTEXT:Lextern/okhttp3/ConnectionSpec;

    aput-object v1, v0, v4

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lextern/okhttp3/OkHttpClient;->DEFAULT_CONNECTION_SPECS:Ljava/util/List;

    .line 132
    new-instance v0, Lextern/okhttp3/OkHttpClient$1;

    invoke-direct {v0}, Lextern/okhttp3/OkHttpClient$1;-><init>()V

    sput-object v0, Lextern/okhttp3/internal/Internal;->instance:Lextern/okhttp3/internal/Internal;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 229
    new-instance v0, Lextern/okhttp3/OkHttpClient$Builder;

    invoke-direct {v0}, Lextern/okhttp3/OkHttpClient$Builder;-><init>()V

    invoke-direct {p0, v0}, Lextern/okhttp3/OkHttpClient;-><init>(Lextern/okhttp3/OkHttpClient$Builder;)V

    return-void
.end method

.method constructor <init>(Lextern/okhttp3/OkHttpClient$Builder;)V
    .locals 4

    .line 232
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 233
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->dispatcher:Lextern/okhttp3/Dispatcher;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->dispatcher:Lextern/okhttp3/Dispatcher;

    .line 234
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->proxy:Ljava/net/Proxy;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->proxy:Ljava/net/Proxy;

    .line 235
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->protocols:Ljava/util/List;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->protocols:Ljava/util/List;

    .line 236
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->connectionSpecs:Ljava/util/List;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->connectionSpecs:Ljava/util/List;

    .line 237
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->interceptors:Ljava/util/List;

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->immutableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->interceptors:Ljava/util/List;

    .line 238
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->networkInterceptors:Ljava/util/List;

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->immutableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->networkInterceptors:Ljava/util/List;

    .line 239
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    .line 240
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->proxySelector:Ljava/net/ProxySelector;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->proxySelector:Ljava/net/ProxySelector;

    .line 241
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->cookieJar:Lextern/okhttp3/CookieJar;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->cookieJar:Lextern/okhttp3/CookieJar;

    .line 242
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->cache:Lextern/okhttp3/Cache;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->cache:Lextern/okhttp3/Cache;

    .line 243
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    .line 244
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->socketFactory:Ljavax/net/SocketFactory;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->socketFactory:Ljavax/net/SocketFactory;

    .line 247
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->connectionSpecs:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v1, 0x0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lextern/okhttp3/ConnectionSpec;

    if-nez v2, :cond_1

    .line 248
    invoke-virtual {v3}, Lextern/okhttp3/ConnectionSpec;->isTls()Z

    move-result v2

    if-eqz v2, :cond_0

    :cond_1
    const/4 v2, 0x1

    goto :goto_0

    .line 251
    :cond_2
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    if-nez v0, :cond_4

    if-nez v2, :cond_3

    goto :goto_1

    .line 255
    :cond_3
    invoke-static {}, Lextern/okhttp3/internal/Util;->platformTrustManager()Ljavax/net/ssl/X509TrustManager;

    move-result-object v0

    .line 256
    invoke-static {v0}, Lextern/okhttp3/OkHttpClient;->newSslSocketFactory(Ljavax/net/ssl/X509TrustManager;)Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    iput-object v1, p0, Lextern/okhttp3/OkHttpClient;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 257
    invoke-static {v0}, Lextern/okhttp3/internal/tls/CertificateChainCleaner;->get(Ljavax/net/ssl/X509TrustManager;)Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    goto :goto_2

    .line 252
    :cond_4
    :goto_1
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 253
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    .line 260
    :goto_2
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    if-eqz v0, :cond_5

    .line 261
    invoke-static {}, Lextern/okhttp3/internal/platform/Platform;->get()Lextern/okhttp3/internal/platform/Platform;

    move-result-object v0

    iget-object v1, p0, Lextern/okhttp3/OkHttpClient;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    invoke-virtual {v0, v1}, Lextern/okhttp3/internal/platform/Platform;->configureSslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 264
    :cond_5
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    .line 265
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    iget-object v1, p0, Lextern/okhttp3/OkHttpClient;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    invoke-virtual {v0, v1}, Lextern/okhttp3/CertificatePinner;->withCertificateChainCleaner(Lextern/okhttp3/internal/tls/CertificateChainCleaner;)Lextern/okhttp3/CertificatePinner;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    .line 267
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    .line 268
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->authenticator:Lextern/okhttp3/Authenticator;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->authenticator:Lextern/okhttp3/Authenticator;

    .line 269
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->connectionPool:Lextern/okhttp3/ConnectionPool;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->connectionPool:Lextern/okhttp3/ConnectionPool;

    .line 270
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->dns:Lextern/okhttp3/Dns;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient;->dns:Lextern/okhttp3/Dns;

    .line 271
    iget-boolean v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->followSslRedirects:Z

    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient;->followSslRedirects:Z

    .line 272
    iget-boolean v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->followRedirects:Z

    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient;->followRedirects:Z

    .line 273
    iget-boolean v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->retryOnConnectionFailure:Z

    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient;->retryOnConnectionFailure:Z

    .line 274
    iget v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->callTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient;->callTimeout:I

    .line 275
    iget v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->connectTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient;->connectTimeout:I

    .line 276
    iget v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->readTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient;->readTimeout:I

    .line 277
    iget v0, p1, Lextern/okhttp3/OkHttpClient$Builder;->writeTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient;->writeTimeout:I

    .line 278
    iget p1, p1, Lextern/okhttp3/OkHttpClient$Builder;->pingInterval:I

    iput p1, p0, Lextern/okhttp3/OkHttpClient;->pingInterval:I

    .line 280
    iget-object p1, p0, Lextern/okhttp3/OkHttpClient;->interceptors:Ljava/util/List;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_7

    .line 283
    iget-object p1, p0, Lextern/okhttp3/OkHttpClient;->networkInterceptors:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_6

    return-void

    .line 284
    :cond_6
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Null network interceptor: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lextern/okhttp3/OkHttpClient;->networkInterceptors:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 281
    :cond_7
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Null interceptor: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lextern/okhttp3/OkHttpClient;->interceptors:Ljava/util/List;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    goto :goto_4

    :goto_3
    throw p1

    :goto_4
    goto :goto_3
.end method

.method private static newSslSocketFactory(Ljavax/net/ssl/X509TrustManager;)Ljavax/net/ssl/SSLSocketFactory;
    .locals 3

    .line 290
    :try_start_0
    invoke-static {}, Lextern/okhttp3/internal/platform/Platform;->get()Lextern/okhttp3/internal/platform/Platform;

    move-result-object v0

    invoke-virtual {v0}, Lextern/okhttp3/internal/platform/Platform;->getSSLContext()Ljavax/net/ssl/SSLContext;

    move-result-object v0

    const/4 v1, 0x1

    .line 291
    new-array v1, v1, [Ljavax/net/ssl/TrustManager;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    const/4 p0, 0x0

    invoke-virtual {v0, p0, v1, p0}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 292
    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object p0
    :try_end_0
    .catch Ljava/security/GeneralSecurityException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    const-string v0, "No System TLS"

    .line 294
    invoke-static {v0, p0}, Lextern/okhttp3/internal/Util;->assertionError(Ljava/lang/String;Ljava/lang/Exception;)Ljava/lang/AssertionError;

    move-result-object p0

    throw p0
.end method


# virtual methods
.method public authenticator()Lextern/okhttp3/Authenticator;
    .locals 1

    .line 364
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->authenticator:Lextern/okhttp3/Authenticator;

    return-object v0
.end method

.method public cache()Lextern/okhttp3/Cache;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 336
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->cache:Lextern/okhttp3/Cache;

    return-object v0
.end method

.method public callTimeoutMillis()I
    .locals 1

    .line 300
    iget v0, p0, Lextern/okhttp3/OkHttpClient;->callTimeout:I

    return v0
.end method

.method public certificatePinner()Lextern/okhttp3/CertificatePinner;
    .locals 1

    .line 360
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    return-object v0
.end method

.method public connectTimeoutMillis()I
    .locals 1

    .line 305
    iget v0, p0, Lextern/okhttp3/OkHttpClient;->connectTimeout:I

    return v0
.end method

.method public connectionPool()Lextern/okhttp3/ConnectionPool;
    .locals 1

    .line 372
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->connectionPool:Lextern/okhttp3/ConnectionPool;

    return-object v0
.end method

.method public connectionSpecs()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lextern/okhttp3/ConnectionSpec;",
            ">;"
        }
    .end annotation

    .line 396
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->connectionSpecs:Ljava/util/List;

    return-object v0
.end method

.method public cookieJar()Lextern/okhttp3/CookieJar;
    .locals 1

    .line 332
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->cookieJar:Lextern/okhttp3/CookieJar;

    return-object v0
.end method

.method public dispatcher()Lextern/okhttp3/Dispatcher;
    .locals 1

    .line 388
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->dispatcher:Lextern/okhttp3/Dispatcher;

    return-object v0
.end method

.method public dns()Lextern/okhttp3/Dns;
    .locals 1

    .line 344
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->dns:Lextern/okhttp3/Dns;

    return-object v0
.end method

.method public eventListenerFactory()Lextern/okhttp3/EventListener$Factory;
    .locals 1

    .line 418
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    return-object v0
.end method

.method public followRedirects()Z
    .locals 1

    .line 380
    iget-boolean v0, p0, Lextern/okhttp3/OkHttpClient;->followRedirects:Z

    return v0
.end method

.method public followSslRedirects()Z
    .locals 1

    .line 376
    iget-boolean v0, p0, Lextern/okhttp3/OkHttpClient;->followSslRedirects:Z

    return v0
.end method

.method public hostnameVerifier()Ljavax/net/ssl/HostnameVerifier;
    .locals 1

    .line 356
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    return-object v0
.end method

.method public interceptors()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lextern/okhttp3/Interceptor;",
            ">;"
        }
    .end annotation

    .line 405
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->interceptors:Ljava/util/List;

    return-object v0
.end method

.method internalCache()Lextern/okhttp3/internal/cache/InternalCache;
    .locals 1

    .line 340
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->cache:Lextern/okhttp3/Cache;

    if-eqz v0, :cond_0

    iget-object v0, v0, Lextern/okhttp3/Cache;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    :goto_0
    return-object v0
.end method

.method public networkInterceptors()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lextern/okhttp3/Interceptor;",
            ">;"
        }
    .end annotation

    .line 414
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->networkInterceptors:Ljava/util/List;

    return-object v0
.end method

.method public newBuilder()Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    .line 438
    new-instance v0, Lextern/okhttp3/OkHttpClient$Builder;

    invoke-direct {v0, p0}, Lextern/okhttp3/OkHttpClient$Builder;-><init>(Lextern/okhttp3/OkHttpClient;)V

    return-object v0
.end method

.method public newCall(Lextern/okhttp3/Request;)Lextern/okhttp3/Call;
    .locals 1

    const/4 v0, 0x0

    .line 425
    invoke-static {p0, p1, v0}, Lextern/okhttp3/RealCall;->newRealCall(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Request;Z)Lextern/okhttp3/RealCall;

    move-result-object p1

    return-object p1
.end method

.method public newWebSocket(Lextern/okhttp3/Request;Lextern/okhttp3/WebSocketListener;)Lextern/okhttp3/WebSocket;
    .locals 7

    .line 432
    new-instance v6, Lextern/okhttp3/internal/ws/RealWebSocket;

    new-instance v3, Ljava/util/Random;

    invoke-direct {v3}, Ljava/util/Random;-><init>()V

    iget v0, p0, Lextern/okhttp3/OkHttpClient;->pingInterval:I

    int-to-long v4, v0

    move-object v0, v6

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lextern/okhttp3/internal/ws/RealWebSocket;-><init>(Lextern/okhttp3/Request;Lextern/okhttp3/WebSocketListener;Ljava/util/Random;J)V

    .line 433
    invoke-virtual {v6, p0}, Lextern/okhttp3/internal/ws/RealWebSocket;->connect(Lextern/okhttp3/OkHttpClient;)V

    return-object v6
.end method

.method public pingIntervalMillis()I
    .locals 1

    .line 320
    iget v0, p0, Lextern/okhttp3/OkHttpClient;->pingInterval:I

    return v0
.end method

.method public protocols()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lextern/okhttp3/Protocol;",
            ">;"
        }
    .end annotation

    .line 392
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->protocols:Ljava/util/List;

    return-object v0
.end method

.method public proxy()Ljava/net/Proxy;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 324
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->proxy:Ljava/net/Proxy;

    return-object v0
.end method

.method public proxyAuthenticator()Lextern/okhttp3/Authenticator;
    .locals 1

    .line 368
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    return-object v0
.end method

.method public proxySelector()Ljava/net/ProxySelector;
    .locals 1

    .line 328
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->proxySelector:Ljava/net/ProxySelector;

    return-object v0
.end method

.method public readTimeoutMillis()I
    .locals 1

    .line 310
    iget v0, p0, Lextern/okhttp3/OkHttpClient;->readTimeout:I

    return v0
.end method

.method public retryOnConnectionFailure()Z
    .locals 1

    .line 384
    iget-boolean v0, p0, Lextern/okhttp3/OkHttpClient;->retryOnConnectionFailure:Z

    return v0
.end method

.method public socketFactory()Ljavax/net/SocketFactory;
    .locals 1

    .line 348
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->socketFactory:Ljavax/net/SocketFactory;

    return-object v0
.end method

.method public sslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;
    .locals 1

    .line 352
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    return-object v0
.end method

.method public writeTimeoutMillis()I
    .locals 1

    .line 315
    iget v0, p0, Lextern/okhttp3/OkHttpClient;->writeTimeout:I

    return v0
.end method
