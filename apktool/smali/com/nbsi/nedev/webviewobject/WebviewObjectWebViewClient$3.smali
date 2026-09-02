.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;
.super Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;
.source "WebviewObjectWebViewClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 618
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct/range {p0 .. p6}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 621
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->errorCode:I

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->description:Ljava/lang/String;

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->failingUrl:Ljava/lang/String;

    invoke-interface {v0, v1, v2, v3}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onReceivedError(ILjava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 622
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->view:Landroid/webkit/WebView;

    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->errorCode:I

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->description:Ljava/lang/String;

    iget-object v4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;->failingUrl:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onReceivedErrorSuper(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
