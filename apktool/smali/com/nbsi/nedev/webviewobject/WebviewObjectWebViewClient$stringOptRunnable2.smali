.class Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;
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
    name = "stringOptRunnable2"
.end annotation


# instance fields
.field str1:Ljava/lang/String;

.field str2:Ljava/lang/String;

.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 245
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 243
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;->str1:Ljava/lang/String;

    .line 244
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;->str2:Ljava/lang/String;

    .line 246
    iput-object p2, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;->str1:Ljava/lang/String;

    .line 247
    iput-object p3, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectWebViewClient$stringOptRunnable2;->str2:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    return-void
.end method
