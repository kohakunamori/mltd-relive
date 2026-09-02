.class Lcom/google/games/bridge/TokenFragment$1$1;
.super Ljava/lang/Object;
.source "TokenFragment.java"

# interfaces
.implements Lcom/google/android/gms/tasks/OnCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/games/bridge/TokenFragment$1;->onComplete(Lcom/google/android/gms/tasks/Task;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/android/gms/tasks/OnCompleteListener<",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$1:Lcom/google/games/bridge/TokenFragment$1;


# direct methods
.method constructor <init>(Lcom/google/games/bridge/TokenFragment$1;)V
    .locals 0

    .line 195
    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment$1$1;->this$1:Lcom/google/games/bridge/TokenFragment$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onComplete(Lcom/google/android/gms/tasks/Task;)V
    .locals 2
    .param p1    # Lcom/google/android/gms/tasks/Task;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/lang/Void;",
            ">;)V"
        }
    .end annotation

    .line 198
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->isSuccessful()Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "TokenFragment"

    const-string v0, "Can\'t reuse the last signed-in account. Second attempt after sign out."

    .line 199
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 201
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$1$1;->this$1:Lcom/google/games/bridge/TokenFragment$1;

    iget-object p1, p1, Lcom/google/games/bridge/TokenFragment$1;->this$0:Lcom/google/games/bridge/TokenFragment;

    invoke-static {p1}, Lcom/google/games/bridge/TokenFragment;->access$200(Lcom/google/games/bridge/TokenFragment;)V

    goto :goto_0

    :cond_0
    const-string p1, "TokenFragment"

    const-string v0, "Can\'t reuse the last signed-in account and sign out failed."

    .line 203
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$1$1;->this$1:Lcom/google/games/bridge/TokenFragment$1;

    iget-object p1, p1, Lcom/google/games/bridge/TokenFragment$1;->this$0:Lcom/google/games/bridge/TokenFragment;

    const/4 v0, 0x4

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/google/games/bridge/TokenFragment;->access$100(Lcom/google/games/bridge/TokenFragment;ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    :goto_0
    return-void
.end method
