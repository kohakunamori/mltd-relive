.class public Lcom/inca/security/DexProtect/Binder;
.super Ljava/lang/Object;
.source "fb"


# static fields
.field private static synthetic IIiIIiiiIi:I

.field private static synthetic IiiiIIiIii:Ljava/lang/Object;


# direct methods
.method public static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getABI()I
    .locals 1

    .line 86
    sget v0, Lcom/inca/security/DexProtect/Binder;->IIiIIiiiIi:I

    return v0
.end method

.method public static getReserved1()Ljava/lang/Object;
    .locals 1

    .line 164
    sget-object v0, Lcom/inca/security/DexProtect/Binder;->IiiiIIiIii:Ljava/lang/Object;

    return-object v0
.end method

.method public static setABI(I)V
    .locals 0

    .line 44
    sput p0, Lcom/inca/security/DexProtect/Binder;->IIiIIiiiIi:I

    return-void
.end method

.method public static setReserved1(Ljava/lang/Object;)V
    .locals 0

    .line 35
    sput-object p0, Lcom/inca/security/DexProtect/Binder;->IiiiIIiIii:Ljava/lang/Object;

    return-void
.end method
