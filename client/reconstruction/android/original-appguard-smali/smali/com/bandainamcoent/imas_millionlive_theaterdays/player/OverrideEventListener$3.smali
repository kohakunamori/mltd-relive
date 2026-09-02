.class Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;
.super Ljava/lang/Object;
.source "OverrideActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->CallSignalMethod(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;

.field final synthetic val$finalArg:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;Ljava/lang/String;)V
    .locals 0

    .line 307
    iput-object p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;->this$0:Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;

    iput-object p2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;->val$finalArg:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 310
    iget-object v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;->this$0:Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;

    invoke-static {v0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->access$100(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SignalCallback"

    iget-object v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;->val$finalArg:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
