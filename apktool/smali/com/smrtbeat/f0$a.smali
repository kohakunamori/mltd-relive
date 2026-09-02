.class final Lcom/smrtbeat/f0$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/f0;->j(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/f0$a;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    invoke-static {}, Lcom/smrtbeat/f0;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/smrtbeat/f0$a;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/smrtbeat/t;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/smrtbeat/f0$a;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Landroid/content/Context;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-static {}, Lcom/smrtbeat/k;->l()V

    return-void

    :cond_1
    :try_start_1
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-static {v0}, Lcom/smrtbeat/m;->b([B)[B

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/smrtbeat/f0$a;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Landroid/content/Context;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    invoke-static {}, Lcom/smrtbeat/k;->l()V

    return-void

    :cond_2
    :try_start_2
    invoke-static {v0}, Lcom/smrtbeat/c;->b([B)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/smrtbeat/f0$a;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/smrtbeat/f0;->a(Landroid/content/Context;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    invoke-static {}, Lcom/smrtbeat/k;->l()V

    return-void

    :cond_3
    :try_start_3
    iget-object v1, p0, Lcom/smrtbeat/f0$a;->a:Landroid/content/Context;

    const-string v2, "SmartBeat"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    sget-object v2, Lcom/smrtbeat/j;->u:Ljava/lang/String;

    if-nez v2, :cond_4

    sput-object v0, Lcom/smrtbeat/j;->u:Ljava/lang/String;

    const-string v2, "idv2"

    :goto_1
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_2

    :cond_4
    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "android:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v4, Lcom/smrtbeat/j;->s:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/smrtbeat/j;->t:Ljava/lang/String;

    sput-object v0, Lcom/smrtbeat/j;->u:Ljava/lang/String;

    const-string v3, "uuid"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    const-string v2, "idv2"

    goto :goto_1

    :goto_2
    invoke-static {v1}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :cond_5
    invoke-static {}, Lcom/smrtbeat/k;->l()V

    return-void

    :catchall_0
    move-exception v0

    invoke-static {}, Lcom/smrtbeat/k;->l()V

    throw v0
.end method
