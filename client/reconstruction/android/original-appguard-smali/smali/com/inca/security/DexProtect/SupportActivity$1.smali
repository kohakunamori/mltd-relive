.class public Lcom/inca/security/DexProtect/SupportActivity$1;
.super Ljava/lang/Object;
.source "cb"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/inca/security/DexProtect/SupportActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field public final synthetic IIiIIiiiIi:Lcom/inca/security/DexProtect/SupportActivity;


# direct methods
.method public constructor <init>(Lcom/inca/security/DexProtect/SupportActivity;)V
    .locals 0

    .line 46
    iput-object p1, p0, Lcom/inca/security/DexProtect/SupportActivity$1;->IIiIIiiiIi:Lcom/inca/security/DexProtect/SupportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 212
    :try_start_0
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0x10

    if-lt p1, p2, :cond_0

    .line 167
    iget-object p1, p0, Lcom/inca/security/DexProtect/SupportActivity$1;->IIiIIiiiIi:Lcom/inca/security/DexProtect/SupportActivity;

    invoke-virtual {p1}, Lcom/inca/security/DexProtect/SupportActivity;->finishAffinity()V

    .line 95
    :cond_0
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result p1

    invoke-static {p1}, Landroid/os/Process;->killProcess(I)V

    const/4 p1, 0x0

    .line 21
    invoke-static {p1}, Ljava/lang/System;->exit(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
