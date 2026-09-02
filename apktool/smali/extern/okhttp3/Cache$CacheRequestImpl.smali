.class final Lextern/okhttp3/Cache$CacheRequestImpl;
.super Ljava/lang/Object;
.source "Cache.java"

# interfaces
.implements Lextern/okhttp3/internal/cache/CacheRequest;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/Cache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "CacheRequestImpl"
.end annotation


# instance fields
.field private body:Lextern/okio/Sink;

.field private cacheOut:Lextern/okio/Sink;

.field done:Z

.field private final editor:Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

.field final synthetic this$0:Lextern/okhttp3/Cache;


# direct methods
.method constructor <init>(Lextern/okhttp3/Cache;Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V
    .locals 2

    .line 441
    iput-object p1, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->this$0:Lextern/okhttp3/Cache;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 442
    iput-object p2, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->editor:Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

    const/4 v0, 0x1

    .line 443
    invoke-virtual {p2, v0}, Lextern/okhttp3/internal/cache/DiskLruCache$Editor;->newSink(I)Lextern/okio/Sink;

    move-result-object v0

    iput-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->cacheOut:Lextern/okio/Sink;

    .line 444
    new-instance v0, Lextern/okhttp3/Cache$CacheRequestImpl$1;

    iget-object v1, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->cacheOut:Lextern/okio/Sink;

    invoke-direct {v0, p0, v1, p1, p2}, Lextern/okhttp3/Cache$CacheRequestImpl$1;-><init>(Lextern/okhttp3/Cache$CacheRequestImpl;Lextern/okio/Sink;Lextern/okhttp3/Cache;Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V

    iput-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->body:Lextern/okio/Sink;

    return-void
.end method


# virtual methods
.method public abort()V
    .locals 4

    .line 460
    iget-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->this$0:Lextern/okhttp3/Cache;

    monitor-enter v0

    .line 461
    :try_start_0
    iget-boolean v1, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->done:Z

    if-eqz v1, :cond_0

    .line 462
    monitor-exit v0

    return-void

    :cond_0
    const/4 v1, 0x1

    .line 464
    iput-boolean v1, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->done:Z

    .line 465
    iget-object v2, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->this$0:Lextern/okhttp3/Cache;

    iget v3, v2, Lextern/okhttp3/Cache;->writeAbortCount:I

    add-int/2addr v3, v1

    iput v3, v2, Lextern/okhttp3/Cache;->writeAbortCount:I

    .line 466
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 467
    iget-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->cacheOut:Lextern/okio/Sink;

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 469
    :try_start_1
    iget-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->editor:Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache$Editor;->abort()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :catchall_0
    move-exception v1

    .line 466
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method public body()Lextern/okio/Sink;
    .locals 1

    .line 475
    iget-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl;->body:Lextern/okio/Sink;

    return-object v0
.end method
