.class final Lcom/smrtbeat/k$c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/k;->s()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    sget-boolean v0, Lcom/smrtbeat/j;->f0:Z

    invoke-static {}, Lcom/smrtbeat/j;->a()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_5

    invoke-static {v1}, Lcom/smrtbeat/f0;->f(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    const-string v5, "https://control.smbeat.jp/api/remote"

    :try_start_0
    invoke-static {}, Lcom/smrtbeat/o;->b()Lorg/json/JSONObject;

    move-result-object v6

    const/4 v7, 0x0

    invoke-static {v5, v6, v7}, Lcom/smrtbeat/k;->a(Ljava/lang/String;Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object v5

    iget-object v6, v5, Lcom/smrtbeat/b0;->b:Ljava/lang/String;

    invoke-static {v6}, Lcom/smrtbeat/k;->a(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    if-eqz v1, :cond_2

    new-instance v1, Lorg/json/JSONObject;

    iget-object v5, v5, Lcom/smrtbeat/b0;->b:Ljava/lang/String;

    invoke-direct {v1, v5}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v5, "suppressSdk"

    invoke-virtual {v1, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v5, "suppressSdk"

    invoke-static {v1, v5, v7}, Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)Z

    move-result v5

    invoke-static {v4, v5}, Lcom/smrtbeat/f0;->b(Landroid/content/SharedPreferences$Editor;Z)V

    goto :goto_0

    :cond_0
    const/4 v5, 0x0

    :goto_0
    const-string v6, "suppressCap"

    invoke-virtual {v1, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    const-string v6, "suppressCap"

    invoke-static {v1, v6, v7}, Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;Ljava/lang/String;Z)Z

    move-result v1

    invoke-static {v4, v1}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_1
    const/4 v7, 0x1

    goto :goto_1

    :cond_2
    const/4 v5, 0x0

    :goto_1
    invoke-static {v4}, Lcom/smrtbeat/f0;->d(Landroid/content/SharedPreferences$Editor;)V

    if-eqz v7, :cond_4

    if-eq v5, v0, :cond_3

    invoke-static {v4}, Lcom/smrtbeat/f0;->b(Landroid/content/SharedPreferences$Editor;)V

    goto :goto_2

    :cond_3
    if-eqz v5, :cond_4

    invoke-static {v3}, Lcom/smrtbeat/f0;->d(Landroid/content/SharedPreferences;)V

    goto :goto_2

    :catchall_0
    move-exception v0

    invoke-static {v4}, Lcom/smrtbeat/f0;->d(Landroid/content/SharedPreferences$Editor;)V

    invoke-static {v4}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    sput-object v2, Lcom/smrtbeat/j;->h0:Ljava/lang/Thread;

    throw v0

    :catch_0
    invoke-static {v4}, Lcom/smrtbeat/f0;->d(Landroid/content/SharedPreferences$Editor;)V

    :cond_4
    :goto_2
    invoke-static {v4}, Lcom/smrtbeat/f0;->a(Landroid/content/SharedPreferences$Editor;)V

    :cond_5
    sput-object v2, Lcom/smrtbeat/j;->h0:Ljava/lang/Thread;

    return-void
.end method
