.class public abstract Lextern/okhttp3/EventListener;
.super Ljava/lang/Object;
.source "EventListener.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/EventListener$Factory;
    }
.end annotation


# static fields
.field public static final NONE:Lextern/okhttp3/EventListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 53
    new-instance v0, Lextern/okhttp3/EventListener$1;

    invoke-direct {v0}, Lextern/okhttp3/EventListener$1;-><init>()V

    sput-object v0, Lextern/okhttp3/EventListener;->NONE:Lextern/okhttp3/EventListener;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static factory(Lextern/okhttp3/EventListener;)Lextern/okhttp3/EventListener$Factory;
    .locals 1

    .line 57
    new-instance v0, Lextern/okhttp3/EventListener$2;

    invoke-direct {v0, p0}, Lextern/okhttp3/EventListener$2;-><init>(Lextern/okhttp3/EventListener;)V

    return-object v0
.end method


# virtual methods
.method public callEnd(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method

.method public callFailed(Lextern/okhttp3/Call;Ljava/io/IOException;)V
    .locals 0

    return-void
.end method

.method public callStart(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method

.method public connectEnd(Lextern/okhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lextern/okhttp3/Protocol;)V
    .locals 0
    .param p4    # Lextern/okhttp3/Protocol;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    return-void
.end method

.method public connectFailed(Lextern/okhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;Lextern/okhttp3/Protocol;Ljava/io/IOException;)V
    .locals 0
    .param p4    # Lextern/okhttp3/Protocol;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    return-void
.end method

.method public connectStart(Lextern/okhttp3/Call;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 0

    return-void
.end method

.method public connectionAcquired(Lextern/okhttp3/Call;Lextern/okhttp3/Connection;)V
    .locals 0

    return-void
.end method

.method public connectionReleased(Lextern/okhttp3/Call;Lextern/okhttp3/Connection;)V
    .locals 0

    return-void
.end method

.method public dnsEnd(Lextern/okhttp3/Call;Ljava/lang/String;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lextern/okhttp3/Call;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/net/InetAddress;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public dnsStart(Lextern/okhttp3/Call;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public requestBodyEnd(Lextern/okhttp3/Call;J)V
    .locals 0

    return-void
.end method

.method public requestBodyStart(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method

.method public requestHeadersEnd(Lextern/okhttp3/Call;Lextern/okhttp3/Request;)V
    .locals 0

    return-void
.end method

.method public requestHeadersStart(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method

.method public responseBodyEnd(Lextern/okhttp3/Call;J)V
    .locals 0

    return-void
.end method

.method public responseBodyStart(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method

.method public responseHeadersEnd(Lextern/okhttp3/Call;Lextern/okhttp3/Response;)V
    .locals 0

    return-void
.end method

.method public responseHeadersStart(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method

.method public secureConnectEnd(Lextern/okhttp3/Call;Lextern/okhttp3/Handshake;)V
    .locals 0
    .param p2    # Lextern/okhttp3/Handshake;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    return-void
.end method

.method public secureConnectStart(Lextern/okhttp3/Call;)V
    .locals 0

    return-void
.end method
