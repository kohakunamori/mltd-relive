.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;
.super Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;
.source "WebviewObjectWebViewClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 0

    .line 660
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct/range {p0 .. p5}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 665
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->request:Landroid/webkit/WebResourceRequest;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 666
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->request:Landroid/webkit/WebResourceRequest;

    invoke-interface {v0}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 669
    :goto_0
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->error:Landroid/webkit/WebResourceError;

    if-eqz v2, :cond_1

    .line 670
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->error:Landroid/webkit/WebResourceError;

    invoke-virtual {v2}, Landroid/webkit/WebResourceError;->getErrorCode()I

    move-result v2

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->error:Landroid/webkit/WebResourceError;

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3, v0}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onReceivedError(ILjava/lang/String;Ljava/lang/String;)Z

    move-result v0

    goto :goto_1

    .line 672
    :cond_1
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v2, v2, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    const/4 v3, -0x1

    invoke-interface {v2, v3, v1, v0}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onReceivedError(ILjava/lang/String;Ljava/lang/String;)Z

    move-result v0

    :goto_1
    if-nez v0, :cond_2

    .line 675
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->view:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->request:Landroid/webkit/WebResourceRequest;

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;->error:Landroid/webkit/WebResourceError;

    invoke-virtual {v0, v1, v2, v3}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onReceivedErrorSuper(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V

    :cond_2
    return-void
.end method
