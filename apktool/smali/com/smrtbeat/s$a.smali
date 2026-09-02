.class Lcom/smrtbeat/s$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/s;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field a:Ljava/nio/ByteBuffer;

.field final synthetic b:Lcom/smrtbeat/s;


# direct methods
.method constructor <init>(Lcom/smrtbeat/s;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Ljava/nio/ByteBuffer;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/s$a;->a:Ljava/nio/ByteBuffer;

    return-object p0
.end method

.method public run()V
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lcom/smrtbeat/j;->U:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    iget-object v1, p0, Lcom/smrtbeat/s$a;->a:Ljava/nio/ByteBuffer;

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget-object v1, p0, Lcom/smrtbeat/s$a;->a:Ljava/nio/ByteBuffer;

    invoke-static {v1}, Lcom/smrtbeat/SmartBeatJni;->copyTextureBuffer(Ljava/nio/ByteBuffer;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-static {v1}, Lcom/smrtbeat/s;->a(Lcom/smrtbeat/s;)Landroid/graphics/Bitmap;

    move-result-object v1

    iget-object v2, p0, Lcom/smrtbeat/s$a;->a:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Landroid/graphics/Bitmap;->copyPixelsFromBuffer(Ljava/nio/Buffer;)V

    iput-object v0, p0, Lcom/smrtbeat/s$a;->a:Ljava/nio/ByteBuffer;

    iget-object v1, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-static {v1}, Lcom/smrtbeat/s;->b(Lcom/smrtbeat/s;)Landroid/graphics/Canvas;

    move-result-object v1

    iget-object v2, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-static {v2}, Lcom/smrtbeat/s;->a(Lcom/smrtbeat/s;)Landroid/graphics/Bitmap;

    move-result-object v2

    new-instance v3, Landroid/graphics/Paint;

    invoke-direct {v3}, Landroid/graphics/Paint;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v4, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    sget-object v1, Lcom/smrtbeat/j$a;->c:Lcom/smrtbeat/j$a;

    iget-object v2, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-static {v2}, Lcom/smrtbeat/s;->c(Lcom/smrtbeat/s;)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v1, v2, v3, v4}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/j$a;Landroid/graphics/Bitmap;J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    iget-object v2, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-static {v2, v0}, Lcom/smrtbeat/s;->a(Lcom/smrtbeat/s;Ljava/lang/Thread;)Ljava/lang/Thread;

    throw v1

    :catch_0
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/smrtbeat/s$a;->b:Lcom/smrtbeat/s;

    invoke-static {v1, v0}, Lcom/smrtbeat/s;->a(Lcom/smrtbeat/s;Ljava/lang/Thread;)Ljava/lang/Thread;

    return-void
.end method
