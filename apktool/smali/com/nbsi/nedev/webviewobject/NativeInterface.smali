.class public Lcom/nbsi/nedev/webviewobject/NativeInterface;
.super Ljava/lang/Object;
.source "NativeInterface.java"


# instance fields
.field unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;)V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 7
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/NativeInterface;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    .line 10
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/NativeInterface;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    return-void
.end method


# virtual methods
.method public Call(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 20
    iget-object v0, p0, Lcom/nbsi/nedev/webviewobject/NativeInterface;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    invoke-interface {v0, p1, p2}, Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;->callFromJS(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method
