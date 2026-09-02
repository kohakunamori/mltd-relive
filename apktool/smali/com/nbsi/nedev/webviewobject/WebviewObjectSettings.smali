.class public Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;
.super Ljava/lang/Object;
.source "WebviewObjectSettings.java"


# static fields
.field public static final URLSCHEME_TYPE_APPLICATION:Ljava/lang/String; = "app"

.field public static final URLSCHEME_TYPE_PLUGUIN_DEFAULT:Ljava/lang/String; = "default"


# instance fields
.field public OverScrollMode:I

.field public isCheckURL:Z

.field public isClearCache:Z

.field public isDomStorageEnable:Z

.field public isHorizontalFadingEdgeEnabled:Z

.field public isHorizontalScrollBarEnabled:Z

.field public isInitWithWindwShow:Z

.field public isLoadWithOverviewMode:Z

.field public isUseWideViewPort:Z

.field public isVerticalFadingEdgeEnabled:Z

.field public isVerticalScrollBarEnabled:Z

.field public isZoomSupport:Z

.field public javascriptInterfaceName:Ljava/lang/String;

.field public overrideURLScheme:Ljava/lang/String;

.field public prefixUserAgent:Ljava/lang/String;

.field public replaceUserAgent:Ljava/lang/String;

.field public suffixUserAgent:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    .line 13
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isDomStorageEnable:Z

    .line 15
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isClearCache:Z

    const-string v1, ""

    .line 20
    iput-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->prefixUserAgent:Ljava/lang/String;

    const-string v1, ""

    .line 21
    iput-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->suffixUserAgent:Ljava/lang/String;

    const/4 v1, 0x0

    .line 22
    iput-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->replaceUserAgent:Ljava/lang/String;

    .line 24
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isInitWithWindwShow:Z

    .line 26
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isCheckURL:Z

    const-string v1, "NativeInterface"

    .line 28
    iput-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->javascriptInterfaceName:Ljava/lang/String;

    const-string v1, "mailto:default;unity:app"

    .line 34
    iput-object v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->overrideURLScheme:Ljava/lang/String;

    const/4 v1, 0x2

    .line 43
    iput v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->OverScrollMode:I

    const/4 v1, 0x0

    .line 45
    iput-boolean v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isHorizontalFadingEdgeEnabled:Z

    .line 46
    iput-boolean v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isVerticalFadingEdgeEnabled:Z

    .line 48
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isHorizontalScrollBarEnabled:Z

    .line 49
    iput-boolean v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isVerticalScrollBarEnabled:Z

    .line 52
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isUseWideViewPort:Z

    .line 53
    iput-boolean v0, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isLoadWithOverviewMode:Z

    .line 55
    iput-boolean v1, p0, Lcom/nbsi/nedev/webviewobject/WebviewObjectSettings;->isZoomSupport:Z

    return-void
.end method
