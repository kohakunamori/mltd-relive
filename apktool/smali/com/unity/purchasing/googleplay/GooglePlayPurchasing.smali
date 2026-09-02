.class public Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;
.super Lcom/unity/purchasing/common/StoreDeserializer;
.source "GooglePlayPurchasing.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;
    }
.end annotation


# static fields
.field public static final ACTIVITY_REQUEST_CODE:I = 0x3e7

.field protected static final TAG:Ljava/lang/String; = "UnityIAP"

.field private static instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

.field private static final isDaydreamApiAvailable:Z


# instance fields
.field public PurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

.field public activityPending:Z

.field private context:Landroid/content/Context;

.field features:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;

.field public helper:Lcom/unity/purchasing/googleplay/IabHelper;

.field private inventory:Lcom/unity/purchasing/googleplay/Inventory;

.field private isUnityVrEnabled:Z

.field private launcher:Lcom/unity/purchasing/googleplay/IActivityLauncher;

.field private manager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

.field private offlineBackOffTime:I

.field private volatile purchaseInProgress:Z

.field private purchasesUpdatedReceiver:Landroid/content/BroadcastReceiver;

.field private skuUnderPurchase:Ljava/lang/String;

.field private unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "com.google.vr.ndk.base.DaydreamApi"

    .line 56
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    .line 60
    :goto_0
    sput-boolean v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isDaydreamApiAvailable:Z

    return-void
.end method

.method public constructor <init>(Lcom/unity/purchasing/common/IStoreCallback;Lcom/unity/purchasing/googleplay/IabHelper;Lcom/unity/purchasing/googleplay/IBillingServiceManager;Landroid/content/Context;Lcom/unity/purchasing/googleplay/IActivityLauncher;)V
    .locals 1

    .line 102
    invoke-direct {p0}, Lcom/unity/purchasing/common/StoreDeserializer;-><init>()V

    .line 68
    new-instance v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;

    invoke-direct {v0, p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)V

    iput-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->features:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;

    .line 132
    new-instance v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;

    invoke-direct {v0, p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$1;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)V

    iput-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->PurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    const/4 v0, 0x0

    .line 258
    iput-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchasesUpdatedReceiver:Landroid/content/BroadcastReceiver;

    const/16 v0, 0x1388

    .line 272
    iput v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->offlineBackOffTime:I

    const/4 v0, 0x0

    .line 334
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchaseInProgress:Z

    .line 103
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;

    .line 104
    iput-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    .line 105
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    sget-boolean p2, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isDaydreamApiAvailable:Z

    invoke-virtual {p1, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->enableDaydreamApi(Z)V

    .line 106
    iput-object p3, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->manager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    .line 107
    iput-object p4, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    .line 108
    iput-object p5, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->launcher:Lcom/unity/purchasing/googleplay/IActivityLauncher;

    .line 109
    sput-object p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    .line 111
    invoke-direct {p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->registerPurchasesUpdatedReceiver()V

    return-void
.end method

.method public static ContinuePurchase(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    .line 83
    sget-object v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    if-eqz v0, :cond_0

    .line 84
    sget-object v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-virtual {v0, p0, p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->StartPurchase(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private NotifyUnityOfProducts(Lcom/unity/purchasing/googleplay/Inventory;)V
    .locals 13

    .line 300
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 301
    iget-object v1, p1, Lcom/unity/purchasing/googleplay/Inventory;->mSkuMap:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 303
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/unity/purchasing/googleplay/SkuDetails;

    .line 306
    new-instance v4, Ljava/math/BigDecimal;

    invoke-virtual {v3}, Lcom/unity/purchasing/googleplay/SkuDetails;->getPriceInMicros()J

    move-result-wide v5

    invoke-direct {v4, v5, v6}, Ljava/math/BigDecimal;-><init>(J)V

    new-instance v5, Ljava/math/BigDecimal;

    const v6, 0xf4240

    invoke-direct {v5, v6}, Ljava/math/BigDecimal;-><init>(I)V

    invoke-virtual {v4, v5}, Ljava/math/BigDecimal;->divide(Ljava/math/BigDecimal;)Ljava/math/BigDecimal;

    move-result-object v12

    .line 307
    new-instance v4, Lcom/unity/purchasing/common/ProductMetadata;

    invoke-virtual {v3}, Lcom/unity/purchasing/googleplay/SkuDetails;->getPrice()Ljava/lang/String;

    move-result-object v8

    .line 308
    invoke-virtual {v3}, Lcom/unity/purchasing/googleplay/SkuDetails;->getTitle()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v3}, Lcom/unity/purchasing/googleplay/SkuDetails;->getDescription()Ljava/lang/String;

    move-result-object v10

    .line 309
    invoke-virtual {v3}, Lcom/unity/purchasing/googleplay/SkuDetails;->getISOCurrencyCode()Ljava/lang/String;

    move-result-object v11

    move-object v7, v4

    invoke-direct/range {v7 .. v12}, Lcom/unity/purchasing/common/ProductMetadata;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigDecimal;)V

    .line 313
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {p1, v3}, Lcom/unity/purchasing/googleplay/Inventory;->hasPurchase(Ljava/lang/String;)Z

    move-result v3

    const/4 v5, 0x0

    if-eqz v3, :cond_0

    .line 314
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {p1, v3}, Lcom/unity/purchasing/googleplay/Inventory;->getPurchase(Ljava/lang/String;)Lcom/unity/purchasing/googleplay/Purchase;

    move-result-object v3

    .line 315
    invoke-direct {p0, v3}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->encodeReceipt(Lcom/unity/purchasing/googleplay/Purchase;)Ljava/lang/String;

    move-result-object v5

    .line 316
    invoke-virtual {v3}, Lcom/unity/purchasing/googleplay/Purchase;->getOrderIdOrPurchaseToken()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_0
    move-object v3, v5

    .line 319
    :goto_1
    new-instance v6, Lcom/unity/purchasing/common/ProductDescription;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-direct {v6, v2, v4, v5, v3}, Lcom/unity/purchasing/common/ProductDescription;-><init>(Ljava/lang/String;Lcom/unity/purchasing/common/ProductMetadata;Ljava/lang/String;Ljava/lang/String;)V

    .line 320
    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 323
    :cond_1
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;

    invoke-interface {p1, v0}, Lcom/unity/purchasing/common/IStoreCallback;->OnProductsRetrieved(Ljava/util/List;)V

    return-void
.end method

.method private NotifyUnityOfPurchase(Lcom/unity/purchasing/googleplay/Purchase;)V
    .locals 3

    const-string v0, "NotifyUnityOfPurchase"

    .line 348
    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;)V

    .line 354
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {v0, p1}, Lcom/unity/purchasing/googleplay/Inventory;->addPurchase(Lcom/unity/purchasing/googleplay/Purchase;)V

    .line 355
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;

    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getSku()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->encodeReceipt(Lcom/unity/purchasing/googleplay/Purchase;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getOrderIdOrPurchaseToken()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, v1, v2, p1}, Lcom/unity/purchasing/common/IStoreCallback;->OnPurchaseSucceeded(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static ProcessActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 92
    sget-object v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    if-eqz v0, :cond_0

    .line 93
    sget-object v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    invoke-virtual {v0, p0, p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->onActivityResult(IILandroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method private QueryInventory(Ljava/util/List;J)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;J)V"
        }
    .end annotation

    const-string v0, "QueryInventory: %s"

    .line 275
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    .line 276
    new-instance v5, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;

    invoke-direct {v5, p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$4;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Ljava/util/List;)V

    .line 296
    iget-object v2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    const/4 v3, 0x1

    move-object v4, p1

    move-wide v6, p2

    invoke-virtual/range {v2 .. v7}, Lcom/unity/purchasing/googleplay/IabHelper;->queryInventoryAsync(ZLjava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;J)V

    return-void
.end method

.method static synthetic access$000(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Z
    .locals 0

    .line 41
    iget-boolean p0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchaseInProgress:Z

    return p0
.end method

.method static synthetic access$002(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Z)Z
    .locals 0

    .line 41
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchaseInProgress:Z

    return p1
.end method

.method static synthetic access$100(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 41
    invoke-static {p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$1000(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)V
    .locals 0

    .line 41
    invoke-direct {p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->pollForNewPurchases()V

    return-void
.end method

.method static synthetic access$1100(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)I
    .locals 0

    .line 41
    iget p0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->offlineBackOffTime:I

    return p0
.end method

.method static synthetic access$1102(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;I)I
    .locals 0

    .line 41
    iput p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->offlineBackOffTime:I

    return p1
.end method

.method static synthetic access$1200(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Ljava/util/List;J)V
    .locals 0

    .line 41
    invoke-direct {p0, p1, p2, p3}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->QueryInventory(Ljava/util/List;J)V

    return-void
.end method

.method static synthetic access$1300(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Landroid/content/Context;
    .locals 0

    .line 41
    iget-object p0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic access$200(Ljava/lang/String;)V
    .locals 0

    .line 41
    invoke-static {p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Purchase;)V
    .locals 0

    .line 41
    invoke-direct {p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->NotifyUnityOfPurchase(Lcom/unity/purchasing/googleplay/Purchase;)V

    return-void
.end method

.method static synthetic access$400(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Ljava/lang/String;
    .locals 0

    .line 41
    iget-object p0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->skuUnderPurchase:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$500(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/common/PurchaseFailureDescription;)V
    .locals 0

    .line 41
    invoke-direct {p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->reconcileFailedPurchaseWithInventory(Lcom/unity/purchasing/common/PurchaseFailureDescription;)V

    return-void
.end method

.method static synthetic access$600(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Lcom/unity/purchasing/common/IStoreCallback;
    .locals 0

    .line 41
    iget-object p0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;

    return-object p0
.end method

.method static synthetic access$700(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)Lcom/unity/purchasing/googleplay/Inventory;
    .locals 0

    .line 41
    iget-object p0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    return-object p0
.end method

.method static synthetic access$702(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Inventory;)Lcom/unity/purchasing/googleplay/Inventory;
    .locals 0

    .line 41
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    return-object p1
.end method

.method static synthetic access$800(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Purchase;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-direct {p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->encodeReceipt(Lcom/unity/purchasing/googleplay/Purchase;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$900(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/googleplay/Inventory;)V
    .locals 0

    .line 41
    invoke-direct {p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->NotifyUnityOfProducts(Lcom/unity/purchasing/googleplay/Inventory;)V

    return-void
.end method

.method private encodeReceipt(Lcom/unity/purchasing/googleplay/Purchase;)Ljava/lang/String;
    .locals 3

    .line 359
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v1, "json"

    .line 361
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getOriginalJson()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "signature"

    .line 362
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getSignature()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 365
    invoke-virtual {p1}, Lorg/json/JSONException;->printStackTrace()V

    .line 368
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private findPurchaseByOrderId(Ljava/lang/String;)Lcom/unity/purchasing/googleplay/Purchase;
    .locals 3

    .line 337
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {v0}, Lcom/unity/purchasing/googleplay/Inventory;->getAllPurchases()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/unity/purchasing/googleplay/Purchase;

    .line 338
    invoke-virtual {v1}, Lcom/unity/purchasing/googleplay/Purchase;->getOrderIdOrPurchaseToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v1

    :cond_1
    const-string v0, "No consumable with order %s"

    .line 343
    invoke-static {v0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method public static instance(Lcom/unity/purchasing/common/IUnityCallback;)Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;
    .locals 7

    .line 73
    sget-object v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    if-nez v0, :cond_0

    .line 74
    new-instance v4, Lcom/unity/purchasing/googleplay/BillingServiceManager;

    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    invoke-direct {v4, v0}, Lcom/unity/purchasing/googleplay/BillingServiceManager;-><init>(Landroid/content/Context;)V

    .line 75
    new-instance v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    new-instance v2, Lcom/unity/purchasing/common/UnityPurchasing;

    invoke-direct {v2, p0}, Lcom/unity/purchasing/common/UnityPurchasing;-><init>(Lcom/unity/purchasing/common/IUnityCallback;)V

    new-instance v3, Lcom/unity/purchasing/googleplay/IabHelper;

    sget-object p0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    new-instance v1, Lcom/unity/purchasing/googleplay/ActivityLauncher;

    invoke-direct {v1}, Lcom/unity/purchasing/googleplay/ActivityLauncher;-><init>()V

    invoke-direct {v3, p0, v4, v1}, Lcom/unity/purchasing/googleplay/IabHelper;-><init>(Landroid/content/Context;Lcom/unity/purchasing/googleplay/IBillingServiceManager;Lcom/unity/purchasing/googleplay/IActivityLauncher;)V

    sget-object v5, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    new-instance v6, Lcom/unity/purchasing/googleplay/ActivityLauncher;

    invoke-direct {v6}, Lcom/unity/purchasing/googleplay/ActivityLauncher;-><init>()V

    move-object v1, v0

    invoke-direct/range {v1 .. v6}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;-><init>(Lcom/unity/purchasing/common/IStoreCallback;Lcom/unity/purchasing/googleplay/IabHelper;Lcom/unity/purchasing/googleplay/IBillingServiceManager;Landroid/content/Context;Lcom/unity/purchasing/googleplay/IActivityLauncher;)V

    sput-object v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    .line 79
    :cond_0
    sget-object p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->instance:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;

    return-object p0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 1

    const-string v0, "UnityIAP"

    .line 372
    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private static log(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x1

    .line 376
    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    invoke-static {p0, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;)V

    return-void
.end method

.method private pollForNewPurchases()V
    .locals 1

    const/4 v0, 0x0

    .line 198
    invoke-direct {p0, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->reconcileFailedPurchaseWithInventory(Lcom/unity/purchasing/common/PurchaseFailureDescription;)V

    return-void
.end method

.method private reconcileFailedPurchaseWithInventory(Lcom/unity/purchasing/common/PurchaseFailureDescription;)V
    .locals 2

    .line 206
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->manager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    new-instance v1, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$2;

    invoke-direct {v1, p0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$2;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Lcom/unity/purchasing/common/PurchaseFailureDescription;)V

    invoke-interface {v0, v1}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->workWith(Lcom/unity/purchasing/googleplay/BillingServiceProcessor;)V

    return-void
.end method

.method private registerPurchasesUpdatedReceiver()V
    .locals 4

    .line 261
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchasesUpdatedReceiver:Landroid/content/BroadcastReceiver;

    if-nez v0, :cond_0

    .line 262
    new-instance v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$3;

    invoke-direct {v0, p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$3;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)V

    iput-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchasesUpdatedReceiver:Landroid/content/BroadcastReceiver;

    .line 268
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchasesUpdatedReceiver:Landroid/content/BroadcastReceiver;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "com.android.vending.billing.PURCHASES_UPDATED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    :cond_0
    return-void
.end method


# virtual methods
.method public FinishTransaction(Lcom/unity/purchasing/common/ProductDefinition;Ljava/lang/String;)V
    .locals 1

    const-string v0, "Finish transaction:%s"

    .line 469
    invoke-static {v0, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    if-nez p1, :cond_0

    const-string p1, "Received FinishTransaction for unknown product with transaction %s. Not consuming."

    .line 472
    invoke-static {p1, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 478
    :cond_0
    iget-object p1, p1, Lcom/unity/purchasing/common/ProductDefinition;->type:Lcom/unity/purchasing/common/ProductType;

    sget-object v0, Lcom/unity/purchasing/common/ProductType;->Consumable:Lcom/unity/purchasing/common/ProductType;

    if-ne p1, v0, :cond_1

    .line 481
    invoke-direct {p0, p2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->findPurchaseByOrderId(Ljava/lang/String;)Lcom/unity/purchasing/googleplay/Purchase;

    move-result-object p1

    if-eqz p1, :cond_1

    const-string p2, "Consuming %s"

    .line 483
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getSku()Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    .line 484
    iget-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getSku()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/unity/purchasing/googleplay/Inventory;->erasePurchase(Ljava/lang/String;)V

    .line 486
    iget-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    new-instance v0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$7;

    invoke-direct {v0, p0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$7;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;)V

    invoke-virtual {p2, p1, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->consumeAsync(Lcom/unity/purchasing/googleplay/Purchase;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;)V

    :cond_1
    return-void
.end method

.method public Purchase(Lcom/unity/purchasing/common/ProductDefinition;)V
    .locals 1

    const/4 v0, 0x0

    .line 417
    invoke-virtual {p0, p1, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->Purchase(Lcom/unity/purchasing/common/ProductDefinition;Ljava/lang/String;)V

    return-void
.end method

.method public Purchase(Lcom/unity/purchasing/common/ProductDefinition;Ljava/lang/String;)V
    .locals 5

    .line 421
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchaseInProgress:Z

    if-eqz v0, :cond_0

    .line 422
    new-instance p2, Lcom/unity/purchasing/common/PurchaseFailureDescription;

    iget-object p1, p1, Lcom/unity/purchasing/common/ProductDefinition;->storeSpecificId:Ljava/lang/String;

    sget-object v0, Lcom/unity/purchasing/common/PurchaseFailureReason;->ExistingPurchasePending:Lcom/unity/purchasing/common/PurchaseFailureReason;

    invoke-direct {p2, p1, v0}, Lcom/unity/purchasing/common/PurchaseFailureDescription;-><init>(Ljava/lang/String;Lcom/unity/purchasing/common/PurchaseFailureReason;)V

    .line 424
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;

    invoke-interface {p1, p2}, Lcom/unity/purchasing/common/IStoreCallback;->OnPurchaseFailed(Lcom/unity/purchasing/common/PurchaseFailureDescription;)V

    return-void

    .line 428
    :cond_0
    iget-object p1, p1, Lcom/unity/purchasing/common/ProductDefinition;->storeSpecificId:Ljava/lang/String;

    .line 429
    iput-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->skuUnderPurchase:Ljava/lang/String;

    const-string v0, "onPurchaseProduct: %s"

    .line 430
    invoke-static {v0, p1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    .line 432
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {v0, p1}, Lcom/unity/purchasing/googleplay/Inventory;->getSkuDetails(Ljava/lang/String;)Lcom/unity/purchasing/googleplay/SkuDetails;

    move-result-object v0

    const-string v1, "ITEM TYPE:%s"

    .line 433
    invoke-virtual {v0}, Lcom/unity/purchasing/googleplay/SkuDetails;->getType()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    .line 435
    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    instance-of v1, v1, Lcom/unity3d/player/UnityPlayerActivity;

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    iget-boolean v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isUnityVrEnabled:Z

    if-eqz v1, :cond_1

    sget-boolean v1, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isDaydreamApiAvailable:Z

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    .line 437
    :goto_0
    invoke-virtual {p0, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->createPurchaseIntent(Z)Landroid/content/Intent;

    move-result-object v3

    const-string v4, "productId"

    .line 438
    invoke-virtual {v3, v4, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "itemType"

    .line 439
    invoke-virtual {v0}, Lcom/unity/purchasing/googleplay/SkuDetails;->getType()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, p1, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "developerPayload"

    .line 440
    invoke-virtual {v3, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 441
    iput-boolean v2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchaseInProgress:Z

    .line 442
    iput-boolean v2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->activityPending:Z

    if-eqz v1, :cond_2

    .line 446
    new-instance p1, Landroid/os/Handler;

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    invoke-virtual {p2}, Landroid/content/Context;->getMainLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance p2, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$6;

    invoke-direct {p2, p0, v3}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$6;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Landroid/content/Intent;)V

    invoke-virtual {p1, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_1

    .line 457
    :cond_2
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->launcher:Lcom/unity/purchasing/googleplay/IActivityLauncher;

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    invoke-interface {p1, p2, v3}, Lcom/unity/purchasing/googleplay/IActivityLauncher;->startActivity(Landroid/content/Context;Landroid/content/Intent;)V

    :goto_1
    return-void
.end method

.method public RetrieveProducts(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/unity/purchasing/common/ProductDefinition;",
            ">;)V"
        }
    .end annotation

    .line 380
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 381
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/unity/purchasing/common/ProductDefinition;

    .line 382
    iget-object v1, v1, Lcom/unity/purchasing/common/ProductDefinition;->storeSpecificId:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 385
    :cond_0
    new-instance p1, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$5;

    invoke-direct {p1, p0, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$5;-><init>(Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;Ljava/util/List;)V

    .line 403
    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    iget-boolean v1, v1, Lcom/unity/purchasing/googleplay/IabHelper;->mSetupDone:Z

    if-nez v1, :cond_1

    .line 405
    :try_start_0
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->manager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    invoke-interface {v0}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->initialise()V

    .line 406
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    invoke-virtual {v0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->startSetup(Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;)V
    :try_end_0
    .catch Lcom/unity/purchasing/googleplay/GooglePlayBillingUnAvailableException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 408
    :catch_0
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->unityPurchasing:Lcom/unity/purchasing/common/IStoreCallback;

    sget-object v0, Lcom/unity/purchasing/common/InitializationFailureReason;->PurchasingUnavailable:Lcom/unity/purchasing/common/InitializationFailureReason;

    invoke-interface {p1, v0}, Lcom/unity/purchasing/common/IStoreCallback;->OnSetupFailed(Lcom/unity/purchasing/common/InitializationFailureReason;)V

    goto :goto_1

    :cond_1
    const-string p1, "Requesting %s products"

    .line 411
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    const-wide/16 v1, 0x0

    .line 412
    invoke-direct {p0, v0, v1, v2}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->QueryInventory(Ljava/util/List;J)V

    :goto_1
    return-void
.end method

.method public SetFeatures(Ljava/lang/String;)V
    .locals 4

    const-string v0, ","

    .line 503
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    .line 504
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    const-string v3, "supportsPurchaseFailureReasonDuplicateTransaction"

    .line 505
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 506
    iget-object v2, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->features:Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing$Features;->supportsPurchaseFailureReasonDuplicateTransaction:Z

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method public SetUnityVrEnabled(Z)V
    .locals 1

    .line 116
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isUnityVrEnabled:Z

    const-string p1, "isUnityVrEnabled = %s"

    .line 117
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isUnityVrEnabled:Z

    invoke-static {v0}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public StartPurchase(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    .line 123
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    iget-boolean v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->isUnityVrEnabled:Z

    invoke-virtual {v0, v1}, Lcom/unity/purchasing/googleplay/IabHelper;->enableUnityVr(Z)V

    .line 125
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->inventory:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {v0, p2}, Lcom/unity/purchasing/googleplay/Inventory;->getSkuDetails(Ljava/lang/String;)Lcom/unity/purchasing/googleplay/SkuDetails;

    move-result-object v0

    iget-object v0, v0, Lcom/unity/purchasing/googleplay/SkuDetails;->mItemType:Ljava/lang/String;

    const-string v1, "inapp"

    if-ne v0, v1, :cond_0

    .line 126
    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    const/16 v4, 0x3e7

    iget-object v5, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->PurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    move-object v2, p1

    move-object v3, p2

    move-object v6, p3

    invoke-virtual/range {v1 .. v6}, Lcom/unity/purchasing/googleplay/IabHelper;->launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V

    goto :goto_0

    .line 128
    :cond_0
    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    const/16 v4, 0x3e7

    iget-object v5, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->PurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    move-object v2, p1

    move-object v3, p2

    move-object v6, p3

    invoke-virtual/range {v1 .. v6}, Lcom/unity/purchasing/googleplay/IabHelper;->launchSubscriptionPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method protected createPurchaseIntent(Z)Landroid/content/Intent;
    .locals 2

    if-eqz p1, :cond_0

    .line 463
    const-class p1, Lcom/unity/purchasing/googleplay/VRPurchaseActivity;

    goto :goto_0

    :cond_0
    const-class p1, Lcom/unity/purchasing/googleplay/PurchaseActivity;

    .line 465
    :goto_0
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->context:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    return-object v0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    .line 327
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    if-eqz v0, :cond_0

    const-string v0, "onActivityResult"

    .line 328
    invoke-static {v0}, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->log(Ljava/lang/String;)V

    .line 329
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->helper:Lcom/unity/purchasing/googleplay/IabHelper;

    invoke-virtual {v0, p1, p2, p3}, Lcom/unity/purchasing/googleplay/IabHelper;->handleActivityResult(IILandroid/content/Intent;)Z

    const/4 p1, 0x0

    .line 330
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/GooglePlayPurchasing;->purchaseInProgress:Z

    :cond_0
    return-void
.end method
