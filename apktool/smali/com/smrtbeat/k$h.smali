.class final Lcom/smrtbeat/k$h;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/smrtbeat/c0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/k;->a(Ljava/io/File;J)Lcom/smrtbeat/b0;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Lcom/smrtbeat/b0;

.field b:Ljava/io/File;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/smrtbeat/k$h;->a:Lcom/smrtbeat/b0;

    iput-object v0, p0, Lcom/smrtbeat/k$h;->b:Ljava/io/File;

    return-void
.end method


# virtual methods
.method public a()Lcom/smrtbeat/b0;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/k$h;->a:Lcom/smrtbeat/b0;

    return-object v0
.end method

.method a(Ljava/io/File;)Lcom/smrtbeat/c0;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/k$h;->b:Ljava/io/File;

    return-object p0
.end method

.method public run()V
    .locals 5

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    new-instance v1, Lcom/smrtbeat/n$a;

    iget-object v2, p0, Lcom/smrtbeat/k$h;->b:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/smrtbeat/k$h;->b:Ljava/io/File;

    const-string v4, "screenshot"

    invoke-direct {v1, v4, v2, v3}, Lcom/smrtbeat/n$a;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lcom/smrtbeat/n;

    const-string v2, "https://images.smbeat.jp/api/upload"

    invoke-direct {v1, v2, v0}, Lcom/smrtbeat/n;-><init>(Ljava/lang/String;Ljava/util/List;)V

    const/16 v0, 0x2710

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lcom/smrtbeat/n;->a(IZ)Lcom/smrtbeat/b0;

    move-result-object v0

    iput-object v0, p0, Lcom/smrtbeat/k$h;->a:Lcom/smrtbeat/b0;

    return-void
.end method
