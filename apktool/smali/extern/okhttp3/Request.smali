.class public final Lextern/okhttp3/Request;
.super Ljava/lang/Object;
.source "Request.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/Request$Builder;
    }
.end annotation


# instance fields
.field final body:Lextern/okhttp3/RequestBody;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field private volatile cacheControl:Lextern/okhttp3/CacheControl;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field final headers:Lextern/okhttp3/Headers;

.field final method:Ljava/lang/String;

.field final tags:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field final url:Lextern/okhttp3/HttpUrl;


# direct methods
.method constructor <init>(Lextern/okhttp3/Request$Builder;)V
    .locals 1

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    iget-object v0, p1, Lextern/okhttp3/Request$Builder;->url:Lextern/okhttp3/HttpUrl;

    iput-object v0, p0, Lextern/okhttp3/Request;->url:Lextern/okhttp3/HttpUrl;

    .line 43
    iget-object v0, p1, Lextern/okhttp3/Request$Builder;->method:Ljava/lang/String;

    iput-object v0, p0, Lextern/okhttp3/Request;->method:Ljava/lang/String;

    .line 44
    iget-object v0, p1, Lextern/okhttp3/Request$Builder;->headers:Lextern/okhttp3/Headers$Builder;

    invoke-virtual {v0}, Lextern/okhttp3/Headers$Builder;->build()Lextern/okhttp3/Headers;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/Request;->headers:Lextern/okhttp3/Headers;

    .line 45
    iget-object v0, p1, Lextern/okhttp3/Request$Builder;->body:Lextern/okhttp3/RequestBody;

    iput-object v0, p0, Lextern/okhttp3/Request;->body:Lextern/okhttp3/RequestBody;

    .line 46
    iget-object p1, p1, Lextern/okhttp3/Request$Builder;->tags:Ljava/util/Map;

    invoke-static {p1}, Lextern/okhttp3/internal/Util;->immutableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/Request;->tags:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public body()Lextern/okhttp3/RequestBody;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 70
    iget-object v0, p0, Lextern/okhttp3/Request;->body:Lextern/okhttp3/RequestBody;

    return-object v0
.end method

.method public cacheControl()Lextern/okhttp3/CacheControl;
    .locals 1

    .line 102
    iget-object v0, p0, Lextern/okhttp3/Request;->cacheControl:Lextern/okhttp3/CacheControl;

    if-eqz v0, :cond_0

    goto :goto_0

    .line 103
    :cond_0
    iget-object v0, p0, Lextern/okhttp3/Request;->headers:Lextern/okhttp3/Headers;

    invoke-static {v0}, Lextern/okhttp3/CacheControl;->parse(Lextern/okhttp3/Headers;)Lextern/okhttp3/CacheControl;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/Request;->cacheControl:Lextern/okhttp3/CacheControl;

    :goto_0
    return-object v0
.end method

.method public header(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 62
    iget-object v0, p0, Lextern/okhttp3/Request;->headers:Lextern/okhttp3/Headers;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public headers()Lextern/okhttp3/Headers;
    .locals 1

    .line 58
    iget-object v0, p0, Lextern/okhttp3/Request;->headers:Lextern/okhttp3/Headers;

    return-object v0
.end method

.method public headers(Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 66
    iget-object v0, p0, Lextern/okhttp3/Request;->headers:Lextern/okhttp3/Headers;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Headers;->values(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public isHttps()Z
    .locals 1

    .line 107
    iget-object v0, p0, Lextern/okhttp3/Request;->url:Lextern/okhttp3/HttpUrl;

    invoke-virtual {v0}, Lextern/okhttp3/HttpUrl;->isHttps()Z

    move-result v0

    return v0
.end method

.method public method()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lextern/okhttp3/Request;->method:Ljava/lang/String;

    return-object v0
.end method

.method public newBuilder()Lextern/okhttp3/Request$Builder;
    .locals 1

    .line 94
    new-instance v0, Lextern/okhttp3/Request$Builder;

    invoke-direct {v0, p0}, Lextern/okhttp3/Request$Builder;-><init>(Lextern/okhttp3/Request;)V

    return-object v0
.end method

.method public tag()Ljava/lang/Object;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 82
    const-class v0, Ljava/lang/Object;

    invoke-virtual {p0, v0}, Lextern/okhttp3/Request;->tag(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public tag(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "+TT;>;)TT;"
        }
    .end annotation

    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 90
    iget-object v0, p0, Lextern/okhttp3/Request;->tags:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/Class;->cast(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 111
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Request{method="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lextern/okhttp3/Request;->method:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ", url="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lextern/okhttp3/Request;->url:Lextern/okhttp3/HttpUrl;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", tags="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lextern/okhttp3/Request;->tags:Ljava/util/Map;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public url()Lextern/okhttp3/HttpUrl;
    .locals 1

    .line 50
    iget-object v0, p0, Lextern/okhttp3/Request;->url:Lextern/okhttp3/HttpUrl;

    return-object v0
.end method
