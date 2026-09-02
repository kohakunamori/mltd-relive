.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$1;
.super Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable;
.source "WebviewObjectWebViewClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Ljava/lang/String;)V
    .locals 0

    .line 564
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct {p0, p1, p2}, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable;-><init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 568
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$1;->str:Ljava/lang/String;

    invoke-interface {v0, v1}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onPageStarted(Ljava/lang/String;)V

    return-void
.end method
