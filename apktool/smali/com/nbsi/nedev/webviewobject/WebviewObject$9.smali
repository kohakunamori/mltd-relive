.class Lcom/nbsi/nedev/webviewobject/WebviewObject$9;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->destroy()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V
    .locals 0

    .line 668
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 669
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 670
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->removeView(Landroid/view/View;)V

    .line 674
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_1

    .line 675
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 676
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v1}, Landroid/webkit/WebView;->stopLoading()V

    .line 677
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 678
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 679
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/app/Activity;->unregisterForContextMenu(Landroid/view/View;)V

    .line 680
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->clearHistory()V

    .line 681
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->clearCache(Z)V

    .line 683
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    .line 684
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-object v2, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    :cond_1
    return-void
.end method
