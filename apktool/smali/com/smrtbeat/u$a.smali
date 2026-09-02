.class final Lcom/smrtbeat/u$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/u;->a(Z)Landroid/app/Application$ActivityLifecycleCallbacks;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Z


# direct methods
.method constructor <init>(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/smrtbeat/u$a;->a:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    iget-boolean p2, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz p2, :cond_0

    new-instance p2, Lcom/smrtbeat/d;

    sget-object v0, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v1, "ActivityLifecycle"

    const-string v2, "onActivityCreated()"

    invoke-static {v1, v2}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    invoke-direct {p2, v0, p1, v1}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {p2}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 4

    iget-boolean v0, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz v0, :cond_0

    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v2, "ActivityLifecycle"

    const-string v3, "onActivityDestroyed()"

    invoke-static {v2, v3}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    invoke-direct {v0, v1, p1, v2}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 4

    invoke-static {p1}, Lcom/smrtbeat/f0;->a(Landroid/app/Activity;)V

    invoke-static {}, Lcom/smrtbeat/b;->a()Lcom/smrtbeat/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/smrtbeat/b;->a(Landroid/app/Activity;)V

    iget-boolean v0, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz v0, :cond_0

    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v2, "ActivityLifecycle"

    const-string v3, "onActivityPaused()"

    invoke-static {v2, v3}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    invoke-direct {v0, v1, p1, v2}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 4

    invoke-static {p1}, Lcom/smrtbeat/f0;->b(Landroid/app/Activity;)V

    invoke-static {}, Lcom/smrtbeat/b;->a()Lcom/smrtbeat/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/smrtbeat/b;->b(Landroid/app/Activity;)V

    iget-boolean v0, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz v0, :cond_0

    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v2, "ActivityLifecycle"

    const-string v3, "onActivityResumed()"

    invoke-static {v2, v3}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    invoke-direct {v0, v1, p1, v2}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    iget-boolean p2, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz p2, :cond_0

    new-instance p2, Lcom/smrtbeat/d;

    sget-object v0, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v1, "ActivityLifecycle"

    const-string v2, "onActivitySaveInstanceState()"

    invoke-static {v1, v2}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v1

    invoke-direct {p2, v0, p1, v1}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {p2}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 4

    iget-boolean v0, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz v0, :cond_0

    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v2, "ActivityLifecycle"

    const-string v3, "onActivityStarted()"

    invoke-static {v2, v3}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    invoke-direct {v0, v1, p1, v2}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 4

    invoke-static {}, Lcom/smrtbeat/b;->a()Lcom/smrtbeat/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/smrtbeat/b;->c(Landroid/app/Activity;)V

    iget-boolean v0, p0, Lcom/smrtbeat/u$a;->a:Z

    if-eqz v0, :cond_0

    new-instance v0, Lcom/smrtbeat/d;

    sget-object v1, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v2, "ActivityLifecycle"

    const-string v3, "onActivityStopped()"

    invoke-static {v2, v3}, Ljava/util/Collections;->singletonMap(Ljava/lang/Object;Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    invoke-direct {v0, v1, p1, v2}, Lcom/smrtbeat/d;-><init>(Lcom/smrtbeat/e;Ljava/lang/String;Ljava/util/Map;)V

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/d;)V

    :cond_0
    return-void
.end method
