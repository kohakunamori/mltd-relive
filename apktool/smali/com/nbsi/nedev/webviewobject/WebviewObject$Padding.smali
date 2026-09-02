.class Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;
.super Ljava/lang/Object;
.source "WebviewObject.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/nbsi/nedev/webviewobject/WebviewObject;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "Padding"
.end annotation


# instance fields
.field bottom:I

.field left:I

.field right:I

.field final synthetic this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

.field top:I


# direct methods
.method public constructor <init>(Lcom/nbsi/nedev/webviewobject/WebviewObject;)V
    .locals 0

    .line 54
    iput-object p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->this$0:Lcom/nbsi/nedev/webviewobject/WebviewObject;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 55
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->left:I

    .line 56
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->top:I

    .line 57
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->right:I

    .line 58
    iput p1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObject$Padding;->bottom:I

    return-void
.end method
