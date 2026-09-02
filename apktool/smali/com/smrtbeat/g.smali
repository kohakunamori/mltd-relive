.class Lcom/smrtbeat/g;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static final h:I = 0x3

.field private static final i:J = 0x3e8L


# instance fields
.field private a:Landroid/view/Window;

.field private b:Landroid/content/Context;

.field private c:I

.field private d:Ljava/lang/Object;

.field e:Landroid/graphics/Canvas;

.field f:Landroid/graphics/Bitmap;

.field g:Landroid/os/Handler;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/smrtbeat/g;->a:Landroid/view/Window;

    iput-object v0, p0, Lcom/smrtbeat/g;->b:Landroid/content/Context;

    const/4 v0, 0x0

    iput v0, p0, Lcom/smrtbeat/g;->c:I

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/smrtbeat/g;->d:Ljava/lang/Object;

    return-void
.end method

.method private b()Z
    .locals 5

    iget-object v0, p0, Lcom/smrtbeat/g;->d:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/smrtbeat/g;->a:Landroid/view/Window;

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    iget-object v3, p0, Lcom/smrtbeat/g;->b:Landroid/content/Context;

    if-eqz v3, :cond_1

    iget-object v4, p0, Lcom/smrtbeat/g;->g:Landroid/os/Handler;

    if-nez v4, :cond_0

    goto :goto_0

    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-static {v1, v3, p0, v4}, Lcom/smrtbeat/d0;->a(Landroid/view/Window;Landroid/content/Context;Lcom/smrtbeat/g;Landroid/os/Handler;)V

    return v2

    :cond_1
    :goto_0
    :try_start_1
    iget v1, p0, Lcom/smrtbeat/g;->c:I

    add-int/2addr v1, v2

    iput v1, p0, Lcom/smrtbeat/g;->c:I

    const/4 v1, 0x0

    monitor-exit v0

    return v1

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method


# virtual methods
.method a(Landroid/app/Activity;)V
    .locals 2

    iget-object v0, p0, Lcom/smrtbeat/g;->d:Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/smrtbeat/g;->a:Landroid/view/Window;

    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object p1

    if-ne v1, p1, :cond_0

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/smrtbeat/g;->a:Landroid/view/Window;

    iput-object p1, p0, Lcom/smrtbeat/g;->b:Landroid/content/Context;

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method b(Landroid/app/Activity;)V
    .locals 2

    iget-object v0, p0, Lcom/smrtbeat/g;->d:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    iput v1, p0, Lcom/smrtbeat/g;->c:I

    sget-boolean v1, Lcom/smrtbeat/j;->Z:Z

    if-eqz v1, :cond_0

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/smrtbeat/g;->a:Landroid/view/Window;

    iput-object p1, p0, Lcom/smrtbeat/g;->b:Landroid/content/Context;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    iput-object v1, p0, Lcom/smrtbeat/g;->a:Landroid/view/Window;

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lcom/smrtbeat/g;->b:Landroid/content/Context;

    new-instance v1, Landroid/os/Handler;

    invoke-virtual {p1}, Landroid/app/Activity;->getMainLooper()Landroid/os/Looper;

    move-result-object p1

    invoke-direct {v1, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/smrtbeat/g;->g:Landroid/os/Handler;

    :goto_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public run()V
    .locals 3

    :goto_0
    const-wide/16 v0, 0x3e8

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {}, Lcom/smrtbeat/f0;->h()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/smrtbeat/g;->d:Ljava/lang/Object;

    monitor-enter v0

    :try_start_1
    iget v1, p0, Lcom/smrtbeat/g;->c:I

    const/4 v2, 0x3

    if-le v1, v2, :cond_1

    monitor-exit v0

    return-void

    :cond_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    invoke-direct {p0}, Lcom/smrtbeat/g;->b()Z

    goto :goto_0

    :catchall_0
    move-exception v1

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method
