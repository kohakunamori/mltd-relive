.class public Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;
.super Landroid/webkit/WebViewClient;
.source "WebviewObjectWebViewClient.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedHttpErrorRunnable;,
        Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;,
        Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable1;,
        Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable;,
        Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;
    }
.end annotation


# instance fields
.field final OpenBrowserQuery:Ljava/lang/String;

.field authpass:Ljava/lang/String;

.field authstr:Ljava/lang/String;

.field authuser:Ljava/lang/String;

.field errorCheckURI:Landroid/net/Uri;

.field errorCheckURL:Ljava/lang/String;

.field isURLCheck:Z

.field javascriptInterfaceName:Ljava/lang/String;

.field nativeInterface:Lcom/nbsi/nedev/webviewobject/NativeInterface;

.field schememap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;ZLjava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 62
    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    const/4 v0, 0x0

    .line 45
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    .line 46
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->nativeInterface:Lcom/nbsi/nedev/webviewobject/NativeInterface;

    .line 47
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->javascriptInterfaceName:Ljava/lang/String;

    .line 49
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    .line 50
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURI:Landroid/net/Uri;

    .line 55
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->schememap:Ljava/util/HashMap;

    const-string v1, "openbrowser=true"

    .line 57
    iput-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->OpenBrowserQuery:Ljava/lang/String;

    const/4 v1, 0x0

    .line 59
    iput-boolean v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->isURLCheck:Z

    .line 527
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authstr:Ljava/lang/String;

    .line 528
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authuser:Ljava/lang/String;

    .line 529
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authpass:Ljava/lang/String;

    .line 63
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    if-eqz p3, :cond_0

    .line 65
    new-instance p1, Lcom/nbsi/nedev/webviewobject/NativeInterface;

    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    invoke-direct {p1, v0}, Lcom/nbsi/nedev/webviewobject/NativeInterface;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;)V

    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->nativeInterface:Lcom/nbsi/nedev/webviewobject/NativeInterface;

    .line 66
    iput-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->javascriptInterfaceName:Ljava/lang/String;

    .line 68
    :cond_0
    iput-boolean p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->isURLCheck:Z

    .line 74
    invoke-direct {p0, p4}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->setURLScheme(Ljava/lang/String;)V

    return-void
.end method

.method private setURLScheme(Ljava/lang/String;)V
    .locals 7

    .line 85
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->schememap:Ljava/util/HashMap;

    if-eqz p1, :cond_1

    const-string v0, ";"

    .line 87
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 89
    array-length v0, p1

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    aget-object v3, p1, v2

    const-string v4, ":"

    .line 90
    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    const/4 v4, 0x2

    .line 91
    array-length v5, v3

    if-gt v4, v5, :cond_0

    .line 92
    iget-object v4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->schememap:Ljava/util/HashMap;

    aget-object v5, v3, v1

    const/4 v6, 0x1

    aget-object v3, v3, v6

    invoke-virtual {v4, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method private shouldInterceptRequestProc(Ljava/lang/String;Ljava/net/HttpURLConnection;)Landroid/webkit/WebResourceResponse;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 1

    .line 586
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 598
    new-instance p1, Ljava/lang/Thread;

    new-instance v0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$2;

    invoke-direct {v0, p0, p2}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$2;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Ljava/lang/String;)V

    invoke-direct {p1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 604
    invoke-virtual {p1}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 2

    .line 558
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->nativeInterface:Lcom/nbsi/nedev/webviewobject/NativeInterface;

    if-eqz v0, :cond_0

    .line 559
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->javascriptInterfaceName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    .line 560
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->nativeInterface:Lcom/nbsi/nedev/webviewobject/NativeInterface;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->javascriptInterfaceName:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 562
    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    .line 564
    new-instance p1, Ljava/lang/Thread;

    new-instance p3, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$1;

    invoke-direct {p3, p0, p2}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$1;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Ljava/lang/String;)V

    invoke-direct {p1, p3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 570
    invoke-virtual {p1}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 9

    const/16 v0, 0x191

    if-ne p2, v0, :cond_0

    .line 613
    invoke-super {p0, p1, p2, p3, p4}, Landroid/webkit/WebViewClient;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    return-void

    .line 617
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    invoke-virtual {v0, p4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 618
    new-instance v0, Ljava/lang/Thread;

    new-instance v8, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p0

    move-object v4, p1

    move v5, p2

    move-object v6, p3

    move-object v7, p4

    invoke-direct/range {v1 .. v7}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$3;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    invoke-direct {v0, v8}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 625
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    :cond_1
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 8
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    .line 660
    new-instance v0, Ljava/lang/Thread;

    new-instance v7, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;

    move-object v1, v7

    move-object v2, p0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$4;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V

    invoke-direct {v0, v7}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 679
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public onReceivedErrorSuper(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 630
    invoke-super {p0, p1, p2, p3, p4}, Landroid/webkit/WebViewClient;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onReceivedErrorSuper(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 0
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    .line 684
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onReceivedError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V

    return-void
.end method

.method public onReceivedHttpAuthRequest(Landroid/webkit/WebView;Landroid/webkit/HttpAuthHandler;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 524
    iget-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authuser:Ljava/lang/String;

    iget-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authpass:Ljava/lang/String;

    invoke-virtual {p2, p1, p3}, Landroid/webkit/HttpAuthHandler;->proceed(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .locals 8
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    .line 709
    invoke-virtual {p3}, Landroid/webkit/WebResourceResponse;->getStatusCode()I

    move-result v0

    const/16 v1, 0x191

    if-ne v0, v1, :cond_0

    .line 710
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V

    return-void

    .line 714
    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v7, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;

    move-object v1, v7

    move-object v2, p0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$5;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V

    invoke-direct {v0, v7}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 737
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method public onReceivedHttpErrorSuper(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V
    .locals 0
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    .line 742
    invoke-super {p0, p1, p2, p3}, Landroid/webkit/WebViewClient;->onReceivedHttpError(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceResponse;)V

    return-void
.end method

.method public setAuthString(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    if-eqz p1, :cond_0

    const-string v0, ":"

    .line 532
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 533
    array-length v1, v0

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    .line 534
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Basic "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-static {p1, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authstr:Ljava/lang/String;

    const/4 p1, 0x0

    .line 535
    aget-object p1, v0, p1

    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authuser:Ljava/lang/String;

    const/4 p1, 0x1

    .line 536
    aget-object p1, v0, p1

    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authpass:Ljava/lang/String;

    .line 537
    iget-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authstr:Ljava/lang/String;

    return-object p1

    :cond_0
    const/4 p1, 0x0

    .line 540
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authstr:Ljava/lang/String;

    .line 541
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authuser:Ljava/lang/String;

    .line 542
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->authpass:Ljava/lang/String;

    return-object p1
.end method

.method public setErrorCheckURL(Ljava/lang/String;)V
    .locals 0

    .line 102
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    .line 103
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURI:Landroid/net/Uri;

    return-void
.end method

.method public shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0x15
    .end annotation

    .line 285
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->isURLCheck:Z

    if-nez v0, :cond_0

    .line 286
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->shouldInterceptRequest(Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;)Landroid/webkit/WebResourceResponse;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    .line 290
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getUrl()Landroid/net/Uri;

    move-result-object v0

    .line 293
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURI:Landroid/net/Uri;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURI:Landroid/net/Uri;

    invoke-virtual {v1, v0}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 296
    :try_start_0
    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    .line 297
    new-instance v2, Ljava/net/URL;

    invoke-direct {v2, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 298
    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v2

    check-cast v2, Ljava/net/HttpURLConnection;

    .line 299
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getMethod()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 301
    invoke-virtual {v2, v3}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const-string v3, "https"

    .line 305
    invoke-virtual {v0}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 309
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xd

    if-le v0, v3, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x13

    if-ge v0, v3, :cond_1

    const-string v0, "Connection"

    const-string v3, "close"

    .line 311
    invoke-virtual {v2, v0, v3}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 315
    :cond_1
    invoke-interface {p2}, Landroid/webkit/WebResourceRequest;->getRequestHeaders()Ljava/util/Map;

    move-result-object p2

    if-eqz p2, :cond_2

    .line 318
    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 320
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v2, v3, v0}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 324
    :cond_2
    invoke-direct {p0, v1, v2}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->shouldInterceptRequestProc(Ljava/lang/String;Ljava/net/HttpURLConnection;)Landroid/webkit/WebResourceResponse;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, p2

    :catch_0
    :cond_3
    return-object p1
.end method

.method public shouldInterceptRequest(Landroid/webkit/WebView;Ljava/lang/String;)Landroid/webkit/WebResourceResponse;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 259
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->isURLCheck:Z

    if-nez v0, :cond_0

    .line 260
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->shouldInterceptRequest(Landroid/webkit/WebView;Ljava/lang/String;)Landroid/webkit/WebResourceResponse;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    .line 264
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->errorCheckURL:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 267
    :try_start_0
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 268
    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 269
    invoke-direct {p0, p2, v0}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->shouldInterceptRequestProc(Ljava/lang/String;Ljava/net/HttpURLConnection;)Landroid/webkit/WebResourceResponse;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, p2

    :catch_0
    :cond_1
    return-object p1
.end method

.method public shouldOverrideUrlCheck(Ljava/lang/String;)Z
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "?"

    .line 135
    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-lez v2, :cond_0

    .line 137
    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, p1

    :goto_0
    const-string v3, "UTF-8"

    .line 143
    invoke-static {v2, v3}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/webkit/MimeTypeMap;->getFileExtensionFromUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_1

    .line 146
    :try_start_1
    invoke-static {}, Landroid/webkit/MimeTypeMap;->getSingleton()Landroid/webkit/MimeTypeMap;

    move-result-object v3

    .line 147
    invoke-virtual {v3, v2}, Landroid/webkit/MimeTypeMap;->getMimeTypeFromExtension(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3
    :try_end_1
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v0, v3

    goto :goto_1

    :catch_0
    move-object v2, v0

    .line 152
    :catch_1
    :cond_1
    :goto_1
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v3

    const v4, 0x1b0f2

    const/4 v5, -0x1

    if-eq v3, v4, :cond_2

    goto :goto_2

    :cond_2
    const-string v3, "pdf"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    const/4 v2, 0x0

    goto :goto_3

    :cond_3
    :goto_2
    const/4 v2, -0x1

    :goto_3
    const/4 v3, 0x1

    if-eqz v2, :cond_e

    const-string v0, "https://play.google.com/store/apps"

    .line 169
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 170
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 171
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const-string p1, "com.android.vending"

    .line 172
    invoke-virtual {v0, p1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 173
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 174
    invoke-virtual {p1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return v3

    :cond_4
    const-string v0, ":"

    .line 178
    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_b

    .line 179
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->schememap:Ljava/util/HashMap;

    aget-object v4, v0, v1

    invoke-virtual {v2, v4}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 180
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->schememap:Ljava/util/HashMap;

    aget-object v4, v0, v1

    invoke-virtual {v2, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 181
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v4

    const v6, 0x17a21

    if-eq v4, v6, :cond_6

    const v6, 0x5c13d641

    if-eq v4, v6, :cond_5

    goto :goto_4

    :cond_5
    const-string v4, "default"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    const/4 v2, 0x0

    goto :goto_5

    :cond_6
    const-string v4, "app"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    const/4 v2, 0x1

    goto :goto_5

    :cond_7
    :goto_4
    const/4 v2, -0x1

    :goto_5
    packed-switch v2, :pswitch_data_0

    goto/16 :goto_7

    .line 209
    :pswitch_0
    iget-object v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    aget-object v0, v0, v1

    invoke-interface {v2, v0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->overrideUrl(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1

    .line 183
    :pswitch_1
    aget-object v2, v0, v1

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v4

    const v6, -0x40777d8e

    if-eq v4, v6, :cond_9

    const v6, 0x8ff2b28

    if-eq v4, v6, :cond_8

    goto :goto_6

    :cond_8
    const-string v4, "browser"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    const/4 v5, 0x1

    goto :goto_6

    :cond_9
    const-string v4, "mailto"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_a

    const/4 v5, 0x0

    :cond_a
    :goto_6
    packed-switch v5, :pswitch_data_1

    .line 199
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 200
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 201
    invoke-virtual {p1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return v3

    .line 191
    :pswitch_2
    aget-object v0, v0, v1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/2addr v0, v3

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    .line 193
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 194
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 195
    invoke-virtual {p1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return v3

    .line 185
    :pswitch_3
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.SENDTO"

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 186
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 187
    invoke-virtual {p1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return v3

    :cond_b
    if-eqz v0, :cond_d

    .line 221
    aget-object v2, v0, v1

    const-string v4, "http"

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_c

    aget-object v0, v0, v1

    const-string v2, "https"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_d

    .line 224
    :cond_c
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    if-eqz p1, :cond_d

    .line 226
    invoke-virtual {p1}, Landroid/net/Uri;->getQuery()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_d

    const-string v2, "openbrowser=true"

    .line 229
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_d

    .line 230
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 231
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 232
    invoke-virtual {p1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    return v3

    :cond_d
    :goto_7
    return v1

    .line 156
    :cond_e
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 157
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    .line 159
    invoke-virtual {v1, p1, v0}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 160
    sget-object p1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 162
    :try_start_2
    invoke-virtual {p1, v1}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catch Landroid/content/ActivityNotFoundException; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return v3

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 0

    .line 110
    invoke-virtual {p0, p2}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->shouldOverrideUrlCheck(Ljava/lang/String;)Z

    move-result p1

    return p1
.end method
