.class Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;
.super Ljava/lang/Object;
.source "UnsupportedUtils.java"

# interfaces
.implements Landroid/media/MediaScannerConnection$OnScanCompletedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;->scanCaptureImage(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;->val$context:Landroid/content/Context;

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScanCompleted(Ljava/lang/String;Landroid/net/Uri;)V
    .locals 1

    .line 50
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    new-instance p2, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1$1;

    iget-object v0, p0, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;->val$context:Landroid/content/Context;

    invoke-direct {p2, p0, v0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1$1;-><init>(Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;Landroid/content/Context;)V

    invoke-virtual {p1, p2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
