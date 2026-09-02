.class public final enum Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;
.super Ljava/lang/Enum;
.source "EasyMovieTexture.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/EasyMovieTexture/EasyMovieTexture;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "MEDIAPLAYER_STATE"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum END:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field private static final synthetic ENUM$VALUES:[Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field public static final enum ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field public static final enum NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field public static final enum PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field public static final enum PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field public static final enum READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field public static final enum STOPPED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;


# instance fields
.field private iValue:I


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 819
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "NOT_READY"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 820
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "READY"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3, v3}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 821
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "END"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4, v4}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->END:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 822
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "PLAYING"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5, v5}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 823
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "PAUSED"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6, v6}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 824
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "STOPPED"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7, v7}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->STOPPED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 825
    new-instance v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const-string v1, "ERROR"

    const/4 v8, 0x6

    invoke-direct {v0, v1, v8, v8}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const/4 v0, 0x7

    .line 817
    new-array v0, v0, [Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v2

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v3

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->END:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v4

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v5

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v6

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->STOPPED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v7

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    aput-object v1, v0, v8

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ENUM$VALUES:[Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 828
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 830
    iput p3, p0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->iValue:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;
    .locals 1

    .line 1
    const-class v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-object p0
.end method

.method public static values()[Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;
    .locals 4

    .line 1
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ENUM$VALUES:[Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    array-length v1, v0

    new-array v2, v1, [Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v2
.end method


# virtual methods
.method public GetValue()I
    .locals 1

    .line 834
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->iValue:I

    return v0
.end method
