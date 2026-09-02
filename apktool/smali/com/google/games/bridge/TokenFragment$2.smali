.class Lcom/google/games/bridge/TokenFragment$2;
.super Ljava/lang/Object;
.source "TokenFragment.java"

# interfaces
.implements Lcom/google/android/gms/tasks/OnFailureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/games/bridge/TokenFragment;->signIn()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/google/games/bridge/TokenFragment;

.field final synthetic val$request:Lcom/google/games/bridge/TokenFragment$TokenRequest;

.field final synthetic val$signInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;


# direct methods
.method constructor <init>(Lcom/google/games/bridge/TokenFragment;Lcom/google/games/bridge/TokenFragment$TokenRequest;Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;)V
    .locals 0

    .line 228
    iput-object p1, p0, Lcom/google/games/bridge/TokenFragment$2;->this$0:Lcom/google/games/bridge/TokenFragment;

    iput-object p2, p0, Lcom/google/games/bridge/TokenFragment$2;->val$request:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    iput-object p3, p0, Lcom/google/games/bridge/TokenFragment$2;->val$signInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/Exception;)V
    .locals 4

    const-string v0, "TokenFragment"

    const-string v1, "silentSignIn.onFailure"

    .line 231
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 233
    instance-of v0, p1, Lcom/google/android/gms/common/api/ApiException;

    const/16 v1, 0x8

    if-eqz v0, :cond_0

    .line 234
    check-cast p1, Lcom/google/android/gms/common/api/ApiException;

    invoke-virtual {p1}, Lcom/google/android/gms/common/api/ApiException;->getStatusCode()I

    move-result p1

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    const/4 v0, 0x0

    const/4 v2, 0x4

    if-eq p1, v2, :cond_2

    if-eq p1, v1, :cond_2

    const/4 v1, 0x6

    if-ne p1, v1, :cond_1

    goto :goto_1

    :cond_1
    const-string v1, "TokenFragment"

    .line 249
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Sign-in failed with status code: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 250
    iget-object v1, p0, Lcom/google/games/bridge/TokenFragment$2;->this$0:Lcom/google/games/bridge/TokenFragment;

    invoke-static {v1, p1, v0}, Lcom/google/games/bridge/TokenFragment;->access$100(Lcom/google/games/bridge/TokenFragment;ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    goto :goto_2

    .line 241
    :cond_2
    :goto_1
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$2;->val$request:Lcom/google/games/bridge/TokenFragment$TokenRequest;

    invoke-virtual {p1}, Lcom/google/games/bridge/TokenFragment$TokenRequest;->getSilent()Z

    move-result p1

    if-nez p1, :cond_3

    .line 242
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$2;->val$signInClient:Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;

    invoke-virtual {p1}, Lcom/google/android/gms/auth/api/signin/GoogleSignInClient;->getSignInIntent()Landroid/content/Intent;

    move-result-object p1

    .line 243
    iget-object v0, p0, Lcom/google/games/bridge/TokenFragment$2;->this$0:Lcom/google/games/bridge/TokenFragment;

    const/16 v1, 0x232a

    invoke-virtual {v0, p1, v1}, Lcom/google/games/bridge/TokenFragment;->startActivityForResult(Landroid/content/Intent;I)V

    goto :goto_2

    :cond_3
    const-string p1, "TokenFragment"

    const-string v1, "Sign-in failed. Run in silent mode and UI sign-in required."

    .line 245
    invoke-static {p1, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 246
    iget-object p1, p0, Lcom/google/games/bridge/TokenFragment$2;->this$0:Lcom/google/games/bridge/TokenFragment;

    invoke-static {p1, v2, v0}, Lcom/google/games/bridge/TokenFragment;->access$100(Lcom/google/games/bridge/TokenFragment;ILcom/google/android/gms/auth/api/signin/GoogleSignInAccount;)V

    :goto_2
    return-void
.end method
