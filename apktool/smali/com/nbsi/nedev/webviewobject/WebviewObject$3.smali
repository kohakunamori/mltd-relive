.class Lcom/nbsi/nedev/webviewobject/WebviewObject$3;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->ForceInvisibility()V
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

    .line 373
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$3;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 375
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$3;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    .line 376
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$3;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V

    .line 377
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$3;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    :cond_0
    return-void
.end method
