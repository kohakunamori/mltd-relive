.class public final Lextern/okhttp3/internal/http1/Http1Codec;
.super Ljava/lang/Object;
.source "Http1Codec.java"

# interfaces
.implements Lextern/okhttp3/internal/http/HttpCodec;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/internal/http1/Http1Codec$UnknownLengthSource;,
        Lextern/okhttp3/internal/http1/Http1Codec$ChunkedSource;,
        Lextern/okhttp3/internal/http1/Http1Codec$FixedLengthSource;,
        Lextern/okhttp3/internal/http1/Http1Codec$AbstractSource;,
        Lextern/okhttp3/internal/http1/Http1Codec$ChunkedSink;,
        Lextern/okhttp3/internal/http1/Http1Codec$FixedLengthSink;
    }
.end annotation


# static fields
.field private static final HEADER_LIMIT:I = 0x40000

.field private static final STATE_CLOSED:I = 0x6

.field private static final STATE_IDLE:I = 0x0

.field private static final STATE_OPEN_REQUEST_BODY:I = 0x1

.field private static final STATE_OPEN_RESPONSE_BODY:I = 0x4

.field private static final STATE_READING_RESPONSE_BODY:I = 0x5

.field private static final STATE_READ_RESPONSE_HEADERS:I = 0x3

.field private static final STATE_WRITING_REQUEST_BODY:I = 0x2


# instance fields
.field final client:Lextern/okhttp3/OkHttpClient;

.field private headerLimit:J

.field final sink:Lextern/okio/BufferedSink;

.field final source:Lextern/okio/BufferedSource;

.field state:I

.field final streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;


# direct methods
.method public constructor <init>(Lextern/okhttp3/OkHttpClient;Lextern/okhttp3/internal/connection/StreamAllocation;Lextern/okio/BufferedSource;Lextern/okio/BufferedSink;)V
    .locals 2

    .line 91
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 87
    iput v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const-wide/32 v0, 0x40000

    .line 88
    iput-wide v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->headerLimit:J

    .line 92
    iput-object p1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->client:Lextern/okhttp3/OkHttpClient;

    .line 93
    iput-object p2, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    .line 94
    iput-object p3, p0, Lextern/okhttp3/internal/http1/Http1Codec;->source:Lextern/okio/BufferedSource;

    .line 95
    iput-object p4, p0, Lextern/okhttp3/internal/http1/Http1Codec;->sink:Lextern/okio/BufferedSink;

    return-void
.end method

.method private readHeaderLine()Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 216
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->source:Lextern/okio/BufferedSource;

    iget-wide v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->headerLimit:J

    invoke-interface {v0, v1, v2}, Lextern/okio/BufferedSource;->readUtf8LineStrict(J)Ljava/lang/String;

    move-result-object v0

    .line 217
    iget-wide v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->headerLimit:J

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    int-to-long v3, v3

    sub-long/2addr v1, v3

    iput-wide v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->headerLimit:J

    return-object v0
.end method


# virtual methods
.method public cancel()V
    .locals 1

    .line 114
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    invoke-virtual {v0}, Lextern/okhttp3/internal/connection/StreamAllocation;->connection()Lextern/okhttp3/internal/connection/RealConnection;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 115
    invoke-virtual {v0}, Lextern/okhttp3/internal/connection/RealConnection;->cancel()V

    :cond_0
    return-void
.end method

.method public createRequestBody(Lextern/okhttp3/Request;J)Lextern/okio/Sink;
    .locals 2

    const-string v0, "Transfer-Encoding"

    .line 99
    invoke-virtual {p1, v0}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "chunked"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 101
    invoke-virtual {p0}, Lextern/okhttp3/internal/http1/Http1Codec;->newChunkedSink()Lextern/okio/Sink;

    move-result-object p1

    return-object p1

    :cond_0
    const-wide/16 v0, -0x1

    cmp-long p1, p2, v0

    if-eqz p1, :cond_1

    .line 106
    invoke-virtual {p0, p2, p3}, Lextern/okhttp3/internal/http1/Http1Codec;->newFixedLengthSink(J)Lextern/okio/Sink;

    move-result-object p1

    return-object p1

    .line 109
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Cannot stream a request body without chunked encoding or a known content length!"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method detachTimeout(Lextern/okio/ForwardingTimeout;)V
    .locals 2

    .line 269
    invoke-virtual {p1}, Lextern/okio/ForwardingTimeout;->delegate()Lextern/okio/Timeout;

    move-result-object v0

    .line 270
    sget-object v1, Lextern/okio/Timeout;->NONE:Lextern/okio/Timeout;

    invoke-virtual {p1, v1}, Lextern/okio/ForwardingTimeout;->setDelegate(Lextern/okio/Timeout;)Lextern/okio/ForwardingTimeout;

    .line 271
    invoke-virtual {v0}, Lextern/okio/Timeout;->clearDeadline()Lextern/okio/Timeout;

    .line 272
    invoke-virtual {v0}, Lextern/okio/Timeout;->clearTimeout()Lextern/okio/Timeout;

    return-void
.end method

.method public finishRequest()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 167
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->sink:Lextern/okio/BufferedSink;

    invoke-interface {v0}, Lextern/okio/BufferedSink;->flush()V

    return-void
.end method

.method public flushRequest()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 163
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->sink:Lextern/okio/BufferedSink;

    invoke-interface {v0}, Lextern/okio/BufferedSink;->flush()V

    return-void
.end method

.method public isClosed()Z
    .locals 2

    .line 159
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public newChunkedSink()Lextern/okio/Sink;
    .locals 3

    .line 232
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x2

    .line 233
    iput v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    .line 234
    new-instance v0, Lextern/okhttp3/internal/http1/Http1Codec$ChunkedSink;

    invoke-direct {v0, p0}, Lextern/okhttp3/internal/http1/Http1Codec$ChunkedSink;-><init>(Lextern/okhttp3/internal/http1/Http1Codec;)V

    return-object v0

    .line 232
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "state: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public newChunkedSource(Lextern/okhttp3/HttpUrl;)Lextern/okio/Source;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 250
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x5

    .line 251
    iput v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    .line 252
    new-instance v0, Lextern/okhttp3/internal/http1/Http1Codec$ChunkedSource;

    invoke-direct {v0, p0, p1}, Lextern/okhttp3/internal/http1/Http1Codec$ChunkedSource;-><init>(Lextern/okhttp3/internal/http1/Http1Codec;Lextern/okhttp3/HttpUrl;)V

    return-object v0

    .line 250
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "state: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public newFixedLengthSink(J)Lextern/okio/Sink;
    .locals 2

    .line 238
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x2

    .line 239
    iput v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    .line 240
    new-instance v0, Lextern/okhttp3/internal/http1/Http1Codec$FixedLengthSink;

    invoke-direct {v0, p0, p1, p2}, Lextern/okhttp3/internal/http1/Http1Codec$FixedLengthSink;-><init>(Lextern/okhttp3/internal/http1/Http1Codec;J)V

    return-object v0

    .line 238
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "state: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public newFixedLengthSource(J)Lextern/okio/Source;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 244
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x5

    .line 245
    iput v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    .line 246
    new-instance v0, Lextern/okhttp3/internal/http1/Http1Codec$FixedLengthSource;

    invoke-direct {v0, p0, p1, p2}, Lextern/okhttp3/internal/http1/Http1Codec$FixedLengthSource;-><init>(Lextern/okhttp3/internal/http1/Http1Codec;J)V

    return-object v0

    .line 244
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "state: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public newUnknownLengthSource()Lextern/okio/Source;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 256
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_1

    .line 257
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    if-eqz v0, :cond_0

    const/4 v1, 0x5

    .line 258
    iput v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    .line 259
    invoke-virtual {v0}, Lextern/okhttp3/internal/connection/StreamAllocation;->noNewStreams()V

    .line 260
    new-instance v0, Lextern/okhttp3/internal/http1/Http1Codec$UnknownLengthSource;

    invoke-direct {v0, p0}, Lextern/okhttp3/internal/http1/Http1Codec$UnknownLengthSource;-><init>(Lextern/okhttp3/internal/http1/Http1Codec;)V

    return-object v0

    .line 257
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "streamAllocation == null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 256
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "state: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public openResponseBody(Lextern/okhttp3/Response;)Lextern/okhttp3/ResponseBody;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 135
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    iget-object v0, v0, Lextern/okhttp3/internal/connection/StreamAllocation;->eventListener:Lextern/okhttp3/EventListener;

    iget-object v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    iget-object v1, v1, Lextern/okhttp3/internal/connection/StreamAllocation;->call:Lextern/okhttp3/Call;

    invoke-virtual {v0, v1}, Lextern/okhttp3/EventListener;->responseBodyStart(Lextern/okhttp3/Call;)V

    const-string v0, "Content-Type"

    .line 136
    invoke-virtual {p1, v0}, Lextern/okhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 138
    invoke-static {p1}, Lextern/okhttp3/internal/http/HttpHeaders;->hasBody(Lextern/okhttp3/Response;)Z

    move-result v1

    if-nez v1, :cond_0

    const-wide/16 v1, 0x0

    .line 139
    invoke-virtual {p0, v1, v2}, Lextern/okhttp3/internal/http1/Http1Codec;->newFixedLengthSource(J)Lextern/okio/Source;

    move-result-object p1

    .line 140
    new-instance v3, Lextern/okhttp3/internal/http/RealResponseBody;

    invoke-static {p1}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object p1

    invoke-direct {v3, v0, v1, v2, p1}, Lextern/okhttp3/internal/http/RealResponseBody;-><init>(Ljava/lang/String;JLextern/okio/BufferedSource;)V

    return-object v3

    :cond_0
    const-string v1, "Transfer-Encoding"

    .line 143
    invoke-virtual {p1, v1}, Lextern/okhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "chunked"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    const-wide/16 v2, -0x1

    if-eqz v1, :cond_1

    .line 144
    invoke-virtual {p1}, Lextern/okhttp3/Response;->request()Lextern/okhttp3/Request;

    move-result-object p1

    invoke-virtual {p1}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object p1

    invoke-virtual {p0, p1}, Lextern/okhttp3/internal/http1/Http1Codec;->newChunkedSource(Lextern/okhttp3/HttpUrl;)Lextern/okio/Source;

    move-result-object p1

    .line 145
    new-instance v1, Lextern/okhttp3/internal/http/RealResponseBody;

    invoke-static {p1}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object p1

    invoke-direct {v1, v0, v2, v3, p1}, Lextern/okhttp3/internal/http/RealResponseBody;-><init>(Ljava/lang/String;JLextern/okio/BufferedSource;)V

    return-object v1

    .line 148
    :cond_1
    invoke-static {p1}, Lextern/okhttp3/internal/http/HttpHeaders;->contentLength(Lextern/okhttp3/Response;)J

    move-result-wide v4

    cmp-long p1, v4, v2

    if-eqz p1, :cond_2

    .line 150
    invoke-virtual {p0, v4, v5}, Lextern/okhttp3/internal/http1/Http1Codec;->newFixedLengthSource(J)Lextern/okio/Source;

    move-result-object p1

    .line 151
    new-instance v1, Lextern/okhttp3/internal/http/RealResponseBody;

    invoke-static {p1}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object p1

    invoke-direct {v1, v0, v4, v5, p1}, Lextern/okhttp3/internal/http/RealResponseBody;-><init>(Ljava/lang/String;JLextern/okio/BufferedSource;)V

    return-object v1

    .line 154
    :cond_2
    new-instance p1, Lextern/okhttp3/internal/http/RealResponseBody;

    invoke-virtual {p0}, Lextern/okhttp3/internal/http1/Http1Codec;->newUnknownLengthSource()Lextern/okio/Source;

    move-result-object v1

    invoke-static {v1}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object v1

    invoke-direct {p1, v0, v2, v3, v1}, Lextern/okhttp3/internal/http/RealResponseBody;-><init>(Ljava/lang/String;JLextern/okio/BufferedSource;)V

    return-object p1
.end method

.method public readHeaders()Lextern/okhttp3/Headers;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 223
    new-instance v0, Lextern/okhttp3/Headers$Builder;

    invoke-direct {v0}, Lextern/okhttp3/Headers$Builder;-><init>()V

    .line 225
    :goto_0
    invoke-direct {p0}, Lextern/okhttp3/internal/http1/Http1Codec;->readHeaderLine()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_0

    .line 226
    sget-object v2, Lextern/okhttp3/internal/Internal;->instance:Lextern/okhttp3/internal/Internal;

    invoke-virtual {v2, v0, v1}, Lextern/okhttp3/internal/Internal;->addLenient(Lextern/okhttp3/Headers$Builder;Ljava/lang/String;)V

    goto :goto_0

    .line 228
    :cond_0
    invoke-virtual {v0}, Lextern/okhttp3/Headers$Builder;->build()Lextern/okhttp3/Headers;

    move-result-object v0

    return-object v0
.end method

.method public readResponseHeaders(Z)Lextern/okhttp3/Response$Builder;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 185
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    const/4 v1, 0x3

    const/4 v2, 0x1

    if-eq v0, v2, :cond_1

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 186
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "state: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 190
    :cond_1
    :goto_0
    :try_start_0
    invoke-direct {p0}, Lextern/okhttp3/internal/http1/Http1Codec;->readHeaderLine()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lextern/okhttp3/internal/http/StatusLine;->parse(Ljava/lang/String;)Lextern/okhttp3/internal/http/StatusLine;

    move-result-object v0

    .line 192
    new-instance v2, Lextern/okhttp3/Response$Builder;

    invoke-direct {v2}, Lextern/okhttp3/Response$Builder;-><init>()V

    iget-object v3, v0, Lextern/okhttp3/internal/http/StatusLine;->protocol:Lextern/okhttp3/Protocol;

    .line 193
    invoke-virtual {v2, v3}, Lextern/okhttp3/Response$Builder;->protocol(Lextern/okhttp3/Protocol;)Lextern/okhttp3/Response$Builder;

    move-result-object v2

    iget v3, v0, Lextern/okhttp3/internal/http/StatusLine;->code:I

    .line 194
    invoke-virtual {v2, v3}, Lextern/okhttp3/Response$Builder;->code(I)Lextern/okhttp3/Response$Builder;

    move-result-object v2

    iget-object v3, v0, Lextern/okhttp3/internal/http/StatusLine;->message:Ljava/lang/String;

    .line 195
    invoke-virtual {v2, v3}, Lextern/okhttp3/Response$Builder;->message(Ljava/lang/String;)Lextern/okhttp3/Response$Builder;

    move-result-object v2

    .line 196
    invoke-virtual {p0}, Lextern/okhttp3/internal/http1/Http1Codec;->readHeaders()Lextern/okhttp3/Headers;

    move-result-object v3

    invoke-virtual {v2, v3}, Lextern/okhttp3/Response$Builder;->headers(Lextern/okhttp3/Headers;)Lextern/okhttp3/Response$Builder;

    move-result-object v2

    const/16 v3, 0x64

    if-eqz p1, :cond_2

    .line 198
    iget p1, v0, Lextern/okhttp3/internal/http/StatusLine;->code:I

    if-ne p1, v3, :cond_2

    const/4 p1, 0x0

    return-object p1

    .line 200
    :cond_2
    iget p1, v0, Lextern/okhttp3/internal/http/StatusLine;->code:I

    if-ne p1, v3, :cond_3

    .line 201
    iput v1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    return-object v2

    :cond_3
    const/4 p1, 0x4

    .line 205
    iput p1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I
    :try_end_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    move-exception p1

    .line 209
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected end of stream on "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .line 210
    invoke-virtual {v0, p1}, Ljava/io/IOException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 211
    throw v0
.end method

.method public writeRequest(Lextern/okhttp3/Headers;Ljava/lang/String;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 172
    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    if-nez v0, :cond_1

    .line 173
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->sink:Lextern/okio/BufferedSink;

    invoke-interface {v0, p2}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    move-result-object p2

    const-string v0, "\r\n"

    invoke-interface {p2, v0}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    const/4 p2, 0x0

    .line 174
    invoke-virtual {p1}, Lextern/okhttp3/Headers;->size()I

    move-result v1

    :goto_0
    if-ge p2, v1, :cond_0

    .line 175
    iget-object v2, p0, Lextern/okhttp3/internal/http1/Http1Codec;->sink:Lextern/okio/BufferedSink;

    invoke-virtual {p1, p2}, Lextern/okhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    move-result-object v2

    const-string v3, ": "

    .line 176
    invoke-interface {v2, v3}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    move-result-object v2

    .line 177
    invoke-virtual {p1, p2}, Lextern/okhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    move-result-object v2

    .line 178
    invoke-interface {v2, v0}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 180
    :cond_0
    iget-object p1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->sink:Lextern/okio/BufferedSink;

    invoke-interface {p1, v0}, Lextern/okio/BufferedSink;->writeUtf8(Ljava/lang/String;)Lextern/okio/BufferedSink;

    const/4 p1, 0x1

    .line 181
    iput p1, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    return-void

    .line 172
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "state: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->state:I

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw p1

    :goto_2
    goto :goto_1
.end method

.method public writeRequestHeaders(Lextern/okhttp3/Request;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 129
    iget-object v0, p0, Lextern/okhttp3/internal/http1/Http1Codec;->streamAllocation:Lextern/okhttp3/internal/connection/StreamAllocation;

    .line 130
    invoke-virtual {v0}, Lextern/okhttp3/internal/connection/StreamAllocation;->connection()Lextern/okhttp3/internal/connection/RealConnection;

    move-result-object v0

    invoke-virtual {v0}, Lextern/okhttp3/internal/connection/RealConnection;->route()Lextern/okhttp3/Route;

    move-result-object v0

    invoke-virtual {v0}, Lextern/okhttp3/Route;->proxy()Ljava/net/Proxy;

    move-result-object v0

    invoke-virtual {v0}, Ljava/net/Proxy;->type()Ljava/net/Proxy$Type;

    move-result-object v0

    .line 129
    invoke-static {p1, v0}, Lextern/okhttp3/internal/http/RequestLine;->get(Lextern/okhttp3/Request;Ljava/net/Proxy$Type;)Ljava/lang/String;

    move-result-object v0

    .line 131
    invoke-virtual {p1}, Lextern/okhttp3/Request;->headers()Lextern/okhttp3/Headers;

    move-result-object p1

    invoke-virtual {p0, p1, v0}, Lextern/okhttp3/internal/http1/Http1Codec;->writeRequest(Lextern/okhttp3/Headers;Ljava/lang/String;)V

    return-void
.end method
