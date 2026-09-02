.class public final enum Lcom/criware/filesystem/CriFsWebInstaller$Error;
.super Ljava/lang/Enum;
.source "CriFsWebInstaller.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/criware/filesystem/CriFsWebInstaller;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Error"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/criware/filesystem/CriFsWebInstaller$Error;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_CONNECTION:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_DNS:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_HTTP:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_INTERNAL:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_LOCALFS:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_MEMORY:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_NONE:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_SSL:Lcom/criware/filesystem/CriFsWebInstaller$Error;

.field public static final enum CRIFSWEBINSTALLER_ERROR_TIMEOUT:Lcom/criware/filesystem/CriFsWebInstaller$Error;


# instance fields
.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 11

    .line 60
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_NONE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_NONE:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 61
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_TIMEOUT"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3, v3}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_TIMEOUT:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 62
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_MEMORY"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4, v4}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_MEMORY:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 63
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_LOCALFS"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5, v5}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_LOCALFS:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 64
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_DNS"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6, v6}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_DNS:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 65
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_CONNECTION"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7, v7}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_CONNECTION:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 66
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_SSL"

    const/4 v8, 0x6

    invoke-direct {v0, v1, v8, v8}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_SSL:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 67
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_HTTP"

    const/4 v9, 0x7

    invoke-direct {v0, v1, v9, v9}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_HTTP:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    .line 68
    new-instance v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const-string v1, "CRIFSWEBINSTALLER_ERROR_INTERNAL"

    const/16 v10, 0x8

    invoke-direct {v0, v1, v10, v10}, Lcom/criware/filesystem/CriFsWebInstaller$Error;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_INTERNAL:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    const/16 v0, 0x9

    .line 59
    new-array v0, v0, [Lcom/criware/filesystem/CriFsWebInstaller$Error;

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_NONE:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v2

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_TIMEOUT:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v3

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_MEMORY:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v4

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_LOCALFS:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v5

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_DNS:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v6

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_CONNECTION:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v7

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_SSL:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v8

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_HTTP:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v9

    sget-object v1, Lcom/criware/filesystem/CriFsWebInstaller$Error;->CRIFSWEBINSTALLER_ERROR_INTERNAL:Lcom/criware/filesystem/CriFsWebInstaller$Error;

    aput-object v1, v0, v10

    sput-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->$VALUES:[Lcom/criware/filesystem/CriFsWebInstaller$Error;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 71
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 72
    iput p3, p0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->value:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/criware/filesystem/CriFsWebInstaller$Error;
    .locals 1

    .line 59
    const-class v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/criware/filesystem/CriFsWebInstaller$Error;

    return-object p0
.end method

.method public static values()[Lcom/criware/filesystem/CriFsWebInstaller$Error;
    .locals 1

    .line 59
    sget-object v0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->$VALUES:[Lcom/criware/filesystem/CriFsWebInstaller$Error;

    invoke-virtual {v0}, [Lcom/criware/filesystem/CriFsWebInstaller$Error;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/criware/filesystem/CriFsWebInstaller$Error;

    return-object v0
.end method


# virtual methods
.method public getValue()I
    .locals 1

    .line 75
    iget v0, p0, Lcom/criware/filesystem/CriFsWebInstaller$Error;->value:I

    return v0
.end method
