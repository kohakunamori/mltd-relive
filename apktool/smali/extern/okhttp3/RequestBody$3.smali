.class Lextern/okhttp3/RequestBody$3;
.super Lextern/okhttp3/RequestBody;
.source "RequestBody.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/RequestBody;->create(Lextern/okhttp3/MediaType;Ljava/io/File;)Lextern/okhttp3/RequestBody;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$contentType:Lextern/okhttp3/MediaType;

.field final synthetic val$file:Ljava/io/File;


# direct methods
.method constructor <init>(Lextern/okhttp3/MediaType;Ljava/io/File;)V
    .locals 0

    .line 108
    iput-object p1, p0, Lextern/okhttp3/RequestBody$3;->val$contentType:Lextern/okhttp3/MediaType;

    iput-object p2, p0, Lextern/okhttp3/RequestBody$3;->val$file:Ljava/io/File;

    invoke-direct {p0}, Lextern/okhttp3/RequestBody;-><init>()V

    return-void
.end method


# virtual methods
.method public contentLength()J
    .locals 2

    .line 114
    iget-object v0, p0, Lextern/okhttp3/RequestBody$3;->val$file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    return-wide v0
.end method

.method public contentType()Lextern/okhttp3/MediaType;
    .locals 1
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation

    .line 110
    iget-object v0, p0, Lextern/okhttp3/RequestBody$3;->val$contentType:Lextern/okhttp3/MediaType;

    return-object v0
.end method

.method public writeTo(Lextern/okio/BufferedSink;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 120
    :try_start_0
    iget-object v1, p0, Lextern/okhttp3/RequestBody$3;->val$file:Ljava/io/File;

    invoke-static {v1}, Lextern/okio/Okio;->source(Ljava/io/File;)Lextern/okio/Source;

    move-result-object v0

    .line 121
    invoke-interface {p1, v0}, Lextern/okio/BufferedSink;->writeAll(Lextern/okio/Source;)J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 123
    invoke-static {v0}, Lextern/okhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    return-void

    :catchall_0
    move-exception p1

    invoke-static {v0}, Lextern/okhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    throw p1
.end method
