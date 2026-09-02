.class public Lcom/nbsi/nedev/webviewobject/WebviewObjectWebChromeClient;
.super Landroid/webkit/WebChromeClient;
.source "WebviewObjectWebChromeClient.java"


# instance fields
.field unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;)V
    .locals 1

    .line 14
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    const/4 v0, 0x0

    .line 11
    iput-object v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebChromeClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    .line 15
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebChromeClient;->unitylistener:Lcom/nbsi/nedev/webviewobject/WebviewObjectUnityListener;

    return-void
.end method
