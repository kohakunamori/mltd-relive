.class Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$7;
.super Ljava/lang/Object;
.source "GooglePlayPurchasing.java"

# interfaces
.implements Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->FinishTransaction(Lcom/unity/purchasing/common/ProductDefinition;Ljava/lang/String;)V
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

    .line 486
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$7;->this$0:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConsumeFinished(Lcom/unity/purchasing/googleplay/Purchase;Lcom/unity/purchasing/googleplay/IabResult;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    const-string p1, "onConsumeFinished:%s"

    .line 489
    invoke-virtual {p2}, Lcom/unity/purchasing/googleplay/IabResult;->isSuccess()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$100(Ljava/lang/String;Ljava/lang/String;)V

    .line 490
    iget-object p1, p2, Lcom/unity/purchasing/googleplay/IabResult;->mMessage:Ljava/lang/String;

    invoke-static {p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    .line 491
    invoke-virtual {p2}, Lcom/unity/purchasing/googleplay/IabResult;->getResponse()I

    move-result p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->access$200(Ljava/lang/String;)V

    return-void
.end method
