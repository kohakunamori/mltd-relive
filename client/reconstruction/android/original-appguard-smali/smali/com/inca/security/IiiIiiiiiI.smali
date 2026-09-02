.class public Lcom/inca/security/IiiIiiiiiI;
.super Landroid/os/Handler;
.source "nb"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/inca/security/Service/AppGuardService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field public final synthetic IIiIIiiiIi:Lcom/inca/security/Service/AppGuardService;


# direct methods
.method public constructor <init>(Lcom/inca/security/Service/AppGuardService;)V
    .locals 0

    .line 143
    iput-object p1, p0, Lcom/inca/security/IiiIiiiiiI;->IIiIIiiiIi:Lcom/inca/security/Service/AppGuardService;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 4

    .line 84
    iget v0, p1, Landroid/os/Message;->what:I

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eq v0, v1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    .line 124
    :cond_0
    iget-object v0, p0, Lcom/inca/security/IiiIiiiiiI;->IIiIIiiiIi:Lcom/inca/security/Service/AppGuardService;

    invoke-static {v0, v1}, Lcom/inca/security/Service/AppGuardService;->IIIIiiIIII(Lcom/inca/security/Service/AppGuardService;I)I

    move-result v0

    .line 158
    :goto_0
    iget-object v1, p1, Landroid/os/Message;->replyTo:Landroid/os/Messenger;

    const/4 v3, 0x0

    .line 181
    iget p1, p1, Landroid/os/Message;->what:I

    invoke-static {v3, p1, v0, v2}, Landroid/os/Message;->obtain(Landroid/os/Handler;III)Landroid/os/Message;

    move-result-object p1

    .line 118
    :try_start_0
    invoke-virtual {v1, p1}, Landroid/os/Messenger;->send(Landroid/os/Message;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
