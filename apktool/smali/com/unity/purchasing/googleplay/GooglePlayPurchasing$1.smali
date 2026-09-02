.class Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;
.super Ljava/lang/Object;
.source "GooglePlayPurchasing.java"

# interfaces
.implements Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;


# direct methods
.method constructor <init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)V
    .locals 0

    .line 132
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V
    .locals 3

    .line 136
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$000(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v0, "onIabPurchaseFinished: %s"

    .line 149
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->isSuccess()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$100(Ljava/lang/String;Ljava/lang/String;)V

    .line 150
    iget-object v0, p1, Lcom/unity/purchasing/googleplay/IabResult;->mMessage:Ljava/lang/String;

    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    .line 151
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$002(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Z)Z

    .line 152
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->isSuccess()Z

    move-result v0

    if-eqz v0, :cond_1

    const-string p1, "Product purchased successfully!"

    .line 153
    invoke-static {p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    .line 154
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$300(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Purchase;)V

    goto :goto_1

    :cond_1
    const-string p2, "Purchase response code:%s"

    .line 156
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->getResponse()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$100(Ljava/lang/String;Ljava/lang/String;)V

    .line 157
    sget-object p2, Lcom/unity/purchasing/common/PurchaseFailureReason;->Unknown:Lcom/unity/purchasing/common/PurchaseFailureReason;

    .line 159
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->getResponse()I

    move-result v0

    const/16 v1, -0x3ed

    if-eq v0, v1, :cond_3

    const/4 v1, 0x7

    if-eq v0, v1, :cond_2

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 165
    :pswitch_0
    sget-object p2, Lcom/unity/purchasing/common/PurchaseFailureReason;->ItemUnavailable:Lcom/unity/purchasing/common/PurchaseFailureReason;

    goto :goto_0

    .line 169
    :pswitch_1
    sget-object p2, Lcom/unity/purchasing/common/PurchaseFailureReason;->BillingUnavailable:Lcom/unity/purchasing/common/PurchaseFailureReason;

    goto :goto_0

    .line 172
    :cond_2
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    iget-object v0, v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->features:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;

    iget-boolean v0, v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;->supportsPurchaseFailureReasonDuplicateTransaction:Z

    if-eqz v0, :cond_4

    .line 173
    sget-object p2, Lcom/unity/purchasing/common/PurchaseFailureReason;->DuplicateTransaction:Lcom/unity/purchasing/common/PurchaseFailureReason;

    goto :goto_0

    .line 162
    :cond_3
    :pswitch_2
    sget-object p2, Lcom/unity/purchasing/common/PurchaseFailureReason;->UserCancelled:Lcom/unity/purchasing/common/PurchaseFailureReason;

    .line 178
    :cond_4
    :goto_0
    new-instance v0, Lcom/unity/purchasing/common/PurchaseFailureDescription;

    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$400(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->getResponse()I

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, p2, v2}, Lcom/unity/purchasing/common/PurchaseFailureDescription;-><init>(Ljava/lang/String;Lcom/unity/purchasing/common/PurchaseFailureReason;Ljava/lang/String;)V

    .line 180
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/IabResult;->getResponse()I

    move-result p1

    const/16 p2, -0x3ea

    if-ne p1, p2, :cond_5

    const-string p1, "Received bad response, polling for successful purchases to investigate failure more deeply"

    .line 181
    invoke-static {p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    .line 187
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {p1, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$500(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/common/PurchaseFailureDescription;)V

    goto :goto_1

    .line 190
    :cond_5
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-static {p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$600(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Lcom/unity/purchasing/common/IStoreCallback;

    move-result-object p1

    invoke-interface {p1, v0}, Lcom/unity/purchasing/common/IStoreCallback;->OnPurchaseFailed(Lcom/unity/purchasing/common/PurchaseFailureDescription;)V

    :goto_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
