.class Lcom/smrtbeat/b$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/b;->a(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/Activity;

.field final synthetic b:Lcom/smrtbeat/b;


# direct methods
.method constructor <init>(Lcom/smrtbeat/b;Landroid/app/Activity;)V
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/b$a;->b:Lcom/smrtbeat/b;

    iput-object p2, p0, Lcom/smrtbeat/b$a;->a:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/smrtbeat/b$a;->b:Lcom/smrtbeat/b;

    iget-object v1, p0, Lcom/smrtbeat/b$a;->a:Landroid/app/Activity;

    sget-object v2, Lcom/smrtbeat/b$d;->d:Lcom/smrtbeat/b$d;

    invoke-static {v0, v1, v2}, Lcom/smrtbeat/b;->a(Lcom/smrtbeat/b;Landroid/app/Activity;Lcom/smrtbeat/b$d;)V

    return-void
.end method
