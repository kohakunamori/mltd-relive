.class Lcom/nbsi/nedev/webviewobject/WebviewObject$17;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->Invalidate()V
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

    .line 827
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$17;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 829
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$17;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 830
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$17;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->invalidate()V

    :cond_0
    return-void
.end method
