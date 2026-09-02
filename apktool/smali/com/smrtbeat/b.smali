.class Lcom/smrtbeat/b;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/b$c;,
        Lcom/smrtbeat/b$d;,
        Lcom/smrtbeat/b$e;
    }
.end annotation


# static fields
.field private static d:Lcom/smrtbeat/b; = null

.field private static final e:J = 0x3e8L


# instance fields
.field private a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/app/Activity;",
            "Lcom/smrtbeat/b$c;",
            ">;"
        }
    .end annotation
.end field

.field private b:Landroid/os/Handler;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/ref/WeakReference<",
            "Lcom/smrtbeat/b$e;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/smrtbeat/b;

    invoke-direct {v0}, Lcom/smrtbeat/b;-><init>()V

    sput-object v0, Lcom/smrtbeat/b;->d:Lcom/smrtbeat/b;

    return-void
.end method

.method constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/smrtbeat/b;->b:Landroid/os/Handler;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    return-void
.end method

.method static a()Lcom/smrtbeat/b;
    .locals 1

    sget-object v0, Lcom/smrtbeat/b;->d:Lcom/smrtbeat/b;

    return-object v0
.end method

.method private declared-synchronized a(Landroid/app/Activity;Lcom/smrtbeat/b$d;)V
    .locals 2

    monitor-enter p0

    if-nez p1, :cond_0

    monitor-exit p0

    return-void

    :cond_0
    :try_start_0
    invoke-direct {p0}, Lcom/smrtbeat/b;->b()Z

    move-result v0

    sget-object v1, Lcom/smrtbeat/b$b;->a:[I

    invoke-virtual {p2}, Ljava/lang/Enum;->ordinal()I

    move-result p2

    aget p2, v1, p2

    packed-switch p2, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/smrtbeat/b$c;

    if-eqz p2, :cond_1

    sget-object v1, Lcom/smrtbeat/b$c;->b:Lcom/smrtbeat/b$c;

    if-ne p2, v1, :cond_1

    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    sget-object v1, Lcom/smrtbeat/b$c;->d:Lcom/smrtbeat/b$c;

    :goto_0
    invoke-interface {p2, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :pswitch_1
    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/smrtbeat/b$c;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :pswitch_2
    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/smrtbeat/b$c;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    sget-object v1, Lcom/smrtbeat/b$c;->b:Lcom/smrtbeat/b$c;

    goto :goto_0

    :pswitch_3
    iget-object p2, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    sget-object v1, Lcom/smrtbeat/b$c;->a:Lcom/smrtbeat/b$c;

    goto :goto_0

    :cond_1
    :goto_1
    invoke-direct {p0}, Lcom/smrtbeat/b;->b()Z

    move-result p1

    if-eq v0, p1, :cond_3

    sget-object p2, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Updated Active Status : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-eqz p1, :cond_2

    const-string v1, "true"

    goto :goto_2

    :cond_2
    const-string v1, "false"

    :goto_2
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/smrtbeat/b;->a(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_3
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lcom/smrtbeat/b;Landroid/app/Activity;Lcom/smrtbeat/b$d;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/smrtbeat/b;->a(Landroid/app/Activity;Lcom/smrtbeat/b$d;)V

    return-void
.end method

.method private b()Z
    .locals 3

    iget-object v0, p0, Lcom/smrtbeat/b;->a:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/smrtbeat/b$c;

    sget-object v2, Lcom/smrtbeat/b$c;->a:Lcom/smrtbeat/b$c;

    if-eq v1, v2, :cond_1

    sget-object v2, Lcom/smrtbeat/b$c;->b:Lcom/smrtbeat/b$c;

    if-ne v1, v2, :cond_0

    :cond_1
    const/4 v0, 0x1

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method a(Landroid/app/Activity;)V
    .locals 4

    sget-object v0, Lcom/smrtbeat/b$d;->b:Lcom/smrtbeat/b$d;

    invoke-direct {p0, p1, v0}, Lcom/smrtbeat/b;->a(Landroid/app/Activity;Lcom/smrtbeat/b$d;)V

    iget-object v0, p0, Lcom/smrtbeat/b;->b:Landroid/os/Handler;

    new-instance v1, Lcom/smrtbeat/b$a;

    invoke-direct {v1, p0, p1}, Lcom/smrtbeat/b$a;-><init>(Lcom/smrtbeat/b;Landroid/app/Activity;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method a(Lcom/smrtbeat/b$e;)V
    .locals 3

    iget-object v0, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method a(Z)V
    .locals 4

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    monitor-enter v1

    :try_start_0
    iget-object v2, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    :goto_0
    if-ltz v2, :cond_1

    iget-object v3, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/smrtbeat/b$e;

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/smrtbeat/b;->c:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :cond_0
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :goto_1
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/smrtbeat/b$e;

    if-eqz p1, :cond_2

    :try_start_1
    invoke-interface {v1}, Lcom/smrtbeat/b$e;->a()V

    goto :goto_2

    :catch_0
    move-exception v1

    goto :goto_3

    :cond_2
    invoke-interface {v1}, Lcom/smrtbeat/b$e;->b()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :goto_3
    sget-object v2, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    const-string v3, "failed to call callbacks."

    invoke-static {v2, v3, v1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_2

    :cond_3
    return-void

    :catchall_0
    move-exception p1

    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p1
.end method

.method b(Landroid/app/Activity;)V
    .locals 1

    sget-object v0, Lcom/smrtbeat/b$d;->a:Lcom/smrtbeat/b$d;

    invoke-direct {p0, p1, v0}, Lcom/smrtbeat/b;->a(Landroid/app/Activity;Lcom/smrtbeat/b$d;)V

    return-void
.end method

.method c(Landroid/app/Activity;)V
    .locals 1

    sget-object v0, Lcom/smrtbeat/b$d;->c:Lcom/smrtbeat/b$d;

    invoke-direct {p0, p1, v0}, Lcom/smrtbeat/b;->a(Landroid/app/Activity;Lcom/smrtbeat/b$d;)V

    return-void
.end method
