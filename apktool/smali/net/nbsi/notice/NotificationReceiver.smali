.class public Lnet/nbsi/notice/NotificationReceiver;
.super Landroid/content/BroadcastReceiver;
.source "NotificationReceiver.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    const-string v0, "LocalPush"

    const-string v1, "NotificationReceiver OnReceive "

    .line 18
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 40
    invoke-static {p1, p2}, Lnet/nbsi/notice/NotificationSender;->SendNotification(Landroid/content/Context;Landroid/content/Intent;)V

    return-void
.end method
