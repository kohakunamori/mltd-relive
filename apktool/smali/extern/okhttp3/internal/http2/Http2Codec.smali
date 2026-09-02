.class public final Lextern/okhttp3/internal/http2/Http2Codec;
.super Ljava/lang/Object;
.source "Http2Codec.java"

# interfaces
.implements Lextern/okhttp3/internal/http/HttpCodec;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/internal/http2/Http2Codec$StreamFinishingSource;
    }
.end annotation


# static fields
.field private static final CONNECTION:Ljava/lang/String; = "connection"

.field private static final ENCODING:Ljava/lang/String; = "encoding"

.field private static final HOST:Ljava/lang/String; = "host"

.field private static final HTTP_2_SKIPPED_REQUEST_HEADERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final HTTP_2_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final KEEP_ALIVE:Ljava/lang/String; = "keep-alive"

.field private static final PROXY_CONNECTION:Ljava/lang/String; = "proxy-connection"

.field private static final TE:Ljava/lang/String; = "te"

.field private static final TRANSFER_ENCODING:Ljava/lang/String; = "transfer-encoding"

.field private static final UPGRADE:Ljava/lang/String; = "upgrade"


# instance fields
.field private final chain:Lextern/okhttp3/Interceptor$Chain;

.field private final connection:Lextern/okhttp3/internal/http2/Http2Connection;

.field private final protocol:Lextern/okhttp3/Protocol;

.field private stream:Lextern/okhttp3/internal/http2/Http2Stream;

.field final streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;


# direct methods
.method static constructor <clinit>()V
    .locals 18

    const/16 v0, 0xc

    .line 61
    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "connection"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v3, "host"

    const/4 v4, 0x1

    aput-object v3, v0, v4

    const-string v5, "keep-alive"

    const/4 v6, 0x2

    aput-object v5, v0, v6

    const-string v7, "proxy-connection"

    const/4 v8, 0x3

    aput-object v7, v0, v8

    const-string v9, "te"

    const/4 v10, 0x4

    aput-object v9, v0, v10

    const-string v11, "transfer-encoding"

    const/4 v12, 0x5

    aput-object v11, v0, v12

    const-string v13, "encoding"

    const/4 v14, 0x6

    aput-object v13, v0, v14

    const/4 v15, 0x7

    const-string v16, "upgrade"

    aput-object v16, v0, v15

    const/16 v16, 0x8

    const-string v17, ":method"

    aput-object v17, v0, v16

    const/16 v16, 0x9

    const-string v17, ":path"

    aput-object v17, v0, v16

    const/16 v16, 0xa

    const-string v17, ":scheme"

    aput-object v17, v0, v16

    const/16 v16, 0xb

    const-string v17, ":authority"

    aput-object v17, v0, v16

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lextern/okhttp3/internal/http2/Http2Codec;->HTTP_2_SKIPPED_REQUEST_HEADERS:Ljava/util/List;

    const/16 v0, 0x8

    .line 74
    new-array v0, v0, [Ljava/lang/String;

    aput-object v1, v0, v2

    aput-object v3, v0, v4

    aput-object v5, v0, v6

    aput-object v7, v0, v8

    aput-object v9, v0, v10

    aput-object v11, v0, v12

    aput-object v13, v0, v14

    const-string v1, "upgrade"

    aput-object v1, v0, v15

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->immutableList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lextern/okhttp3/internal/http2/Http2Codec;->HTTP_2_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;

    return-void
.end method

.method public constructor <init>(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/Interceptor$Chain;Lextern/okhttp3/internal/connection/StreamAllocation;Lextern/okhttp3/internal/http2/Http2Connection;)V
    .locals 0

    .line 91
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 92
    iput-object p2, p0, Lextern/okhttp3/internal/http2/Http2Codec;->chain:Lextern/okhttp3/Interceptor$Chain;

    .line 93
    iput-object p3, p0, Lextern/okhttp3/internal/http2/Http2Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    .line 94
    iput-object p4, p0, Lextern/okhttp3/internal/http2/Http2Codec;->connection:Lextern/okhttp3/internal/http2/Http2Connection;

    .line 95
    invoke-virtual {p1}, Lextern/okhttp3/OkHttpClient;->protocols()Ljava/util/List;

    move-result-object p1

    sget-object p2, Lextern/okhttp3/Protocol;->H2_PRIOR_KNOWLEDGE:Lextern/okhttp3/Protocol;

    invoke-interface {p1, p2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 96
    sget-object p1, Lextern/okhttp3/Protocol;->H2_PRIOR_KNOWLEDGE:Lextern/okhttp3/Protocol;

    goto :goto_0

    .line 97
    :cond_0
    sget-object p1, Lextern/okhttp3/Protocol;->HTTP_2:Lextern/okhttp3/Protocol;

    :goto_0
    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->protocol:Lextern/okhttp3/Protocol;

    return-void
.end method

.method public static http2HeadersList(Lextern/okhttp3/Request;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lextern/okhttp3/Request;",
            ")",
            "Ljava/util/List<",
            "Lextern/okhttp3/internal/http2/Header;",
            ">;"
        }
    .end annotation

    .line 132
    invoke-virtual {p0}, Lextern/okhttp3/Request;->headers()Lextern/okhttp3/Headers;

    move-result-object v0

    .line 133
    new-instance v1, Ljava/util/ArrayList;

    invoke-virtual {v0}, Lextern/okhttp3/Headers;->size()I

    move-result v2

    add-int/lit8 v2, v2, 0x4

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 134
    new-instance v2, Lextern/okhttp3/internal/http2/Header;

    sget-object v3, Lextern/okhttp3/internal/http2/Header;->TARGET_METHOD:Lextern/okio/ByteString;

    invoke-virtual {p0}, Lextern/okhttp3/Request;->method()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lextern/okhttp3/internal/http2/Header;-><init>(Lextern/okio/ByteString;Ljava/lang/String;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 135
    new-instance v2, Lextern/okhttp3/internal/http2/Header;

    sget-object v3, Lextern/okhttp3/internal/http2/Header;->TARGET_PATH:Lextern/okio/ByteString;

    invoke-virtual {p0}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object v4

    invoke-static {v4}, Lextern/okhttp3/internal/http/RequestLine;->requestPath(Lextern/okhttp3/HttpUrl;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lextern/okhttp3/internal/http2/Header;-><init>(Lextern/okio/ByteString;Ljava/lang/String;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const-string v2, "Host"

    .line 136
    invoke-virtual {p0, v2}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 138
    new-instance v3, Lextern/okhttp3/internal/http2/Header;

    sget-object v4, Lextern/okhttp3/internal/http2/Header;->TARGET_AUTHORITY:Lextern/okio/ByteString;

    invoke-direct {v3, v4, v2}, Lextern/okhttp3/internal/http2/Header;-><init>(Lextern/okio/ByteString;Ljava/lang/String;)V

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 140
    :cond_0
    new-instance v2, Lextern/okhttp3/internal/http2/Header;

    sget-object v3, Lextern/okhttp3/internal/http2/Header;->TARGET_SCHEME:Lextern/okio/ByteString;

    invoke-virtual {p0}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object p0

    invoke-virtual {p0}, Lextern/okhttp3/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, v3, p0}, Lextern/okhttp3/internal/http2/Header;-><init>(Lextern/okio/ByteString;Ljava/lang/String;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 p0, 0x0

    .line 142
    invoke-virtual {v0}, Lextern/okhttp3/Headers;->size()I

    move-result v2

    :goto_0
    if-ge p0, v2, :cond_2

    .line 144
    invoke-virtual {v0, p0}, Lextern/okhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lextern/okio/ByteString;->encodeUtf8(Ljava/lang/String;)Lextern/okio/ByteString;

    move-result-object v3

    .line 145
    sget-object v4, Lextern/okhttp3/internal/http2/Http2Codec;->HTTP_2_SKIPPED_REQUEST_HEADERS:Ljava/util/List;

    invoke-virtual {v3}, Lextern/okio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 146
    new-instance v4, Lextern/okhttp3/internal/http2/Header;

    invoke-virtual {v0, p0}, Lextern/okhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v3, v5}, Lextern/okhttp3/internal/http2/Header;-><init>(Lextern/okio/ByteString;Ljava/lang/String;)V

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 p0, p0, 0x1

    goto :goto_0

    :cond_2
    return-object v1
.end method

.method public static readHttp2HeadersList(Lextern/okhttp3/Headers;Lextern/okhttp3/Protocol;)Lextern/okhttp3/Response$Builder;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 156
    new-instance v0, Lextern/okhttp3/Headers$Builder;

    invoke-direct {v0}, Lextern/okhttp3/Headers$Builder;-><init>()V

    .line 157
    invoke-virtual {p0}, Lextern/okhttp3/Headers;->size()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_2

    .line 158
    invoke-virtual {p0, v3}, Lextern/okhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v4

    .line 159
    invoke-virtual {p0, v3}, Lextern/okhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v5

    const-string v6, ":status"

    .line 160
    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 161
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "HTTP/1.1 "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lextern/okhttp3/internal/http/StatusLine;->parse(Ljava/lang/String;)Lextern/okhttp3/internal/http/StatusLine;

    move-result-object v2

    goto :goto_1

    .line 162
    :cond_0
    sget-object v6, Lextern/okhttp3/internal/http2/Http2Codec;->HTTP_2_SKIPPED_RESPONSE_HEADERS:Ljava/util/List;

    invoke-interface {v6, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 163
    sget-object v6, Lextern/okhttp3/internal/Internal;->instance:Lextern/okhttp3/internal/Internal;

    invoke-virtual {v6, v0, v4, v5}, Lextern/okhttp3/internal/Internal;->addLenient(Lextern/okhttp3/Headers$Builder;Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    if-eqz v2, :cond_3

    .line 168
    new-instance p0, Lextern/okhttp3/Response$Builder;

    invoke-direct {p0}, Lextern/okhttp3/Response$Builder;-><init>()V

    .line 169
    invoke-virtual {p0, p1}, Lextern/okhttp3/Response$Builder;->protocol(Lextern/okhttp3/Protocol;)Lextern/okhttp3/Response$Builder;

    move-result-object p0

    iget p1, v2, Lextern/okhttp3/internal/http/StatusLine;->code:I

    .line 170
    invoke-virtual {p0, p1}, Lextern/okhttp3/Response$Builder;->code(I)Lextern/okhttp3/Response$Builder;

    move-result-object p0

    iget-object p1, v2, Lextern/okhttp3/internal/http/StatusLine;->message:Ljava/lang/String;

    .line 171
    invoke-virtual {p0, p1}, Lextern/okhttp3/Response$Builder;->message(Ljava/lang/String;)Lextern/okhttp3/Response$Builder;

    move-result-object p0

    .line 172
    invoke-virtual {v0}, Lextern/okhttp3/Headers$Builder;->build()Lextern/okhttp3/Headers;

    move-result-object p1

    invoke-virtual {p0, p1}, Lextern/okhttp3/Response$Builder;->headers(Lextern/okhttp3/Headers;)Lextern/okhttp3/Response$Builder;

    move-result-object p0

    return-object p0

    .line 166
    :cond_3
    new-instance p0, Ljava/net/ProtocolException;

    const-string p1, "Expected \':status\' header not present"

    invoke-direct {p0, p1}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw p0

    :goto_3
    goto :goto_2
.end method


# virtual methods
.method public cancel()V
    .locals 2

    .line 184
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    if-eqz v0, :cond_0

    sget-object v1, Lextern/okhttp3/internal/http2/ErrorCode;->CANCEL:Lextern/okhttp3/internal/http2/ErrorCode;

    invoke-virtual {v0, v1}, Lextern/okhttp3/internal/http2/Http2Stream;->closeLater(Lextern/okhttp3/internal/http2/ErrorCode;)V

    :cond_0
    return-void
.end method

.method public createRequestBody(Lextern/okhttp3/Request;J)Lextern/okio/Sink;
    .locals 0

    .line 101
    iget-object p1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    invoke-virtual {p1}, Lextern/okhttp3/internal/http2/Http2Stream;->getSink()Lextern/okio/Sink;

    move-result-object p1

    return-object p1
.end method

.method public finishRequest()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 119
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    invoke-virtual {v0}, Lextern/okhttp3/internal/http2/Http2Stream;->getSink()Lextern/okio/Sink;

    move-result-object v0

    invoke-interface {v0}, Lextern/okio/Sink;->close()V

    return-void
.end method

.method public flushRequest()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 115
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->connection:Lextern/okhttp3/internal/http2/Http2Connection;

    invoke-virtual {v0}, Lextern/okhttp3/internal/http2/Http2Connection;->flush()V

    return-void
.end method

.method public openResponseBody(Lextern/okhttp3/Response;)Lextern/okhttp3/ResponseBody;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 176
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    iget-object v0, v0, Lextern/okhttp3/internal/connection/StreamAllocation;->eventListener:Lextern/okhttp3/EventListener;

    iget-object v1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    iget-object v1, v1, Lextern/okhttp3/internal/connection/StreamAllocation;->call:Lextern/okhttp3/Call;

    invoke-virtual {v0, v1}, Lextern/okhttp3/EventListener;->responseBodyStart(Lextern/okhttp3/Call;)V

    const-string v0, "Content-Type"

    .line 177
    invoke-virtual {p1, v0}, Lextern/okhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 178
    invoke-static {p1}, Lextern/okhttp3/internal/http/HttpHeaders;->contentLength(Lextern/okhttp3/Response;)J

    move-result-wide v1

    .line 179
    new-instance p1, Lextern/okhttp3/internal/http2/Http2Codec$StreamFinishingSource;

    iget-object v3, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    invoke-virtual {v3}, Lextern/okhttp3/internal/http2/Http2Stream;->getSource()Lextern/okio/Source;

    move-result-object v3

    invoke-direct {p1, p0, v3}, Lextern/okhttp3/internal/http2/Http2Codec$StreamFinishingSource;-><init>(Lextern/okhttp3/internal/http2/Http2Codec;Lextern/okio/Source;)V

    .line 180
    new-instance v3, Lextern/okhttp3/internal/http/RealResponseBody;

    invoke-static {p1}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object p1

    invoke-direct {v3, v0, v1, v2, p1}, Lextern/okhttp3/internal/http/RealResponseBody;-><init>(Ljava/lang/String;JLextern/okio/BufferedSource;)V

    return-object v3
.end method

.method public readResponseHeaders(Z)Lextern/okhttp3/Response$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 123
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    invoke-virtual {v0}, Lextern/okhttp3/internal/http2/Http2Stream;->takeHeaders()Lextern/okhttp3/Headers;

    move-result-object v0

    .line 124
    iget-object v1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->protocol:Lextern/okhttp3/Protocol;

    invoke-static {v0, v1}, Lextern/okhttp3/internal/http2/Http2Codec;->readHttp2HeadersList(Lextern/okhttp3/Headers;Lextern/okhttp3/Protocol;)Lextern/okhttp3/Response$Builder;

    move-result-object v0

    if-eqz p1, :cond_0

    .line 125
    sget-object p1, Lextern/okhttp3/internal/Internal;->instance:Lextern/okhttp3/internal/Internal;

    invoke-virtual {p1, v0}, Lextern/okhttp3/internal/Internal;->code(Lextern/okhttp3/Response$Builder;)I

    move-result p1

    const/16 v1, 0x64

    if-ne p1, v1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    return-object v0
.end method

.method public writeRequestHeaders(Lextern/okhttp3/Request;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 105
    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    if-eqz v0, :cond_0

    return-void

    .line 107
    :cond_0
    invoke-virtual {p1}, Lextern/okhttp3/Request;->body()Lextern/okhttp3/RequestBody;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 108
    :goto_0
    invoke-static {p1}, Lextern/okhttp3/internal/http2/Http2Codec;->http2HeadersList(Lextern/okhttp3/Request;)Ljava/util/List;

    move-result-object p1

    .line 109
    iget-object v1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->connection:Lextern/okhttp3/internal/http2/Http2Connection;

    invoke-virtual {v1, p1, v0}, Lextern/okhttp3/internal/http2/Http2Connection;->newStream(Ljava/util/List;Z)Lextern/okhttp3/internal/http2/Http2Stream;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    .line 110
    iget-object p1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    invoke-virtual {p1}, Lextern/okhttp3/internal/http2/Http2Stream;->readTimeout()Lextern/okio/Timeout;

    move-result-object p1

    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->chain:Lextern/okhttp3/Interceptor$Chain;

    invoke-interface {v0}, Lextern/okhttp3/Interceptor$Chain;->readTimeoutMillis()I

    move-result v0

    int-to-long v0, v0

    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p1, v0, v1, v2}, Lextern/okio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lextern/okio/Timeout;

    .line 111
    iget-object p1, p0, Lextern/okhttp3/internal/http2/Http2Codec;->stream:Lextern/okhttp3/internal/http2/Http2Stream;

    invoke-virtual {p1}, Lextern/okhttp3/internal/http2/Http2Stream;->writeTimeout()Lextern/okio/Timeout;

    move-result-object p1

    iget-object v0, p0, Lextern/okhttp3/internal/http2/Http2Codec;->chain:Lextern/okhttp3/Interceptor$Chain;

    invoke-interface {v0}, Lextern/okhttp3/Interceptor$Chain;->writeTimeoutMillis()I

    move-result v0

    int-to-long v0, v0

    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p1, v0, v1, v2}, Lextern/okio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lextern/okio/Timeout;

    return-void
.end method
