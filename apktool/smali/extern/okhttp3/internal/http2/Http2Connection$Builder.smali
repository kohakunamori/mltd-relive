.class public Lextern/okhttp3/internal/http2/Http2Connection$Builder;
.super Ljava/lang/Object;
.source "Http2Connection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/internal/http2/Http2Connection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field client:Z

.field hostname:Ljava/lang/String;

.field listener:Lextern/okhttp3/internal/http2/Http2Connection$Listener;

.field pingIntervalMillis:I

.field pushObserver:Lextern/okhttp3/internal/http2/PushObserver;

.field sink:Lextern/okio/BufferedSink;

.field socket:Ljava/net/Socket;

.field source:Lextern/okio/BufferedSource;


# direct methods
.method public constructor <init>(Z)V
    .locals 1

    .line 621
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 612
    sget-object v0, Lextern/okhttp3/internal/http2/Http2Connection$Listener;->REFUSE_INCOMING_STREAMS:Lextern/okhttp3/internal/http2/Http2Connection$Listener;

    iput-object v0, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->listener:Lextern/okhttp3/internal/http2/Http2Connection$Listener;

    .line 613
    sget-object v0, Lextern/okhttp3/internal/http2/PushObserver;->CANCEL:Lextern/okhttp3/internal/http2/PushObserver;

    iput-object v0, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->pushObserver:Lextern/okhttp3/internal/http2/PushObserver;

    .line 622
    iput-boolean p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->client:Z

    return-void
.end method


# virtual methods
.method public build()Lextern/okhttp3/internal/http2/Http2Connection;
    .locals 1

    .line 655
    new-instance v0, Lextern/okhttp3/internal/http2/Http2Connection;

    invoke-direct {v0, p0}, Lextern/okhttp3/internal/http2/Http2Connection;-><init>(Lextern/okhttp3/internal/http2/Http2Connection$Builder;)V

    return-object v0
.end method

.method public listener(Lextern/okhttp3/internal/http2/Http2Connection$Listener;)Lextern/okhttp3/internal/http2/Http2Connection$Builder;
    .locals 0

    .line 640
    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->listener:Lextern/okhttp3/internal/http2/Http2Connection$Listener;

    return-object p0
.end method

.method public pingIntervalMillis(I)Lextern/okhttp3/internal/http2/Http2Connection$Builder;
    .locals 0

    .line 650
    iput p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->pingIntervalMillis:I

    return-object p0
.end method

.method public pushObserver(Lextern/okhttp3/internal/http2/PushObserver;)Lextern/okhttp3/internal/http2/Http2Connection$Builder;
    .locals 0

    .line 645
    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->pushObserver:Lextern/okhttp3/internal/http2/PushObserver;

    return-object p0
.end method

.method public socket(Ljava/net/Socket;)Lextern/okhttp3/internal/http2/Http2Connection$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 626
    invoke-virtual {p1}, Ljava/net/Socket;->getRemoteSocketAddress()Ljava/net/SocketAddress;

    move-result-object v0

    check-cast v0, Ljava/net/InetSocketAddress;

    invoke-virtual {v0}, Ljava/net/InetSocketAddress;->getHostName()Ljava/lang/String;

    move-result-object v0

    .line 627
    invoke-static {p1}, Lextern/okio/Okio;->source(Ljava/net/Socket;)Lextern/okio/Source;

    move-result-object v1

    invoke-static {v1}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object v1

    invoke-static {p1}, Lextern/okio/Okio;->sink(Ljava/net/Socket;)Lextern/okio/Sink;

    move-result-object v2

    invoke-static {v2}, Lextern/okio/Okio;->buffer(Lextern/okio/Sink;)Lextern/okio/BufferedSink;

    move-result-object v2

    .line 626
    invoke-virtual {p0, p1, v0, v1, v2}, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->socket(Ljava/net/Socket;Ljava/lang/String;Lextern/okio/BufferedSource;Lextern/okio/BufferedSink;)Lextern/okhttp3/internal/http2/Http2Connection$Builder;

    move-result-object p1

    return-object p1
.end method

.method public socket(Ljava/net/Socket;Ljava/lang/String;Lextern/okio/BufferedSource;Lextern/okio/BufferedSink;)Lextern/okhttp3/internal/http2/Http2Connection$Builder;
    .locals 0

    .line 632
    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->socket:Ljava/net/Socket;

    .line 633
    iput-object p2, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->hostname:Ljava/lang/String;

    .line 634
    iput-object p3, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->source:Lextern/okio/BufferedSource;

    .line 635
    iput-object p4, p0, Lextern/okhttp3/internal/http2/Http2Connection$Builder;->sink:Lextern/okio/BufferedSink;

    return-object p0
.end method
