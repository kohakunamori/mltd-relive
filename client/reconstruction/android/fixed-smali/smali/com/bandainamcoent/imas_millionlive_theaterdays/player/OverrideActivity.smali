.class public Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;
.super Lcom/unity3d/player/UnityPlayerActivity;

# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/unity3d/player/UnityPlayerActivity;-><init>()V

    return-void
.end method

.method public static getCurrentActivity()Landroid/app/Activity;
    .locals 1

    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    return-object v0
.end method

# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lcom/unity3d/player/UnityPlayerActivity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Landroid/view/Window;->setFormat(I)V

    new-instance p1, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverridePlayer;

    invoke-direct {p1, p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverridePlayer;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    iget-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p0, p1}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->setContentView(Landroid/view/View;)V

    iget-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p1}, Lcom/unity3d/player/UnityPlayer;->requestFocus()Z

    return-void
.end method
