.class final Lcom/smrtbeat/ExceptionHandler$c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/ExceptionHandler;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Lcom/smrtbeat/i;Ljava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lorg/json/JSONObject;

.field final synthetic b:Ljava/io/File;


# direct methods
.method constructor <init>(Lorg/json/JSONObject;Ljava/io/File;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/ExceptionHandler$c;->a:Lorg/json/JSONObject;

    iput-object p2, p0, Lcom/smrtbeat/ExceptionHandler$c;->b:Ljava/io/File;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler$c;->a:Lorg/json/JSONObject;

    invoke-static {v0}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;)V

    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler$c;->b:Ljava/io/File;

    if-eqz v0, :cond_0

    const-wide/16 v1, 0x0

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/k;->a(Ljava/io/File;J)Lcom/smrtbeat/b0;

    move-result-object v0

    iget-object v1, p0, Lcom/smrtbeat/ExceptionHandler$c;->b:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/smrtbeat/b0;->a(Ljava/lang/String;)Lcom/smrtbeat/b0$a;

    move-result-object v0

    sget-object v1, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler$c;->b:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    return-void
.end method
