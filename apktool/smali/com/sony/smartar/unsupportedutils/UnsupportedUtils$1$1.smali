.class Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1$1;
.super Ljava/lang/Object;
.source "UnsupportedUtils.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;->onScanCompleted(Ljava/lang/String;Landroid/net/Uri;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;

.field private final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;Landroid/content/Context;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1$1;->this$1:Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;

    iput-object p2, p0, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1$1;->val$context:Landroid/content/Context;

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 53
    iget-object v0, p0, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1$1;->val$context:Landroid/content/Context;

    const-string v1, "Completed capture image."

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method
