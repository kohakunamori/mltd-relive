.class Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;
.super Ljava/lang/Object;
.source "GooglePlayPurchasing.java"

# interfaces
.implements Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->QueryInventory(Ljava/util/List;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

.field final synthetic val$skus:Ljava/util/List;


# direct methods
.method constructor <init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Ljava/util/List;)V
    .locals 0

    .line 276
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    iput-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->val$skus:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onQueryInventoryFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Inventory;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const-string v0, "onQueryInventoryFinished: %s"

    .line 280
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->isSuccess()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$100(Ljava/lang/String;Ljava/lang/String;)V

    .line 281
    iget-object v0, p1, Lcom/unity/purchasing/googleplay/IabResult;->mMessage:Ljava/lang/String;

    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    .line 283
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->isFailure()Z

    move-result p1

    if-eqz p1, :cond_0

    .line 284
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Failed to Query inventory. UnityIAP will automatically retry in "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$1100(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)I

    move-result p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, "ms"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    .line 285
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->val$skus:Ljava/util/List;

    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$1100(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)I

    move-result v0

    int-to-long v0, v0

    invoke-static {p1, p2, v0, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$1200(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Ljava/util/List;J)V

    .line 286
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    const p2, 0x493e0

    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$1100(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)I

    move-result v0

    mul-int/lit8 v0, v0, 0x2

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    invoke-static {p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$1102(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;I)I

    return-void

    .line 290
    :cond_0
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$702(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Inventory;)Lcom/unity/purchasing/googleplay/Inventory;

    .line 292
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$900(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Inventory;)V

    return-void
.end method
