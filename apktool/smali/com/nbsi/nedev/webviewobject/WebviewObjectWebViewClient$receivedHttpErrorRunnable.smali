.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;
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
    name = "receivedHttpErrorRunnable"
.end annotation


# instance fields
.field errorResponse:Landroid/webkit/WebResourceResponse;

.field request:Landroid/webkit/WebResourceRequest;

.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

.field view:Landroid/webkit/WebView;

.field wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .locals 0

    .line 750
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 746
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 747
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->view:Landroid/webkit/WebView;

    .line 751
    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 752
    iput-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->view:Landroid/webkit/WebView;

    .line 753
    iput-object p4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->request:Landroid/webkit/WebResourceRequest;

    .line 754
    iput-object p5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;->errorResponse:Landroid/webkit/WebResourceResponse;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    return-void
.end method
