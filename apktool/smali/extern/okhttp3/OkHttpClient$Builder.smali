.class public final Lextern/okhttp3/OkHttpClient$Builder;
.super Ljava/lang/Object;
.source "OkHttpClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/OkHttpClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field authenticator:Lextern/okhttp3/Authenticator;

.field cache:Lextern/okhttp3/Cache;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field callTimeout:I

.field certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field certificatePinner:Lextern/okhttp3/CertificatePinner;

.field connectTimeout:I

.field connectionPool:Lextern/okhttp3/ConnectionPool;

.field connectionSpecs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/ConnectionSpec;",
            ">;"
        }
    .end annotation
.end field

.field cookieJar:Lextern/okhttp3/CookieJar;

.field dispatcher:Lextern/okhttp3/Dispatcher;

.field dns:Lextern/okhttp3/Dns;

.field eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

.field followRedirects:Z

.field followSslRedirects:Z

.field hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

.field final interceptors:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/Interceptor;",
            ">;"
        }
    .end annotation
.end field

.field internalCache:Lextern/okhttp3/internal/cache/InternalCache;
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

.field pingInterval:I

.field protocols:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lextern/okhttp3/Protocol;",
            ">;"
        }
    .end annotation
.end field

.field proxy:Ljava/net/Proxy;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field proxyAuthenticator:Lextern/okhttp3/Authenticator;

.field proxySelector:Ljava/net/ProxySelector;

.field readTimeout:I

.field retryOnConnectionFailure:Z

.field socketFactory:Ljavax/net/SocketFactory;

.field sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field writeTimeout:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 471
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 446
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->interceptors:Ljava/util/List;

    .line 447
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->networkInterceptors:Ljava/util/List;

    .line 472
    new-instance v0, Lextern/okhttp3/Dispatcher;

    invoke-direct {v0}, Lextern/okhttp3/Dispatcher;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->dispatcher:Lextern/okhttp3/Dispatcher;

    .line 473
    sget-object v0, Lextern/okhttp3/OkHttpClient;->DEFAULT_PROTOCOLS:Ljava/util/List;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->protocols:Ljava/util/List;

    .line 474
    sget-object v0, Lextern/okhttp3/OkHttpClient;->DEFAULT_CONNECTION_SPECS:Ljava/util/List;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectionSpecs:Ljava/util/List;

    .line 475
    sget-object v0, Lextern/okhttp3/EventListener;->NONE:Lextern/okhttp3/EventListener;

    invoke-static {v0}, Lextern/okhttp3/EventListener;->factory(Lextern/okhttp3/EventListener;)Lextern/okhttp3/EventListener$Factory;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    .line 476
    invoke-static {}, Ljava/net/ProxySelector;->getDefault()Ljava/net/ProxySelector;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxySelector:Ljava/net/ProxySelector;

    .line 477
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxySelector:Ljava/net/ProxySelector;

    if-nez v0, :cond_0

    .line 478
    new-instance v0, Lextern/okhttp3/internal/proxy/NullProxySelector;

    invoke-direct {v0}, Lextern/okhttp3/internal/proxy/NullProxySelector;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxySelector:Ljava/net/ProxySelector;

    .line 480
    :cond_0
    sget-object v0, Lextern/okhttp3/CookieJar;->NO_COOKIES:Lextern/okhttp3/CookieJar;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->cookieJar:Lextern/okhttp3/CookieJar;

    .line 481
    invoke-static {}, Ljavax/net/SocketFactory;->getDefault()Ljavax/net/SocketFactory;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->socketFactory:Ljavax/net/SocketFactory;

    .line 482
    sget-object v0, Lextern/okhttp3/internal/tls/OkHostnameVerifier;->INSTANCE:Lextern/okhttp3/internal/tls/OkHostnameVerifier;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    .line 483
    sget-object v0, Lextern/okhttp3/CertificatePinner;->DEFAULT:Lextern/okhttp3/CertificatePinner;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    .line 484
    sget-object v0, Lextern/okhttp3/Authenticator;->NONE:Lextern/okhttp3/Authenticator;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    .line 485
    sget-object v0, Lextern/okhttp3/Authenticator;->NONE:Lextern/okhttp3/Authenticator;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->authenticator:Lextern/okhttp3/Authenticator;

    .line 486
    new-instance v0, Lextern/okhttp3/ConnectionPool;

    invoke-direct {v0}, Lextern/okhttp3/ConnectionPool;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectionPool:Lextern/okhttp3/ConnectionPool;

    .line 487
    sget-object v0, Lextern/okhttp3/Dns;->SYSTEM:Lextern/okhttp3/Dns;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->dns:Lextern/okhttp3/Dns;

    const/4 v0, 0x1

    .line 488
    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->followSslRedirects:Z

    .line 489
    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->followRedirects:Z

    .line 490
    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->retryOnConnectionFailure:Z

    const/4 v0, 0x0

    .line 491
    iput v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->callTimeout:I

    const/16 v1, 0x2710

    .line 492
    iput v1, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectTimeout:I

    .line 493
    iput v1, p0, Lextern/okhttp3/OkHttpClient$Builder;->readTimeout:I

    .line 494
    iput v1, p0, Lextern/okhttp3/OkHttpClient$Builder;->writeTimeout:I

    .line 495
    iput v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->pingInterval:I

    return-void
.end method

.method constructor <init>(Lextern/okhttp3/OkHttpClient;)V
    .locals 2

    .line 498
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 446
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->interceptors:Ljava/util/List;

    .line 447
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->networkInterceptors:Ljava/util/List;

    .line 499
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->dispatcher:Lextern/okhttp3/Dispatcher;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->dispatcher:Lextern/okhttp3/Dispatcher;

    .line 500
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->proxy:Ljava/net/Proxy;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxy:Ljava/net/Proxy;

    .line 501
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->protocols:Ljava/util/List;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->protocols:Ljava/util/List;

    .line 502
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->connectionSpecs:Ljava/util/List;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectionSpecs:Ljava/util/List;

    .line 503
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->interceptors:Ljava/util/List;

    iget-object v1, p1, Lextern/okhttp3/OkHttpClient;->interceptors:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 504
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->networkInterceptors:Ljava/util/List;

    iget-object v1, p1, Lextern/okhttp3/OkHttpClient;->networkInterceptors:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 505
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    .line 506
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->proxySelector:Ljava/net/ProxySelector;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxySelector:Ljava/net/ProxySelector;

    .line 507
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->cookieJar:Lextern/okhttp3/CookieJar;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->cookieJar:Lextern/okhttp3/CookieJar;

    .line 508
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    .line 509
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->cache:Lextern/okhttp3/Cache;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->cache:Lextern/okhttp3/Cache;

    .line 510
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->socketFactory:Ljavax/net/SocketFactory;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->socketFactory:Ljavax/net/SocketFactory;

    .line 511
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 512
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    .line 513
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    .line 514
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    .line 515
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    .line 516
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->authenticator:Lextern/okhttp3/Authenticator;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->authenticator:Lextern/okhttp3/Authenticator;

    .line 517
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->connectionPool:Lextern/okhttp3/ConnectionPool;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectionPool:Lextern/okhttp3/ConnectionPool;

    .line 518
    iget-object v0, p1, Lextern/okhttp3/OkHttpClient;->dns:Lextern/okhttp3/Dns;

    iput-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->dns:Lextern/okhttp3/Dns;

    .line 519
    iget-boolean v0, p1, Lextern/okhttp3/OkHttpClient;->followSslRedirects:Z

    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->followSslRedirects:Z

    .line 520
    iget-boolean v0, p1, Lextern/okhttp3/OkHttpClient;->followRedirects:Z

    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->followRedirects:Z

    .line 521
    iget-boolean v0, p1, Lextern/okhttp3/OkHttpClient;->retryOnConnectionFailure:Z

    iput-boolean v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->retryOnConnectionFailure:Z

    .line 522
    iget v0, p1, Lextern/okhttp3/OkHttpClient;->callTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->callTimeout:I

    .line 523
    iget v0, p1, Lextern/okhttp3/OkHttpClient;->connectTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectTimeout:I

    .line 524
    iget v0, p1, Lextern/okhttp3/OkHttpClient;->readTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->readTimeout:I

    .line 525
    iget v0, p1, Lextern/okhttp3/OkHttpClient;->writeTimeout:I

    iput v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->writeTimeout:I

    .line 526
    iget p1, p1, Lextern/okhttp3/OkHttpClient;->pingInterval:I

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->pingInterval:I

    return-void
.end method


# virtual methods
.method public addInterceptor(Lextern/okhttp3/Interceptor;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 992
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->interceptors:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0

    .line 991
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "interceptor == null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public addNetworkInterceptor(Lextern/okhttp3/Interceptor;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 1007
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->networkInterceptors:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0

    .line 1006
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "interceptor == null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public authenticator(Lextern/okhttp3/Authenticator;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 840
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->authenticator:Lextern/okhttp3/Authenticator;

    return-object p0

    .line 839
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "authenticator == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public build()Lextern/okhttp3/OkHttpClient;
    .locals 1

    .line 1038
    new-instance v0, Lextern/okhttp3/OkHttpClient;

    invoke-direct {v0, p0}, Lextern/okhttp3/OkHttpClient;-><init>(Lextern/okhttp3/OkHttpClient$Builder;)V

    return-object v0
.end method

.method public cache(Lextern/okhttp3/Cache;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0
    .param p1    # Lextern/okhttp3/Cache;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 724
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->cache:Lextern/okhttp3/Cache;

    const/4 p1, 0x0

    .line 725
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    return-object p0
.end method

.method public callTimeout(JLjava/util/concurrent/TimeUnit;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    const-string v0, "timeout"

    .line 538
    invoke-static {v0, p1, p2, p3}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->callTimeout:I

    return-object p0
.end method

.method public callTimeout(Ljava/time/Duration;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 3
    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    .line 552
    invoke-virtual {p1}, Ljava/time/Duration;->toMillis()J

    move-result-wide v0

    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-string v2, "timeout"

    invoke-static {v2, v0, v1, p1}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->callTimeout:I

    return-object p0
.end method

.method public certificatePinner(Lextern/okhttp3/CertificatePinner;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 828
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->certificatePinner:Lextern/okhttp3/CertificatePinner;

    return-object p0

    .line 827
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "certificatePinner == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public connectTimeout(JLjava/util/concurrent/TimeUnit;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    const-string v0, "timeout"

    .line 565
    invoke-static {v0, p1, p2, p3}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectTimeout:I

    return-object p0
.end method

.method public connectTimeout(Ljava/time/Duration;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 3
    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    .line 579
    invoke-virtual {p1}, Ljava/time/Duration;->toMillis()J

    move-result-wide v0

    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-string v2, "timeout"

    invoke-static {v2, v0, v1, p1}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectTimeout:I

    return-object p0
.end method

.method public connectionPool(Lextern/okhttp3/ConnectionPool;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 863
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectionPool:Lextern/okhttp3/ConnectionPool;

    return-object p0

    .line 862
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "connectionPool == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public connectionSpecs(Ljava/util/List;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lextern/okhttp3/ConnectionSpec;",
            ">;)",
            "Lextern/okhttp3/OkHttpClient$Builder;"
        }
    .end annotation

    .line 977
    invoke-static {p1}, Lextern/okhttp3/internal/Util;->immutableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->connectionSpecs:Ljava/util/List;

    return-object p0
.end method

.method public cookieJar(Lextern/okhttp3/CookieJar;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 712
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->cookieJar:Lextern/okhttp3/CookieJar;

    return-object p0

    .line 711
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "cookieJar == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public dispatcher(Lextern/okhttp3/Dispatcher;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 912
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->dispatcher:Lextern/okhttp3/Dispatcher;

    return-object p0

    .line 911
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "dispatcher == null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public dns(Lextern/okhttp3/Dns;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 736
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->dns:Lextern/okhttp3/Dns;

    return-object p0

    .line 735
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "dns == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public eventListener(Lextern/okhttp3/EventListener;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 1019
    invoke-static {p1}, Lextern/okhttp3/EventListener;->factory(Lextern/okhttp3/EventListener;)Lextern/okhttp3/EventListener$Factory;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    return-object p0

    .line 1018
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "eventListener == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public eventListenerFactory(Lextern/okhttp3/EventListener$Factory;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 1033
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->eventListenerFactory:Lextern/okhttp3/EventListener$Factory;

    return-object p0

    .line 1031
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "eventListenerFactory == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public followRedirects(Z)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0

    .line 880
    iput-boolean p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->followRedirects:Z

    return-object p0
.end method

.method public followSslRedirects(Z)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0

    .line 874
    iput-boolean p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->followSslRedirects:Z

    return-object p0
.end method

.method public hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 817
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    return-object p0

    .line 816
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "hostnameVerifier == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
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

    .line 987
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->interceptors:Ljava/util/List;

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

    .line 1002
    iget-object v0, p0, Lextern/okhttp3/OkHttpClient$Builder;->networkInterceptors:Ljava/util/List;

    return-object v0
.end method

.method public pingInterval(JLjava/util/concurrent/TimeUnit;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    const-string v0, "interval"

    .line 657
    invoke-static {v0, p1, p2, p3}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->pingInterval:I

    return-object p0
.end method

.method public pingInterval(Ljava/time/Duration;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 3
    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    .line 676
    invoke-virtual {p1}, Ljava/time/Duration;->toMillis()J

    move-result-wide v0

    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-string v2, "timeout"

    invoke-static {v2, v0, v1, p1}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->pingInterval:I

    return-object p0
.end method

.method public protocols(Ljava/util/List;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lextern/okhttp3/Protocol;",
            ">;)",
            "Lextern/okhttp3/OkHttpClient$Builder;"
        }
    .end annotation

    .line 949
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 952
    sget-object p1, Lextern/okhttp3/Protocol;->H2_PRIOR_KNOWLEDGE:Lextern/okhttp3/Protocol;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    sget-object p1, Lextern/okhttp3/Protocol;->HTTP_1_1:Lextern/okhttp3/Protocol;

    .line 953
    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    .line 954
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "protocols must contain h2_prior_knowledge or http/1.1: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 957
    :cond_1
    :goto_0
    sget-object p1, Lextern/okhttp3/Protocol;->H2_PRIOR_KNOWLEDGE:Lextern/okhttp3/Protocol;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p1

    const/4 v1, 0x1

    if-gt p1, v1, :cond_2

    goto :goto_1

    .line 958
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "protocols containing h2_prior_knowledge cannot use other protocols: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 961
    :cond_3
    :goto_1
    sget-object p1, Lextern/okhttp3/Protocol;->HTTP_1_0:Lextern/okhttp3/Protocol;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_5

    const/4 p1, 0x0

    .line 964
    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_4

    .line 969
    sget-object p1, Lextern/okhttp3/Protocol;->SPDY_3:Lextern/okhttp3/Protocol;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 972
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->protocols:Ljava/util/List;

    return-object p0

    .line 965
    :cond_4
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "protocols must not contain null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 962
    :cond_5
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "protocols must not contain http/1.0: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public proxy(Ljava/net/Proxy;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0
    .param p1    # Ljava/net/Proxy;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 686
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxy:Ljava/net/Proxy;

    return-object p0
.end method

.method public proxyAuthenticator(Lextern/okhttp3/Authenticator;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 852
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxyAuthenticator:Lextern/okhttp3/Authenticator;

    return-object p0

    .line 851
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "proxyAuthenticator == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public proxySelector(Ljava/net/ProxySelector;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 700
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->proxySelector:Ljava/net/ProxySelector;

    return-object p0

    .line 699
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "proxySelector == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public readTimeout(JLjava/util/concurrent/TimeUnit;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    const-string v0, "timeout"

    .line 594
    invoke-static {v0, p1, p2, p3}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->readTimeout:I

    return-object p0
.end method

.method public readTimeout(Ljava/time/Duration;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 3
    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    .line 610
    invoke-virtual {p1}, Ljava/time/Duration;->toMillis()J

    move-result-wide v0

    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-string v2, "timeout"

    invoke-static {v2, v0, v1, p1}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->readTimeout:I

    return-object p0
.end method

.method public retryOnConnectionFailure(Z)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0

    .line 903
    iput-boolean p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->retryOnConnectionFailure:Z

    return-object p0
.end method

.method setInternalCache(Lextern/okhttp3/internal/cache/InternalCache;)V
    .locals 0
    .param p1    # Lextern/okhttp3/internal/cache/InternalCache;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 718
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    const/4 p1, 0x0

    .line 719
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->cache:Lextern/okhttp3/Cache;

    return-void
.end method

.method public socketFactory(Ljavax/net/SocketFactory;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 750
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->socketFactory:Ljavax/net/SocketFactory;

    return-object p0

    .line 749
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "socketFactory == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    if-eqz p1, :cond_0

    .line 765
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 766
    invoke-static {}, Lextern/okhttp3/internal/platform/Platform;->get()Lextern/okhttp3/internal/platform/Platform;

    move-result-object v0

    invoke-virtual {v0, p1}, Lextern/okhttp3/internal/platform/Platform;->buildCertificateChainCleaner(Ljavax/net/ssl/SSLSocketFactory;)Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    return-object p0

    .line 764
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "sslSocketFactory == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 0

    if-eqz p1, :cond_1

    if-eqz p2, :cond_0

    .line 804
    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->sslSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    .line 805
    invoke-static {p2}, Lextern/okhttp3/internal/tls/CertificateChainCleaner;->get(Ljavax/net/ssl/X509TrustManager;)Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->certificateChainCleaner:Lextern/okhttp3/internal/tls/CertificateChainCleaner;

    return-object p0

    .line 803
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "trustManager == null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 802
    :cond_1
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "sslSocketFactory == null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public writeTimeout(JLjava/util/concurrent/TimeUnit;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 1

    const-string v0, "timeout"

    .line 624
    invoke-static {v0, p1, p2, p3}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->writeTimeout:I

    return-object p0
.end method

.method public writeTimeout(Ljava/time/Duration;)Lextern/okhttp3/OkHttpClient$Builder;
    .locals 3
    .annotation build Lorg/codehaus/mojo/animal_sniffer/IgnoreJRERequirement;
    .end annotation

    .line 639
    invoke-virtual {p1}, Ljava/time/Duration;->toMillis()J

    move-result-wide v0

    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-string v2, "timeout"

    invoke-static {v2, v0, v1, p1}, Lextern/okhttp3/internal/Util;->checkDuration(Ljava/lang/String;JLjava/util/concurrent/TimeUnit;)I

    move-result p1

    iput p1, p0, Lextern/okhttp3/OkHttpClient$Builder;->writeTimeout:I

    return-object p0
.end method
