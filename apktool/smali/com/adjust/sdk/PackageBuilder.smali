.class public Lcom/adjust/sdk/PackageBuilder;
.super Ljava/lang/Object;
.source "PackageBuilder.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;
    }
.end annotation


# static fields
.field private static logger:Lcom/adjust/sdk/ILogger;


# instance fields
.field private activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

.field private adjustConfig:Lcom/adjust/sdk/AdjustConfig;

.field attribution:Lcom/adjust/sdk/AdjustAttribution;

.field clickTimeInMilliseconds:J

.field clickTimeInSeconds:J

.field clickTimeServerInSeconds:J

.field private createdAt:J

.field deeplink:Ljava/lang/String;

.field private deviceInfo:Lcom/adjust/sdk/DeviceInfo;

.field extraParameters:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field googlePlayInstant:Ljava/lang/Boolean;

.field installBeginTimeInSeconds:J

.field installBeginTimeServerInSeconds:J

.field installVersion:Ljava/lang/String;

.field preinstallLocation:Ljava/lang/String;

.field preinstallPayload:Ljava/lang/String;

.field rawReferrer:Ljava/lang/String;

.field referrer:Ljava/lang/String;

.field referrerApi:Ljava/lang/String;

.field reftag:Ljava/lang/String;

.field private sessionParameters:Lcom/adjust/sdk/SessionParameters;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 21
    invoke-static {}, Lcom/adjust/sdk/AdjustFactory;->getLogger()Lcom/adjust/sdk/ILogger;

    move-result-object v0

    sput-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    return-void
.end method

.method constructor <init>(Lcom/adjust/sdk/AdjustConfig;Lcom/adjust/sdk/DeviceInfo;Lcom/adjust/sdk/ActivityState;Lcom/adjust/sdk/SessionParameters;J)V
    .locals 2

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, -0x1

    .line 28
    iput-wide v0, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeInSeconds:J

    .line 29
    iput-wide v0, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeInMilliseconds:J

    .line 30
    iput-wide v0, p0, Lcom/adjust/sdk/PackageBuilder;->installBeginTimeInSeconds:J

    .line 31
    iput-wide v0, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeServerInSeconds:J

    .line 32
    iput-wide v0, p0, Lcom/adjust/sdk/PackageBuilder;->installBeginTimeServerInSeconds:J

    .line 75
    iput-wide p5, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    .line 76
    iput-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    .line 77
    iput-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    .line 78
    new-instance p1, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    invoke-direct {p1, p0, p3}, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;-><init>(Lcom/adjust/sdk/PackageBuilder;Lcom/adjust/sdk/ActivityState;)V

    iput-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    .line 79
    iput-object p4, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    return-void
.end method

.method public static addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ")V"
        }
    .end annotation

    if-nez p2, :cond_0

    return-void

    .line 1104
    :cond_0
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    int-to-long v0, p2

    .line 1105
    invoke-static {p0, p1, v0, v1}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    return-void
.end method

.method private static addDate(Ljava/util/Map;Ljava/lang/String;Ljava/util/Date;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/Date;",
            ")V"
        }
    .end annotation

    if-nez p2, :cond_0

    return-void

    .line 1157
    :cond_0
    sget-object v0, Lcom/adjust/sdk/Util;->dateFormatter:Ljava/text/SimpleDateFormat;

    invoke-virtual {v0, p2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p2

    .line 1158
    invoke-static {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private static addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "J)V"
        }
    .end annotation

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-gtz v2, :cond_0

    return-void

    .line 1141
    :cond_0
    new-instance v0, Ljava/util/Date;

    invoke-direct {v0, p2, p3}, Ljava/util/Date;-><init>(J)V

    .line 1142
    invoke-static {p0, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addDate(Ljava/util/Map;Ljava/lang/String;Ljava/util/Date;)V

    return-void
.end method

.method private static addDateInSeconds(Ljava/util/Map;Ljava/lang/String;J)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "J)V"
        }
    .end annotation

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-gtz v2, :cond_0

    return-void

    .line 1149
    :cond_0
    new-instance v0, Ljava/util/Date;

    const-wide/16 v1, 0x3e8

    mul-long p2, p2, v1

    invoke-direct {v0, p2, p3}, Ljava/util/Date;-><init>(J)V

    .line 1150
    invoke-static {p0, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addDate(Ljava/util/Map;Ljava/lang/String;Ljava/util/Date;)V

    return-void
.end method

.method private static addDouble(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Double;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/Double;",
            ")V"
        }
    .end annotation

    if-nez p2, :cond_0

    return-void

    :cond_0
    const-string v0, "%.5f"

    const/4 v1, 0x1

    .line 1173
    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p2, v1, v2

    invoke-static {v0, v1}, Lcom/adjust/sdk/Util;->formatString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    .line 1174
    invoke-static {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private static addDuration(Ljava/util/Map;Ljava/lang/String;J)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "J)V"
        }
    .end annotation

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-gez v2, :cond_0

    return-void

    :cond_0
    const-wide/16 v0, 0x1f4

    add-long/2addr p2, v0

    const-wide/16 v0, 0x3e8

    .line 1165
    div-long/2addr p2, v0

    .line 1166
    invoke-static {p0, p1, p2, p3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    return-void
.end method

.method static addJsonObject(Ljava/util/Map;Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Lorg/json/JSONObject;",
            ")V"
        }
    .end annotation

    if-nez p2, :cond_0

    return-void

    .line 1113
    :cond_0
    invoke-virtual {p2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static addLong(Ljava/util/Map;Ljava/lang/String;J)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "J)V"
        }
    .end annotation

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-gez v2, :cond_0

    return-void

    .line 1133
    :cond_0
    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object p2

    .line 1134
    invoke-static {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/Map;",
            ")V"
        }
    .end annotation

    if-nez p2, :cond_0

    return-void

    .line 1120
    :cond_0
    invoke-interface {p2}, Ljava/util/Map;->size()I

    move-result v0

    if-nez v0, :cond_1

    return-void

    .line 1124
    :cond_1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p2}, Lorg/json/JSONObject;-><init>(Ljava/util/Map;)V

    .line 1125
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p2

    .line 1126
    invoke-static {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 1094
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 1097
    :cond_0
    invoke-interface {p0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private checkDeviceIds(Ljava/util/Map;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_0

    const-string v0, "mac_sha1"

    .line 1192
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mac_md5"

    .line 1193
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "android_id"

    .line 1194
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "gps_adid"

    .line 1195
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "oaid"

    .line 1196
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "imei"

    .line 1197
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "meid"

    .line 1198
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "device_id"

    .line 1199
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "imeis"

    .line 1200
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "meids"

    .line 1201
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "device_ids"

    .line 1202
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    .line 1203
    sget-object p1, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v0, "Missing device id\'s. Please check if Proguard is correctly set with Adjust SDK"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-interface {p1, v0, v1}, Lcom/adjust/sdk/ILogger;->error(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-void
.end method

.method private containsFireIds(Ljava/util/Map;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const-string v0, "fire_adid"

    .line 1188
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method private containsPlayIds(Ljava/util/Map;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const-string v0, "gps_adid"

    .line 1181
    invoke-interface {p1, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method private getAdRevenueParameters(Ljava/lang/String;Lorg/json/JSONObject;)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lorg/json/JSONObject;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 902
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 903
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 904
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 908
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 912
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 914
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 918
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 919
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 920
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 921
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 922
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 923
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 924
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 925
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 927
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 928
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 930
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 931
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 932
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 933
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v0, "api_level"

    .line 937
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_secret"

    .line 938
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_token"

    .line 939
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_version"

    .line 940
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "attribution_deeplink"

    const/4 v2, 0x1

    .line 941
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "connectivity_type"

    .line 942
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/adjust/sdk/Util;->getConnectivityType(Landroid/content/Context;)I

    move-result v3

    int-to-long v3, v3

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "country"

    .line 943
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->country:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "cpu_type"

    .line 944
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->abi:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "created_at"

    .line 945
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "default_tracker"

    .line 946
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->defaultTracker:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_known"

    .line 947
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "needs_cost"

    .line 948
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "device_manufacturer"

    .line 949
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceManufacturer:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_name"

    .line 950
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_type"

    .line 951
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "display_height"

    .line 952
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->displayHeight:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "display_width"

    .line 953
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->displayWidth:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "environment"

    .line 954
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "event_buffering_enabled"

    .line 955
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v3, v3, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "external_device_id"

    .line 956
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "fb_id"

    .line 957
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->fbAttributionId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "hardware_name"

    .line 958
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->hardwareName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "installed_at"

    .line 959
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->appInstallTime:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "language"

    .line 960
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->language:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "last_interval"

    .line 961
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->lastInterval:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "mcc"

    .line 962
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/adjust/sdk/Util;->getMcc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mnc"

    .line 963
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/adjust/sdk/Util;->getMnc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "needs_response_details"

    .line 964
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "network_type"

    .line 965
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getNetworkType(Landroid/content/Context;)I

    move-result v2

    int-to-long v2, v2

    invoke-static {v1, v0, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "os_build"

    .line 966
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->buildName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os_name"

    .line 967
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os_version"

    .line 968
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "package_name"

    .line 969
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "push_token"

    .line 970
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "screen_density"

    .line 971
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->screenDensity:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "screen_format"

    .line 972
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->screenFormat:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "screen_size"

    .line 973
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->screenSize:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "secret_id"

    .line 974
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "source"

    .line 975
    invoke-static {v1, v0, p1}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "payload"

    .line 976
    invoke-static {v1, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addJsonObject(Ljava/util/Map;Ljava/lang/String;Lorg/json/JSONObject;)V

    const-string p1, "session_count"

    .line 977
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget p2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionCount:I

    int-to-long v2, p2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "session_length"

    .line 978
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionLength:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "subsession_count"

    .line 979
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget p2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->subsessionCount:I

    int-to-long v2, p2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "time_spent"

    .line 980
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->timeSpent:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "updated_at"

    .line 981
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object p2, p2, Lcom/adjust/sdk/DeviceInfo;->appUpdateTime:Ljava/lang/String;

    invoke-static {v1, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 983
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getAttributionParameters(Ljava/lang/String;)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 586
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 587
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 588
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 592
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 596
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 598
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 602
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 603
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 604
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 605
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 606
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 607
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 608
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 609
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 611
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 612
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 614
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 615
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 616
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 617
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v0, "api_level"

    .line 621
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_secret"

    .line 622
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_token"

    .line 623
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_version"

    .line 624
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "attribution_deeplink"

    const/4 v2, 0x1

    .line 625
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "created_at"

    .line 626
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "device_known"

    .line 627
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "needs_cost"

    .line 628
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "device_name"

    .line 629
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_type"

    .line 630
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "environment"

    .line 631
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "event_buffering_enabled"

    .line 632
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v3, v3, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "external_device_id"

    .line 633
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "initiated_by"

    .line 634
    invoke-static {v1, v0, p1}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "needs_response_details"

    .line 635
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "os_name"

    .line 636
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "os_version"

    .line 637
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "package_name"

    .line 638
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "push_token"

    .line 639
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "secret_id"

    .line 640
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 642
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getClickParameters(Ljava/lang/String;)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 477
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 478
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 479
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 483
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 487
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 489
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 493
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 494
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 495
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 496
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 497
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 498
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 499
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 500
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 502
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 503
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 505
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 506
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 507
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 508
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 512
    :cond_2
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->attribution:Lcom/adjust/sdk/AdjustAttribution;

    if-eqz v0, :cond_3

    const-string v0, "tracker"

    .line 513
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->attribution:Lcom/adjust/sdk/AdjustAttribution;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustAttribution;->trackerName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "campaign"

    .line 514
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->attribution:Lcom/adjust/sdk/AdjustAttribution;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustAttribution;->campaign:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "adgroup"

    .line 515
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->attribution:Lcom/adjust/sdk/AdjustAttribution;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustAttribution;->adgroup:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "creative"

    .line 516
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->attribution:Lcom/adjust/sdk/AdjustAttribution;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustAttribution;->creative:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string v0, "api_level"

    .line 520
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_secret"

    .line 521
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_token"

    .line 522
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_version"

    .line 523
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "attribution_deeplink"

    const/4 v2, 0x1

    .line 524
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "callback_params"

    .line 525
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v3, v3, Lcom/adjust/sdk/SessionParameters;->callbackParameters:Ljava/util/Map;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    const-string v0, "click_time"

    .line 526
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeInMilliseconds:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "click_time"

    .line 527
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeInSeconds:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInSeconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "click_time_server"

    .line 528
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeServerInSeconds:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInSeconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "connectivity_type"

    .line 529
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/adjust/sdk/Util;->getConnectivityType(Landroid/content/Context;)I

    move-result v3

    int-to-long v3, v3

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "country"

    .line 530
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->country:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "cpu_type"

    .line 531
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->abi:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "created_at"

    .line 532
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "deeplink"

    .line 533
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deeplink:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_known"

    .line 534
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "needs_cost"

    .line 535
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "device_manufacturer"

    .line 536
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceManufacturer:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_name"

    .line 537
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_type"

    .line 538
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "display_height"

    .line 539
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->displayHeight:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "display_width"

    .line 540
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->displayWidth:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "environment"

    .line 541
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "event_buffering_enabled"

    .line 542
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v3, v3, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "external_device_id"

    .line 543
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "fb_id"

    .line 544
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->fbAttributionId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "google_play_instant"

    .line 545
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->googlePlayInstant:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "hardware_name"

    .line 546
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->hardwareName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "install_begin_time"

    .line 547
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->installBeginTimeInSeconds:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInSeconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "install_begin_time_server"

    .line 548
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->installBeginTimeServerInSeconds:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInSeconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "install_version"

    .line 549
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->installVersion:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "installed_at"

    .line 550
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->appInstallTime:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "language"

    .line 551
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->language:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "last_interval"

    .line 552
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->lastInterval:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "mcc"

    .line 553
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/adjust/sdk/Util;->getMcc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mnc"

    .line 554
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v3}, Lcom/adjust/sdk/Util;->getMnc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "needs_response_details"

    .line 555
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "network_type"

    .line 556
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getNetworkType(Landroid/content/Context;)I

    move-result v2

    int-to-long v2, v2

    invoke-static {v1, v0, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "os_build"

    .line 557
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->buildName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os_name"

    .line 558
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os_version"

    .line 559
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "package_name"

    .line 560
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "params"

    .line 561
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->extraParameters:Ljava/util/Map;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    const-string v0, "partner_params"

    .line 562
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v2, v2, Lcom/adjust/sdk/SessionParameters;->partnerParameters:Ljava/util/Map;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    const-string v0, "push_token"

    .line 563
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "raw_referrer"

    .line 564
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->rawReferrer:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "referrer"

    .line 565
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->referrer:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "referrer_api"

    .line 566
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->referrerApi:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "reftag"

    .line 567
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->reftag:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "screen_density"

    .line 568
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->screenDensity:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "screen_format"

    .line 569
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->screenFormat:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "screen_size"

    .line 570
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->screenSize:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "secret_id"

    .line 571
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "session_count"

    .line 572
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionCount:I

    int-to-long v2, v2

    invoke-static {v1, v0, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "session_length"

    .line 573
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionLength:J

    invoke-static {v1, v0, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "source"

    .line 574
    invoke-static {v1, v0, p1}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "subsession_count"

    .line 575
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->subsessionCount:I

    int-to-long v2, v0

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "time_spent"

    .line 576
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->timeSpent:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "updated_at"

    .line 577
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appUpdateTime:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "payload"

    .line 578
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->preinstallPayload:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "found_location"

    .line 579
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->preinstallLocation:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 581
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;
    .locals 1

    .line 1088
    new-instance v0, Lcom/adjust/sdk/ActivityPackage;

    invoke-direct {v0, p1}, Lcom/adjust/sdk/ActivityPackage;-><init>(Lcom/adjust/sdk/ActivityKind;)V

    .line 1089
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object p1, p1, Lcom/adjust/sdk/DeviceInfo;->clientSdk:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setClientSdk(Ljava/lang/String;)V

    return-object v0
.end method

.method private getDisableThirdPartySharingParameters()Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 707
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 708
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 709
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 713
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 717
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 719
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 723
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 724
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 725
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 726
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 727
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 728
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 729
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 730
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 732
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 733
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 735
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 736
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 737
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 738
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v0, "api_level"

    .line 742
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_secret"

    .line 743
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_token"

    .line 744
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_version"

    .line 745
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "attribution_deeplink"

    const/4 v2, 0x1

    .line 746
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "created_at"

    .line 747
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "device_known"

    .line 748
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "needs_cost"

    .line 749
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "device_name"

    .line 750
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_type"

    .line 751
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "environment"

    .line 752
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "event_buffering_enabled"

    .line 753
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v3, v3, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "external_device_id"

    .line 754
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "needs_response_details"

    .line 755
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "os_name"

    .line 756
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os_version"

    .line 757
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "package_name"

    .line 758
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "push_token"

    .line 759
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "secret_id"

    .line 760
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 762
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getEventSuffix(Lcom/adjust/sdk/AdjustEvent;)Ljava/lang/String;
    .locals 5

    .line 1208
    iget-object v0, p1, Lcom/adjust/sdk/AdjustEvent;->revenue:Ljava/lang/Double;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_0

    const-string v0, "\'%s\'"

    .line 1209
    new-array v2, v2, [Ljava/lang/Object;

    iget-object p1, p1, Lcom/adjust/sdk/AdjustEvent;->eventToken:Ljava/lang/String;

    aput-object p1, v2, v1

    invoke-static {v0, v2}, Lcom/adjust/sdk/Util;->formatString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const-string v0, "(%.5f %s, \'%s\')"

    const/4 v3, 0x3

    .line 1211
    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p1, Lcom/adjust/sdk/AdjustEvent;->revenue:Ljava/lang/Double;

    aput-object v4, v3, v1

    iget-object v1, p1, Lcom/adjust/sdk/AdjustEvent;->currency:Ljava/lang/String;

    aput-object v1, v3, v2

    const/4 v1, 0x2

    iget-object p1, p1, Lcom/adjust/sdk/AdjustEvent;->eventToken:Ljava/lang/String;

    aput-object p1, v3, v1

    invoke-static {v0, v3}, Lcom/adjust/sdk/Util;->formatString(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private getGdprParameters()Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 647
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 648
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 649
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 653
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 657
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 659
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 663
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 664
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 665
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 666
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 667
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 668
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 669
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 670
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 672
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 673
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 675
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 676
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 677
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 678
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v0, "api_level"

    .line 682
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_secret"

    .line 683
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_token"

    .line 684
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_version"

    .line 685
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "attribution_deeplink"

    const/4 v2, 0x1

    .line 686
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "created_at"

    .line 687
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "device_known"

    .line 688
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "needs_cost"

    .line 689
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "device_name"

    .line 690
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "device_type"

    .line 691
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "environment"

    .line 692
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "event_buffering_enabled"

    .line 693
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v3, v3, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "external_device_id"

    .line 694
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "needs_response_details"

    .line 695
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "os_name"

    .line 696
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os_version"

    .line 697
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "package_name"

    .line 698
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "push_token"

    .line 699
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "secret_id"

    .line 700
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 702
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getInfoParameters(Ljava/lang/String;)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 423
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 424
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 425
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 429
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 433
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 435
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 439
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 440
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 441
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 442
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 443
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 444
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 445
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 446
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 448
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 449
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 451
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 452
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 453
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 454
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v0, "app_secret"

    .line 458
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "app_token"

    .line 459
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "attribution_deeplink"

    const/4 v2, 0x1

    .line 460
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "created_at"

    .line 461
    iget-wide v3, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, v0, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v0, "device_known"

    .line 462
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "needs_cost"

    .line 463
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "environment"

    .line 464
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "event_buffering_enabled"

    .line 465
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v3, v3, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "external_device_id"

    .line 466
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, v0, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "needs_response_details"

    .line 467
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v0, "push_token"

    .line 468
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "secret_id"

    .line 469
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "source"

    .line 470
    invoke-static {v1, v0, p1}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 472
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getMeasurementConsentParameters(Z)Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 839
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 840
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 841
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 845
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 849
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 851
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    :cond_1
    const-string v2, "measurement"

    if-eqz p1, :cond_2

    const-string p1, "enable"

    goto :goto_0

    :cond_2
    const-string p1, "disable"

    .line 855
    :goto_0
    invoke-static {v1, v2, p1}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 859
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p1, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string p1, "android_uuid"

    .line 860
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gps_adid"

    .line 861
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gps_adid_attempt"

    .line 862
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v2, v2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "gps_adid_src"

    .line 863
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "tracking_enabled"

    .line 864
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "fire_adid"

    .line 865
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "fire_tracking_enabled"

    .line 866
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 868
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 869
    sget-object p1, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v0, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-interface {p1, v0, v2}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 871
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p1, v0}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string p1, "android_id"

    .line 872
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mac_md5"

    .line 873
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mac_sha1"

    .line 874
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string p1, "api_level"

    .line 878
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_secret"

    .line 879
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_token"

    .line 880
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_version"

    .line 881
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "attribution_deeplink"

    const/4 v0, 0x1

    .line 882
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "created_at"

    .line 883
    iget-wide v2, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "device_known"

    .line 884
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "device_name"

    .line 885
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "device_type"

    .line 886
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "environment"

    .line 887
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "event_buffering_enabled"

    .line 888
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v2, v2, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "external_device_id"

    .line 889
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "needs_response_details"

    .line 890
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "os_name"

    .line 891
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "os_version"

    .line 892
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "package_name"

    .line 893
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "push_token"

    .line 894
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "secret_id"

    .line 895
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 897
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getSessionParameters(Z)Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 242
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 243
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 244
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 248
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 252
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 254
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    :cond_1
    if-nez p1, :cond_2

    const-string p1, "callback_params"

    .line 259
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v2, v2, Lcom/adjust/sdk/SessionParameters;->callbackParameters:Ljava/util/Map;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    const-string p1, "partner_params"

    .line 260
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v2, v2, Lcom/adjust/sdk/SessionParameters;->partnerParameters:Ljava/util/Map;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    .line 264
    :cond_2
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p1, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string p1, "android_uuid"

    .line 265
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gps_adid"

    .line 266
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gps_adid_attempt"

    .line 267
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v2, v2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "gps_adid_src"

    .line 268
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "tracking_enabled"

    .line 269
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "fire_adid"

    .line 270
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "fire_tracking_enabled"

    .line 271
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 273
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result p1

    if-nez p1, :cond_3

    .line 274
    sget-object p1, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v0, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-interface {p1, v0, v2}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 276
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p1, v0}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string p1, "android_id"

    .line 277
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mac_md5"

    .line 278
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mac_sha1"

    .line 279
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string p1, "api_level"

    .line 283
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_secret"

    .line 284
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_token"

    .line 285
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_version"

    .line 286
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "attribution_deeplink"

    const/4 v0, 0x1

    .line 287
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "connectivity_type"

    .line 288
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getConnectivityType(Landroid/content/Context;)I

    move-result v2

    int-to-long v2, v2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "country"

    .line 289
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->country:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "cpu_type"

    .line 290
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->abi:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "created_at"

    .line 291
    iget-wide v2, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "default_tracker"

    .line 292
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->defaultTracker:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "device_known"

    .line 293
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "needs_cost"

    .line 294
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "device_manufacturer"

    .line 295
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceManufacturer:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "device_name"

    .line 296
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "device_type"

    .line 297
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "display_height"

    .line 298
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->displayHeight:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "display_width"

    .line 299
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->displayWidth:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "environment"

    .line 300
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "event_buffering_enabled"

    .line 301
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v2, v2, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "external_device_id"

    .line 302
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "fb_id"

    .line 303
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->fbAttributionId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "hardware_name"

    .line 304
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->hardwareName:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "installed_at"

    .line 305
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appInstallTime:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "language"

    .line 306
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->language:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "last_interval"

    .line 307
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->lastInterval:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "mcc"

    .line 308
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getMcc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mnc"

    .line 309
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getMnc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "needs_response_details"

    .line 310
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "network_type"

    .line 311
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/adjust/sdk/Util;->getNetworkType(Landroid/content/Context;)I

    move-result v0

    int-to-long v2, v0

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "os_build"

    .line 312
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->buildName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "os_name"

    .line 313
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "os_version"

    .line 314
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "package_name"

    .line 315
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "push_token"

    .line 316
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "screen_density"

    .line 317
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->screenDensity:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "screen_format"

    .line 318
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->screenFormat:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "screen_size"

    .line 319
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->screenSize:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "secret_id"

    .line 320
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "session_count"

    .line 321
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionCount:I

    int-to-long v2, v0

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "session_length"

    .line 322
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionLength:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "subsession_count"

    .line 323
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->subsessionCount:I

    int-to-long v2, v0

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "time_spent"

    .line 324
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->timeSpent:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "updated_at"

    .line 325
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appUpdateTime:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 327
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getSubscriptionParameters(Lcom/adjust/sdk/AdjustPlayStoreSubscription;Z)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/adjust/sdk/AdjustPlayStoreSubscription;",
            "Z)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 988
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 989
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 990
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 994
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 998
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 1000
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 1004
    :cond_1
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v2, v3}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string v2, "android_uuid"

    .line 1005
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v3, v3, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid"

    .line 1006
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "gps_adid_attempt"

    .line 1007
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v3, v3

    invoke-static {v1, v2, v3, v4}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string v2, "gps_adid_src"

    .line 1008
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "tracking_enabled"

    .line 1009
    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v3, v3, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v2, "fire_adid"

    .line 1010
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "fire_tracking_enabled"

    .line 1011
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 1013
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1014
    sget-object v0, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v2, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-interface {v0, v2, v3}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1016
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string v0, "android_id"

    .line 1017
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_md5"

    .line 1018
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mac_sha1"

    .line 1019
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, v0, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    if-nez p2, :cond_3

    const-string p2, "callback_params"

    .line 1024
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v0, v0, Lcom/adjust/sdk/SessionParameters;->callbackParameters:Ljava/util/Map;

    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getCallbackParameters()Ljava/util/Map;

    move-result-object v2

    const-string v3, "Callback"

    invoke-static {v0, v2, v3}, Lcom/adjust/sdk/Util;->mergeParameters(Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    const-string p2, "partner_params"

    .line 1025
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v0, v0, Lcom/adjust/sdk/SessionParameters;->partnerParameters:Ljava/util/Map;

    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getPartnerParameters()Ljava/util/Map;

    move-result-object v2

    const-string v3, "Partner"

    invoke-static {v0, v2, v3}, Lcom/adjust/sdk/Util;->mergeParameters(Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    :cond_3
    const-string p2, "api_level"

    .line 1029
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "app_secret"

    .line 1030
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "app_token"

    .line 1031
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "app_version"

    .line 1032
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "attribution_deeplink"

    const/4 v0, 0x1

    .line 1033
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "connectivity_type"

    .line 1034
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getConnectivityType(Landroid/content/Context;)I

    move-result v2

    int-to-long v2, v2

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "country"

    .line 1035
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->country:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "cpu_type"

    .line 1036
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->abi:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "created_at"

    .line 1037
    iget-wide v2, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "default_tracker"

    .line 1038
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->defaultTracker:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "device_known"

    .line 1039
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "needs_cost"

    .line 1040
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "device_manufacturer"

    .line 1041
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceManufacturer:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "device_name"

    .line 1042
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "device_type"

    .line 1043
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "display_height"

    .line 1044
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->displayHeight:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "display_width"

    .line 1045
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->displayWidth:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "environment"

    .line 1046
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "event_buffering_enabled"

    .line 1047
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v2, v2, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "external_device_id"

    .line 1048
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "fb_id"

    .line 1049
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->fbAttributionId:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "hardware_name"

    .line 1050
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->hardwareName:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "installed_at"

    .line 1051
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->appInstallTime:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "language"

    .line 1052
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->language:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "last_interval"

    .line 1053
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->lastInterval:J

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "mcc"

    .line 1054
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getMcc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "mnc"

    .line 1055
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getMnc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "needs_response_details"

    .line 1056
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "network_type"

    .line 1057
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/adjust/sdk/Util;->getNetworkType(Landroid/content/Context;)I

    move-result v0

    int-to-long v2, v0

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "os_build"

    .line 1058
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->buildName:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "os_name"

    .line 1059
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "os_version"

    .line 1060
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "package_name"

    .line 1061
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "push_token"

    .line 1062
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "screen_density"

    .line 1063
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->screenDensity:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "screen_format"

    .line 1064
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->screenFormat:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "screen_size"

    .line 1065
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->screenSize:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "secret_id"

    .line 1066
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "session_count"

    .line 1067
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionCount:I

    int-to-long v2, v0

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "session_length"

    .line 1068
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionLength:J

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "subsession_count"

    .line 1069
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->subsessionCount:I

    int-to-long v2, v0

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "time_spent"

    .line 1070
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->timeSpent:J

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "updated_at"

    .line 1071
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appUpdateTime:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "billing_store"

    .line 1074
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getBillingStore()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "currency"

    .line 1075
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getCurrency()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "product_id"

    .line 1076
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getSku()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "purchase_token"

    .line 1077
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getPurchaseToken()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "receipt"

    .line 1078
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getSignature()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "revenue"

    .line 1079
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getPrice()J

    move-result-wide v2

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "transaction_date"

    .line 1080
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getPurchaseTime()J

    move-result-wide v2

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "transaction_id"

    .line 1081
    invoke-virtual {p1}, Lcom/adjust/sdk/AdjustPlayStoreSubscription;->getOrderId()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p2, p1}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 1083
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method

.method private getThirdPartySharingParameters(Lcom/adjust/sdk/AdjustThirdPartySharing;)Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/adjust/sdk/AdjustThirdPartySharing;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 769
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 770
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 771
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 775
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 779
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 781
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 785
    :cond_1
    iget-object v2, p1, Lcom/adjust/sdk/AdjustThirdPartySharing;->isEnabled:Ljava/lang/Boolean;

    if-eqz v2, :cond_3

    const-string v2, "sharing"

    .line 786
    iget-object v3, p1, Lcom/adjust/sdk/AdjustThirdPartySharing;->isEnabled:Ljava/lang/Boolean;

    .line 787
    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "enable"

    goto :goto_0

    :cond_2
    const-string v3, "disable"

    .line 786
    :goto_0
    invoke-static {v1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string v2, "granular_third_party_sharing_options"

    .line 790
    iget-object p1, p1, Lcom/adjust/sdk/AdjustThirdPartySharing;->granularOptions:Ljava/util/Map;

    invoke-static {v1, v2, p1}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    .line 794
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p1, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string p1, "android_uuid"

    .line 795
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gps_adid"

    .line 796
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gps_adid_attempt"

    .line 797
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v2, v2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "gps_adid_src"

    .line 798
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "tracking_enabled"

    .line 799
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "fire_adid"

    .line 800
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "fire_tracking_enabled"

    .line 801
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 803
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result p1

    if-nez p1, :cond_4

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result p1

    if-nez p1, :cond_4

    .line 804
    sget-object p1, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v0, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-interface {p1, v0, v2}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 806
    iget-object p1, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p1, v0}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string p1, "android_id"

    .line 807
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mac_md5"

    .line 808
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "mac_sha1"

    .line 809
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    const-string p1, "api_level"

    .line 813
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_secret"

    .line 814
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_token"

    .line 815
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "app_version"

    .line 816
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "attribution_deeplink"

    const/4 v0, 0x1

    .line 817
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "created_at"

    .line 818
    iget-wide v2, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "device_known"

    .line 819
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "device_name"

    .line 820
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "device_type"

    .line 821
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "environment"

    .line 822
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "event_buffering_enabled"

    .line 823
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v2, v2, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "external_device_id"

    .line 824
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, p1, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "needs_response_details"

    .line 825
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p1, "os_name"

    .line 826
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "os_version"

    .line 827
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "package_name"

    .line 828
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "push_token"

    .line 829
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "secret_id"

    .line 830
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, p1, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    .line 832
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method


# virtual methods
.method buildAdRevenuePackage(Ljava/lang/String;Lorg/json/JSONObject;)Lcom/adjust/sdk/ActivityPackage;
    .locals 4

    .line 216
    invoke-direct {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->getAdRevenueParameters(Ljava/lang/String;Lorg/json/JSONObject;)Ljava/util/Map;

    move-result-object p1

    .line 217
    sget-object p2, Lcom/adjust/sdk/ActivityKind;->AD_REVENUE:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, p2}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object p2

    const-string v0, "/ad_revenue"

    .line 218
    invoke-virtual {p2, v0}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v0, ""

    .line 219
    invoke-virtual {p2, v0}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 221
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->AD_REVENUE:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v0

    .line 222
    invoke-virtual {p2}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 221
    invoke-static {p1, v0, v1, v2, v3}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 224
    invoke-virtual {p2, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object p2
.end method

.method buildAttributionPackage(Ljava/lang/String;)Lcom/adjust/sdk/ActivityPackage;
    .locals 5

    .line 148
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getAttributionParameters(Ljava/lang/String;)Ljava/util/Map;

    move-result-object p1

    .line 149
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->ATTRIBUTION:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v0}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v0

    const-string v1, "attribution"

    .line 150
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v1, ""

    .line 151
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 153
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->ATTRIBUTION:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v1

    .line 154
    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 153
    invoke-static {p1, v1, v2, v3, v4}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 156
    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v0
.end method

.method buildClickPackage(Ljava/lang/String;)Lcom/adjust/sdk/ActivityPackage;
    .locals 5

    .line 128
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getClickParameters(Ljava/lang/String;)Ljava/util/Map;

    move-result-object p1

    .line 129
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->CLICK:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v0}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v0

    const-string v1, "/sdk_click"

    .line 130
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v1, ""

    .line 131
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 132
    iget-wide v1, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeInMilliseconds:J

    invoke-virtual {v0, v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setClickTimeInMilliseconds(J)V

    .line 133
    iget-wide v1, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeInSeconds:J

    invoke-virtual {v0, v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setClickTimeInSeconds(J)V

    .line 134
    iget-wide v1, p0, Lcom/adjust/sdk/PackageBuilder;->installBeginTimeInSeconds:J

    invoke-virtual {v0, v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setInstallBeginTimeInSeconds(J)V

    .line 135
    iget-wide v1, p0, Lcom/adjust/sdk/PackageBuilder;->clickTimeServerInSeconds:J

    invoke-virtual {v0, v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setClickTimeServerInSeconds(J)V

    .line 136
    iget-wide v1, p0, Lcom/adjust/sdk/PackageBuilder;->installBeginTimeServerInSeconds:J

    invoke-virtual {v0, v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setInstallBeginTimeServerInSeconds(J)V

    .line 137
    iget-object v1, p0, Lcom/adjust/sdk/PackageBuilder;->installVersion:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setInstallVersion(Ljava/lang/String;)V

    .line 138
    iget-object v1, p0, Lcom/adjust/sdk/PackageBuilder;->googlePlayInstant:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setGooglePlayInstant(Ljava/lang/Boolean;)V

    .line 140
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->CLICK:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v1

    .line 141
    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 140
    invoke-static {p1, v1, v2, v3, v4}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 143
    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v0
.end method

.method buildDisableThirdPartySharingPackage()Lcom/adjust/sdk/ActivityPackage;
    .locals 6

    .line 174
    invoke-direct {p0}, Lcom/adjust/sdk/PackageBuilder;->getDisableThirdPartySharingParameters()Ljava/util/Map;

    move-result-object v0

    .line 175
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->DISABLE_THIRD_PARTY_SHARING:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v1

    const-string v2, "/disable_third_party_sharing"

    .line 176
    invoke-virtual {v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v2, ""

    .line 177
    invoke-virtual {v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 179
    sget-object v2, Lcom/adjust/sdk/ActivityKind;->DISABLE_THIRD_PARTY_SHARING:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v2}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v2

    .line 180
    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v5, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v5, v5, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 179
    invoke-static {v0, v2, v3, v4, v5}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 182
    invoke-virtual {v1, v0}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v1
.end method

.method buildEventPackage(Lcom/adjust/sdk/AdjustEvent;Z)Lcom/adjust/sdk/ActivityPackage;
    .locals 6

    .line 96
    invoke-virtual {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->getEventParameters(Lcom/adjust/sdk/AdjustEvent;Z)Ljava/util/Map;

    move-result-object v0

    .line 97
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->EVENT:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v1

    const-string v2, "/event"

    .line 98
    invoke-virtual {v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    .line 99
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getEventSuffix(Lcom/adjust/sdk/AdjustEvent;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 101
    sget-object v2, Lcom/adjust/sdk/ActivityKind;->EVENT:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v2}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v2

    .line 102
    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v5, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v5, v5, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 101
    invoke-static {v0, v2, v3, v4, v5}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 104
    invoke-virtual {v1, v0}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    if-eqz p2, :cond_0

    .line 107
    iget-object p2, p1, Lcom/adjust/sdk/AdjustEvent;->callbackParameters:Ljava/util/Map;

    invoke-virtual {v1, p2}, Lcom/adjust/sdk/ActivityPackage;->setCallbackParameters(Ljava/util/Map;)V

    .line 108
    iget-object p1, p1, Lcom/adjust/sdk/AdjustEvent;->partnerParameters:Ljava/util/Map;

    invoke-virtual {v1, p1}, Lcom/adjust/sdk/ActivityPackage;->setPartnerParameters(Ljava/util/Map;)V

    :cond_0
    return-object v1
.end method

.method buildGdprPackage()Lcom/adjust/sdk/ActivityPackage;
    .locals 6

    .line 161
    invoke-direct {p0}, Lcom/adjust/sdk/PackageBuilder;->getGdprParameters()Ljava/util/Map;

    move-result-object v0

    .line 162
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->GDPR:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v1

    const-string v2, "/gdpr_forget_device"

    .line 163
    invoke-virtual {v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v2, ""

    .line 164
    invoke-virtual {v1, v2}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 166
    sget-object v2, Lcom/adjust/sdk/ActivityKind;->GDPR:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v2}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v2

    .line 167
    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v5, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v5, v5, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 166
    invoke-static {v0, v2, v3, v4, v5}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 169
    invoke-virtual {v1, v0}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v1
.end method

.method buildInfoPackage(Ljava/lang/String;)Lcom/adjust/sdk/ActivityPackage;
    .locals 5

    .line 115
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getInfoParameters(Ljava/lang/String;)Ljava/util/Map;

    move-result-object p1

    .line 116
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->INFO:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v0}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v0

    const-string v1, "/sdk_info"

    .line 117
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v1, ""

    .line 118
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 120
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->INFO:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v1

    .line 121
    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 120
    invoke-static {p1, v1, v2, v3, v4}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 123
    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v0
.end method

.method buildMeasurementConsentPackage(Z)Lcom/adjust/sdk/ActivityPackage;
    .locals 5

    .line 202
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getMeasurementConsentParameters(Z)Ljava/util/Map;

    move-result-object p1

    .line 203
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->MEASUREMENT_CONSENT:Lcom/adjust/sdk/ActivityKind;

    .line 204
    invoke-direct {p0, v0}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v0

    const-string v1, "/measurement_consent"

    .line 205
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v1, ""

    .line 206
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 208
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->MEASUREMENT_CONSENT:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v1

    .line 209
    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 208
    invoke-static {p1, v1, v2, v3, v4}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 211
    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v0
.end method

.method buildSessionPackage(Z)Lcom/adjust/sdk/ActivityPackage;
    .locals 5

    .line 83
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getSessionParameters(Z)Ljava/util/Map;

    move-result-object p1

    .line 84
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->SESSION:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v0}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v0

    const-string v1, "/session"

    .line 85
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v1, ""

    .line 86
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 88
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->SESSION:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v1

    .line 89
    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 88
    invoke-static {p1, v1, v2, v3, v4}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 91
    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v0
.end method

.method buildSubscriptionPackage(Lcom/adjust/sdk/AdjustPlayStoreSubscription;Z)Lcom/adjust/sdk/ActivityPackage;
    .locals 4

    .line 229
    invoke-direct {p0, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->getSubscriptionParameters(Lcom/adjust/sdk/AdjustPlayStoreSubscription;Z)Ljava/util/Map;

    move-result-object p1

    .line 230
    sget-object p2, Lcom/adjust/sdk/ActivityKind;->SUBSCRIPTION:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, p2}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object p2

    const-string v0, "/v2/purchase"

    .line 231
    invoke-virtual {p2, v0}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v0, ""

    .line 232
    invoke-virtual {p2, v0}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 234
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->SUBSCRIPTION:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v0

    .line 235
    invoke-virtual {p2}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 234
    invoke-static {p1, v0, v1, v2, v3}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 237
    invoke-virtual {p2, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object p2
.end method

.method buildThirdPartySharingPackage(Lcom/adjust/sdk/AdjustThirdPartySharing;)Lcom/adjust/sdk/ActivityPackage;
    .locals 5

    .line 189
    invoke-direct {p0, p1}, Lcom/adjust/sdk/PackageBuilder;->getThirdPartySharingParameters(Lcom/adjust/sdk/AdjustThirdPartySharing;)Ljava/util/Map;

    move-result-object p1

    .line 190
    sget-object v0, Lcom/adjust/sdk/ActivityKind;->THIRD_PARTY_SHARING:Lcom/adjust/sdk/ActivityKind;

    invoke-direct {p0, v0}, Lcom/adjust/sdk/PackageBuilder;->getDefaultActivityPackage(Lcom/adjust/sdk/ActivityKind;)Lcom/adjust/sdk/ActivityPackage;

    move-result-object v0

    const-string v1, "/third_party_sharing"

    .line 191
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setPath(Ljava/lang/String;)V

    const-string v1, ""

    .line 192
    invoke-virtual {v0, v1}, Lcom/adjust/sdk/ActivityPackage;->setSuffix(Ljava/lang/String;)V

    .line 194
    sget-object v1, Lcom/adjust/sdk/ActivityKind;->THIRD_PARTY_SHARING:Lcom/adjust/sdk/ActivityKind;

    invoke-virtual {v1}, Lcom/adjust/sdk/ActivityKind;->toString()Ljava/lang/String;

    move-result-object v1

    .line 195
    invoke-virtual {v0}, Lcom/adjust/sdk/ActivityPackage;->getClientSdk()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v3, v3, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    iget-object v4, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v4, v4, Lcom/adjust/sdk/AdjustConfig;->logger:Lcom/adjust/sdk/ILogger;

    .line 194
    invoke-static {p1, v1, v2, v3, v4}, Lcom/adjust/sdk/AdjustSigner;->sign(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Lcom/adjust/sdk/ILogger;)V

    .line 197
    invoke-virtual {v0, p1}, Lcom/adjust/sdk/ActivityPackage;->setParameters(Ljava/util/Map;)V

    return-object v0
.end method

.method public getEventParameters(Lcom/adjust/sdk/AdjustEvent;Z)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/adjust/sdk/AdjustEvent;",
            "Z)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 332
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 333
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 334
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getImeiParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 338
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 342
    :cond_0
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    sget-object v3, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    invoke-static {v2, v3}, Lcom/adjust/sdk/Reflection;->getOaidParameters(Landroid/content/Context;Lcom/adjust/sdk/ILogger;)Ljava/util/Map;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 344
    invoke-interface {v1, v2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    :cond_1
    if-nez p2, :cond_2

    const-string p2, "callback_params"

    .line 349
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v2, v2, Lcom/adjust/sdk/SessionParameters;->callbackParameters:Ljava/util/Map;

    iget-object v3, p1, Lcom/adjust/sdk/AdjustEvent;->callbackParameters:Ljava/util/Map;

    const-string v4, "Callback"

    invoke-static {v2, v3, v4}, Lcom/adjust/sdk/Util;->mergeParameters(Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;)Ljava/util/Map;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    const-string p2, "partner_params"

    .line 350
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->sessionParameters:Lcom/adjust/sdk/SessionParameters;

    iget-object v2, v2, Lcom/adjust/sdk/SessionParameters;->partnerParameters:Ljava/util/Map;

    iget-object v3, p1, Lcom/adjust/sdk/AdjustEvent;->partnerParameters:Ljava/util/Map;

    const-string v4, "Partner"

    invoke-static {v2, v3, v4}, Lcom/adjust/sdk/Util;->mergeParameters(Ljava/util/Map;Ljava/util/Map;Ljava/lang/String;)Ljava/util/Map;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addMapJson(Ljava/util/Map;Ljava/lang/String;Ljava/util/Map;)V

    .line 354
    :cond_2
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p2, v2}, Lcom/adjust/sdk/DeviceInfo;->reloadPlayIds(Landroid/content/Context;)V

    const-string p2, "android_uuid"

    .line 355
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->uuid:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "gps_adid"

    .line 356
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdId:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "gps_adid_attempt"

    .line 357
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdAttempt:I

    int-to-long v2, v2

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "gps_adid_src"

    .line 358
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->playAdIdSource:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "tracking_enabled"

    .line 359
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->isTrackingEnabled:Ljava/lang/Boolean;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "fire_adid"

    .line 360
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireAdvertisingId(Landroid/content/ContentResolver;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "fire_tracking_enabled"

    .line 361
    invoke-static {v0}, Lcom/adjust/sdk/Util;->getFireTrackingEnabled(Landroid/content/ContentResolver;)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    .line 363
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsPlayIds(Ljava/util/Map;)Z

    move-result p2

    if-nez p2, :cond_3

    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->containsFireIds(Ljava/util/Map;)Z

    move-result p2

    if-nez p2, :cond_3

    .line 364
    sget-object p2, Lcom/adjust/sdk/PackageBuilder;->logger:Lcom/adjust/sdk/ILogger;

    const-string v0, "Google Advertising ID or Fire Advertising ID not detected, fallback to non Google Play and Fire identifiers will take place"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-interface {p2, v0, v2}, Lcom/adjust/sdk/ILogger;->warn(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 366
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-virtual {p2, v0}, Lcom/adjust/sdk/DeviceInfo;->reloadNonPlayIds(Landroid/content/Context;)V

    const-string p2, "android_id"

    .line 367
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->androidId:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "mac_md5"

    .line 368
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macShortMd5:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "mac_sha1"

    .line 369
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->macSha1:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    const-string p2, "api_level"

    .line 373
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->apiLevel:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "app_secret"

    .line 374
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appSecret:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "app_token"

    .line 375
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->appToken:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "app_version"

    .line 376
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->appVersion:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "attribution_deeplink"

    const/4 v0, 0x1

    .line 377
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "connectivity_type"

    .line 378
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getConnectivityType(Landroid/content/Context;)I

    move-result v2

    int-to-long v2, v2

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "country"

    .line 379
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->country:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "cpu_type"

    .line 380
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->abi:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "created_at"

    .line 381
    iget-wide v2, p0, Lcom/adjust/sdk/PackageBuilder;->createdAt:J

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDateInMilliseconds(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "currency"

    .line 382
    iget-object v2, p1, Lcom/adjust/sdk/AdjustEvent;->currency:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "device_known"

    .line 383
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->deviceKnown:Ljava/lang/Boolean;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "needs_cost"

    .line 384
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->needsCost:Ljava/lang/Boolean;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "device_manufacturer"

    .line 385
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceManufacturer:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "device_name"

    .line 386
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceName:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "device_type"

    .line 387
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->deviceType:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "display_height"

    .line 388
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->displayHeight:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "display_width"

    .line 389
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->displayWidth:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "environment"

    .line 390
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->environment:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "event_callback_id"

    .line 391
    iget-object v2, p1, Lcom/adjust/sdk/AdjustEvent;->callbackId:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "event_count"

    .line 392
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget v2, v2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->eventCount:I

    int-to-long v2, v2

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "event_buffering_enabled"

    .line 393
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-boolean v2, v2, Lcom/adjust/sdk/AdjustConfig;->eventBufferingEnabled:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "event_token"

    .line 394
    iget-object v2, p1, Lcom/adjust/sdk/AdjustEvent;->eventToken:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "external_device_id"

    .line 395
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->externalDeviceId:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "fb_id"

    .line 396
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->fbAttributionId:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "hardware_name"

    .line 397
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->hardwareName:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "language"

    .line 398
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v2, v2, Lcom/adjust/sdk/DeviceInfo;->language:Ljava/lang/String;

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "mcc"

    .line 399
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getMcc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "mnc"

    .line 400
    iget-object v2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v2, v2, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adjust/sdk/Util;->getMnc(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "needs_response_details"

    .line 401
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addBoolean(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string p2, "network_type"

    .line 402
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object v0, v0, Lcom/adjust/sdk/AdjustConfig;->context:Landroid/content/Context;

    invoke-static {v0}, Lcom/adjust/sdk/Util;->getNetworkType(Landroid/content/Context;)I

    move-result v0

    int-to-long v2, v0

    invoke-static {v1, p2, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p2, "os_build"

    .line 403
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->buildName:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "os_name"

    .line 404
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osName:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "os_version"

    .line 405
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->osVersion:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "package_name"

    .line 406
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object v0, v0, Lcom/adjust/sdk/DeviceInfo;->packageName:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "push_token"

    .line 407
    iget-object v0, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-object v0, v0, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->pushToken:Ljava/lang/String;

    invoke-static {v1, p2, v0}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p2, "revenue"

    .line 408
    iget-object p1, p1, Lcom/adjust/sdk/AdjustEvent;->revenue:Ljava/lang/Double;

    invoke-static {v1, p2, p1}, Lcom/adjust/sdk/PackageBuilder;->addDouble(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Double;)V

    const-string p1, "screen_density"

    .line 409
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object p2, p2, Lcom/adjust/sdk/DeviceInfo;->screenDensity:Ljava/lang/String;

    invoke-static {v1, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "screen_format"

    .line 410
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object p2, p2, Lcom/adjust/sdk/DeviceInfo;->screenFormat:Ljava/lang/String;

    invoke-static {v1, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "screen_size"

    .line 411
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->deviceInfo:Lcom/adjust/sdk/DeviceInfo;

    iget-object p2, p2, Lcom/adjust/sdk/DeviceInfo;->screenSize:Ljava/lang/String;

    invoke-static {v1, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "secret_id"

    .line 412
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->adjustConfig:Lcom/adjust/sdk/AdjustConfig;

    iget-object p2, p2, Lcom/adjust/sdk/AdjustConfig;->secretId:Ljava/lang/String;

    invoke-static {v1, p1, p2}, Lcom/adjust/sdk/PackageBuilder;->addString(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "session_count"

    .line 413
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget p2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionCount:I

    int-to-long v2, p2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "session_length"

    .line 414
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->sessionLength:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "subsession_count"

    .line 415
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget p2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->subsessionCount:I

    int-to-long v2, p2

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addLong(Ljava/util/Map;Ljava/lang/String;J)V

    const-string p1, "time_spent"

    .line 416
    iget-object p2, p0, Lcom/adjust/sdk/PackageBuilder;->activityStateCopy:Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;

    iget-wide v2, p2, Lcom/adjust/sdk/PackageBuilder$ActivityStateCopy;->timeSpent:J

    invoke-static {v1, p1, v2, v3}, Lcom/adjust/sdk/PackageBuilder;->addDuration(Ljava/util/Map;Ljava/lang/String;J)V

    .line 418
    invoke-direct {p0, v1}, Lcom/adjust/sdk/PackageBuilder;->checkDeviceIds(Ljava/util/Map;)V

    return-object v1
.end method
