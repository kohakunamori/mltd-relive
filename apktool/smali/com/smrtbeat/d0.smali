.class Lcom/smrtbeat/d0;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:J = 0x2800L


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "_"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static a(Landroid/view/Window;Landroid/content/Context;Lcom/smrtbeat/g;Landroid/os/Handler;)V
    .locals 1

    const-string v0, "activity"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/ActivityManager;

    invoke-static {p1}, Lcom/smrtbeat/d0;->a(Landroid/app/ActivityManager;)Z

    move-result p1

    if-nez p1, :cond_0

    invoke-static {p0, p2, p3}, Lcom/smrtbeat/d0;->a(Landroid/view/Window;Lcom/smrtbeat/g;Landroid/os/Handler;)V

    return-void

    :cond_0
    sget-object p0, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    const-string p1, "Skip Capturing ScreenShot due to low memory"

    invoke-static {p0, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    return-void
.end method

.method private static a(Landroid/view/Window;Lcom/smrtbeat/g;Landroid/os/Handler;)V
    .locals 7

    sget-boolean v0, Lcom/smrtbeat/j;->d0:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_1

    return-void

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    if-nez p0, :cond_2

    return-void

    :cond_2
    invoke-virtual {p0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Landroid/view/View;->getHeight()I

    move-result p0

    if-lez p0, :cond_7

    invoke-virtual {v2}, Landroid/view/View;->getWidth()I

    move-result p0

    if-gtz p0, :cond_3

    goto :goto_0

    :cond_3
    iget-object p0, p1, Lcom/smrtbeat/g;->e:Landroid/graphics/Canvas;

    if-eqz p0, :cond_4

    invoke-virtual {p0}, Landroid/graphics/Canvas;->getWidth()I

    move-result p0

    invoke-virtual {v2}, Landroid/view/View;->getWidth()I

    move-result v0

    if-ne p0, v0, :cond_4

    iget-object p0, p1, Lcom/smrtbeat/g;->e:Landroid/graphics/Canvas;

    invoke-virtual {p0}, Landroid/graphics/Canvas;->getHeight()I

    move-result p0

    invoke-virtual {v2}, Landroid/view/View;->getHeight()I

    move-result v0

    if-eq p0, v0, :cond_6

    :cond_4
    iget-object p0, p1, Lcom/smrtbeat/g;->f:Landroid/graphics/Bitmap;

    if-eqz p0, :cond_5

    sget-object v0, Lcom/smrtbeat/j$a;->b:Lcom/smrtbeat/j$a;

    invoke-static {v0, p0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/j$a;Landroid/graphics/Bitmap;)V

    :cond_5
    invoke-virtual {v2}, Landroid/view/View;->getWidth()I

    move-result p0

    invoke-virtual {v2}, Landroid/view/View;->getHeight()I

    move-result v0

    sget-object v1, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    invoke-static {p0, v0, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p0

    iput-object p0, p1, Lcom/smrtbeat/g;->f:Landroid/graphics/Bitmap;

    new-instance p0, Landroid/graphics/Canvas;

    invoke-direct {p0}, Landroid/graphics/Canvas;-><init>()V

    iput-object p0, p1, Lcom/smrtbeat/g;->e:Landroid/graphics/Canvas;

    iget-object v0, p1, Lcom/smrtbeat/g;->f:Landroid/graphics/Bitmap;

    invoke-virtual {p0, v0}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    iget-object p0, p1, Lcom/smrtbeat/g;->e:Landroid/graphics/Canvas;

    invoke-virtual {p0}, Landroid/graphics/Canvas;->getDensity()I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Canvas;->setDensity(I)V

    :cond_6
    new-instance v1, Lcom/smrtbeat/d0$a;

    invoke-direct {v1}, Lcom/smrtbeat/d0$a;-><init>()V

    iget-object v3, p1, Lcom/smrtbeat/g;->e:Landroid/graphics/Canvas;

    iget-object v6, p1, Lcom/smrtbeat/g;->f:Landroid/graphics/Bitmap;

    invoke-virtual/range {v1 .. v6}, Lcom/smrtbeat/d0$a;->a(Landroid/view/View;Landroid/graphics/Canvas;JLandroid/graphics/Bitmap;)Ljava/lang/Runnable;

    move-result-object p0

    invoke-virtual {p2, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_7
    :goto_0
    return-void
.end method

.method private static a(Landroid/app/ActivityManager;)Z
    .locals 6

    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->maxMemory()J

    move-result-wide v0

    const/4 v2, 0x1

    new-array v3, v2, [I

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v4

    const/4 v5, 0x0

    aput v4, v3, v5

    invoke-virtual {p0, v3}, Landroid/app/ActivityManager;->getProcessMemoryInfo([I)[Landroid/os/Debug$MemoryInfo;

    move-result-object p0

    aget-object p0, p0, v5

    invoke-virtual {p0}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result p0

    mul-int/lit16 p0, p0, 0x400

    int-to-long v3, p0

    sub-long/2addr v0, v3

    const-wide/16 v3, 0x2800

    cmp-long p0, v0, v3

    if-gez p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return v2
.end method

.method static a(Ljava/io/File;Landroid/graphics/Bitmap;)Z
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    invoke-virtual {p0}, Ljava/io/File;->createNewFile()Z

    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    sget-object p0, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v1, 0x50

    invoke-virtual {p1, p0, v1, v2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const/4 p0, 0x1

    :try_start_2
    sget-object p1, Lcom/smrtbeat/f0$e;->e:Lcom/smrtbeat/f0$e;

    const-string v0, "saved Screenshot to file"

    invoke-static {p1, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    goto :goto_7

    :catchall_0
    const/4 v0, 0x1

    goto :goto_0

    :catch_0
    const/4 v0, 0x1

    goto :goto_1

    :catch_1
    const/4 v0, 0x1

    goto :goto_2

    :catchall_1
    :goto_0
    move p0, v0

    move-object v1, v2

    goto :goto_3

    :catch_2
    :goto_1
    move p0, v0

    move-object v1, v2

    goto :goto_4

    :catch_3
    :goto_2
    move p0, v0

    move-object v1, v2

    goto :goto_5

    :catchall_2
    const/4 p0, 0x0

    :goto_3
    if-eqz v1, :cond_0

    goto :goto_6

    :catch_4
    const/4 p0, 0x0

    :goto_4
    if-eqz v1, :cond_0

    goto :goto_6

    :catch_5
    const/4 p0, 0x0

    :goto_5
    if-eqz v1, :cond_0

    :goto_6
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_6

    :catch_6
    :cond_0
    :goto_7
    return p0
.end method

.method static b(Ljava/lang/String;JLjava/lang/String;)Ljava/io/File;
    .locals 3

    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/smrtbeat/j;->C:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "/capture/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p0, p1, p2, p3}, Lcom/smrtbeat/d0;->a(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v0
.end method
