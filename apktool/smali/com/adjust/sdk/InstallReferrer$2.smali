.class Lcom/adjust/sdk/InstallReferrer$2;
.super Ljava/lang/Object;
.source "InstallReferrer.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adjust/sdk/InstallReferrer;->invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adjust/sdk/InstallReferrer;

.field final synthetic val$args:[Ljava/lang/Object;

.field final synthetic val$method:Ljava/lang/reflect/Method;

.field final synthetic val$proxy:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lcom/adjust/sdk/InstallReferrer;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)V
    .locals 0

    .line 269
    iput-object p1, p0, Lcom/adjust/sdk/InstallReferrer$2;->this$0:Lcom/adjust/sdk/InstallReferrer;

    iput-object p2, p0, Lcom/adjust/sdk/InstallReferrer$2;->val$proxy:Ljava/lang/Object;

    iput-object p3, p0, Lcom/adjust/sdk/InstallReferrer$2;->val$method:Ljava/lang/reflect/Method;

    iput-object p4, p0, Lcom/adjust/sdk/InstallReferrer$2;->val$args:[Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 274
    :try_start_0
    iget-object v0, p0, Lcom/adjust/sdk/InstallReferrer$2;->this$0:Lcom/adjust/sdk/InstallReferrer;

    iget-object v1, p0, Lcom/adjust/sdk/InstallReferrer$2;->val$proxy:Ljava/lang/Object;

    iget-object v2, p0, Lcom/adjust/sdk/InstallReferrer$2;->val$method:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/adjust/sdk/InstallReferrer$2;->val$args:[Ljava/lang/Object;

    invoke-static {v0, v1, v2, v3}, Lcom/adjust/sdk/InstallReferrer;->access$000(Lcom/adjust/sdk/InstallReferrer;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 276
    iget-object v1, p0, Lcom/adjust/sdk/InstallReferrer$2;->this$0:Lcom/adjust/sdk/InstallReferrer;

    invoke-static {v1}, Lcom/adjust/sdk/InstallReferrer;->access$100(Lcom/adjust/sdk/InstallReferrer;)Lcom/adjust/sdk/ILogger;

    move-result-object v1

    const-string v2, "invoke error (%s) thrown by (%s)"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    .line 277
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    .line 278
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v4

    .line 276
    invoke-interface {v1, v2, v3}, Lcom/adjust/sdk/ILogger;->error(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
