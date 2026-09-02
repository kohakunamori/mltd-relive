.class Lcom/smrtbeat/SmartBeat$a$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/SmartBeat$a;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field a:Ljava/io/File;

.field final synthetic b:Lcom/smrtbeat/SmartBeat$a;


# direct methods
.method constructor <init>(Lcom/smrtbeat/SmartBeat$a;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/SmartBeat$a$a;->b:Lcom/smrtbeat/SmartBeat$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Ljava/io/File;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/SmartBeat$a$a;->a:Ljava/io/File;

    return-object p0
.end method

.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/smrtbeat/SmartBeat$a$a;->a:Ljava/io/File;

    const-wide/16 v1, 0x0

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/k;->a(Ljava/io/File;J)Lcom/smrtbeat/b0;

    iget-object v0, p0, Lcom/smrtbeat/SmartBeat$a$a;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    return-void
.end method
