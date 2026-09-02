.class Lcom/nbsi/nedev/webviewobject/WebviewObject$13;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->SetTransparent(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field final synthetic val$isTrans:Z


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Z)V
    .locals 0

    .line 762
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-boolean p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;->val$isTrans:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 764
    iget-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;->val$isTrans:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 766
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/4 v2, 0x0

    invoke-static {v1, v2, v2, v2}, Landroid/graphics/Color;->argb(IIII)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    goto :goto_0

    .line 768
    :cond_0
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$13;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    const/16 v1, 0xff

    invoke-static {v1, v1, v1, v1}, Landroid/graphics/Color;->argb(IIII)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    :goto_0
    return-void
.end method
