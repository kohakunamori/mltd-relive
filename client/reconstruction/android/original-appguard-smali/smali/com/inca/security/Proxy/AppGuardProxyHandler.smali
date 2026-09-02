.class public Lcom/inca/security/Proxy/AppGuardProxyHandler;
.super Ljava/lang/Object;
.source "AppGuardProxyHandler.java"

# interfaces
.implements Landroid/os/Handler$Callback;


# static fields
.field private static mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/inca/security/Proxy/AppGuardProxyHandler;
    .locals 2

    const-class v0, Lcom/inca/security/Proxy/AppGuardProxyHandler;

    monitor-enter v0

    .line 13
    :try_start_0
    sget-object v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;->mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;

    if-nez v1, :cond_0

    .line 14
    new-instance v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;

    invoke-direct {v1}, Lcom/inca/security/Proxy/AppGuardProxyHandler;-><init>()V

    sput-object v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;->mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;

    .line 17
    :cond_0
    sget-object v1, Lcom/inca/security/Proxy/AppGuardProxyHandler;->mInstance:Lcom/inca/security/Proxy/AppGuardProxyHandler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private native iiIiIIiIIi(Landroid/os/Message;)Z
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)Z
    .locals 0

    .line 24
    invoke-direct {p0, p1}, Lcom/inca/security/Proxy/AppGuardProxyHandler;->iiIiIIiIIi(Landroid/os/Message;)Z

    move-result p1

    return p1
.end method
