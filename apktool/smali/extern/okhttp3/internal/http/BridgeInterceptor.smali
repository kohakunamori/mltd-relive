.class public final Lextern/okhttp3/internal/http/BridgeInterceptor;
.super Ljava/lang/Object;
.source "BridgeInterceptor.java"

# interfaces
.implements Lextern/okhttp3/Interceptor;


# instance fields
.field private final cookieJar:Lextern/okhttp3/CookieJar;


# direct methods
.method public constructor <init>(Lextern/okhttp3/CookieJar;)V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    iput-object p1, p0, Lextern/okhttp3/internal/http/BridgeInterceptor;->cookieJar:Lextern/okhttp3/CookieJar;

    return-void
.end method

.method private cookieHeader(Ljava/util/List;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lextern/okhttp3/Cookie;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 118
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 119
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    if-lez v2, :cond_0

    const-string v3, "; "

    .line 121
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 123
    :cond_0
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lextern/okhttp3/Cookie;

    .line 124
    invoke-virtual {v3}, Lextern/okhttp3/Cookie;->name()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v4, 0x3d

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Lextern/okhttp3/Cookie;->value()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 126
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public intercept(Lextern/okhttp3/Interceptor$Chain;)Lextern/okhttp3/Response;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 48
    invoke-interface {p1}, Lextern/okhttp3/Interceptor$Chain;->request()Lextern/okhttp3/Request;

    move-result-object v0

    .line 49
    invoke-virtual {v0}, Lextern/okhttp3/Request;->newBuilder()Lextern/okhttp3/Request$Builder;

    move-result-object v1

    .line 51
    invoke-virtual {v0}, Lextern/okhttp3/Request;->body()Lextern/okhttp3/RequestBody;

    move-result-object v2

    const-string v3, "Content-Type"

    const-wide/16 v4, -0x1

    const-string v6, "Content-Length"

    if-eqz v2, :cond_2

    .line 53
    invoke-virtual {v2}, Lextern/okhttp3/RequestBody;->contentType()Lextern/okhttp3/MediaType;

    move-result-object v7

    if-eqz v7, :cond_0

    .line 55
    invoke-virtual {v7}, Lextern/okhttp3/MediaType;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v3, v7}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    .line 58
    :cond_0
    invoke-virtual {v2}, Lextern/okhttp3/RequestBody;->contentLength()J

    move-result-wide v7

    const-string v2, "Transfer-Encoding"

    cmp-long v9, v7, v4

    if-eqz v9, :cond_1

    .line 60
    invoke-static {v7, v8}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v6, v7}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    .line 61
    invoke-virtual {v1, v2}, Lextern/okhttp3/Request$Builder;->removeHeader(Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    goto :goto_0

    :cond_1
    const-string v7, "chunked"

    .line 63
    invoke-virtual {v1, v2, v7}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    .line 64
    invoke-virtual {v1, v6}, Lextern/okhttp3/Request$Builder;->removeHeader(Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    :cond_2
    :goto_0
    const-string v2, "Host"

    .line 68
    invoke-virtual {v0, v2}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    if-nez v7, :cond_3

    .line 69
    invoke-virtual {v0}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object v7

    invoke-static {v7, v8}, Lextern/okhttp3/internal/Util;->hostHeader(Lextern/okhttp3/HttpUrl;Z)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v2, v7}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    :cond_3
    const-string v2, "Connection"

    .line 72
    invoke-virtual {v0, v2}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_4

    const-string v7, "Keep-Alive"

    .line 73
    invoke-virtual {v1, v2, v7}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    :cond_4
    const-string v2, "Accept-Encoding"

    .line 79
    invoke-virtual {v0, v2}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v9, "gzip"

    if-nez v7, :cond_5

    const-string v7, "Range"

    invoke-virtual {v0, v7}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_5

    const/4 v8, 0x1

    .line 81
    invoke-virtual {v1, v2, v9}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    .line 84
    :cond_5
    iget-object v2, p0, Lextern/okhttp3/internal/http/BridgeInterceptor;->cookieJar:Lextern/okhttp3/CookieJar;

    invoke-virtual {v0}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object v7

    invoke-interface {v2, v7}, Lextern/okhttp3/CookieJar;->loadForRequest(Lextern/okhttp3/HttpUrl;)Ljava/util/List;

    move-result-object v2

    .line 85
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_6

    .line 86
    invoke-direct {p0, v2}, Lextern/okhttp3/internal/http/BridgeInterceptor;->cookieHeader(Ljava/util/List;)Ljava/lang/String;

    move-result-object v2

    const-string v7, "Cookie"

    invoke-virtual {v1, v7, v2}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    :cond_6
    const-string v2, "User-Agent"

    .line 89
    invoke-virtual {v0, v2}, Lextern/okhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_7

    .line 90
    invoke-static {}, Lextern/okhttp3/internal/Version;->userAgent()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v2, v7}, Lextern/okhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lextern/okhttp3/Request$Builder;

    .line 93
    :cond_7
    invoke-virtual {v1}, Lextern/okhttp3/Request$Builder;->build()Lextern/okhttp3/Request;

    move-result-object v1

    invoke-interface {p1, v1}, Lextern/okhttp3/Interceptor$Chain;->proceed(Lextern/okhttp3/Request;)Lextern/okhttp3/Response;

    move-result-object p1

    .line 95
    iget-object v1, p0, Lextern/okhttp3/internal/http/BridgeInterceptor;->cookieJar:Lextern/okhttp3/CookieJar;

    invoke-virtual {v0}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object v2

    invoke-virtual {p1}, Lextern/okhttp3/Response;->headers()Lextern/okhttp3/Headers;

    move-result-object v7

    invoke-static {v1, v2, v7}, Lextern/okhttp3/internal/http/HttpHeaders;->receiveHeaders(Lextern/okhttp3/CookieJar;Lextern/okhttp3/HttpUrl;Lextern/okhttp3/Headers;)V

    .line 97
    invoke-virtual {p1}, Lextern/okhttp3/Response;->newBuilder()Lextern/okhttp3/Response$Builder;

    move-result-object v1

    .line 98
    invoke-virtual {v1, v0}, Lextern/okhttp3/Response$Builder;->request(Lextern/okhttp3/Request;)Lextern/okhttp3/Response$Builder;

    move-result-object v0

    if-eqz v8, :cond_8

    const-string v1, "Content-Encoding"

    .line 101
    invoke-virtual {p1, v1}, Lextern/okhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v9, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 102
    invoke-static {p1}, Lextern/okhttp3/internal/http/HttpHeaders;->hasBody(Lextern/okhttp3/Response;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 103
    new-instance v2, Lextern/okio/GzipSource;

    invoke-virtual {p1}, Lextern/okhttp3/Response;->body()Lextern/okhttp3/ResponseBody;

    move-result-object v7

    invoke-virtual {v7}, Lextern/okhttp3/ResponseBody;->source()Lextern/okio/BufferedSource;

    move-result-object v7

    invoke-direct {v2, v7}, Lextern/okio/GzipSource;-><init>(Lextern/okio/Source;)V

    .line 104
    invoke-virtual {p1}, Lextern/okhttp3/Response;->headers()Lextern/okhttp3/Headers;

    move-result-object v7

    invoke-virtual {v7}, Lextern/okhttp3/Headers;->newBuilder()Lextern/okhttp3/Headers$Builder;

    move-result-object v7

    .line 105
    invoke-virtual {v7, v1}, Lextern/okhttp3/Headers$Builder;->removeAll(Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    move-result-object v1

    .line 106
    invoke-virtual {v1, v6}, Lextern/okhttp3/Headers$Builder;->removeAll(Ljava/lang/String;)Lextern/okhttp3/Headers$Builder;

    move-result-object v1

    .line 107
    invoke-virtual {v1}, Lextern/okhttp3/Headers$Builder;->build()Lextern/okhttp3/Headers;

    move-result-object v1

    .line 108
    invoke-virtual {v0, v1}, Lextern/okhttp3/Response$Builder;->headers(Lextern/okhttp3/Headers;)Lextern/okhttp3/Response$Builder;

    .line 109
    invoke-virtual {p1, v3}, Lextern/okhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 110
    new-instance v1, Lextern/okhttp3/internal/http/RealResponseBody;

    invoke-static {v2}, Lextern/okio/Okio;->buffer(Lextern/okio/Source;)Lextern/okio/BufferedSource;

    move-result-object v2

    invoke-direct {v1, p1, v4, v5, v2}, Lextern/okhttp3/internal/http/RealResponseBody;-><init>(Ljava/lang/String;JLextern/okio/BufferedSource;)V

    invoke-virtual {v0, v1}, Lextern/okhttp3/Response$Builder;->body(Lextern/okhttp3/ResponseBody;)Lextern/okhttp3/Response$Builder;

    .line 113
    :cond_8
    invoke-virtual {v0}, Lextern/okhttp3/Response$Builder;->build()Lextern/okhttp3/Response;

    move-result-object p1

    return-object p1
.end method
