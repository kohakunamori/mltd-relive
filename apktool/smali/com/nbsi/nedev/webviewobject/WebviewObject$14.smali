.class Lcom/nbsi/nedev/webviewobject/WebviewObject$14;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->SetBounces(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field final synthetic val$isBounce:Z


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Z)V
    .locals 0

    .line 784
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-boolean p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;->val$isBounce:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 787
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;->val$isBounce:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 788
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setOverScrollMode(I)V

    goto :goto_0

    .line 790
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$14;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setOverScrollMode(I)V

    :goto_0
    return-void
.end method
