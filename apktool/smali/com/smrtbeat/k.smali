.class Lcom/smrtbeat/k;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/k$k;
    }
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "%1$s-%2$s"

.field private static final b:Ljava/lang/String; = "%3$s"

.field private static final c:Ljava/lang/String; = ".dat"

.field private static final d:Ljava/lang/String; = ".id"

.field private static final e:Ljava/lang/Object;

.field private static final f:Ljava/util/concurrent/locks/ReentrantLock;

.field private static final g:Ljava/util/concurrent/locks/ReentrantLock;

.field private static h:Z = false

.field private static i:Z = false

.field private static final j:Ljava/util/concurrent/locks/ReentrantLock;

.field private static final k:J = 0x36ee80L


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/smrtbeat/k;->e:Ljava/lang/Object;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    sput-object v0, Lcom/smrtbeat/k;->f:Ljava/util/concurrent/locks/ReentrantLock;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    sput-object v0, Lcom/smrtbeat/k;->g:Ljava/util/concurrent/locks/ReentrantLock;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/smrtbeat/k;->h:Z

    sput-boolean v0, Lcom/smrtbeat/k;->i:Z

    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    sput-object v0, Lcom/smrtbeat/k;->j:Ljava/util/concurrent/locks/ReentrantLock;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Ljava/io/File;J)Lcom/smrtbeat/b0;
    .locals 1

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/smrtbeat/f0;->i()Z

    move-result v0

    if-nez v0, :cond_1

    new-instance p0, Lcom/smrtbeat/b0;

    invoke-direct {p0}, Lcom/smrtbeat/b0;-><init>()V

    return-object p0

    :cond_1
    new-instance v0, Lcom/smrtbeat/k$h;

    invoke-direct {v0}, Lcom/smrtbeat/k$h;-><init>()V

    invoke-virtual {v0, p0}, Lcom/smrtbeat/k$h;->a(Ljava/io/File;)Lcom/smrtbeat/c0;

    move-result-object p0

    invoke-static {p0, p1, p2}, Lcom/smrtbeat/e0;->a(Lcom/smrtbeat/c0;J)Lcom/smrtbeat/b0;

    move-result-object p0

    return-object p0

    :cond_2
    :goto_0
    new-instance p0, Lcom/smrtbeat/b0;

    invoke-direct {p0}, Lcom/smrtbeat/b0;-><init>()V

    return-object p0
.end method

.method static synthetic a(Ljava/lang/String;Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/smrtbeat/k;->b(Ljava/lang/String;Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;
    .locals 0

    invoke-static {p0, p1}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;
    .locals 0

    invoke-static {p0, p1}, Lcom/smrtbeat/k;->c(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a()V
    .locals 0

    invoke-static {}, Lcom/smrtbeat/k;->q()V

    return-void
.end method

.method private static a(Lcom/smrtbeat/k$k;)V
    .locals 6

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object p0

    if-nez p0, :cond_0

    return-void

    :cond_0
    array-length v0, p0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_4

    aget-object v2, p0, v1

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-static {v2}, Lcom/smrtbeat/k;->c(Ljava/io/File;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_3

    :try_start_0
    sget-object v4, Lcom/smrtbeat/k$a;->a:[I

    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5, v3}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const/4 v3, 0x1

    invoke-static {v5, v3}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object v5

    invoke-virtual {v5}, Lcom/smrtbeat/b0;->a()Lcom/smrtbeat/b0$a;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Enum;->ordinal()I

    move-result v5

    aget v4, v4, v5

    if-eq v4, v3, :cond_2

    const/4 v3, 0x2

    if-eq v4, v3, :cond_1

    const/4 v3, 0x3

    if-eq v4, v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-static {v2}, Lcom/smrtbeat/k;->a(Ljava/io/File;)Z

    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    return-void
.end method

.method static a(Lorg/json/JSONObject;)V
    .locals 0

    invoke-static {p0}, Lcom/smrtbeat/k;->c(Lorg/json/JSONObject;)V

    return-void
.end method

.method static a(Lorg/json/JSONObject;Ljava/io/File;J)V
    .locals 4

    invoke-static {}, Lcom/smrtbeat/k;->j()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v1, Ljava/io/File;

    sget-object v2, Lcom/smrtbeat/k$k;->h:Lcom/smrtbeat/k$k;

    invoke-virtual {v2}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/smrtbeat/k;->n()V

    new-instance v1, Ljava/io/File;

    sget-object v2, Lcom/smrtbeat/k$k;->g:Lcom/smrtbeat/k$k;

    invoke-virtual {v2}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/io/File;

    sget-object v3, Lcom/smrtbeat/k$k;->i:Lcom/smrtbeat/k$k;

    invoke-virtual {v3}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    invoke-virtual {p1, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-object p1, v2

    :goto_0
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, v2}, Lcom/smrtbeat/k;->c(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;

    new-instance p0, Lcom/smrtbeat/k$e;

    invoke-direct {p0}, Lcom/smrtbeat/k$e;-><init>()V

    invoke-virtual {p0, v1, p1}, Lcom/smrtbeat/k$e;->a(Ljava/io/File;Ljava/io/File;)Lcom/smrtbeat/c0;

    move-result-object p0

    invoke-static {p0, p2, p3}, Lcom/smrtbeat/e0;->a(Lcom/smrtbeat/c0;J)Lcom/smrtbeat/b0;

    move-result-object p0

    invoke-virtual {p0}, Lcom/smrtbeat/b0;->a()Lcom/smrtbeat/b0$a;

    move-result-object p0

    sget-object p2, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    if-ne p0, p2, :cond_1

    const/4 p0, 0x1

    goto :goto_1

    :cond_1
    const/4 p0, 0x0

    :goto_1
    if-nez p0, :cond_2

    if-eqz v0, :cond_3

    :cond_2
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_3
    return-void
.end method

.method static synthetic a(Landroid/content/SharedPreferences;)Z
    .locals 0

    invoke-static {p0}, Lcom/smrtbeat/k;->b(Landroid/content/SharedPreferences;)Z

    move-result p0

    return p0
.end method

.method private static a(Ljava/io/File;)Z
    .locals 8

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    add-int/lit8 v2, v1, -0x1

    const-string v3, "."

    invoke-virtual {v0, v3, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;I)I

    move-result v2

    const/4 v3, 0x0

    if-ltz v1, :cond_0

    if-ltz v2, :cond_0

    add-int/lit8 v4, v2, 0x1

    :try_start_0
    invoke-virtual {v0, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    const/4 v4, 0x0

    :goto_0
    const/4 v5, 0x1

    add-int/2addr v4, v5

    const/4 v6, 0x3

    if-lt v4, v6, :cond_1

    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    return v5

    :cond_1
    if-ltz v1, :cond_3

    if-gez v2, :cond_2

    move v2, v1

    :cond_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v7, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/2addr v2, v5

    invoke-virtual {v0, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    :cond_3
    return v3
.end method

.method private static a(Ljava/io/File;[Ljava/io/File;)Z
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, ".id"

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p1, v2

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return v0
.end method

.method static synthetic a(Ljava/lang/String;)Z
    .locals 0

    invoke-static {p0}, Lcom/smrtbeat/k;->b(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static a(Lorg/json/JSONObject;J)Z
    .locals 2

    sget-object v0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string v1, "SendCrashEvent"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    new-instance v0, Lcom/smrtbeat/k$d;

    invoke-direct {v0}, Lcom/smrtbeat/k$d;-><init>()V

    invoke-virtual {v0, p0}, Lcom/smrtbeat/k$d;->a(Lorg/json/JSONObject;)Lcom/smrtbeat/c0;

    move-result-object p0

    invoke-static {p0, p1, p2}, Lcom/smrtbeat/e0;->a(Lcom/smrtbeat/c0;J)Lcom/smrtbeat/b0;

    move-result-object p0

    invoke-virtual {p0}, Lcom/smrtbeat/b0;->a()Lcom/smrtbeat/b0$a;

    move-result-object p0

    sget-object p1, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    if-ne p0, p1, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method static synthetic a(Lorg/json/JSONObject;Ljava/lang/String;Z)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;Ljava/lang/String;Z)Z

    move-result p0

    return p0
.end method

.method private static b(Ljava/lang/String;Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;
    .locals 5

    new-instance v0, Lcom/smrtbeat/b0;

    invoke-direct {v0}, Lcom/smrtbeat/b0;-><init>()V

    sget-object v1, Lcom/smrtbeat/j;->o:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-gtz v1, :cond_0

    sget-object p0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string p1, "Data cannot send due to invalid api key."

    invoke-static {p0, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-object v0

    :cond_0
    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Ljava/net/URL;

    invoke-direct {v2, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object p0

    check-cast p0, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/16 v2, 0x4e20

    :try_start_1
    invoke-virtual {p0, v2}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    invoke-virtual {p0, v2}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const-string v2, "X-SmartBeat-Api-Key"

    :try_start_2
    sget-object v3, Lcom/smrtbeat/j;->o:Ljava/lang/String;

    invoke-virtual {p0, v2, v3}, Ljava/net/HttpURLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    const-string v2, "X-SmartBeat-Device-Time"

    :try_start_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Ljava/net/HttpURLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "Content-Type"

    const-string v3, "application/json"

    invoke-virtual {p0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p2, :cond_1

    const-string v2, "Content-Encoding"

    const-string v3, "gzip"

    invoke-virtual {p0, v2, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :catchall_0
    move-exception p1

    goto/16 :goto_4

    :catch_0
    move-exception p1

    goto :goto_2

    :cond_1
    :goto_0
    const/4 v2, 0x1

    invoke-virtual {p0, v2}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Ljava/net/HttpURLConnection;->setChunkedStreamingMode(I)V

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz p2, :cond_2

    :try_start_4
    new-instance p2, Ljava/util/zip/GZIPOutputStream;

    invoke-direct {p2, v2}, Ljava/util/zip/GZIPOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-object v1, p2

    goto :goto_1

    :catchall_1
    move-exception p1

    move-object v1, v2

    goto :goto_4

    :catch_1
    move-exception p1

    move-object v1, v2

    goto :goto_2

    :cond_2
    move-object v1, v2

    :goto_1
    :try_start_5
    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "UTF-8"

    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v1}, Ljava/io/OutputStream;->flush()V

    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result p1

    iput p1, v0, Lcom/smrtbeat/b0;->a:I

    const/16 p2, 0xc8

    if-ne p1, p2, :cond_3

    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Ljava/net/HttpURLConnection;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/smrtbeat/b0;->b:Ljava/lang/String;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :cond_3
    if-eqz p0, :cond_4

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_4
    if-eqz v1, :cond_6

    goto :goto_3

    :catchall_2
    move-exception p0

    move-object p1, p0

    move-object p0, v1

    goto :goto_4

    :catch_2
    move-exception p0

    move-object p1, p0

    move-object p0, v1

    :goto_2
    :try_start_6
    sget-object p2, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "failed to send data"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    if-eqz p0, :cond_5

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_5
    if-eqz v1, :cond_6

    :goto_3
    :try_start_7
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :cond_6
    return-object v0

    :goto_4
    if-eqz p0, :cond_7

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_7
    if-eqz v1, :cond_8

    :try_start_8
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    :catch_4
    :cond_8
    throw p1
.end method

.method private static b(Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;
    .locals 1

    const-string v0, "https://api.smbeat.jp/api/errors"

    invoke-static {v0, p0, p1}, Lcom/smrtbeat/k;->b(Ljava/lang/String;Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object p0

    return-object p0
.end method

.method static synthetic b()Ljava/util/concurrent/locks/ReentrantLock;
    .locals 1

    sget-object v0, Lcom/smrtbeat/k;->f:Ljava/util/concurrent/locks/ReentrantLock;

    return-object v0
.end method

.method public static b(Ljava/io/File;)V
    .locals 4

    if-nez p0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    invoke-static {v3}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    return-void
.end method

.method static b(Lorg/json/JSONObject;)V
    .locals 2

    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object v0

    invoke-virtual {v0}, Lcom/smrtbeat/b0;->a()Lcom/smrtbeat/b0$a;

    move-result-object v0

    sget-object v1, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    if-eq v0, v1, :cond_0

    invoke-static {p0}, Lcom/smrtbeat/k;->f(Lorg/json/JSONObject;)V

    :cond_0
    return-void
.end method

.method private static b(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/smrtbeat/k$f;

    invoke-direct {v1}, Lcom/smrtbeat/k$f;-><init>()V

    invoke-virtual {v1, p1, p0}, Lcom/smrtbeat/k$f;->a(Ljava/lang/String;Lorg/json/JSONObject;)Ljava/lang/Runnable;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method private static b(Landroid/content/SharedPreferences;)Z
    .locals 10

    invoke-static {}, Lcom/smrtbeat/f0;->j()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    invoke-static {p0}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences;)J

    move-result-wide v2

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long p0, v2, v6

    if-eqz p0, :cond_2

    sub-long v6, v4, v2

    const-wide/32 v8, 0x1499700

    cmp-long p0, v6, v8

    if-gtz p0, :cond_2

    cmp-long p0, v2, v4

    if-lez p0, :cond_1

    goto :goto_0

    :cond_1
    return v1

    :cond_2
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method private static b(Ljava/lang/String;)Z
    .locals 2

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string p0, "OK"

    :try_start_1
    const-string v1, "status"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static b(Lorg/json/JSONObject;Ljava/lang/String;Z)Z
    .locals 0

    :try_start_0
    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string p1, "true"

    invoke-virtual {p1, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p0, :cond_0

    const/4 p2, 0x1

    :catch_0
    :cond_0
    return p2
.end method

.method private static c(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;
    .locals 3

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->mkdirs()Z

    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->createNewFile()Z

    new-instance p1, Ljava/io/BufferedWriter;

    new-instance v1, Ljava/io/FileWriter;

    invoke-direct {v1, v0}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    const/16 v2, 0x2000

    invoke-direct {p1, v1, v2}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;I)V

    invoke-virtual {p0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/BufferedWriter;->flush()V

    invoke-virtual {p1}, Ljava/io/BufferedWriter;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object v0
.end method

.method private static c(Ljava/io/File;)Ljava/lang/String;
    .locals 4

    const-string v0, ""

    :try_start_0
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/InputStreamReader;

    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    const/16 p0, 0x2000

    invoke-direct {v1, v2, p0}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    new-instance p0, Ljava/lang/StringBuffer;

    invoke-direct {p0}, Ljava/lang/StringBuffer;-><init>()V

    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {p0, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-object v0, p0

    goto :goto_1

    :catchall_0
    const/4 v1, 0x0

    :catchall_1
    if-eqz v1, :cond_1

    :try_start_3
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :cond_1
    :goto_1
    return-object v0
.end method

.method static synthetic c()V
    .locals 0

    invoke-static {}, Lcom/smrtbeat/k;->n()V

    return-void
.end method

.method private static c(Lorg/json/JSONObject;)V
    .locals 3

    sget-object v0, Lcom/smrtbeat/k$k;->m:Lcom/smrtbeat/k$k;

    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->a()I

    move-result v1

    sget v2, Lcom/smrtbeat/j;->T:I

    if-lt v1, v2, :cond_0

    sget-object p0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string v0, "Dropped Abort due to Event full"

    invoke-static {p0, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/smrtbeat/k;->c(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;

    return-void
.end method

.method static synthetic d()Ljava/util/concurrent/locks/ReentrantLock;
    .locals 1

    sget-object v0, Lcom/smrtbeat/k;->g:Ljava/util/concurrent/locks/ReentrantLock;

    return-object v0
.end method

.method static d(Lorg/json/JSONObject;)V
    .locals 2

    sget-object v0, Lcom/smrtbeat/k;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/k$k;->n:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Lcom/smrtbeat/k;->c(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method static e(Lorg/json/JSONObject;)Ljava/io/File;
    .locals 1

    invoke-static {}, Lcom/smrtbeat/k;->j()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object p0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string v0, "Dropped CrashData due to Event full"

    invoke-static {p0, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    const/4 p0, 0x0

    return-object p0

    :cond_0
    invoke-static {}, Lcom/smrtbeat/k;->n()V

    sget-object v0, Lcom/smrtbeat/k$k;->f:Lcom/smrtbeat/k$k;

    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/smrtbeat/k;->c(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;

    move-result-object p0

    return-object p0
.end method

.method static e()V
    .locals 1

    sget-object v0, Lcom/smrtbeat/j;->h0:Ljava/lang/Thread;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lcom/smrtbeat/k;->r()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/smrtbeat/k;->s()V

    :cond_1
    return-void
.end method

.method static f()V
    .locals 3

    sget-object v0, Lcom/smrtbeat/k;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/k$k;->n:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private static f(Lorg/json/JSONObject;)V
    .locals 3

    sget-object v0, Lcom/smrtbeat/k$k;->j:Lcom/smrtbeat/k$k;

    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->a()I

    move-result v1

    sget v2, Lcom/smrtbeat/j;->T:I

    if-lt v1, v2, :cond_0

    sget-object p0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string v0, "Dropped ExceptionData due to Event full"

    invoke-static {p0, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void
.end method

.method static g()V
    .locals 4

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/smrtbeat/k$k;->h:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, v0, v2

    invoke-static {v3}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method static h()V
    .locals 2

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/smrtbeat/k$k;->k:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    return-void
.end method

.method static i()Lorg/json/JSONObject;
    .locals 3

    sget-object v0, Lcom/smrtbeat/k;->e:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/k$k;->n:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Lcom/smrtbeat/k;->c(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-lez v2, :cond_0

    :try_start_1
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    :cond_0
    const/4 v2, 0x0

    :goto_0
    :try_start_2
    monitor-exit v0

    return-object v2

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method private static j()Z
    .locals 2

    sget-object v0, Lcom/smrtbeat/k$k;->f:Lcom/smrtbeat/k$k;

    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->a()I

    move-result v0

    sget-object v1, Lcom/smrtbeat/k$k;->g:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->a()I

    move-result v1

    add-int/2addr v0, v1

    sget v1, Lcom/smrtbeat/j;->T:I

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method static k()V
    .locals 3

    sget-boolean v0, Lcom/smrtbeat/j;->R:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    sget-object v0, Lcom/smrtbeat/k;->j:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->lock()V

    sget-boolean v1, Lcom/smrtbeat/k;->h:Z

    if-nez v1, :cond_1

    const/4 v1, 0x1

    sput-boolean v1, Lcom/smrtbeat/k;->i:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    return-void

    :cond_1
    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    invoke-static {v0}, Lcom/smrtbeat/f0;->f(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0}, Lcom/smrtbeat/k;->b(Landroid/content/SharedPreferences;)Z

    move-result v1

    if-nez v1, :cond_3

    return-void

    :cond_3
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/smrtbeat/k$b;

    invoke-direct {v2}, Lcom/smrtbeat/k$b;-><init>()V

    invoke-virtual {v2, v0}, Lcom/smrtbeat/k$b;->a(Landroid/content/SharedPreferences;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    return-void

    :catchall_0
    move-exception v0

    sget-object v1, Lcom/smrtbeat/k;->j:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v1}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    throw v0
.end method

.method static l()V
    .locals 3

    :try_start_0
    sget-object v0, Lcom/smrtbeat/k;->j:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->lock()V

    sget-boolean v1, Lcom/smrtbeat/k;->i:Z

    const/4 v2, 0x1

    sput-boolean v2, Lcom/smrtbeat/k;->h:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/smrtbeat/k;->k()V

    :cond_0
    return-void

    :catchall_0
    move-exception v0

    sget-object v1, Lcom/smrtbeat/k;->j:Ljava/util/concurrent/locks/ReentrantLock;

    invoke-virtual {v1}, Ljava/util/concurrent/locks/ReentrantLock;->unlock()V

    throw v0
.end method

.method private static m()V
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/smrtbeat/k$g;

    invoke-direct {v1}, Lcom/smrtbeat/k$g;-><init>()V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method private static n()V
    .locals 3

    sget-object v0, Lcom/smrtbeat/k$k;->k:Lcom/smrtbeat/k$k;

    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->a()I

    move-result v1

    sget v2, Lcom/smrtbeat/j;->T:I

    if-lt v1, v2, :cond_0

    sget-object v0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string v1, "Dropped Captured Images due to Event full"

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void

    :cond_0
    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Lcom/smrtbeat/k$k;->b()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private static o()V
    .locals 8

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/smrtbeat/k$k;->m:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_3

    aget-object v4, v0, v3

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/io/File;->isFile()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-static {v4}, Lcom/smrtbeat/k;->c(Ljava/io/File;)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    :try_start_0
    new-instance v7, Lorg/json/JSONObject;

    invoke-direct {v7, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v7}, Lcom/smrtbeat/a;->b(Lorg/json/JSONObject;)Z

    move-result v5

    if-nez v5, :cond_1

    const-string v5, "https://abort-count.smbeat.jp/api/abort"

    invoke-static {v5, v7, v2}, Lcom/smrtbeat/k;->b(Ljava/lang/String;Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object v5

    sget-object v7, Lcom/smrtbeat/k$a;->a:[I

    invoke-virtual {v5}, Lcom/smrtbeat/b0;->a()Lcom/smrtbeat/b0$a;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Enum;->ordinal()I

    move-result v5

    aget v5, v7, v5
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    if-eq v5, v6, :cond_1

    const/4 v7, 0x2

    if-eq v5, v7, :cond_1

    const/4 v6, 0x0

    :catch_0
    :cond_1
    if-eqz v6, :cond_2

    invoke-virtual {v4}, Ljava/io/File;->delete()Z

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method static p()V
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/smrtbeat/k$j;

    invoke-direct {v1}, Lcom/smrtbeat/k$j;-><init>()V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method private static q()V
    .locals 16

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/smrtbeat/k$k;->e:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/smrtbeat/k$k;->f:Lcom/smrtbeat/k$k;

    invoke-static {v0}, Lcom/smrtbeat/k;->a(Lcom/smrtbeat/k$k;)V

    sget-object v0, Lcom/smrtbeat/k$k;->j:Lcom/smrtbeat/k$k;

    invoke-static {v0}, Lcom/smrtbeat/k;->a(Lcom/smrtbeat/k$k;)V

    invoke-static {}, Lcom/smrtbeat/k;->o()V

    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/smrtbeat/k$k;->g:Lcom/smrtbeat/k$k;

    invoke-virtual {v1}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    const/4 v2, 0x3

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-eqz v1, :cond_a

    array-length v6, v1

    const/4 v7, 0x0

    :goto_0
    if-ge v7, v6, :cond_a

    aget-object v8, v1, v7

    invoke-virtual {v8}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_1

    goto/16 :goto_3

    :cond_1
    array-length v9, v0

    const/4 v10, 0x0

    move-object v11, v10

    move-object v12, v11

    const/4 v10, 0x0

    :goto_1
    if-ge v10, v9, :cond_4

    aget-object v13, v0, v10

    invoke-virtual {v13}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v14

    sget-object v15, Lcom/smrtbeat/k$k;->i:Lcom/smrtbeat/k$k;

    invoke-static {v15}, Lcom/smrtbeat/k$k;->a(Lcom/smrtbeat/k$k;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_2

    move-object v11, v13

    goto :goto_2

    :cond_2
    invoke-virtual {v13}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v14

    sget-object v15, Lcom/smrtbeat/k$k;->g:Lcom/smrtbeat/k$k;

    invoke-static {v15}, Lcom/smrtbeat/k$k;->a(Lcom/smrtbeat/k$k;)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_3

    move-object v12, v13

    :cond_3
    :goto_2
    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    :cond_4
    if-eqz v11, :cond_6

    if-eqz v12, :cond_6

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v9, Lcom/smrtbeat/n$a;

    const-string v10, "errors"

    const-string v13, "json.txt"

    invoke-direct {v9, v10, v13, v12}, Lcom/smrtbeat/n$a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v9, Lcom/smrtbeat/n$a;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v10, "minidump"

    :try_start_1
    invoke-static {v11}, Lcom/smrtbeat/f0;->a(Ljava/io/File;)Ljava/lang/String;

    move-result-object v12

    invoke-direct {v9, v10, v12, v11}, Lcom/smrtbeat/n$a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v9, Lcom/smrtbeat/n;

    const-string v10, "https://minidumps.smbeat.jp/api/errors/multi"

    invoke-direct {v9, v10, v0}, Lcom/smrtbeat/n;-><init>(Ljava/lang/String;Ljava/util/List;)V

    const/16 v0, 0x7d0

    invoke-virtual {v9, v0, v5}, Lcom/smrtbeat/n;->a(IZ)Lcom/smrtbeat/b0;

    move-result-object v0

    sget-object v9, Lcom/smrtbeat/k$a;->a:[I

    invoke-virtual {v0}, Lcom/smrtbeat/b0;->a()Lcom/smrtbeat/b0$a;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Enum;->ordinal()I

    move-result v0

    aget v0, v9, v0

    if-eq v0, v5, :cond_7

    if-eq v0, v3, :cond_5

    if-eq v0, v2, :cond_5

    goto :goto_4

    :cond_5
    invoke-static {v11}, Lcom/smrtbeat/k;->a(Ljava/io/File;)Z

    move-result v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_5

    :catch_0
    move-exception v0

    sget-object v9, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    new-array v10, v5, [Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v10, v4

    const-string v0, "failed to send dump: %s"

    invoke-static {v0, v10}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v9, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    goto :goto_4

    :cond_6
    invoke-virtual {v8}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    sget-object v9, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    invoke-virtual {v0, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_8

    :cond_7
    :goto_3
    const/4 v0, 0x1

    goto :goto_5

    :cond_8
    :goto_4
    const/4 v0, 0x0

    :goto_5
    if-eqz v0, :cond_9

    invoke-static {v8}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    :cond_9
    add-int/lit8 v7, v7, 0x1

    goto/16 :goto_0

    :cond_a
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/smrtbeat/j;->C:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v1, Lcom/smrtbeat/k$i;

    invoke-direct {v1}, Lcom/smrtbeat/k$i;-><init>()V

    invoke-virtual {v0, v1}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    sget-object v6, Lcom/smrtbeat/k$k;->l:Lcom/smrtbeat/k$k;

    invoke-virtual {v6}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v1, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_14

    array-length v6, v1

    const/4 v7, 0x0

    :goto_6
    if-ge v7, v6, :cond_14

    aget-object v8, v1, v7

    invoke-virtual {v8}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v9

    sget-object v10, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_b

    const/4 v14, 0x3

    goto/16 :goto_c

    :cond_b
    invoke-static {v8, v0}, Lcom/smrtbeat/k;->a(Ljava/io/File;[Ljava/io/File;)Z

    move-result v9

    if-eqz v9, :cond_12

    invoke-virtual {v8}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v9

    if-eqz v9, :cond_11

    array-length v10, v9

    const/4 v11, 0x0

    const/4 v12, 0x0

    :goto_7
    if-ge v11, v10, :cond_10

    aget-object v13, v9, v11

    sget-object v14, Lcom/smrtbeat/k$a;->a:[I

    const-wide/16 v2, 0x0

    invoke-static {v13, v2, v3}, Lcom/smrtbeat/k;->a(Ljava/io/File;J)Lcom/smrtbeat/b0;

    move-result-object v2

    invoke-virtual {v13}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/smrtbeat/b0;->a(Ljava/lang/String;)Lcom/smrtbeat/b0$a;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Enum;->ordinal()I

    move-result v2

    aget v2, v14, v2

    if-eq v2, v5, :cond_e

    const/4 v3, 0x2

    if-eq v2, v3, :cond_c

    const/4 v14, 0x3

    if-eq v2, v14, :cond_d

    goto :goto_8

    :cond_c
    const/4 v14, 0x3

    :cond_d
    invoke-static {v13}, Lcom/smrtbeat/k;->a(Ljava/io/File;)Z

    move-result v2

    if-nez v2, :cond_f

    :goto_8
    const/4 v12, 0x1

    goto :goto_9

    :cond_e
    const/4 v3, 0x2

    const/4 v14, 0x3

    invoke-static {v13}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    :cond_f
    :goto_9
    add-int/lit8 v11, v11, 0x1

    const/4 v2, 0x3

    goto :goto_7

    :cond_10
    const/4 v14, 0x3

    goto :goto_a

    :cond_11
    const/4 v14, 0x3

    const/4 v12, 0x0

    :goto_a
    if-nez v12, :cond_13

    new-instance v2, Ljava/io/File;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v10, Lcom/smrtbeat/j;->C:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, "/"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, ".id"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v2, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    goto :goto_b

    :cond_12
    const/4 v14, 0x3

    :goto_b
    invoke-static {v8}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    :cond_13
    :goto_c
    add-int/lit8 v7, v7, 0x1

    const/4 v2, 0x3

    goto/16 :goto_6

    :cond_14
    if-eqz v0, :cond_17

    array-length v1, v0

    const/4 v2, 0x0

    :goto_d
    if-ge v2, v1, :cond_17

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x2e

    invoke-virtual {v6, v7}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v6

    invoke-virtual {v5, v4, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    sget-object v6, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_15

    goto :goto_e

    :cond_15
    new-instance v6, Ljava/io/File;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v8, Lcom/smrtbeat/k$k;->l:Lcom/smrtbeat/k$k;

    invoke-virtual {v8}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v6, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_16

    invoke-static {v3}, Lcom/smrtbeat/k;->b(Ljava/io/File;)V

    :cond_16
    :goto_e
    add-int/lit8 v2, v2, 0x1

    goto :goto_d

    :cond_17
    return-void
.end method

.method private static r()Z
    .locals 9

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    sget-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string v2, "failed to check remote control due to context is null"

    invoke-static {v0, v2}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return v1

    :cond_0
    invoke-static {v0}, Lcom/smrtbeat/f0;->f(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0}, Lcom/smrtbeat/f0;->b(Landroid/content/SharedPreferences;)J

    move-result-wide v2

    invoke-static {v0}, Lcom/smrtbeat/f0;->c(Landroid/content/SharedPreferences;)J

    move-result-wide v4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    cmp-long v0, v6, v2

    const/4 v8, 0x1

    if-lez v0, :cond_1

    sub-long v4, v6, v4

    cmp-long v0, v4, v2

    if-lez v0, :cond_1

    return v8

    :cond_1
    const-wide/32 v4, 0x36ee80

    sub-long/2addr v2, v4

    cmp-long v0, v6, v2

    if-gez v0, :cond_2

    return v8

    :cond_2
    return v1
.end method

.method private static declared-synchronized s()V
    .locals 3

    const-class v0, Lcom/smrtbeat/k;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/j;->h0:Ljava/lang/Thread;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    :try_start_1
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/smrtbeat/k$c;

    invoke-direct {v2}, Lcom/smrtbeat/k$c;-><init>()V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    sput-object v1, Lcom/smrtbeat/j;->h0:Ljava/lang/Thread;

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method
