.class final Lcom/smrtbeat/d0$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/d0;->a(Landroid/view/Window;Lcom/smrtbeat/g;Landroid/os/Handler;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Landroid/view/View;

.field b:Landroid/graphics/Canvas;

.field c:J

.field d:Landroid/graphics/Bitmap;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Landroid/view/View;Landroid/graphics/Canvas;JLandroid/graphics/Bitmap;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/d0$a;->a:Landroid/view/View;

    iput-object p2, p0, Lcom/smrtbeat/d0$a;->b:Landroid/graphics/Canvas;

    iput-wide p3, p0, Lcom/smrtbeat/d0$a;->c:J

    iput-object p5, p0, Lcom/smrtbeat/d0$a;->d:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lcom/smrtbeat/d0$a;->a:Landroid/view/View;

    iget-object v1, p0, Lcom/smrtbeat/d0$a;->b:Landroid/graphics/Canvas;

    invoke-virtual {v0, v1}, Landroid/view/View;->draw(Landroid/graphics/Canvas;)V

    sget-object v0, Lcom/smrtbeat/j$a;->b:Lcom/smrtbeat/j$a;

    iget-object v1, p0, Lcom/smrtbeat/d0$a;->d:Landroid/graphics/Bitmap;

    iget-wide v2, p0, Lcom/smrtbeat/d0$a;->c:J

    invoke-static {v0, v1, v2, v3}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/j$a;Landroid/graphics/Bitmap;J)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/smrtbeat/d0$a;->a:Landroid/view/View;

    iput-object v0, p0, Lcom/smrtbeat/d0$a;->b:Landroid/graphics/Canvas;

    iput-object v0, p0, Lcom/smrtbeat/d0$a;->d:Landroid/graphics/Bitmap;

    return-void
.end method
