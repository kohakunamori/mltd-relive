.class Lcom/nbsi/nedev/webviewobject/WebviewObject$4;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->SetVisibility(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field final synthetic val$visibility:Z


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Z)V
    .locals 0

    .line 392
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-boolean p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->val$visibility:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 394
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->val$visibility:Z

    if-eqz v0, :cond_1

    .line 395
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 396
    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/nbsi/nedev/webviewobject/WebviewObject;->access$000()Landroid/widget/RelativeLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->requestFocus()Z

    .line 397
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->requestFocus()Z

    goto :goto_0

    .line 400
    :cond_1
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V

    .line 401
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$4;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    :goto_0
    return-void
.end method
