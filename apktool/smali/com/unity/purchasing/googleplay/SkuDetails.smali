.class public Lcom/unity/purchasing/googleplay/SkuDetails;
.super Ljava/lang/Object;
.source "SkuDetails.java"


# instance fields
.field isoCurrencyCode:Ljava/lang/String;

.field mDescription:Ljava/lang/String;

.field mItemType:Ljava/lang/String;

.field mJson:Ljava/lang/String;

.field mPrice:Ljava/lang/String;

.field mSku:Ljava/lang/String;

.field mTitle:Ljava/lang/String;

.field mType:Ljava/lang/String;

.field priceInMicros:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    const-string v0, "inapp"

    .line 39
    invoke-direct {p0, v0, p1}, Lcom/unity/purchasing/googleplay/SkuDetails;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mItemType:Ljava/lang/String;

    .line 44
    iput-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mJson:Ljava/lang/String;

    .line 45
    new-instance p1, Lorg/json/JSONObject;

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mJson:Ljava/lang/String;

    invoke-direct {p1, p2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p2, "productId"

    .line 46
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mSku:Ljava/lang/String;

    const-string p2, "type"

    .line 47
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mType:Ljava/lang/String;

    const-string p2, "price"

    .line 48
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mPrice:Ljava/lang/String;

    const-string p2, "title"

    .line 49
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mTitle:Ljava/lang/String;

    const-string p2, "description"

    .line 50
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mDescription:Ljava/lang/String;

    const-string p2, "price_amount_micros"

    .line 51
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->priceInMicros:J

    const-string p2, "price_currency_code"

    .line 52
    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->isoCurrencyCode:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getDescription()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mDescription:Ljava/lang/String;

    return-object v0
.end method

.method public getISOCurrencyCode()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->isoCurrencyCode:Ljava/lang/String;

    return-object v0
.end method

.method public getPrice()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mPrice:Ljava/lang/String;

    return-object v0
.end method

.method public getPriceInMicros()J
    .locals 2

    .line 60
    iget-wide v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->priceInMicros:J

    return-wide v0
.end method

.method public getSku()Ljava/lang/String;
    .locals 1

    .line 55
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mSku:Ljava/lang/String;

    return-object v0
.end method

.method public getTitle()Ljava/lang/String;
    .locals 1

    .line 58
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mTitle:Ljava/lang/String;

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 56
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mType:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 65
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SkuDetails:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/unity/purchasing/googleplay/SkuDetails;->mJson:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
