.class public Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;
.super Lcom/unity3d/player/UnityPlayerActivity;
.source "OverrideActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Lcom/unity3d/player/UnityPlayerActivity;-><init>()V

    return-void
.end method

.method public static getCurrentActivity()Landroid/app/Activity;
    .locals 1

    .line 33
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    return-object v0
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 50
    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerActivity;->onCreate(Landroid/os/Bundle;)V

    .line 53
    invoke-virtual {p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Landroid/view/Window;->setFormat(I)V

    .line 55
    new-instance p1, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverridePlayer;

    invoke-direct {p1, p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverridePlayer;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    .line 57
    iget-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p0, p1}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->setContentView(Landroid/view/View;)V

    .line 58
    iget-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p1}, Lcom/unity3d/player/UnityPlayer;->requestFocus()Z

    return-void
.end method
