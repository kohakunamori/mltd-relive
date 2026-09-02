.class Lcom/google/games/bridge/TokenFragment$1;
.super Ljava/lang/Object;
.source "TokenFragment.java"

# interfaces
.implements Lcom/google/android/gms/tasks/OnCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/games/bridge/TokenFragment;->signIn()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/google/android/gms/tasks/OnCompleteListener<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/games/bridge/TokenFragment;

.field final synthetic val$account:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

.field final synthetic val$signInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;


# direct methods
.method constructor <init>(Lcom/google/games/bridge/TokenFragment;Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;)V
    .locals 0

    .line 187
    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment$1;->this$0:Lcom/google/games/bridge/TokenFragment;

    iput-object p2, p0, Lcom/google/games/bridge/TokenFragment$1;->val$account:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    iput-object p3, p0, Lcom/google/games/bridge/TokenFragment$1;->val$signInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

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
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 190
    invoke-virtual {p1}, Lcom/google/android/gms/tasks/Task;->isSuccessful()Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "TokenFragment"

    const-string v0, "Signed-in with the last signed-in account."

    .line 191
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 192
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$1;->this$0:Lcom/google/games/bridge/TokenFragment;

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/google/games/bridge/TokenFragment$1;->val$account:Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    invoke-static {p1, v0, v1}, Lcom/google/games/bridge/TokenFragment;->access$100(Lcom/google/games/bridge/TokenFragment;ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    goto :goto_0

    .line 194
    :cond_0
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$1;->val$signInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;->signOut()Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    new-instance v0, Lcom/google/games/bridge/TokenFragment$1$1;

    invoke-direct {v0, p0}, Lcom/google/games/bridge/TokenFragment$1$1;-><init>(Lcom/google/games/bridge/TokenFragment$1;)V

    invoke-virtual {p1, v0}, Lcom/google/android/gms/tasks/Task;->addOnCompleteListener(Lcom/google/android/gms/tasks/OnCompleteListener;)Lcom/google/android/gms/tasks/Task;

    :goto_0
    return-void
.end method
