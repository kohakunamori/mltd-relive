.class final Lcom/smrtbeat/SmartBeat$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/SmartBeat;->logHandleExceptionCustom(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Ljava/io/File;

.field b:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Ljava/io/File;Ljava/lang/String;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    iput-object p2, p0, Lcom/smrtbeat/SmartBeat$a;->b:Ljava/lang/String;

    return-object p0
.end method

.method public run()V
    .locals 7

    const/16 v0, 0x1e

    :goto_0
    if-lez v0, :cond_0

    iget-object v1, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    const-wide/16 v1, 0x64

    :try_start_0
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_3

    invoke-static {}, Lcom/smrtbeat/f0;->k()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    return-void

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "."

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/webkit/MimeTypeMap;->getFileExtensionFromUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lcom/smrtbeat/SmartBeat$a;->b:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v3, v4, v5, v0}, Lcom/smrtbeat/d0;->b(Ljava/lang/String;JLjava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    iget-object v3, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v3, v0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v3

    const/4 v4, 0x2

    if-nez v3, :cond_2

    iget-object v3, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-static {v3, v0}, Lcom/smrtbeat/f0;->a(Ljava/io/File;Ljava/io/File;)Z

    move-result v3

    if-nez v3, :cond_2

    sget-object v3, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-array v5, v4, [Ljava/lang/Object;

    iget-object v6, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v1

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v5, v2

    const-string v1, "failed to move file from %s to %s"

    invoke-static {v1, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_2
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/smrtbeat/SmartBeat$a$a;

    invoke-direct {v2, p0}, Lcom/smrtbeat/SmartBeat$a$a;-><init>(Lcom/smrtbeat/SmartBeat$a;)V

    invoke-virtual {v2, v0}, Lcom/smrtbeat/SmartBeat$a$a;->a(Ljava/io/File;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1, v4}, Ljava/lang/Thread;->setPriority(I)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_1

    :cond_3
    sget-object v0, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/smrtbeat/SmartBeat$a;->a:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v1

    const-string v1, "missing capture image file path=%s"

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :goto_1
    return-void
.end method
