.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;
.super Ljava/lang/Object;
.source "WebviewObjectWebViewClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "receivedErrorRunnable1"
.end annotation


# instance fields
.field description:Ljava/lang/String;

.field errorCode:I

.field failingUrl:Ljava/lang/String;

.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

.field view:Landroid/webkit/WebView;

.field wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 640
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 635
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 636
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->view:Landroid/webkit/WebView;

    const/4 v0, 0x0

    .line 637
    iput v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->errorCode:I

    .line 638
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->description:Ljava/lang/String;

    .line 639
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->failingUrl:Ljava/lang/String;

    .line 641
    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 642
    iput-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->view:Landroid/webkit/WebView;

    .line 643
    iput p4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->errorCode:I

    .line 644
    iput-object p5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->description:Ljava/lang/String;

    .line 645
    iput-object p6, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;->failingUrl:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    return-void
.end method
