.class Lcom/google/games/bridge/TokenFragment$3;
.super Ljava/lang/Object;
.source "TokenFragment.java"

# interfaces
.implements Lcom/google/android/gms/tasks/OnSuccessListener;


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
        "Lcom/google/android/gms/tasks/OnSuccessListener<",
        "Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/games/bridge/TokenFragment;


# direct methods
.method constructor <init>(Lcom/google/games/bridge/TokenFragment;)V
    .locals 0

    .line 219
    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment$3;->this$0:Lcom/google/games/bridge/TokenFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSuccess(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V
    .locals 2

    const-string v0, "TokenFragment"

    const-string v1, "silentSignIn.onSuccess"

    .line 222
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 223
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$3;->this$0:Lcom/google/games/bridge/TokenFragment;

    const/4 v1, 0x0

    invoke-static {v0, v1, p1}, Lcom/google/games/bridge/TokenFragment;->access$100(Lcom/google/games/bridge/TokenFragment;ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 0

    .line 219
    check-cast p1, Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;

    invoke-virtual {p0, p1}, Lcom/google/games/bridge/TokenFragment$3;->onSuccess(Lcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    return-void
.end method
