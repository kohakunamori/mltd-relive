.class public Lcom/nbsi/nedev/webviewobject/WebviewObject;
.super Ljava/lang/Object;
.source "WebviewObject.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;
    }
.end annotation


# static fields
.field private static globallayout:Landroid/widget/RelativeLayout;


# instance fields
.field customheader:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field isInitComplete:Z

.field mWebview:Landroid/webkit/WebView;

.field padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

.field private resize_tmp:Landroid/graphics/Rect;

.field private scr_h_tmp:I

.field private scr_w_tmp:I

.field unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

.field webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 69
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 39
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    .line 42
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    const/4 v1, 0x0

    .line 43
    iput-boolean v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->isInitComplete:Z

    .line 45
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 47
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->customheader:Ljava/util/HashMap;

    .line 62
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    .line 65
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    .line 66
    iput v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->scr_w_tmp:I

    .line 67
    iput v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->scr_h_tmp:I

    return-void
.end method

.method public static RemoveAllCookie()V
    .locals 2

    .line 342
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 343
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$2;

    invoke-direct {v1}, Lcom/nbsi/nedev/webviewobject/WebviewObject$2;-><init>()V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$000()Landroid/widget/RelativeLayout;
    .locals 1

    .line 37
    sget-object v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->globallayout:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method static synthetic access$002(Landroid/widget/RelativeLayout;)Landroid/widget/RelativeLayout;
    .locals 0

    .line 37
    sput-object p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->globallayout:Landroid/widget/RelativeLayout;

    return-object p0
.end method

.method static synthetic access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;
    .locals 0

    .line 37
    iget-object p0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    return-object p0
.end method

.method static synthetic access$102(Lcom/nbsi/nedev/webviewobject/WebviewObject;Landroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 0

    .line 37
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    return-object p1
.end method

.method static synthetic access$202(Lcom/nbsi/nedev/webviewobject/WebviewObject;I)I
    .locals 0

    .line 37
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->scr_w_tmp:I

    return p1
.end method

.method static synthetic access$302(Lcom/nbsi/nedev/webviewobject/WebviewObject;I)I
    .locals 0

    .line 37
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->scr_h_tmp:I

    return p1
.end method

.method public static createWebviewObject()Lcom/nbsi/nedev/webviewobject/WebviewObject;
    .locals 1

    .line 74
    new-instance v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-direct {v0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;-><init>()V

    return-object v0
.end method

.method public static getRealDisplaySize()Landroid/graphics/Point;
    .locals 3

    .line 490
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0}, Landroid/graphics/Point;-><init>()V

    .line 507
    sget-object v1, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 515
    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    const v2, 0x1020002

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .line 517
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getWidth()I

    move-result v2

    iput v2, v0, Landroid/graphics/Point;->x:I

    .line 518
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getHeight()I

    move-result v1

    iput v1, v0, Landroid/graphics/Point;->y:I

    return-object v0
.end method


# virtual methods
.method public ClearCache()V
    .locals 2

    .line 736
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 737
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$12;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$12;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public ClearRequestHeader()V
    .locals 1

    .line 547
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->customheader:Ljava/util/HashMap;

    return-void
.end method

.method public EvaluateJS(Ljava/lang/String;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .line 697
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 698
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 699
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$10;

    invoke-direct {v1, p0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObject$10;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public ForceInvisibility()V
    .locals 2

    .line 370
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 372
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 373
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$3;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$3;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public Invalidate()V
    .locals 2

    .line 826
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 827
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$17;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$17;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public LoadURL(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 559
    invoke-virtual {p0, p1, v0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->LoadURL(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public LoadURL(Ljava/lang/String;Ljava/lang/String;)V
    .locals 9

    if-nez p1, :cond_0

    return-void

    .line 566
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    if-eqz v0, :cond_1

    .line 570
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Landroid/widget/RelativeLayout$LayoutParams;

    .line 571
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    iput v0, v2, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 572
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->top:I

    iput v0, v2, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 573
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    sub-int/2addr v0, v1

    iput v0, v2, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 574
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->top:I

    sub-int/2addr v0, v1

    iput v0, v2, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 575
    iget v3, v2, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    iget v4, v2, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    iget v5, v2, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    iget v6, v2, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    iget v7, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->scr_w_tmp:I

    iget v8, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->scr_h_tmp:I

    move-object v1, p0

    invoke-virtual/range {v1 .. v8}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->setWebviewSize(Landroid/widget/RelativeLayout$LayoutParams;IIIIII)V

    const/4 v0, 0x0

    .line 576
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize_tmp:Landroid/graphics/Rect;

    .line 579
    :cond_1
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    if-eqz v0, :cond_2

    .line 581
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->webviewclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-virtual {v0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->shouldOverrideUrlCheck(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return-void

    .line 585
    :cond_2
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 586
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;

    invoke-direct {v1, p0, p1, p2}, Lcom/nbsi/nedev/webviewobject/WebviewObject$6;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public Reload()V
    .locals 2

    .line 815
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 816
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$16;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$16;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public SetAppCache(Ljava/lang/String;)V
    .locals 2

    .line 721
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 722
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$11;

    invoke-direct {v1, p0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObject$11;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public SetBackgroundColor(I)V
    .locals 1

    .line 750
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 751
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0, p1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    :cond_0
    return-void
.end method

.method public SetBounces(Z)V
    .locals 2

    .line 783
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 784
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;

    invoke-direct {v1, p0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Z)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public SetRequestHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 551
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->customheader:Ljava/util/HashMap;

    if-nez v0, :cond_0

    .line 552
    invoke-virtual {p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->ClearRequestHeader()V

    .line 555
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->customheader:Ljava/util/HashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public SetTransparent(Z)V
    .locals 2

    .line 761
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 762
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;

    invoke-direct {v1, p0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Z)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public SetVisibility(Z)V
    .locals 2

    .line 389
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 391
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 392
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;

    invoke-direct {v1, p0, p1}, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Z)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public StopLoading()V
    .locals 2

    .line 801
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 802
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$15;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$15;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public destroy()V
    .locals 2

    .line 666
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 667
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 668
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$9;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public isInitComplete()Z
    .locals 1

    .line 660
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->isInitComplete:Z

    return v0
.end method

.method public onPause()V
    .locals 2

    .line 636
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 637
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 638
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$7;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$7;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public onResume()V
    .locals 2

    .line 646
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 647
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 648
    new-instance v1, Lcom/nbsi/nedev/webviewobject/WebviewObject$8;

    invoke-direct {v1, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$8;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public resize(IIIIII)V
    .locals 10

    .line 421
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 422
    new-instance v9, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;

    move-object v1, v9

    move-object v2, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move v7, p5

    move/from16 v8, p6

    invoke-direct/range {v1 .. v8}, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;IIIIII)V

    invoke-virtual {v0, v9}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setDisplayPos(IIIIII)V
    .locals 8

    const/4 v7, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    .line 97
    invoke-virtual/range {v0 .. v7}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->setDisplayPos(IIIIIILcom/nbsi/nedev/webviewobject/WebviewObjectSettings;)V

    return-void
.end method

.method public setDisplayPos(IIIIIILcom/nbsi/nedev/webviewobject/WebviewObjectSettings;)V
    .locals 11
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    .line 111
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    .line 112
    new-instance v10, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;

    move-object v1, v10

    move-object v2, p0

    move-object/from16 v3, p7

    move v4, p3

    move v5, p4

    move v6, p1

    move v7, p2

    move/from16 v8, p5

    move/from16 v9, p6

    invoke-direct/range {v1 .. v9}, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;IIIIII)V

    invoke-virtual {v0, v10}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setListener(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;)V
    .locals 0

    .line 85
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    return-void
.end method

.method public setPadding(IIII)V
    .locals 1

    .line 624
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    if-nez v0, :cond_0

    .line 625
    new-instance v0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    invoke-direct {v0, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    .line 627
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iput p1, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->left:I

    .line 628
    iget-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iput p2, p1, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->top:I

    .line 629
    iget-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iput p3, p1, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->right:I

    .line 630
    iget-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iput p4, p1, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->bottom:I

    return-void
.end method

.method public setWebviewSize(Landroid/widget/RelativeLayout$LayoutParams;IIIIII)V
    .locals 2

    .line 472
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    if-nez v0, :cond_0

    .line 473
    new-instance v0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    invoke-direct {v0, p0}, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V

    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    .line 475
    :cond_0
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->getRealDisplaySize()Landroid/graphics/Point;

    move-result-object v0

    int-to-float p6, p6

    .line 476
    iget v1, v0, Landroid/graphics/Point;->x:I

    int-to-float v1, v1

    div-float/2addr p6, v1

    int-to-float p7, p7

    .line 477
    iget v0, v0, Landroid/graphics/Point;->y:I

    int-to-float v0, v0

    div-float/2addr p7, v0

    .line 482
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iget v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->left:I

    add-int/2addr p2, v0

    int-to-float p2, p2

    div-float/2addr p2, p6

    float-to-int p2, p2

    iput p2, p1, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 483
    iget-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iget p2, p2, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->top:I

    add-int/2addr p3, p2

    int-to-float p2, p3

    div-float/2addr p2, p7

    float-to-int p2, p2

    iput p2, p1, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 484
    iget-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iget p2, p2, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->left:I

    iget-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iget p3, p3, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->right:I

    add-int/2addr p2, p3

    sub-int/2addr p4, p2

    int-to-float p2, p4

    div-float/2addr p2, p6

    float-to-int p2, p2

    iput p2, p1, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 485
    iget-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iget p2, p2, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->top:I

    iget-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->padding:Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;

    iget p3, p3, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->bottom:I

    add-int/2addr p2, p3

    sub-int/2addr p5, p2

    int-to-float p2, p5

    div-float/2addr p2, p7

    float-to-int p2, p2

    iput p2, p1, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    return-void
.end method
