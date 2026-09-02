.class public Lcom/android/debug_plugin/debugBatteryInfo$myBatteryInfo;
.super Ljava/lang/Object;
.source "debugBatteryInfo.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/debug_plugin/debugBatteryInfo;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "myBatteryInfo"
.end annotation


# instance fields
.field public level:I

.field public temperature:I

.field public voltage:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
