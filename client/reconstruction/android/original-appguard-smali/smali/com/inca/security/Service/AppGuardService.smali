.class public Lcom/inca/security/Service/AppGuardService;
.super Landroid/app/Service;
.source "nb"


# static fields
.field private static final synthetic IIiIIiiiIi:I = 0x1


# instance fields
.field private synthetic IiiiIIiIii:Landroid/os/Handler;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 143
    new-instance v0, Lcom/inca/security/IiiIiiiiiI;

    invoke-direct {v0, p0}, Lcom/inca/security/IiiIiiiiiI;-><init>(Lcom/inca/security/Service/AppGuardService;)V

    iput-object v0, p0, Lcom/inca/security/Service/AppGuardService;->IiiiIIiIii:Landroid/os/Handler;

    return-void
.end method

.method public static synthetic IIIIiiIIII(Lcom/inca/security/Service/AppGuardService;I)I
    .locals 0

    .line 35
    invoke-direct {p0, p1}, Lcom/inca/security/Service/AppGuardService;->IiiiIIiIIi(I)I

    move-result p0

    return p0
.end method

.method private native synthetic IiiiIIiIIi(I)I
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    .line 75
    new-instance p1, Landroid/os/Messenger;

    iget-object v0, p0, Lcom/inca/security/Service/AppGuardService;->IiiiIIiIii:Landroid/os/Handler;

    invoke-direct {p1, v0}, Landroid/os/Messenger;-><init>(Landroid/os/Handler;)V

    invoke-virtual {p1}, Landroid/os/Messenger;->getBinder()Landroid/os/IBinder;

    move-result-object p1

    return-object p1
.end method

.method public onCreate()V
    .locals 0

    .line 169
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    return-void
.end method

.method public onDestroy()V
    .locals 0

    .line 174
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    .line 102
    invoke-super {p0, p1, p2, p3}, Landroid/app/Service;->onStartCommand(Landroid/content/Intent;II)I

    const/4 p1, 0x2

    return p1
.end method

.method public onUnbind(Landroid/content/Intent;)Z
    .locals 0

    .line 46
    invoke-super {p0, p1}, Landroid/app/Service;->onUnbind(Landroid/content/Intent;)Z

    move-result p1

    return p1
.end method
