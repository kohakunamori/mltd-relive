.class public final Lextern/okhttp3/Cache;
.super Ljava/lang/Object;
.source "Cache.java"

# interfaces
.implements Ljava/io/Closeable;
.implements Ljava/io/Flushable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lextern/okhttp3/Cache$CacheResponseBody;,
        Lextern/okhttp3/Cache$Entry;,
        Lextern/okhttp3/Cache$CacheRequestImpl;
    }
.end annotation


# static fields
.field private static final ENTRY_BODY:I = 0x1

.field private static final ENTRY_COUNT:I = 0x2

.field private static final ENTRY_METADATA:I = 0x0

.field private static final VERSION:I = 0x31191


# instance fields
.field final cache:Lextern/okhttp3/internal/cache/DiskLruCache;

.field private hitCount:I

.field final internalCache:Lextern/okhttp3/internal/cache/InternalCache;

.field private networkCount:I

.field private requestCount:I

.field writeAbortCount:I

.field writeSuccessCount:I


# direct methods
.method public constructor <init>(Ljava/io/File;J)V
    .locals 1

    .line 183
    sget-object v0, Lextern/okhttp3/internal/io/FileSystem;->SYSTEM:Lextern/okhttp3/internal/io/FileSystem;

    invoke-direct {p0, p1, p2, p3, v0}, Lextern/okhttp3/Cache;-><init>(Ljava/io/File;JLextern/okhttp3/internal/io/FileSystem;)V

    return-void
.end method

.method constructor <init>(Ljava/io/File;JLextern/okhttp3/internal/io/FileSystem;)V
    .locals 7

    .line 186
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 144
    new-instance v0, Lextern/okhttp3/Cache$1;

    invoke-direct {v0, p0}, Lextern/okhttp3/Cache$1;-><init>(Lextern/okhttp3/Cache;)V

    iput-object v0, p0, Lextern/okhttp3/Cache;->internalCache:Lextern/okhttp3/internal/cache/InternalCache;

    const v3, 0x31191

    const/4 v4, 0x2

    move-object v1, p4

    move-object v2, p1

    move-wide v5, p2

    .line 187
    invoke-static/range {v1 .. v6}, Lextern/okhttp3/internal/cache/DiskLruCache;->create(Lextern/okhttp3/internal/io/FileSystem;Ljava/io/File;IIJ)Lextern/okhttp3/internal/cache/DiskLruCache;

    move-result-object p1

    iput-object p1, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    return-void
.end method

.method private abortQuietly(Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V
    .locals 0
    .param p1    # Lextern/okhttp3/internal/cache/DiskLruCache$Editor;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    if-eqz p1, :cond_0

    .line 285
    :try_start_0
    invoke-virtual {p1}, Lextern/okhttp3/internal/cache/DiskLruCache$Editor;->abort()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static key(Lextern/okhttp3/HttpUrl;)Ljava/lang/String;
    .locals 0

    .line 191
    invoke-virtual {p0}, Lextern/okhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lextern/okio/ByteString;->encodeUtf8(Ljava/lang/String;)Lextern/okio/ByteString;

    move-result-object p0

    invoke-virtual {p0}, Lextern/okio/ByteString;->md5()Lextern/okio/ByteString;

    move-result-object p0

    invoke-virtual {p0}, Lextern/okio/ByteString;->hex()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static readInt(Lextern/okio/BufferedSource;)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 727
    :try_start_0
    invoke-interface {p0}, Lextern/okio/BufferedSource;->readDecimalLong()J

    move-result-wide v0

    .line 728
    invoke-interface {p0}, Lextern/okio/BufferedSource;->readUtf8LineStrict()Ljava/lang/String;

    move-result-object p0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-ltz v4, :cond_0

    const-wide/32 v2, 0x7fffffff

    cmp-long v4, v0, v2

    if-gtz v4, :cond_0

    .line 729
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    long-to-int p0, v0

    return p0

    .line 730
    :cond_0
    new-instance v2, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "expected an int but was \""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "\""

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p0

    .line 734
    new-instance v0, Ljava/io/IOException;

    invoke-virtual {p0}, Ljava/lang/NumberFormatException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 396
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->close()V

    return-void
.end method

.method public delete()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 311
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->delete()V

    return-void
.end method

.method public directory()Ljava/io/File;
    .locals 1

    .line 400
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->getDirectory()Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method public evictAll()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 319
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->evictAll()V

    return-void
.end method

.method public flush()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 392
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->flush()V

    return-void
.end method

.method get(Lextern/okhttp3/Request;)Lextern/okhttp3/Response;
    .locals 4
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 195
    invoke-virtual {p1}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object v0

    invoke-static {v0}, Lextern/okhttp3/Cache;->key(Lextern/okhttp3/HttpUrl;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    .line 199
    :try_start_0
    iget-object v2, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v2, v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->get(Ljava/lang/String;)Lextern/okhttp3/internal/cache/DiskLruCache$Snapshot;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v0, :cond_0

    return-object v1

    .line 209
    :cond_0
    :try_start_1
    new-instance v2, Lextern/okhttp3/Cache$Entry;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lextern/okhttp3/internal/cache/DiskLruCache$Snapshot;->getSource(I)Lextern/okio/Source;

    move-result-object v3

    invoke-direct {v2, v3}, Lextern/okhttp3/Cache$Entry;-><init>(Lextern/okio/Source;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 215
    invoke-virtual {v2, v0}, Lextern/okhttp3/Cache$Entry;->response(Lextern/okhttp3/internal/cache/DiskLruCache$Snapshot;)Lextern/okhttp3/Response;

    move-result-object v0

    .line 217
    invoke-virtual {v2, p1, v0}, Lextern/okhttp3/Cache$Entry;->matches(Lextern/okhttp3/Request;Lextern/okhttp3/Response;)Z

    move-result p1

    if-nez p1, :cond_1

    .line 218
    invoke-virtual {v0}, Lextern/okhttp3/Response;->body()Lextern/okhttp3/ResponseBody;

    move-result-object p1

    invoke-static {p1}, Lextern/okhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    return-object v1

    :cond_1
    return-object v0

    .line 211
    :catch_0
    invoke-static {v0}, Lextern/okhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    :catch_1
    return-object v1
.end method

.method public declared-synchronized hitCount()I
    .locals 1

    monitor-enter p0

    .line 428
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->hitCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public initialize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 303
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->initialize()V

    return-void
.end method

.method public isClosed()Z
    .locals 1

    .line 404
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->isClosed()Z

    move-result v0

    return v0
.end method

.method public maxSize()J
    .locals 2

    .line 388
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->getMaxSize()J

    move-result-wide v0

    return-wide v0
.end method

.method public declared-synchronized networkCount()I
    .locals 1

    monitor-enter p0

    .line 424
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->networkCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method put(Lextern/okhttp3/Response;)Lextern/okhttp3/internal/cache/CacheRequest;
    .locals 3
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 226
    invoke-virtual {p1}, Lextern/okhttp3/Response;->request()Lextern/okhttp3/Request;

    move-result-object v0

    invoke-virtual {v0}, Lextern/okhttp3/Request;->method()Ljava/lang/String;

    move-result-object v0

    .line 228
    invoke-virtual {p1}, Lextern/okhttp3/Response;->request()Lextern/okhttp3/Request;

    move-result-object v1

    invoke-virtual {v1}, Lextern/okhttp3/Request;->method()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lextern/okhttp3/internal/http/HttpMethod;->invalidatesCache(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 230
    :try_start_0
    invoke-virtual {p1}, Lextern/okhttp3/Response;->request()Lextern/okhttp3/Request;

    move-result-object p1

    invoke-virtual {p0, p1}, Lextern/okhttp3/Cache;->remove(Lextern/okhttp3/Request;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object v2

    :cond_0
    const-string v1, "GET"

    .line 236
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    return-object v2

    .line 243
    :cond_1
    invoke-static {p1}, Lextern/okhttp3/internal/http/HttpHeaders;->hasVaryAll(Lextern/okhttp3/Response;)Z

    move-result v0

    if-eqz v0, :cond_2

    return-object v2

    .line 247
    :cond_2
    new-instance v0, Lextern/okhttp3/Cache$Entry;

    invoke-direct {v0, p1}, Lextern/okhttp3/Cache$Entry;-><init>(Lextern/okhttp3/Response;)V

    .line 250
    :try_start_1
    iget-object v1, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {p1}, Lextern/okhttp3/Response;->request()Lextern/okhttp3/Request;

    move-result-object p1

    invoke-virtual {p1}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object p1

    invoke-static {p1}, Lextern/okhttp3/Cache;->key(Lextern/okhttp3/HttpUrl;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lextern/okhttp3/internal/cache/DiskLruCache;->edit(Ljava/lang/String;)Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

    move-result-object p1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    if-nez p1, :cond_3

    return-object v2

    .line 254
    :cond_3
    :try_start_2
    invoke-virtual {v0, p1}, Lextern/okhttp3/Cache$Entry;->writeTo(Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V

    .line 255
    new-instance v0, Lextern/okhttp3/Cache$CacheRequestImpl;

    invoke-direct {v0, p0, p1}, Lextern/okhttp3/Cache$CacheRequestImpl;-><init>(Lextern/okhttp3/Cache;Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    return-object v0

    :catch_1
    move-object p1, v2

    .line 257
    :catch_2
    invoke-direct {p0, p1}, Lextern/okhttp3/Cache;->abortQuietly(Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V

    return-object v2
.end method

.method remove(Lextern/okhttp3/Request;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 263
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {p1}, Lextern/okhttp3/Request;->url()Lextern/okhttp3/HttpUrl;

    move-result-object p1

    invoke-static {p1}, Lextern/okhttp3/Cache;->key(Lextern/okhttp3/HttpUrl;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lextern/okhttp3/internal/cache/DiskLruCache;->remove(Ljava/lang/String;)Z

    return-void
.end method

.method public declared-synchronized requestCount()I
    .locals 1

    monitor-enter p0

    .line 432
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->requestCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public size()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 383
    iget-object v0, p0, Lextern/okhttp3/Cache;->cache:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-virtual {v0}, Lextern/okhttp3/internal/cache/DiskLruCache;->size()J

    move-result-wide v0

    return-wide v0
.end method

.method declared-synchronized trackConditionalCacheHit()V
    .locals 1

    monitor-enter p0

    .line 420
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->hitCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lextern/okhttp3/Cache;->hitCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 421
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method declared-synchronized trackResponse(Lextern/okhttp3/internal/cache/CacheStrategy;)V
    .locals 1

    monitor-enter p0

    .line 408
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->requestCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lextern/okhttp3/Cache;->requestCount:I

    .line 410
    iget-object v0, p1, Lextern/okhttp3/internal/cache/CacheStrategy;->networkRequest:Lextern/okhttp3/Request;

    if-eqz v0, :cond_0

    .line 412
    iget p1, p0, Lextern/okhttp3/Cache;->networkCount:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lextern/okhttp3/Cache;->networkCount:I

    goto :goto_0

    .line 413
    :cond_0
    iget-object p1, p1, Lextern/okhttp3/internal/cache/CacheStrategy;->cacheResponse:Lextern/okhttp3/Response;

    if-eqz p1, :cond_1

    .line 415
    iget p1, p0, Lextern/okhttp3/Cache;->hitCount:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lextern/okhttp3/Cache;->hitCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 417
    :cond_1
    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method update(Lextern/okhttp3/Response;Lextern/okhttp3/Response;)V
    .locals 1

    .line 267
    new-instance v0, Lextern/okhttp3/Cache$Entry;

    invoke-direct {v0, p2}, Lextern/okhttp3/Cache$Entry;-><init>(Lextern/okhttp3/Response;)V

    .line 268
    invoke-virtual {p1}, Lextern/okhttp3/Response;->body()Lextern/okhttp3/ResponseBody;

    move-result-object p1

    check-cast p1, Lextern/okhttp3/Cache$CacheResponseBody;

    iget-object p1, p1, Lextern/okhttp3/Cache$CacheResponseBody;->snapshot:Lextern/okhttp3/internal/cache/DiskLruCache$Snapshot;

    .line 271
    :try_start_0
    invoke-virtual {p1}, Lextern/okhttp3/internal/cache/DiskLruCache$Snapshot;->edit()Lextern/okhttp3/internal/cache/DiskLruCache$Editor;

    move-result-object p1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p1, :cond_0

    .line 273
    :try_start_1
    invoke-virtual {v0, p1}, Lextern/okhttp3/Cache$Entry;->writeTo(Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V

    .line 274
    invoke-virtual {p1}, Lextern/okhttp3/internal/cache/DiskLruCache$Editor;->commit()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    const/4 p1, 0x0

    .line 277
    :catch_1
    invoke-direct {p0, p1}, Lextern/okhttp3/Cache;->abortQuietly(Lextern/okhttp3/internal/cache/DiskLruCache$Editor;)V

    :cond_0
    :goto_0
    return-void
.end method

.method public urls()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 332
    new-instance v0, Lextern/okhttp3/Cache$2;

    invoke-direct {v0, p0}, Lextern/okhttp3/Cache$2;-><init>(Lextern/okhttp3/Cache;)V

    return-object v0
.end method

.method public declared-synchronized writeAbortCount()I
    .locals 1

    monitor-enter p0

    .line 375
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->writeAbortCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized writeSuccessCount()I
    .locals 1

    monitor-enter p0

    .line 379
    :try_start_0
    iget v0, p0, Lextern/okhttp3/Cache;->writeSuccessCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
