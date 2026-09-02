.class public Lcom/inca/security/Proxy/AppGuardProxyApplication;
.super Landroid/app/Application;
.source "AppGuardProxyApplication.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method private native IiIiiIiIiI(Landroid/content/Context;)V
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .line 28
    :try_start_0
    invoke-static {}, Lcom/inca/security/DexProtect/Binder;->getABI()I

    move-result v0

    if-nez v0, :cond_0

    .line 29
    invoke-virtual {p1}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/inca/security/Proxy/iIiIiIiIii;->iIiIIiIiiI(Landroid/content/Context;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    .line 34
    :catch_0
    :cond_0
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    return-void
.end method

.method public onCreate()V
    .locals 1

    .line 39
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 40
    invoke-virtual {p0}, Lcom/inca/security/Proxy/AppGuardProxyApplication;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/inca/security/Proxy/JNISoxProxy;->setApplicationContext(Landroid/content/Context;)V

    .line 41
    invoke-direct {p0, p0}, Lcom/inca/security/Proxy/AppGuardProxyApplication;->IiIiiIiIiI(Landroid/content/Context;)V

    return-void
.end method
