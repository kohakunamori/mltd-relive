.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;
.super Ljava/lang/Object;
.source "WebviewObjectWebViewClient.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "receivedErrorRunnable2"
.end annotation


# instance fields
.field error:Landroid/webkit/WebResourceError;

.field request:Landroid/webkit/WebResourceRequest;

.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

.field view:Landroid/webkit/WebView;

.field wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Landroid/webkit/WebView;Landroid/webkit/WebResourceRequest;Landroid/webkit/WebResourceError;)V
    .locals 0

    .line 692
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 688
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 689
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->view:Landroid/webkit/WebView;

    .line 693
    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->wbclient:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    .line 694
    iput-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->view:Landroid/webkit/WebView;

    .line 695
    iput-object p4, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->request:Landroid/webkit/WebResourceRequest;

    .line 696
    iput-object p5, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$receivedErrorRunnable2;->error:Landroid/webkit/WebResourceError;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    return-void
.end method
