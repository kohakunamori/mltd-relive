.class Lcom/nbsi/nedev/webviewobject/WebviewObject$6;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->LoadURL(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field final synthetic val$authstr:Ljava/lang/String;

.field final synthetic val$url:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 586
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$url:Ljava/lang/String;

    iput-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$authstr:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 588
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 589
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V

    .line 591
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    if-eqz v0, :cond_1

    .line 592
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$url:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->setErrorCheckURL(Ljava/lang/String;)V

    .line 596
    :cond_1
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$authstr:Ljava/lang/String;

    const/4 v1, 0x0

    if-nez v0, :cond_2

    .line 597
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-virtual {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->setAuthString(Ljava/lang/String;)Ljava/lang/String;

    goto :goto_0

    .line 600
    :cond_2
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$authstr:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->setAuthString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 601
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const-string v2, "Authorization"

    .line 602
    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 604
    :goto_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->customheader:Ljava/util/HashMap;

    if-eqz v0, :cond_4

    if-nez v1, :cond_3

    .line 606
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    move-object v1, v0

    .line 608
    :cond_3
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->customheader:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 609
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v3, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_4
    if-eqz v1, :cond_5

    .line 614
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$url:Ljava/lang/String;

    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;Ljava/util/Map;)V

    goto :goto_2

    .line 616
    :cond_5
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;->val$url:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :goto_2
    return-void
.end method
