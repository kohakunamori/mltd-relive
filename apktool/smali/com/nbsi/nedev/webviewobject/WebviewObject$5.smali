.class Lcom/nbsi/nedev/webviewobject/WebviewObject$5;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->resize(IIIIII)V
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

.field final synthetic val$width:I


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;IIIIII)V
    .locals 0

    .line 422
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posx:I

    iput p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posy:I

    iput p4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$width:I

    iput p5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$height:I

    iput p6, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$scr_width:I

    iput p7, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$scr_height:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    .line 426
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 431
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout$LayoutParams;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    .line 435
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    invoke-static {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$102(Lcom/nbsi/nedev/webviewobject/WebviewObject;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    .line 436
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v0

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posx:I

    iput v1, v0, Landroid/graphics/Rect;->left:I

    .line 437
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v0

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posy:I

    iput v1, v0, Landroid/graphics/Rect;->top:I

    .line 438
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v0

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posx:I

    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$width:I

    add-int/2addr v1, v2

    iput v1, v0, Landroid/graphics/Rect;->right:I

    .line 439
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-static {v0}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$100(Lcom/nbsi/nedev/webviewobject/WebviewObject;)Landroid/graphics/Rect;

    move-result-object v0

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posy:I

    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$height:I

    add-int/2addr v1, v2

    iput v1, v0, Landroid/graphics/Rect;->bottom:I

    .line 441
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$scr_width:I

    invoke-static {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$202(Lcom/nbsi/nedev/webviewobject/WebviewObject;I)I

    .line 442
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$scr_height:I

    invoke-static {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$302(Lcom/nbsi/nedev/webviewobject/WebviewObject;I)I

    return-void

    .line 446
    :cond_1
    iget v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posx:I

    if-ne v1, v2, :cond_2

    iget v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posy:I

    if-ne v1, v2, :cond_2

    iget v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    iget v2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$width:I

    if-ne v1, v2, :cond_2

    iget v0, v0, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    iget v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$height:I

    if-eq v0, v1, :cond_3

    .line 451
    :cond_2
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout$LayoutParams;

    .line 452
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget v3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posx:I

    iget v4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$posy:I

    iget v5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$width:I

    iget v6, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$height:I

    iget v7, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$scr_width:I

    iget v8, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->val$scr_height:I

    move-object v2, v0

    invoke-virtual/range {v1 .. v8}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->setWebviewSize(Landroid/widget/RelativeLayout$LayoutParams;IIIIII)V

    .line 463
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v1, v1, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 464
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$5;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->invalidate()V

    :cond_3
    return-void
.end method
