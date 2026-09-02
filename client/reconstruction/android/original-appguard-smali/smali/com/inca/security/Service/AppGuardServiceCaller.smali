.class public Lcom/inca/security/Service/AppGuardServiceCaller;
.super Ljava/lang/Object;
.source "yb"


# static fields
.field private static synthetic IIIiiiIIiI:Landroid/os/Messenger;

.field private static synthetic IIiIIiiiIi:Landroid/content/ServiceConnection;

.field private static synthetic IiiiIIiIii:Z

.field private static synthetic iIIIIiiIiI:I

.field private static synthetic iiIIIiiiii:Landroid/os/Messenger;


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    .line 169
    new-instance v0, Lcom/inca/security/iiIiiiiIIi;

    invoke-direct {v0}, Lcom/inca/security/iiIiiiiIIi;-><init>()V

    sput-object v0, Lcom/inca/security/Service/AppGuardServiceCaller;->IIiIIiiiIi:Landroid/content/ServiceConnection;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 207
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic IIIIiiIIII()I
    .locals 1

    .line 207
    sget v0, Lcom/inca/security/Service/AppGuardServiceCaller;->iIIIIiiIiI:I

    return v0
.end method

.method public static synthetic IIIIiiIIII()Landroid/os/Messenger;
    .locals 1

    .line 207
    sget-object v0, Lcom/inca/security/Service/AppGuardServiceCaller;->iiIIIiiiii:Landroid/os/Messenger;

    return-object v0
.end method

.method public static synthetic IIIIiiIIII(Landroid/os/Messenger;)Landroid/os/Messenger;
    .locals 0

    .line 207
    sput-object p0, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIiiiIIiI:Landroid/os/Messenger;

    return-object p0
.end method

.method public static synthetic IIIIiiIIII(III)V
    .locals 0

    .line 207
    invoke-static {p0, p1, p2}, Lcom/inca/security/Service/AppGuardServiceCaller;->IiiIiIiiIi(III)V

    return-void
.end method

.method public static synthetic IIIIiiIIII(Z)Z
    .locals 0

    .line 207
    sput-boolean p0, Lcom/inca/security/Service/AppGuardServiceCaller;->IiiiIIiIii:Z

    return p0
.end method

.method public static synthetic IiIIiiiiiI()Landroid/os/Messenger;
    .locals 1

    .line 207
    sget-object v0, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIiiiIIiI:Landroid/os/Messenger;

    return-object v0
.end method

.method public static synthetic IiIIiiiiiI(Landroid/os/Messenger;)Landroid/os/Messenger;
    .locals 0

    .line 207
    sput-object p0, Lcom/inca/security/Service/AppGuardServiceCaller;->iiIIIiiiii:Landroid/os/Messenger;

    return-object p0
.end method

.method private static native synthetic IiiIiIiiIi(III)V
.end method

.method public static callService(II)V
    .locals 2

    .line 95
    sput p1, Lcom/inca/security/Service/AppGuardServiceCaller;->iIIIIiiIiI:I

    .line 21
    sget-boolean p0, Lcom/inca/security/Service/AppGuardServiceCaller;->IiiiIIiIii:Z

    const/4 p1, 0x1

    if-nez p0, :cond_0

    .line 174
    new-instance p0, Landroid/content/Intent;

    invoke-static {}, Lcom/inca/security/Proxy/JNISoxProxy;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-class v1, Lcom/inca/security/Service/AppGuardService;

    invoke-direct {p0, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 127
    invoke-static {}, Lcom/inca/security/Proxy/JNISoxProxy;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lcom/inca/security/Service/AppGuardServiceCaller;->IIiIIiiiIi:Landroid/content/ServiceConnection;

    invoke-virtual {v0, p0, v1, p1}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    return-void

    :cond_0
    const/4 p0, 0x0

    const/4 v0, 0x0

    .line 139
    invoke-static {p0, p1, v0, v0}, Landroid/os/Message;->obtain(Landroid/os/Handler;III)Landroid/os/Message;

    move-result-object p0

    .line 185
    sget-object p1, Lcom/inca/security/Service/AppGuardServiceCaller;->iiIIIiiiii:Landroid/os/Messenger;

    iput-object p1, p0, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    .line 196
    :try_start_0
    sget-object p1, Lcom/inca/security/Service/AppGuardServiceCaller;->IIIiiiIIiI:Landroid/os/Messenger;

    invoke-virtual {p1, p0}, Landroid/os/Messenger;->send(Landroid/os/Message;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
