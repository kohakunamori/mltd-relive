.class Lcom/smrtbeat/k$k$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/FilenameFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/k$k;->a()I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/smrtbeat/k$k;


# direct methods
.method constructor <init>(Lcom/smrtbeat/k$k;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/k$k$b;->a:Lcom/smrtbeat/k$k;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public accept(Ljava/io/File;Ljava/lang/String;)Z
    .locals 0

    iget-object p1, p0, Lcom/smrtbeat/k$k$b;->a:Lcom/smrtbeat/k$k;

    invoke-static {p1}, Lcom/smrtbeat/k$k;->a(Lcom/smrtbeat/k$k;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method
