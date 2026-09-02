.class Lextern/okhttp3/Cache$CacheRequestImpl$1;
.super Lextern/okio/ForwardingSink;
.source "Cache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/Cache$CacheRequestImpl;-><init>(Lextern/okhttp3/Cache;Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lextern/okhttp3/Cache$CacheRequestImpl;

.field final synthetic val$editor:Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

.field final synthetic val$this$0:Lextern/okhttp3/Cache;


# direct methods
.method constructor <init>(Lextern/okhttp3/Cache$CacheRequestImpl;Lextern/okio/Sink;Lextern/okhttp3/Cache;Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V
    .locals 0

    .line 444
    iput-object p1, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->this$1:Lextern/okhttp3/Cache$CacheRequestImpl;

    iput-object p3, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->val$this$0:Lextern/okhttp3/Cache;

    iput-object p4, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->val$editor:Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

    invoke-direct {p0, p2}, Lextern/okio/ForwardingSink;-><init>(Lextern/okio/Sink;)V

    return-void
.end method


# virtual methods
.method public close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 446
    iget-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->this$1:Lextern/okhttp3/Cache$CacheRequestImpl;

    iget-object v0, v0, Lextern/okhttp3/Cache$CacheRequestImpl;->this$0:Lextern/okhttp3/Cache;

    monitor-enter v0

    .line 447
    :try_start_0
    iget-object v1, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->this$1:Lextern/okhttp3/Cache$CacheRequestImpl;

    iget-boolean v1, v1, Lextern/okhttp3/Cache$CacheRequestImpl;->done:Z

    if-eqz v1, :cond_0

    .line 448
    monitor-exit v0

    return-void

    .line 450
    :cond_0
    iget-object v1, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->this$1:Lextern/okhttp3/Cache$CacheRequestImpl;

    const/4 v2, 0x1

    iput-boolean v2, v1, Lextern/okhttp3/Cache$CacheRequestImpl;->done:Z

    .line 451
    iget-object v1, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->this$1:Lextern/okhttp3/Cache$CacheRequestImpl;

    iget-object v1, v1, Lextern/okhttp3/Cache$CacheRequestImpl;->this$0:Lextern/okhttp3/Cache;

    iget v3, v1, Lextern/okhttp3/Cache;->writeSuccessCount:I

    add-int/2addr v3, v2

    iput v3, v1, Lextern/okhttp3/Cache;->writeSuccessCount:I

    .line 452
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 453
    invoke-super {p0}, Lextern/okio/ForwardingSink;->close()V

    .line 454
    iget-object v0, p0, Lextern/okhttp3/Cache$CacheRequestImpl$1;->val$editor:Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache$Editor;->commit()V

    return-void

    :catchall_0
    move-exception v1

    .line 452
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method
