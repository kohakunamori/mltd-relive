.class Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;
.super Ljava/lang/Object;
.source "OverrideActivity.java"

# interfaces
.implements Lcom/inca/security/AppGuard/AppGuardEventListener;


# static fields
.field private static final mUnityFatalMethodName:Ljava/lang/String; = "FatalError"

.field private static final mUnityObjName:Ljava/lang/String; = "XXXdRaUgPpAXXX"

.field private static mUnityObjNameBytes:Lcom/inca/security/Interface/SecureBytes; = null

.field private static final mUnitySignalMethodName:Ljava/lang/String; = "SignalCallback"


# instance fields
.field private mDetect2Flag:J

.field private mDetectFlag:J

.field private mDirectSend:Z

.field private final mDirectSendDelayTime:J

.field private mErrorFlag:J

.field private mEventFlag:J

.field private final mHandler:Landroid/os/Handler;

.field private mLastEvent:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    .line 237
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    .line 220
    iput-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mEventFlag:J

    .line 221
    iput-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mLastEvent:J

    .line 222
    iput-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mErrorFlag:J

    .line 223
    iput-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetectFlag:J

    .line 224
    iput-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetect2Flag:J

    const-wide/32 v0, 0xea60

    .line 228
    iput-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDirectSendDelayTime:J

    .line 229
    new-instance v2, Landroid/os/Handler;

    invoke-direct {v2}, Landroid/os/Handler;-><init>()V

    iput-object v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    .line 238
    iget-object v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    if-nez v2, :cond_0

    const/4 v0, 0x1

    .line 239
    iput-boolean v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDirectSend:Z

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 243
    iput-boolean v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDirectSend:Z

    .line 244
    iget-object v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    new-instance v3, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$1;

    invoke-direct {v3, p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$1;-><init>(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;)V

    invoke-virtual {v2, v3, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :goto_0
    return-void
.end method

.method private CallFatalMethod(Ljava/lang/String;)V
    .locals 4

    .line 287
    iget-boolean v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDirectSend:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    if-nez v0, :cond_0

    goto :goto_0

    .line 292
    :cond_0
    iget-object v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    new-instance v1, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$2;

    invoke-direct {v1, p0, p1}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$2;-><init>(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;Ljava/lang/String;)V

    const-wide/32 v2, 0xea60

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_1

    .line 288
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->getUnityObjName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "FatalError"

    invoke-static {v0, v1, p1}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method private CallSignalMethod(Ljava/lang/String;)V
    .locals 4

    .line 302
    iget-boolean v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDirectSend:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    if-nez v0, :cond_0

    goto :goto_0

    .line 307
    :cond_0
    iget-object v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mHandler:Landroid/os/Handler;

    new-instance v1, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;

    invoke-direct {v1, p0, p1}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener$3;-><init>(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;Ljava/lang/String;)V

    const-wide/32 v2, 0xea60

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_1

    .line 303
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->getUnityObjName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "SignalCallback"

    invoke-static {v0, v1, p1}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    return-void
.end method

.method static synthetic access$002(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;Z)Z
    .locals 0

    .line 215
    iput-boolean p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDirectSend:Z

    return p1
.end method

.method static synthetic access$100(Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;)Ljava/lang/String;
    .locals 0

    .line 215
    invoke-direct {p0}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->getUnityObjName()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private getUnityObjName()Ljava/lang/String;
    .locals 2

    .line 272
    sget-object v0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mUnityObjNameBytes:Lcom/inca/security/Interface/SecureBytes;

    if-nez v0, :cond_1

    .line 273
    sget-object v0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mUnityObjNameBytes:Lcom/inca/security/Interface/SecureBytes;

    invoke-interface {v0}, Lcom/inca/security/Interface/SecureBytes;->get()[B

    move-result-object v0

    if-eqz v0, :cond_0

    .line 274
    array-length v1, v0

    if-lez v1, :cond_0

    .line 275
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([B)V

    return-object v1

    :cond_0
    const-string v0, "XXXdRaUgPpAXXX"

    return-object v0

    :cond_1
    const-string v0, "XXXdRaUgPpAXXX"

    return-object v0
.end method


# virtual methods
.method public getDetect()J
    .locals 2

    .line 234
    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetectFlag:J

    return-wide v0
.end method

.method public getDetect2()J
    .locals 2

    .line 235
    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetect2Flag:J

    return-wide v0
.end method

.method public getError()J
    .locals 2

    .line 233
    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mErrorFlag:J

    return-wide v0
.end method

.method public getEvent()J
    .locals 2

    .line 231
    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mEventFlag:J

    return-wide v0
.end method

.method public getLastEvent()J
    .locals 2

    .line 232
    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mLastEvent:J

    return-wide v0
.end method

.method public onDetected(I[B)V
    .locals 4

    const/16 p2, 0x1f

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const/16 v0, 0x26

    goto/16 :goto_0

    :pswitch_1
    const/16 p2, 0x24

    goto/16 :goto_1

    :pswitch_2
    const/16 p2, 0x23

    goto/16 :goto_1

    :pswitch_3
    const/16 p2, 0x22

    goto/16 :goto_1

    :pswitch_4
    const/16 p2, 0x21

    goto/16 :goto_1

    :pswitch_5
    const/16 p2, 0x20

    goto/16 :goto_1

    :pswitch_6
    const/16 p2, 0x1a

    goto/16 :goto_1

    :pswitch_7
    const/16 p2, 0x1e

    goto/16 :goto_1

    :pswitch_8
    const/16 p2, 0x1d

    goto/16 :goto_1

    :pswitch_9
    const/16 p2, 0x1c

    goto/16 :goto_1

    :pswitch_a
    const/16 p2, 0x25

    goto/16 :goto_1

    :pswitch_b
    const/16 p2, 0x1b

    goto :goto_1

    :pswitch_c
    const/16 p2, 0x19

    goto :goto_1

    :pswitch_d
    const/16 p2, 0x18

    goto :goto_1

    :pswitch_e
    const/16 p2, 0x17

    goto :goto_1

    :pswitch_f
    const/16 p2, 0x16

    goto :goto_1

    :pswitch_10
    const/16 p2, 0x15

    goto :goto_1

    :pswitch_11
    const/16 p2, 0x14

    goto :goto_1

    :pswitch_12
    const/16 p2, 0x13

    goto :goto_1

    :pswitch_13
    const/16 p2, 0x12

    goto :goto_1

    :pswitch_14
    const/16 p2, 0x11

    goto :goto_1

    :pswitch_15
    const/16 p2, 0x10

    goto :goto_1

    :pswitch_16
    const/16 p2, 0xf

    goto :goto_1

    :pswitch_17
    const/16 p2, 0xe

    goto :goto_1

    :pswitch_18
    const/16 p2, 0xd

    goto :goto_1

    :pswitch_19
    const/16 p2, 0xc

    goto :goto_1

    :pswitch_1a
    const/16 p2, 0xb

    goto :goto_1

    :pswitch_1b
    const/16 p2, 0xa

    goto :goto_1

    :pswitch_1c
    const/16 p2, 0x9

    goto :goto_1

    :pswitch_1d
    const/16 p2, 0x8

    goto :goto_1

    :pswitch_1e
    const/4 p2, 0x7

    goto :goto_1

    :pswitch_1f
    const/4 p2, 0x6

    goto :goto_1

    :pswitch_20
    const/4 p2, 0x5

    goto :goto_1

    :pswitch_21
    const/4 p2, 0x4

    goto :goto_1

    :pswitch_22
    const/4 p2, 0x3

    goto :goto_1

    :pswitch_23
    const/4 p2, 0x2

    goto :goto_1

    :pswitch_24
    const/4 p2, 0x1

    goto :goto_1

    :pswitch_25
    const/4 p2, 0x0

    goto :goto_1

    :goto_0
    const/16 p2, 0x26

    :goto_1
    :pswitch_26
    if-lez p2, :cond_1

    const/16 p2, 0x3e

    const-wide/16 v0, 0x1

    if-gt p1, p2, :cond_0

    add-int/lit8 p1, p1, -0x1

    .line 622
    iget-wide v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetectFlag:J

    shl-long p1, v0, p1

    or-long/2addr p1, v2

    iput-wide p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetectFlag:J

    goto :goto_2

    :cond_0
    const/16 p2, 0x7c

    if-gt p1, p2, :cond_1

    add-int/lit8 p1, p1, -0x3f

    .line 626
    iget-wide v2, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetect2Flag:J

    shl-long p1, v0, p1

    or-long/2addr p1, v2

    iput-wide p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mDetect2Flag:J

    :cond_1
    :goto_2
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_25
        :pswitch_24
        :pswitch_23
        :pswitch_22
        :pswitch_21
        :pswitch_20
        :pswitch_1f
        :pswitch_1e
        :pswitch_1d
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_8
        :pswitch_7
        :pswitch_26
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public onError(I[B)V
    .locals 4

    const/16 p2, 0x2706

    if-eq p1, p2, :cond_1

    const/16 p2, 0x270f

    if-eq p1, p2, :cond_0

    packed-switch p1, :pswitch_data_0

    packed-switch p1, :pswitch_data_1

    const/16 p1, 0xe

    goto :goto_0

    :pswitch_0
    const/16 p1, 0xb

    goto :goto_0

    :pswitch_1
    const/16 p1, 0xa

    goto :goto_0

    :pswitch_2
    const/16 p1, 0x9

    goto :goto_0

    :pswitch_3
    const/16 p1, 0x8

    goto :goto_0

    :pswitch_4
    const/4 p1, 0x7

    goto :goto_0

    :pswitch_5
    const/4 p1, 0x6

    goto :goto_0

    :pswitch_6
    const/4 p1, 0x5

    goto :goto_0

    :pswitch_7
    const/4 p1, 0x4

    goto :goto_0

    :pswitch_8
    const/4 p1, 0x3

    goto :goto_0

    :pswitch_9
    const/4 p1, 0x2

    goto :goto_0

    :pswitch_a
    const/4 p1, 0x1

    goto :goto_0

    :pswitch_b
    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0xd

    const-string p2, ""

    .line 430
    invoke-direct {p0, p2}, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->CallFatalMethod(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const/16 p1, 0xc

    :goto_0
    if-lez p1, :cond_2

    add-int/lit8 p1, p1, -0x1

    .line 440
    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mErrorFlag:J

    const-wide/16 v2, 0x1

    shl-long p1, v2, p1

    or-long/2addr p1, v0

    iput-wide p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mErrorFlag:J

    :cond_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1f41
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onEvent(I[B)V
    .locals 2

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const/16 p1, 0xb

    goto :goto_0

    :pswitch_1
    const/16 p1, 0xa

    goto :goto_0

    :pswitch_2
    const/16 p1, 0x9

    goto :goto_0

    :pswitch_3
    const/16 p1, 0x8

    goto :goto_0

    :pswitch_4
    const/4 p1, 0x7

    goto :goto_0

    :pswitch_5
    const/4 p1, 0x6

    goto :goto_0

    :pswitch_6
    const/4 p1, 0x5

    goto :goto_0

    :pswitch_7
    const/4 p1, 0x4

    goto :goto_0

    :pswitch_8
    const/4 p1, 0x3

    goto :goto_0

    :pswitch_9
    const/4 p1, 0x2

    goto :goto_0

    :pswitch_a
    const/4 p1, 0x1

    :goto_0
    if-lez p1, :cond_0

    add-int/lit8 p1, p1, -0x1

    const-wide/16 v0, 0x1

    shl-long p1, v0, p1

    .line 368
    iput-wide p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mLastEvent:J

    .line 369
    iget-wide p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mEventFlag:J

    iget-wide v0, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mLastEvent:J

    or-long/2addr p1, v0

    iput-wide p1, p0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mEventFlag:J

    :cond_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_0
        :pswitch_0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public setCallbackObjName(Ljava/lang/String;)V
    .locals 1

    .line 255
    sget-object v0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mUnityObjNameBytes:Lcom/inca/security/Interface/SecureBytes;

    if-nez v0, :cond_0

    .line 257
    :try_start_0
    invoke-static {}, Lcom/inca/security/AppGuard/SecureObjectFactory;->newInstanceOfSecureBytes()Lcom/inca/security/Interface/SecureBytes;

    move-result-object v0

    sput-object v0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mUnityObjNameBytes:Lcom/inca/security/Interface/SecureBytes;
    :try_end_0
    .catch Lcom/inca/security/Exception/AppGuardException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 264
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-void

    :catch_1
    move-exception p1

    .line 260
    invoke-virtual {p1}, Lcom/inca/security/Exception/AppGuardException;->printStackTrace()V

    return-void

    .line 268
    :cond_0
    :goto_0
    sget-object v0, Lcom/bandainamcoent/imas_millionlive_theaterdays/player/OverrideEventListener;->mUnityObjNameBytes:Lcom/inca/security/Interface/SecureBytes;

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/inca/security/Interface/SecureBytes;->set([B)V

    return-void
.end method
