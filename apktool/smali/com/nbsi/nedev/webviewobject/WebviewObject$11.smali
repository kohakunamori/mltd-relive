.class Lcom/nbsi/nedev/webviewobject/WebviewObject$11;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;->SetAppCache(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field final synthetic val$_cachePath:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;Ljava/lang/String;)V
    .locals 0

    .line 722
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$11;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$11;->val$_cachePath:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 724
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$11;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->mWebview:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v0

    .line 725
    iget-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$11;->val$_cachePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAppCachePath(Ljava/lang/String;)V

    const/4 v1, 0x1

    .line 726
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAppCacheEnabled(Z)V

    return-void
.end method
