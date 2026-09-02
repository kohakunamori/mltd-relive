.class final Lcom/smrtbeat/k$e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/smrtbeat/c0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;Ljava/io/File;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Lcom/smrtbeat/b0;

.field b:Ljava/io/File;

.field c:Ljava/io/File;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/smrtbeat/k$e;->a:Lcom/smrtbeat/b0;

    iput-object v0, p0, Lcom/smrtbeat/k$e;->b:Ljava/io/File;

    iput-object v0, p0, Lcom/smrtbeat/k$e;->c:Ljava/io/File;

    return-void
.end method


# virtual methods
.method public a()Lcom/smrtbeat/b0;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/k$e;->a:Lcom/smrtbeat/b0;

    return-object v0
.end method

.method a(Ljava/io/File;Ljava/io/File;)Lcom/smrtbeat/c0;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/k$e;->b:Ljava/io/File;

    iput-object p2, p0, Lcom/smrtbeat/k$e;->c:Ljava/io/File;

    return-object p0
.end method

.method public run()V
    .locals 5

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v1, Lcom/smrtbeat/n$a;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v2, "errors"

    const-string v3, "json.txt"

    :try_start_1
    iget-object v4, p0, Lcom/smrtbeat/k$e;->b:Ljava/io/File;

    invoke-direct {v1, v2, v3, v4}, Lcom/smrtbeat/n$a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lcom/smrtbeat/n$a;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string v2, "minidump"

    :try_start_2
    iget-object v3, p0, Lcom/smrtbeat/k$e;->c:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/smrtbeat/k$e;->c:Ljava/io/File;

    invoke-direct {v1, v2, v3, v4}, Lcom/smrtbeat/n$a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lcom/smrtbeat/n;

    const-string v2, "https://minidumps.smbeat.jp/api/errors/multi"

    invoke-direct {v1, v2, v0}, Lcom/smrtbeat/n;-><init>(Ljava/lang/String;Ljava/util/List;)V

    const/16 v0, 0x7d0

    const/4 v2, 0x1

    invoke-virtual {v1, v0, v2}, Lcom/smrtbeat/n;->a(IZ)Lcom/smrtbeat/b0;

    move-result-object v0

    iput-object v0, p0, Lcom/smrtbeat/k$e;->a:Lcom/smrtbeat/b0;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    return-void
.end method
