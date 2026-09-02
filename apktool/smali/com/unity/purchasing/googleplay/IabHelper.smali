.class public Lcom/unity/purchasing/googleplay/IabHelper;
.super Ljava/lang/Object;
.source "IabHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;,
        Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;,
        Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;,
        Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;,
        Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;
    }
.end annotation


# static fields
.field public static final BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE:I = 0x3

.field public static final BILLING_RESPONSE_RESULT_DEVELOPER_ERROR:I = 0x5

.field public static final BILLING_RESPONSE_RESULT_ERROR:I = 0x6

.field public static final BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED:I = 0x7

.field public static final BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED:I = 0x8

.field public static final BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE:I = 0x4

.field public static final BILLING_RESPONSE_RESULT_OK:I = 0x0

.field public static final BILLING_RESPONSE_RESULT_SERVICE_UNAVAILABLE:I = 0x2

.field public static final BILLING_RESPONSE_RESULT_USER_CANCELED:I = 0x1

.field public static final GET_SKU_DETAILS_ITEM_LIST:Ljava/lang/String; = "ITEM_ID_LIST"

.field public static final GET_SKU_DETAILS_ITEM_TYPE_LIST:Ljava/lang/String; = "ITEM_TYPE_LIST"

.field public static final IABHELPER_BAD_RESPONSE:I = -0x3ea

.field public static final IABHELPER_ERROR_BASE:I = -0x3e8

.field public static final IABHELPER_INVALID_CONSUMPTION:I = -0x3f2

.field public static final IABHELPER_MISSING_TOKEN:I = -0x3ef

.field public static final IABHELPER_REMOTE_EXCEPTION:I = -0x3e9

.field public static final IABHELPER_SEND_INTENT_FAILED:I = -0x3ec

.field public static final IABHELPER_SUBSCRIPTIONS_NOT_AVAILABLE:I = -0x3f1

.field public static final IABHELPER_UNKNOWN_ERROR:I = -0x3f0

.field public static final IABHELPER_UNKNOWN_PURCHASE_RESPONSE:I = -0x3ee

.field public static final IABHELPER_USER_CANCELLED:I = -0x3ed

.field public static final IABHELPER_VERIFICATION_FAILED:I = -0x3eb

.field public static final INAPP_CONTINUATION_TOKEN:Ljava/lang/String; = "INAPP_CONTINUATION_TOKEN"

.field public static final ITEM_TYPE_INAPP:Ljava/lang/String; = "inapp"

.field public static final ITEM_TYPE_SUBS:Ljava/lang/String; = "subs"

.field public static final RESPONSE_BUY_INTENT:Ljava/lang/String; = "BUY_INTENT"

.field public static final RESPONSE_CODE:Ljava/lang/String; = "RESPONSE_CODE"

.field public static final RESPONSE_GET_SKU_DETAILS_LIST:Ljava/lang/String; = "DETAILS_LIST"

.field public static final RESPONSE_INAPP_ITEM_LIST:Ljava/lang/String; = "INAPP_PURCHASE_ITEM_LIST"

.field public static final RESPONSE_INAPP_PURCHASE_DATA:Ljava/lang/String; = "INAPP_PURCHASE_DATA"

.field public static final RESPONSE_INAPP_PURCHASE_DATA_LIST:Ljava/lang/String; = "INAPP_PURCHASE_DATA_LIST"

.field public static final RESPONSE_INAPP_SIGNATURE:Ljava/lang/String; = "INAPP_DATA_SIGNATURE"

.field public static final RESPONSE_INAPP_SIGNATURE_LIST:Ljava/lang/String; = "INAPP_DATA_SIGNATURE_LIST"


# instance fields
.field private inv:Lcom/unity/purchasing/googleplay/Inventory;

.field private launcher:Lcom/unity/purchasing/googleplay/IActivityLauncher;

.field mAsyncOperation:Ljava/lang/String;

.field mContext:Landroid/content/Context;

.field private mDaydreamApiAvailable:Z

.field mDebugLog:Z

.field mDebugTag:Ljava/lang/String;

.field volatile mDisposed:Z

.field mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

.field mPurchasingItemType:Ljava/lang/String;

.field mRequestCode:I

.field volatile mSetupDone:Z

.field mSubscriptionsSupported:Z

.field private mUnityVrEnabled:Z

.field private mVrSupported:Z

.field private serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/unity/purchasing/googleplay/IBillingServiceManager;Lcom/unity/purchasing/googleplay/IActivityLauncher;)V
    .locals 2

    .line 169
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 77
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugLog:Z

    const-string v1, "IabHelper"

    .line 78
    iput-object v1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugTag:Ljava/lang/String;

    .line 81
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSetupDone:Z

    .line 85
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDisposed:Z

    .line 88
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSubscriptionsSupported:Z

    .line 91
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mVrSupported:Z

    .line 94
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mUnityVrEnabled:Z

    .line 97
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDaydreamApiAvailable:Z

    const-string v0, ""

    .line 101
    iput-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mAsyncOperation:Ljava/lang/String;

    .line 170
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    .line 171
    iput-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    .line 172
    iput-object p3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->launcher:Lcom/unity/purchasing/googleplay/IActivityLauncher;

    .line 173
    new-instance p1, Lcom/unity/purchasing/googleplay/Inventory;

    invoke-direct {p1}, Lcom/unity/purchasing/googleplay/Inventory;-><init>()V

    iput-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    const-string p1, "IAB helper created."

    .line 175
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$000(Lcom/unity/purchasing/googleplay/IabHelper;Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;Lcom/android/vending/billing/IInAppBillingService;)V
    .locals 0

    .line 75
    invoke-direct {p0, p1, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->finishSetup(Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;Lcom/android/vending/billing/IInAppBillingService;)V

    return-void
.end method

.method static synthetic access$100(Lcom/unity/purchasing/googleplay/IabHelper;)Z
    .locals 0

    .line 75
    iget-boolean p0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mVrSupported:Z

    return p0
.end method

.method static synthetic access$200(Lcom/unity/purchasing/googleplay/IabHelper;)Z
    .locals 0

    .line 75
    iget-boolean p0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mUnityVrEnabled:Z

    return p0
.end method

.method static synthetic access$300(Lcom/unity/purchasing/googleplay/IabHelper;)Lcom/unity/purchasing/googleplay/Inventory;
    .locals 0

    .line 75
    iget-object p0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    return-object p0
.end method

.method static synthetic access$400(Lcom/unity/purchasing/googleplay/IabHelper;)Z
    .locals 0

    .line 75
    iget-boolean p0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDaydreamApiAvailable:Z

    return p0
.end method

.method static synthetic access$500(Lcom/unity/purchasing/googleplay/IabHelper;)Lcom/unity/purchasing/googleplay/IActivityLauncher;
    .locals 0

    .line 75
    iget-object p0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->launcher:Lcom/unity/purchasing/googleplay/IActivityLauncher;

    return-object p0
.end method

.method public static byteArrayToHexString([B)Ljava/lang/String;
    .locals 7

    .line 994
    new-instance v0, Ljava/lang/StringBuilder;

    array-length v1, p0

    mul-int/lit8 v1, v1, 0x2

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 995
    array-length v1, p0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_0

    aget-byte v4, p0, v3

    const-string v5, "%02x"

    const/4 v6, 0x1

    .line 996
    new-array v6, v6, [Ljava/lang/Object;

    and-int/lit16 v4, v4, 0xff

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v6, v2

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 998
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private finishSetup(Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;Lcom/android/vending/billing/IInAppBillingService;)V
    .locals 6

    .line 244
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    :try_start_0
    const-string v1, "Checking for in-app billing 3 support."

    .line 246
    invoke-virtual {p0, v1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const-string v1, "inapp"

    const/4 v2, 0x3

    .line 249
    invoke-interface {p2, v2, v0, v1}, Lcom/android/vending/billing/IInAppBillingService;->isBillingSupported(ILjava/lang/String;Ljava/lang/String;)I

    move-result v1

    const/4 v3, 0x0

    if-eqz v1, :cond_0

    .line 251
    new-instance p2, Lcom/unity/purchasing/googleplay/IabResult;

    const-string v0, "Billing V3 not supported."

    invoke-direct {p2, v1, v0}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    invoke-interface {p1, p2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;->onIabSetupFinished(Lcom/unity/purchasing/googleplay/IabResult;)V

    .line 255
    iput-boolean v3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSubscriptionsSupported:Z

    return-void

    .line 258
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "In-app billing version 3 supported for "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const-string v1, "subs"

    .line 261
    invoke-interface {p2, v2, v0, v1}, Lcom/android/vending/billing/IInAppBillingService;->isBillingSupported(ILjava/lang/String;Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_1

    const-string v0, "Subscriptions AVAILABLE."

    .line 263
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 264
    iput-boolean v1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSubscriptionsSupported:Z

    goto :goto_0

    .line 267
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Subscriptions NOT AVAILABLE. Response: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 271
    :goto_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v2, "vr"

    .line 272
    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const/4 v2, 0x7

    .line 273
    iget-object v4, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "inapp"

    invoke-interface {p2, v2, v4, v5, v0}, Lcom/android/vending/billing/IInAppBillingService;->isBillingSupportedExtraParams(ILjava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)I

    move-result p2

    if-nez p2, :cond_2

    const-string p2, "VR supported."

    .line 275
    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 276
    iput-boolean v1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mVrSupported:Z

    goto :goto_1

    .line 279
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "VR purchases  NOT AVAILABLE. Response: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 282
    :goto_1
    iput-boolean v1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSetupDone:Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 290
    new-instance p2, Lcom/unity/purchasing/googleplay/IabResult;

    const-string v0, "Setup successful."

    invoke-direct {p2, v3, v0}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    invoke-interface {p1, p2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;->onIabSetupFinished(Lcom/unity/purchasing/googleplay/IabResult;)V

    return-void

    .line 285
    :catch_0
    new-instance p2, Lcom/unity/purchasing/googleplay/IabResult;

    const/16 v0, -0x3e9

    const-string v1, "RemoteException while setting up in-app billing."

    invoke-direct {p2, v0, v1}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    invoke-interface {p1, p2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;->onIabSetupFinished(Lcom/unity/purchasing/googleplay/IabResult;)V

    return-void
.end method

.method public static getResponseDesc(I)Ljava/lang/String;
    .locals 3

    const-string v0, "0:OK/1:User Canceled/2:Unknown/3:Billing Unavailable/4:Item unavailable/5:Developer Error/6:Error/7:Item Already Owned/8:Item not owned"

    const-string v1, "/"

    .line 785
    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const-string v1, "0:OK/-1001:Remote exception during initialization/-1002:Bad response received/-1003:Purchase signature verification failed/-1004:Send intent failed/-1005:User cancelled/-1006:Unknown purchase response/-1007:Missing token/-1008:Unknown error/-1009:Subscriptions not available/-1010:Invalid consumption attempt"

    const-string v2, "/"

    .line 795
    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    const/16 v2, -0x3e8

    if-gt p0, v2, :cond_1

    sub-int/2addr v2, p0

    if-ltz v2, :cond_0

    .line 799
    array-length v0, v1

    if-ge v2, v0, :cond_0

    aget-object p0, v1, v2

    return-object p0

    .line 800
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, ":Unknown IAB Helper Error"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    if-ltz p0, :cond_3

    .line 802
    array-length v1, v0

    if-lt p0, v1, :cond_2

    goto :goto_0

    .line 805
    :cond_2
    aget-object p0, v0, p0

    return-object p0

    .line 803
    :cond_3
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, ":Unknown"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method checkSetupDone(Ljava/lang/String;)V
    .locals 3

    .line 811
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSetupDone:Z

    if-eqz v0, :cond_0

    return-void

    .line 812
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal state for operation ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "): IAB helper is not set up."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 813
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IAB helper is not set up. Can\'t perform operation: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method consume(Lcom/unity/purchasing/googleplay/Purchase;Lcom/android/vending/billing/IInAppBillingService;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/unity/purchasing/googleplay/IabException;
        }
    .end annotation

    .line 692
    iget-object v0, p1, Lcom/unity/purchasing/googleplay/Purchase;->mItemType:Ljava/lang/String;

    const-string v1, "inapp"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 698
    :try_start_0
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getToken()Ljava/lang/String;

    move-result-object v0

    .line 699
    invoke-virtual {p1}, Lcom/unity/purchasing/googleplay/Purchase;->getSku()Ljava/lang/String;

    move-result-object v1

    if-eqz v0, :cond_1

    const-string v2, ""

    .line 700
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 706
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Consuming sku: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ", token: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const/4 v2, 0x3

    .line 707
    iget-object v3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-interface {p2, v2, v3, v0}, Lcom/android/vending/billing/IInAppBillingService;->consumePurchase(ILjava/lang/String;Ljava/lang/String;)I

    move-result p2

    if-nez p2, :cond_0

    .line 709
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Successfully consumed sku: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    return-void

    .line 712
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Error consuming consuming sku "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ". "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p2}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 713
    new-instance v0, Lcom/unity/purchasing/googleplay/IabException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error consuming sku "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p2, v1}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw v0

    .line 701
    :cond_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "Can\'t consume "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ". No token."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 702
    new-instance p2, Lcom/unity/purchasing/googleplay/IabException;

    const/16 v0, -0x3ef

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PurchaseInfo is missing token for sku: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p2, v0, v1}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw p2
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p2

    .line 717
    new-instance v0, Lcom/unity/purchasing/googleplay/IabException;

    const/16 v1, -0x3e9

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Remote exception while consuming. PurchaseInfo: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, v1, p1, p2}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;Ljava/lang/Exception;)V

    throw v0

    .line 693
    :cond_2
    new-instance p2, Lcom/unity/purchasing/googleplay/IabException;

    const/16 v0, -0x3f2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Items of type \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p1, p1, Lcom/unity/purchasing/googleplay/Purchase;->mItemType:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\' can\'t be consumed."

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, v0, p1}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw p2
.end method

.method public consumeAsync(Lcom/unity/purchasing/googleplay/Purchase;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;)V
    .locals 1

    const-string v0, "consume"

    .line 758
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->checkSetupDone(Ljava/lang/String;)V

    .line 759
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 760
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 p1, 0x0

    .line 761
    invoke-virtual {p0, v0, p2, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->consumeAsyncInternal(Ljava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;)V

    return-void
.end method

.method public consumeAsync(Ljava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/unity/purchasing/googleplay/Purchase;",
            ">;",
            "Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;",
            ")V"
        }
    .end annotation

    const-string v0, "consume"

    .line 770
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->checkSetupDone(Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 771
    invoke-virtual {p0, p1, v0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->consumeAsyncInternal(Ljava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;)V

    return-void
.end method

.method consumeAsyncInternal(Ljava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/unity/purchasing/googleplay/Purchase;",
            ">;",
            "Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;",
            "Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;",
            ")V"
        }
    .end annotation

    .line 963
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    new-instance v1, Lcom/unity/purchasing/googleplay/IabHelper$4;

    invoke-direct {v1, p0, p1, p2, p3}, Lcom/unity/purchasing/googleplay/IabHelper$4;-><init>(Lcom/unity/purchasing/googleplay/IabHelper;Ljava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeFinishedListener;Lcom/unity/purchasing/googleplay/IabHelper$OnConsumeMultiFinishedListener;)V

    invoke-interface {v0, v1}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->workWith(Lcom/unity/purchasing/googleplay/BillingServiceProcessor;)V

    return-void
.end method

.method public dispose()V
    .locals 1

    const-string v0, "Disposing."

    .line 300
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 301
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSetupDone:Z

    .line 302
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    invoke-interface {v0}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->dispose()V

    const/4 v0, 0x1

    .line 303
    iput-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDisposed:Z

    return-void
.end method

.method public enableDaydreamApi(Z)V
    .locals 0

    .line 203
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDaydreamApiAvailable:Z

    return-void
.end method

.method public enableDebugLogging(Z)V
    .locals 0

    .line 187
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugLog:Z

    return-void
.end method

.method public enableDebugLogging(ZLjava/lang/String;)V
    .locals 0

    .line 182
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugLog:Z

    .line 183
    iput-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugTag:Ljava/lang/String;

    return-void
.end method

.method public enableUnityVr(Z)V
    .locals 0

    .line 195
    iput-boolean p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mUnityVrEnabled:Z

    return-void
.end method

.method getResponseCodeFromBundle(Landroid/os/Bundle;)I
    .locals 3

    const-string v0, "RESPONSE_CODE"

    .line 819
    invoke-virtual {p1, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    if-nez p1, :cond_0

    const-string p1, "Bundle with null response code, assuming OK (known issue)"

    .line 821
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    .line 824
    :cond_0
    instance-of v0, p1, Ljava/lang/Integer;

    if-eqz v0, :cond_1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1

    .line 825
    :cond_1
    instance-of v0, p1, Ljava/lang/Long;

    if-eqz v0, :cond_2

    check-cast p1, Ljava/lang/Long;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    long-to-int p1, v0

    return p1

    :cond_2
    const-string v0, "Unexpected type for bundle response code."

    .line 827
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 828
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 829
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected type for bundle response code: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method getResponseCodeFromIntent(Landroid/content/Intent;)I
    .locals 3

    .line 835
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "RESPONSE_CODE"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    if-nez p1, :cond_0

    const-string p1, "Intent with no response code, assuming OK (known issue)"

    .line 837
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    .line 840
    :cond_0
    instance-of v0, p1, Ljava/lang/Integer;

    if-eqz v0, :cond_1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    return p1

    .line 841
    :cond_1
    instance-of v0, p1, Ljava/lang/Long;

    if-eqz v0, :cond_2

    check-cast p1, Ljava/lang/Long;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    long-to-int p1, v0

    return p1

    :cond_2
    const-string v0, "Unexpected type for intent response code."

    .line 843
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 844
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 845
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected type for intent response code: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public handleActivityResult(IILandroid/content/Intent;)Z
    .locals 7

    .line 483
    iget v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mRequestCode:I

    const/4 v1, 0x0

    if-eq p1, v0, :cond_0

    return v1

    :cond_0
    const-string p1, "handleActivityResult"

    .line 485
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->checkSetupDone(Ljava/lang/String;)V

    const/16 p1, -0x3ea

    const/4 v0, 0x1

    const/4 v2, 0x0

    if-nez p3, :cond_2

    const-string p2, "Null data in IAB activity result."

    .line 488
    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 489
    new-instance p2, Lcom/unity/purchasing/googleplay/IabResult;

    const-string p3, "Null data in IAB result"

    invoke-direct {p2, p1, p3}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    .line 490
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    invoke-interface {p1, p2, v2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    :cond_1
    return v0

    .line 494
    :cond_2
    invoke-virtual {p0, p3}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseCodeFromIntent(Landroid/content/Intent;)I

    move-result v3

    const-string v4, "INAPP_PURCHASE_DATA"

    .line 495
    invoke-virtual {p3, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "INAPP_DATA_SIGNATURE"

    .line 496
    invoke-virtual {p3, v5}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const/4 v6, -0x1

    if-ne p2, v6, :cond_7

    if-nez v3, :cond_7

    const-string p2, "Successful resultcode from purchase activity."

    .line 499
    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 500
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Purchase data: "

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 501
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Data signature: "

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 502
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Extras: "

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 503
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Expected item type: "

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchasingItemType:Ljava/lang/String;

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    if-eqz v4, :cond_5

    if-nez v5, :cond_3

    goto :goto_0

    .line 515
    :cond_3
    :try_start_0
    new-instance p2, Lcom/unity/purchasing/googleplay/Purchase;

    iget-object p3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchasingItemType:Ljava/lang/String;

    invoke-direct {p2, p3, v4, v5}, Lcom/unity/purchasing/googleplay/Purchase;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 516
    invoke-virtual {p2}, Lcom/unity/purchasing/googleplay/Purchase;->getSku()Ljava/lang/String;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 526
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p1, :cond_a

    .line 527
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    new-instance p3, Lcom/unity/purchasing/googleplay/IabResult;

    const-string v2, "Success"

    invoke-direct {p3, v1, v2}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    invoke-interface {p1, p3, p2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    goto/16 :goto_1

    :catch_0
    move-exception p2

    const-string p3, "Failed to parse purchase data."

    .line 519
    invoke-virtual {p0, p3}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 520
    invoke-virtual {p2}, Lorg/json/JSONException;->printStackTrace()V

    .line 521
    new-instance p2, Lcom/unity/purchasing/googleplay/IabResult;

    const-string p3, "Failed to parse purchase data."

    invoke-direct {p2, p1, p3}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    .line 522
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    invoke-interface {p1, p2, v2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    :cond_4
    return v0

    :cond_5
    :goto_0
    const-string p1, "BUG: either purchaseData or dataSignature is null."

    .line 506
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 507
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Extras: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p2

    invoke-virtual {p2}, Landroid/os/Bundle;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 508
    new-instance p1, Lcom/unity/purchasing/googleplay/IabResult;

    const/16 p2, -0x3f0

    const-string p3, "IAB returned null purchaseData or dataSignature"

    invoke-direct {p1, p2, p3}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    .line 509
    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p2, :cond_6

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    invoke-interface {p2, p1, v2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    :cond_6
    return v0

    :cond_7
    if-ne p2, v6, :cond_8

    .line 532
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Result code was OK but in-app billing response was not OK: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v3}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseDesc(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 533
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p1, :cond_a

    .line 534
    new-instance p1, Lcom/unity/purchasing/googleplay/IabResult;

    const-string p2, "Problem purchasing item."

    invoke-direct {p1, v3, p2}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    .line 535
    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    invoke-interface {p2, p1, v2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    goto :goto_1

    :cond_8
    if-nez p2, :cond_9

    .line 539
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Purchase canceled - Response: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v3}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseDesc(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 540
    new-instance p1, Lcom/unity/purchasing/googleplay/IabResult;

    const/16 p2, -0x3ed

    const-string p3, "User canceled."

    invoke-direct {p1, p2, p3}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    .line 541
    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p2, :cond_a

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    invoke-interface {p2, p1, v2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    goto :goto_1

    .line 544
    :cond_9
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "Purchase failed. Result code: "

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, ". Response: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 545
    invoke-static {v3}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseDesc(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 544
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    .line 546
    new-instance p1, Lcom/unity/purchasing/googleplay/IabResult;

    const/16 p2, -0x3ee

    const-string p3, "Unknown purchase response."

    invoke-direct {p1, p2, p3}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    .line 547
    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    if-eqz p2, :cond_a

    iget-object p2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mPurchaseListener:Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;

    invoke-interface {p2, p1, v2}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    :cond_a
    :goto_1
    return v0
.end method

.method public launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;)V
    .locals 6

    const-string v5, ""

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move-object v4, p4

    .line 334
    invoke-virtual/range {v0 .. v5}, Lcom/unity/purchasing/googleplay/IabHelper;->launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V

    return-void
.end method

.method public launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V
    .locals 7

    const-string v3, "inapp"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v4, p3

    move-object v5, p4

    move-object v6, p5

    .line 339
    invoke-virtual/range {v0 .. v6}, Lcom/unity/purchasing/googleplay/IabHelper;->launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V

    return-void
.end method

.method public launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V
    .locals 11

    move-object v8, p0

    move-object/from16 v6, p5

    const-string v0, "launchPurchaseFlow"

    .line 373
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->checkSetupDone(Ljava/lang/String;)V

    const-string v0, "subs"

    move-object v3, p3

    .line 375
    invoke-virtual {p3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, v8, Lcom/unity/purchasing/googleplay/IabHelper;->mSubscriptionsSupported:Z

    if-nez v0, :cond_1

    .line 376
    new-instance v0, Lcom/unity/purchasing/googleplay/IabResult;

    const/16 v1, -0x3f1

    const-string v2, "Subscriptions are not available."

    invoke-direct {v0, v1, v2}, Lcom/unity/purchasing/googleplay/IabResult;-><init>(ILjava/lang/String;)V

    if-eqz v6, :cond_0

    const/4 v1, 0x0

    .line 378
    invoke-interface {v6, v0, v1}, Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;->onIabPurchaseFinished(Lcom/unity/purchasing/googleplay/IabResult;Lcom/unity/purchasing/googleplay/Purchase;)V

    :cond_0
    return-void

    .line 381
    :cond_1
    iget-object v9, v8, Lcom/unity/purchasing/googleplay/IabHelper;->serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    new-instance v10, Lcom/unity/purchasing/googleplay/IabHelper$2;

    move-object v0, v10

    move-object v1, p0

    move-object v2, p2

    move-object v3, p3

    move-object/from16 v4, p6

    move-object v5, p1

    move-object/from16 v6, p5

    move v7, p4

    invoke-direct/range {v0 .. v7}, Lcom/unity/purchasing/googleplay/IabHelper$2;-><init>(Lcom/unity/purchasing/googleplay/IabHelper;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/Activity;Lcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;I)V

    invoke-interface {v9, v10}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->workWith(Lcom/unity/purchasing/googleplay/BillingServiceProcessor;)V

    return-void
.end method

.method public launchSubscriptionPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;)V
    .locals 6

    const-string v5, ""

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move-object v4, p4

    .line 344
    invoke-virtual/range {v0 .. v5}, Lcom/unity/purchasing/googleplay/IabHelper;->launchSubscriptionPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V

    return-void
.end method

.method public launchSubscriptionPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V
    .locals 7

    const-string v3, "subs"

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v4, p3

    move-object v5, p4

    move-object v6, p5

    .line 349
    invoke-virtual/range {v0 .. v6}, Lcom/unity/purchasing/googleplay/IabHelper;->launchPurchaseFlow(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;ILcom/unity/purchasing/googleplay/IabHelper$OnIabPurchaseFinishedListener;Ljava/lang/String;)V

    return-void
.end method

.method logDebug(Ljava/lang/String;)V
    .locals 1

    const-string v0, "UnityIAP"

    .line 1002
    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method logError(Ljava/lang/String;)V
    .locals 3

    .line 1006
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugTag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "In-app billing error: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method logWarn(Ljava/lang/String;)V
    .locals 3

    .line 1010
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDebugTag:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "In-app billing warning: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public queryInventory(ZLjava/util/List;Lcom/android/vending/billing/IInAppBillingService;)Lcom/unity/purchasing/googleplay/Inventory;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/android/vending/billing/IInAppBillingService;",
            ")",
            "Lcom/unity/purchasing/googleplay/Inventory;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/unity/purchasing/googleplay/IabException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 553
    invoke-virtual {p0, p1, p2, v0, p3}, Lcom/unity/purchasing/googleplay/IabHelper;->queryInventory(ZLjava/util/List;Ljava/util/List;Lcom/android/vending/billing/IInAppBillingService;)Lcom/unity/purchasing/googleplay/Inventory;

    move-result-object p1

    return-object p1
.end method

.method public queryInventory(ZLjava/util/List;Ljava/util/List;Lcom/android/vending/billing/IInAppBillingService;)Lcom/unity/purchasing/googleplay/Inventory;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/android/vending/billing/IInAppBillingService;",
            ")",
            "Lcom/unity/purchasing/googleplay/Inventory;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/unity/purchasing/googleplay/IabException;
        }
    .end annotation

    const-string p3, "queryInventory"

    .line 571
    invoke-virtual {p0, p3}, Lcom/unity/purchasing/googleplay/IabHelper;->checkSetupDone(Ljava/lang/String;)V

    .line 573
    :try_start_0
    iget-object p3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    const-string v0, "inapp"

    invoke-virtual {p0, p3, v0, p4}, Lcom/unity/purchasing/googleplay/IabHelper;->queryPurchases(Lcom/unity/purchasing/googleplay/Inventory;Ljava/lang/String;Lcom/android/vending/billing/IInAppBillingService;)I

    move-result p3

    if-nez p3, :cond_5

    if-eqz p1, :cond_1

    const-string p3, "inapp"

    .line 579
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {p0, p3, v0, p2, p4}, Lcom/unity/purchasing/googleplay/IabHelper;->querySkuDetails(Ljava/lang/String;Lcom/unity/purchasing/googleplay/Inventory;Ljava/util/List;Lcom/android/vending/billing/IInAppBillingService;)I

    move-result p3

    if-nez p3, :cond_0

    goto :goto_0

    .line 581
    :cond_0
    new-instance p1, Lcom/unity/purchasing/googleplay/IabException;

    const-string p2, "Error refreshing inventory (querying prices of items)."

    invoke-direct {p1, p3, p2}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw p1

    .line 586
    :cond_1
    :goto_0
    iget-boolean p3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSubscriptionsSupported:Z

    if-eqz p3, :cond_4

    .line 587
    iget-object p3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    const-string v0, "subs"

    invoke-virtual {p0, p3, v0, p4}, Lcom/unity/purchasing/googleplay/IabHelper;->queryPurchases(Lcom/unity/purchasing/googleplay/Inventory;Ljava/lang/String;Lcom/android/vending/billing/IInAppBillingService;)I

    move-result p3

    if-nez p3, :cond_3

    if-eqz p1, :cond_4

    const-string p1, "subs"

    .line 593
    iget-object p3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    invoke-virtual {p0, p1, p3, p2, p4}, Lcom/unity/purchasing/googleplay/IabHelper;->querySkuDetails(Ljava/lang/String;Lcom/unity/purchasing/googleplay/Inventory;Ljava/util/List;Lcom/android/vending/billing/IInAppBillingService;)I

    move-result p1

    if-nez p1, :cond_2

    goto :goto_1

    .line 595
    :cond_2
    new-instance p2, Lcom/unity/purchasing/googleplay/IabException;

    const-string p3, "Error refreshing inventory (querying prices of subscriptions)."

    invoke-direct {p2, p1, p3}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw p2

    .line 589
    :cond_3
    new-instance p1, Lcom/unity/purchasing/googleplay/IabException;

    const-string p2, "Error refreshing inventory (querying owned subscriptions)."

    invoke-direct {p1, p3, p2}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw p1

    .line 600
    :cond_4
    :goto_1
    iget-object p1, p0, Lcom/unity/purchasing/googleplay/IabHelper;->inv:Lcom/unity/purchasing/googleplay/Inventory;

    return-object p1

    .line 575
    :cond_5
    new-instance p1, Lcom/unity/purchasing/googleplay/IabException;

    const-string p2, "Error refreshing inventory (querying owned items)."

    invoke-direct {p1, p3, p2}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;)V

    throw p1
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p1

    .line 610
    new-instance p2, Lcom/unity/purchasing/googleplay/IabException;

    const/16 p3, -0x3f0

    const-string p4, "SecurityException querying inventory, update Google Play - https://github.com/googlesamples/android-play-billing/issues/26"

    invoke-direct {p2, p3, p4, p1}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;Ljava/lang/Exception;)V

    throw p2

    :catch_1
    move-exception p1

    .line 606
    new-instance p2, Lcom/unity/purchasing/googleplay/IabException;

    const/16 p3, -0x3ea

    const-string p4, "Error parsing JSON response while refreshing inventory."

    invoke-direct {p2, p3, p4, p1}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;Ljava/lang/Exception;)V

    throw p2

    :catch_2
    move-exception p1

    .line 603
    new-instance p2, Lcom/unity/purchasing/googleplay/IabException;

    const/16 p3, -0x3e9

    const-string p4, "Remote exception while refreshing inventory."

    invoke-direct {p2, p3, p4, p1}, Lcom/unity/purchasing/googleplay/IabException;-><init>(ILjava/lang/String;Ljava/lang/Exception;)V

    throw p2
.end method

.method public queryInventoryAsync(Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;)V
    .locals 6

    const/4 v1, 0x1

    const/4 v2, 0x0

    const-wide/16 v4, 0x0

    move-object v0, p0

    move-object v3, p1

    .line 674
    invoke-virtual/range {v0 .. v5}, Lcom/unity/purchasing/googleplay/IabHelper;->queryInventoryAsync(ZLjava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;J)V

    return-void
.end method

.method public queryInventoryAsync(ZLcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;)V
    .locals 6

    const/4 v2, 0x0

    const-wide/16 v4, 0x0

    move-object v0, p0

    move v1, p1

    move-object v3, p2

    .line 678
    invoke-virtual/range {v0 .. v5}, Lcom/unity/purchasing/googleplay/IabHelper;->queryInventoryAsync(ZLjava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;J)V

    return-void
.end method

.method public queryInventoryAsync(ZLjava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;J)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;",
            "J)V"
        }
    .end annotation

    const-string v0, "queryInventory"

    .line 642
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->checkSetupDone(Ljava/lang/String;)V

    .line 643
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    new-instance v8, Lcom/unity/purchasing/googleplay/IabHelper$3;

    move-object v1, v8

    move-object v2, p0

    move-wide v3, p4

    move v5, p1

    move-object v6, p2

    move-object v7, p3

    invoke-direct/range {v1 .. v7}, Lcom/unity/purchasing/googleplay/IabHelper$3;-><init>(Lcom/unity/purchasing/googleplay/IabHelper;JZLjava/util/List;Lcom/unity/purchasing/googleplay/IabHelper$QueryInventoryFinishedListener;)V

    invoke-interface {v0, v8}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->workWith(Lcom/unity/purchasing/googleplay/BillingServiceProcessor;)V

    return-void
.end method

.method queryPurchases(Lcom/unity/purchasing/googleplay/Inventory;Ljava/lang/String;Lcom/android/vending/billing/IInAppBillingService;)I
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;,
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 850
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mDisposed:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string p1, "queryPurchases - Biller disposed. Returning..."

    .line 851
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    return v1

    .line 855
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Querying owned items, item type: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 856
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Package name: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 862
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Calling getPurchases with continuation token: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    const/4 v2, 0x3

    .line 863
    iget-object v3, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-interface {p3, v2, v3, p2, v0}, Lcom/android/vending/billing/IInAppBillingService;->getPurchases(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    .line 866
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseCodeFromBundle(Landroid/os/Bundle;)I

    move-result v2

    .line 867
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Owned items response: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    if-eqz v2, :cond_2

    .line 869
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "getPurchases() failed: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseDesc(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    return v2

    :cond_2
    const-string v2, "INAPP_PURCHASE_ITEM_LIST"

    .line 872
    invoke-virtual {v0, v2}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    const-string v2, "INAPP_PURCHASE_DATA_LIST"

    .line 873
    invoke-virtual {v0, v2}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    const-string v2, "INAPP_DATA_SIGNATURE_LIST"

    .line 874
    invoke-virtual {v0, v2}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    goto/16 :goto_1

    :cond_3
    const-string v2, "INAPP_PURCHASE_ITEM_LIST"

    .line 879
    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v2

    const-string v3, "INAPP_PURCHASE_DATA_LIST"

    .line 881
    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v3

    const-string v4, "INAPP_DATA_SIGNATURE_LIST"

    .line 883
    invoke-virtual {v0, v4}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v4

    const/4 v5, 0x0

    .line 886
    :goto_0
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v5, v6, :cond_5

    .line 887
    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 888
    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 889
    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    .line 890
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Sku is owned: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 891
    new-instance v8, Lcom/unity/purchasing/googleplay/Purchase;

    invoke-direct {v8, p2, v6, v7}, Lcom/unity/purchasing/googleplay/Purchase;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 893
    invoke-virtual {v8}, Lcom/unity/purchasing/googleplay/Purchase;->getToken()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_4

    const-string v7, "BUG: empty/null token!"

    .line 894
    invoke-virtual {p0, v7}, Lcom/unity/purchasing/googleplay/IabHelper;->logWarn(Ljava/lang/String;)V

    .line 895
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Purchase data: "

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 899
    :cond_4
    invoke-virtual {p1, v8}, Lcom/unity/purchasing/googleplay/Inventory;->addPurchase(Lcom/unity/purchasing/googleplay/Purchase;)V

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_5
    const-string v2, "INAPP_CONTINUATION_TOKEN"

    .line 902
    invoke-virtual {v0, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 903
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Continuation token: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 904
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    return v1

    :cond_6
    :goto_1
    const-string p1, "Bundle returned from getPurchases() doesn\'t contain required fields."

    .line 875
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    const/16 p1, -0x3ea

    return p1
.end method

.method querySkuDetails(Ljava/lang/String;Lcom/unity/purchasing/googleplay/Inventory;Ljava/util/List;Lcom/android/vending/billing/IInAppBillingService;)I
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/unity/purchasing/googleplay/Inventory;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/android/vending/billing/IInAppBillingService;",
            ")I"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;,
            Lorg/json/JSONException;
        }
    .end annotation

    const-string v0, "Querying SKU details."

    .line 910
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 911
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 912
    invoke-virtual {p2, p1}, Lcom/unity/purchasing/googleplay/Inventory;->getAllOwnedSkus(Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    if-eqz p3, :cond_0

    .line 913
    invoke-virtual {v0, p3}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 915
    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p3

    const/4 v1, 0x0

    if-nez p3, :cond_1

    const-string p1, "queryPrices: nothing to do because there are no SKUs."

    .line 916
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    return v1

    .line 920
    :cond_1
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result p3

    if-lez p3, :cond_5

    const/16 p3, 0x14

    .line 921
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-static {p3, v2}, Ljava/lang/Math;->min(II)I

    move-result p3

    .line 923
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const/4 v3, 0x0

    :goto_0
    if-ge v3, p3, :cond_2

    .line 925
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 928
    :cond_2
    new-instance p3, Landroid/os/Bundle;

    invoke-direct {p3}, Landroid/os/Bundle;-><init>()V

    const-string v3, "ITEM_ID_LIST"

    .line 929
    invoke-virtual {p3, v3, v2}, Landroid/os/Bundle;->putStringArrayList(Ljava/lang/String;Ljava/util/ArrayList;)V

    const/4 v3, 0x3

    .line 930
    iget-object v4, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-interface {p4, v3, v4, p1, p3}, Lcom/android/vending/billing/IInAppBillingService;->getSkuDetails(ILjava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p3

    .line 933
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->removeAll(Ljava/util/Collection;)Z

    const-string v2, "DETAILS_LIST"

    .line 935
    invoke-virtual {p3, v2}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    .line 936
    invoke-virtual {p0, p3}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseCodeFromBundle(Landroid/os/Bundle;)I

    move-result p1

    if-eqz p1, :cond_3

    .line 938
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "getSkuDetails() failed: "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p1}, Lcom/unity/purchasing/googleplay/IabHelper;->getResponseDesc(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    return p1

    :cond_3
    const-string p1, "getSkuDetails() returned a bundle with neither an error nor a detail list."

    .line 942
    invoke-virtual {p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper;->logError(Ljava/lang/String;)V

    const/16 p1, -0x3ea

    return p1

    :cond_4
    const-string v2, "DETAILS_LIST"

    .line 947
    invoke-virtual {p3, v2}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p3

    .line 950
    invoke-virtual {p3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :goto_1
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 951
    new-instance v3, Lcom/unity/purchasing/googleplay/SkuDetails;

    invoke-direct {v3, p1, v2}, Lcom/unity/purchasing/googleplay/SkuDetails;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 952
    invoke-virtual {p2, v3}, Lcom/unity/purchasing/googleplay/Inventory;->addSkuDetails(Lcom/unity/purchasing/googleplay/SkuDetails;)V

    goto :goto_1

    :cond_5
    return v1
.end method

.method public startSetup(Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;)V
    .locals 2

    .line 229
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSetupDone:Z

    if-nez v0, :cond_0

    const-string v0, "Starting in-app billing setup."

    .line 232
    invoke-virtual {p0, v0}, Lcom/unity/purchasing/googleplay/IabHelper;->logDebug(Ljava/lang/String;)V

    .line 234
    iget-object v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->serviceManager:Lcom/unity/purchasing/googleplay/IBillingServiceManager;

    new-instance v1, Lcom/unity/purchasing/googleplay/IabHelper$1;

    invoke-direct {v1, p0, p1}, Lcom/unity/purchasing/googleplay/IabHelper$1;-><init>(Lcom/unity/purchasing/googleplay/IabHelper;Lcom/unity/purchasing/googleplay/IabHelper$OnIabSetupFinishedListener;)V

    invoke-interface {v0, v1}, Lcom/unity/purchasing/googleplay/IBillingServiceManager;->workWith(Lcom/unity/purchasing/googleplay/BillingServiceProcessor;)V

    return-void

    .line 229
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "IAB helper is already set up."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public subscriptionsSupported()Z
    .locals 1

    .line 308
    iget-boolean v0, p0, Lcom/unity/purchasing/googleplay/IabHelper;->mSubscriptionsSupported:Z

    return v0
.end method
