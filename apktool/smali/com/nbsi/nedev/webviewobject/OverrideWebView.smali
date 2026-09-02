.class public Lcom/nbsi/nedev/webviewobject/OverrideWebView;
.super Landroid/webkit/WebView;
.source "OverrideWebView.java"


# instance fields
.field isTouchDown:Z

.field last_dY:F

.field oldY:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 19
    invoke-direct {p0, p1}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    .line 35
    iput-boolean p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->isTouchDown:Z

    const/4 p1, 0x1

    .line 36
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->oldY:F

    const/4 p1, 0x0

    .line 37
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .line 23
    invoke-direct {p0, p1, p2}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    .line 35
    iput-boolean p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->isTouchDown:Z

    const/4 p1, 0x1

    .line 36
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->oldY:F

    const/4 p1, 0x0

    .line 37
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    .line 27
    invoke-direct {p0, p1, p2, p3}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    .line 35
    iput-boolean p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->isTouchDown:Z

    const/4 p1, 0x1

    .line 36
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->oldY:F

    const/4 p1, 0x0

    .line 37
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    return-void
.end method


# virtual methods
.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 2

    .line 43
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const/4 v0, 0x0

    .line 50
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->isTouchDown:Z

    .line 53
    :pswitch_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    .line 54
    iget v1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->oldY:F

    cmpl-float v1, v0, v1

    if-eqz v1, :cond_0

    .line 55
    iget v1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->oldY:F

    sub-float/2addr v1, v0

    iput v1, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    goto :goto_0

    .line 45
    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    iput v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->oldY:F

    const/4 v0, 0x0

    .line 46
    iput v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    const/4 v0, 0x1

    .line 47
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->isTouchDown:Z

    .line 60
    :cond_0
    :goto_0
    invoke-super {p0, p1}, Landroid/webkit/WebView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected overScrollBy(IIIIIIIIZ)Z
    .locals 2

    .line 66
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->isTouchDown:Z

    if-nez v0, :cond_2

    iget v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    const/4 v1, 0x0

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_2

    if-gez p2, :cond_0

    .line 67
    iget v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    cmpg-float v0, v1, v0

    if-ltz v0, :cond_1

    :cond_0
    if-lez p2, :cond_2

    iget v0, p0, Lcom/nbsi/nedev/webviewobject/OverrideWebView;->last_dY:F

    cmpg-float v0, v0, v1

    if-gez v0, :cond_2

    :cond_1
    const/4 p1, 0x1

    return p1

    .line 73
    :cond_2
    invoke-super/range {p0 .. p9}, Landroid/webkit/WebView;->overScrollBy(IIIIIIIIZ)Z

    move-result p1

    return p1
.end method
