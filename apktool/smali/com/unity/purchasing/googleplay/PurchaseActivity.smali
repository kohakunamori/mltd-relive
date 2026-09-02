.class public Lcom/unity/purchasing/googleplay/PurchaseActivity;
.super Landroid/app/Activity;
.source "PurchaseActivity.java"


# static fields
.field protected static final TAG:Ljava/lang/String; = "UnityIAP"


# instance fields
.field private receivedResult:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    .line 53
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 54
    invoke-virtual {p0, p1, p2, p3}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->processActivityResult(IILandroid/content/Intent;)V

    const/4 p1, 0x1

    .line 55
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/PurchaseActivity;->receivedResult:Z

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 21
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const-string p1, "UnityIAP"

    const-string v0, "Creating purchase activity"

    .line 22
    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 25
    invoke-virtual {p0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    const-string v1, "vr"

    .line 27
    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 28
    invoke-virtual {p0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    const/4 v1, 0x6

    .line 35
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xb

    if-lt v2, v3, :cond_0

    .line 36
    invoke-virtual {p1, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 41
    :cond_0
    invoke-virtual {p0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v1, "productId"

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 42
    invoke-virtual {p0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v1

    const-string v2, "developerPayload"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 45
    invoke-static {p0, p1, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->ContinuePurchase(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    .line 46
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->setResult(I)V

    .line 47
    invoke-virtual {p0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->finish()V

    :cond_1
    return-void
.end method

.method protected onDestroy()V
    .locals 3

    .line 60
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 61
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/PurchaseActivity;->receivedResult:Z

    if-nez v0, :cond_0

    const/16 v0, 0x3e7

    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 62
    invoke-virtual {p0, v0, v1, v2}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->processActivityResult(IILandroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method public processActivityResult(IILandroid/content/Intent;)V
    .locals 0

    .line 68
    invoke-static {p1, p2, p3}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->ProcessActivityResult(IILandroid/content/Intent;)V

    .line 69
    invoke-virtual {p0}, Lcom/unity/purchasing/googleplay/PurchaseActivity;->finish()V

    return-void
.end method
