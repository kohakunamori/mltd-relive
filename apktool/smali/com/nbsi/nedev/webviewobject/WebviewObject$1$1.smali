.class Lcom/nbsi/nedev/webviewobject/WebviewObject$1$1;
.super Ljava/lang/Object;
.source "WebviewObject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/nbsi/nedev/webviewobject/WebviewObject$1;


# direct methods
.method constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject$1;)V
    .locals 0

    .line 292
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1$1;->this$1:Lcom/nbsi/nedev/webviewobject/WebviewObject$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 295
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1$1;->this$1:Lcom/nbsi/nedev/webviewobject/WebviewObject$1;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject$1;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    iget-object v0, v0, Lcom/nbsi/nedev/webviewobject/WebviewObject;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    invoke-interface {v0}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->onInitComplete()V

    return-void
.end method
