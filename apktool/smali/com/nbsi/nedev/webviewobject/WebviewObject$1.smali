.class Lcom/nbsi/nedev/webviewobject/WebviewObject$1;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->setDisplayPos(IIIIIILcom/nbsi/nedev/webviewobject/WebviewObjectSettings;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field final synthetic val$height:I

.field final synthetic val$posx:I

.field final synthetic val$posy:I

.field final synthetic val$scr_height:I

.field final synthetic val$scr_width:I

.field final synthetic val$usersettings:Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;

.field final synthetic val$width:I


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;IIIIII)V
    .locals 0

    .line 112
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$usersettings:Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;

    iput p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$width:I

    iput p4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$height:I

    iput p5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$posx:I

    iput p6, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$posy:I

    iput p7, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$scr_width:I

    iput p8, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$scr_height:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 13

    .line 116
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 119
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 120
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v1

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v1, v3}, Landroid/widget/RelativeLayout;->removeView(Landroid/view/View;)V

    .line 121
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-object v2, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    .line 123
    :cond_0
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    new-instance v3, Lcom/nbsi/nedev/webviewobject/OverrideWebView;

    invoke-direct {v3, v0}, Lcom/nbsi/nedev/webviewobject/OverrideWebView;-><init>(Landroid/content/Context;)V

    iput-object v3, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    .line 127
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$usersettings:Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;

    if-nez v1, :cond_1

    .line 131
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;

    invoke-direct {v1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;-><init>()V

    .line 134
    :cond_1
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    if-eqz v3, :cond_2

    .line 135
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    new-instance v4, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v5, v5, Lcom/nbsi/nedev/webviewobject/WebviewObject;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    iget-boolean v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isCheckURL:Z

    iget-object v7, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->javascriptInterfaceName:Ljava/lang/String;

    iget-object v8, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->overrideURLScheme:Ljava/lang/String;

    invoke-direct {v4, v5, v6, v7, v8}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;ZLjava/lang/String;Ljava/lang/String;)V

    iput-object v4, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 136
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-object v4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v4, v4, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 137
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    new-instance v4, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebChromeClient;

    iget-object v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v5, v5, Lcom/nbsi/nedev/webviewobject/WebviewObject;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    invoke-direct {v4, v5}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebChromeClient;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;)V

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    .line 142
    :cond_2
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setFocusable(Z)V

    .line 143
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setFocusableInTouchMode(Z)V

    .line 146
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->OverScrollMode:I

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setOverScrollMode(I)V

    .line 147
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-boolean v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isHorizontalFadingEdgeEnabled:Z

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setHorizontalFadingEdgeEnabled(Z)V

    .line 148
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-boolean v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isVerticalFadingEdgeEnabled:Z

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setVerticalFadingEdgeEnabled(Z)V

    .line 151
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-boolean v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isHorizontalScrollBarEnabled:Z

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setHorizontalScrollBarEnabled(Z)V

    .line 152
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    iget-boolean v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isVerticalScrollBarEnabled:Z

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setVerticalScrollBarEnabled(Z)V

    .line 155
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v5, 0x0

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setHovered(Z)V

    .line 156
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setLongClickable(Z)V

    .line 157
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v3, v5}, Landroid/webkit/WebView;->setHapticFeedbackEnabled(Z)V

    .line 160
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v3

    .line 161
    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 162
    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 164
    iget-boolean v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isDomStorageEnable:Z

    if-eqz v6, :cond_3

    .line 165
    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 170
    :cond_3
    iget-boolean v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isUseWideViewPort:Z

    invoke-virtual {v3, v6}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V

    .line 171
    iget-boolean v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isLoadWithOverviewMode:Z

    invoke-virtual {v3, v6}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V

    .line 174
    iget-boolean v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isZoomSupport:Z

    if-eqz v6, :cond_4

    .line 175
    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 176
    invoke-virtual {v3, v5}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    .line 180
    :cond_4
    iget-object v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->replaceUserAgent:Ljava/lang/String;

    if-eqz v5, :cond_5

    iget-object v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->replaceUserAgent:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_5

    .line 182
    iget-object v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->replaceUserAgent:Ljava/lang/String;

    goto :goto_0

    .line 186
    :cond_5
    invoke-virtual {v3}, Landroid/webkit/WebSettings;->getUserAgentString()Ljava/lang/String;

    move-result-object v5

    .line 189
    :goto_0
    iget-object v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->prefixUserAgent:Ljava/lang/String;

    if-eqz v6, :cond_6

    .line 190
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->prefixUserAgent:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 192
    :cond_6
    iget-object v6, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->suffixUserAgent:Ljava/lang/String;

    if-eqz v6, :cond_7

    .line 193
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->suffixUserAgent:Ljava/lang/String;

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 195
    :cond_7
    invoke-virtual {v3, v5}, Landroid/webkit/WebSettings;->setUserAgentString(Ljava/lang/String;)V

    .line 198
    iget-boolean v5, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isClearCache:Z

    if-eqz v5, :cond_8

    .line 199
    iget-object v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v5, v5, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v5, v4}, Landroid/webkit/WebView;->clearCache(Z)V

    .line 201
    :cond_8
    invoke-virtual {v3, v4}, Landroid/webkit/WebSettings;->setAppCacheEnabled(Z)V

    const/16 v3, 0x15

    .line 204
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-gt v3, v5, :cond_9

    .line 205
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/webkit/CookieManager;->removeAllCookies(Landroid/webkit/ValueCallback;)V

    .line 206
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/webkit/CookieManager;->flush()V

    goto :goto_1

    .line 208
    :cond_9
    invoke-static {v0}, Landroid/webkit/CookieSyncManager;->createInstance(Landroid/content/Context;)Landroid/webkit/CookieSyncManager;

    move-result-object v3

    .line 209
    invoke-virtual {v3}, Landroid/webkit/CookieSyncManager;->startSync()V

    .line 210
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;

    move-result-object v5

    .line 211
    invoke-virtual {v5}, Landroid/webkit/CookieManager;->removeAllCookie()V

    .line 212
    invoke-virtual {v5}, Landroid/webkit/CookieManager;->removeSessionCookie()V

    .line 213
    invoke-virtual {v3}, Landroid/webkit/CookieSyncManager;->stopSync()V

    .line 214
    invoke-virtual {v3}, Landroid/webkit/CookieSyncManager;->sync()V

    .line 249
    :goto_1
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v3

    if-nez v3, :cond_a

    .line 252
    new-instance v3, Landroid/widget/RelativeLayout;

    invoke-direct {v3, v0}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    invoke-static {v3}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$002(Landroid/widget/RelativeLayout;)Landroid/widget/RelativeLayout;

    .line 253
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v3

    new-instance v5, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v6, -0x1

    invoke-direct {v5, v6, v6}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v3, v5}, Landroid/app/Activity;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 254
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/RelativeLayout;->setFocusable(Z)V

    .line 255
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroid/widget/RelativeLayout;->setFocusableInTouchMode(Z)V

    .line 259
    :cond_a
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    iget v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$width:I

    iget v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$height:I

    invoke-direct {v0, v3, v5}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 260
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v3}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v3

    if-eqz v3, :cond_b

    .line 262
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v3}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->left:I

    iput v3, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 263
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v3}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->top:I

    iput v3, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 264
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v3}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->right:I

    iget-object v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v5}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Rect;->left:I

    sub-int/2addr v3, v5

    iput v3, v0, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 265
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v3}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Rect;->bottom:I

    iget-object v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v5}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Rect;->top:I

    sub-int/2addr v3, v5

    iput v3, v0, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 268
    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v3, v2}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$102(Lcom/nbsi/nedev/webviewobject/WebviewObject;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    goto :goto_2

    .line 271
    :cond_b
    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$posx:I

    iput v2, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 272
    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$posy:I

    iput v2, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 275
    :goto_2
    invoke-static {v4}, Ljava/net/HttpURLConnection;->setFollowRedirects(Z)V

    .line 278
    iget-object v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget v7, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    iget v8, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    iget v9, v0, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    iget v10, v0, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    iget v11, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$scr_width:I

    iget v12, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->val$scr_height:I

    move-object v6, v0

    invoke-virtual/range {v5 .. v12}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->setWebviewSize(Landroid/widget/RelativeLayout$LayoutParams;IIIIII)V

    .line 282
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v3, v3, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v2, v3, v0}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 285
    iget-boolean v0, v1, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isInitWithWindwShow:Z

    if-nez v0, :cond_c

    .line 286
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 289
    :cond_c
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-boolean v4, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->isInitComplete:Z

    .line 292
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$1$1;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$1$1;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject$1;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 297
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method
