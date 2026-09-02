.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;
.super Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;
.source "WebviewObjectWebViewClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .locals 0

    .line 714
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct/range {p0 .. p5}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 720
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->request:Landroid/webkit/WebResourceRequest;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 721
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->request:Landroid/webkit/WebResourceRequest;

    invoke-interface {v0}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 725
    :goto_0
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v2, v2, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v2, v2, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 726
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->errorResponse:Landroid/webkit/WebResourceResponse;

    if-eqz v2, :cond_1

    .line 728
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->errorResponse:Landroid/webkit/WebResourceResponse;

    invoke-virtual {v2}, Landroid/webkit/WebResourceResponse;->getStatusCode()I

    move-result v2

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->errorResponse:Landroid/webkit/WebResourceResponse;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3, v0}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onReceivedError(ILjava/lang/String;Ljava/lang/String;)Z

    move-result v0

    goto :goto_1

    .line 730
    :cond_1
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v2, v2, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    const/4 v3, -0x1

    invoke-interface {v2, v3, v1, v0}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onReceivedError(ILjava/lang/String;Ljava/lang/String;)Z

    move-result v0

    :goto_1
    if-nez v0, :cond_2

    .line 733
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->view:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->request:Landroid/webkit/WebResourceRequest;

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;->errorResponse:Landroid/webkit/WebResourceResponse;

    invoke-virtual {v0, v1, v2, v3}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onReceivedHttpErrorSuper(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V

    :cond_2
    return-void
.end method
