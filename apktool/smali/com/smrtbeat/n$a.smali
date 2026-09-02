.class Lcom/smrtbeat/n$a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/smrtbeat/n;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "a"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/io/File;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/smrtbeat/n$a;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/smrtbeat/n$a;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/smrtbeat/n$a;->c:Ljava/io/File;

    return-void
.end method


# virtual methods
.method a()Ljava/io/File;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/n$a;->c:Ljava/io/File;

    return-object v0
.end method

.method b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/n$a;->b:Ljava/lang/String;

    return-object v0
.end method

.method c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/n$a;->a:Ljava/lang/String;

    return-object v0
.end method
