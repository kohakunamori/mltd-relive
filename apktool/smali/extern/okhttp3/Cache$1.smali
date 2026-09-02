.class Lextern/okhttp3/Cache$1;
.super Ljava/lang/Object;
.source "Cache.java"

# interfaces
.implements Lextern/okhttp3/internal/cache/InternalCache;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/Cache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lextern/okhttp3/Cache;


# direct methods
.method constructor <init>(Lextern/okhttp3/Cache;)V
    .locals 0

    .line 144
    iput-object p1, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public get(Lextern/okhttp3/Request;)Lextern/okhttp3/Response;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 146
    iget-object v0, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Cache;->get(Lextern/okhttp3/Request;)Lextern/okhttp3/Response;

    move-result-object p1

    return-object p1
.end method

.method public put(Lextern/okhttp3/Response;)Lextern/okhttp3/internal/cache/CacheRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 150
    iget-object v0, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Cache;->put(Lextern/okhttp3/Response;)Lextern/okhttp3/internal/cache/CacheRequest;

    move-result-object p1

    return-object p1
.end method

.method public remove(Lextern/okhttp3/Request;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 154
    iget-object v0, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Cache;->remove(Lextern/okhttp3/Request;)V

    return-void
.end method

.method public trackConditionalCacheHit()V
    .locals 1

    .line 162
    iget-object v0, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-virtual {v0}, Lextern/okhttp3/Cache;->trackConditionalCacheHit()V

    return-void
.end method

.method public trackResponse(Lextern/okhttp3/internal/cache/CacheStrategy;)V
    .locals 1

    .line 166
    iget-object v0, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-virtual {v0, p1}, Lextern/okhttp3/Cache;->trackResponse(Lextern/okhttp3/internal/cache/CacheStrategy;)V

    return-void
.end method

.method public update(Lextern/okhttp3/Response;Lextern/okhttp3/Response;)V
    .locals 1

    .line 158
    iget-object v0, p0, Lextern/okhttp3/Cache$1;->this$0:Lextern/okhttp3/Cache;

    invoke-virtual {v0, p1, p2}, Lextern/okhttp3/Cache;->update(Lextern/okhttp3/Response;Lextern/okhttp3/Response;)V

    return-void
.end method
