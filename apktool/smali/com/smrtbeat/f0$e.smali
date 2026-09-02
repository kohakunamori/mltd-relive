.class final enum Lcom/smrtbeat/f0$e;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/smrtbeat/f0;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4018
    name = "e"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/smrtbeat/f0$e;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lcom/smrtbeat/f0$e;

.field public static final enum b:Lcom/smrtbeat/f0$e;

.field public static final enum c:Lcom/smrtbeat/f0$e;

.field public static final enum d:Lcom/smrtbeat/f0$e;

.field public static final enum e:Lcom/smrtbeat/f0$e;

.field private static final synthetic f:[Lcom/smrtbeat/f0$e;


# direct methods
.method static constructor <clinit>()V
    .locals 11

    new-instance v0, Lcom/smrtbeat/f0$e;

    const-string v1, "ERROR"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/smrtbeat/f0$e;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    new-instance v1, Lcom/smrtbeat/f0$e;

    const-string v3, "WARN"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lcom/smrtbeat/f0$e;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    new-instance v3, Lcom/smrtbeat/f0$e;

    const-string v5, "INFO"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lcom/smrtbeat/f0$e;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/smrtbeat/f0$e;->c:Lcom/smrtbeat/f0$e;

    new-instance v5, Lcom/smrtbeat/f0$e;

    const-string v7, "DEBUG"

    const/4 v8, 0x3

    invoke-direct {v5, v7, v8}, Lcom/smrtbeat/f0$e;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lcom/smrtbeat/f0$e;->d:Lcom/smrtbeat/f0$e;

    new-instance v7, Lcom/smrtbeat/f0$e;

    const-string v9, "VERBOSE"

    const/4 v10, 0x4

    invoke-direct {v7, v9, v10}, Lcom/smrtbeat/f0$e;-><init>(Ljava/lang/String;I)V

    sput-object v7, Lcom/smrtbeat/f0$e;->e:Lcom/smrtbeat/f0$e;

    const/4 v9, 0x5

    new-array v9, v9, [Lcom/smrtbeat/f0$e;

    aput-object v0, v9, v2

    aput-object v1, v9, v4

    aput-object v3, v9, v6

    aput-object v5, v9, v8

    aput-object v7, v9, v10

    sput-object v9, Lcom/smrtbeat/f0$e;->f:[Lcom/smrtbeat/f0$e;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/smrtbeat/f0$e;
    .locals 1

    const-class v0, Lcom/smrtbeat/f0$e;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/smrtbeat/f0$e;

    return-object p0
.end method

.method public static values()[Lcom/smrtbeat/f0$e;
    .locals 1

    sget-object v0, Lcom/smrtbeat/f0$e;->f:[Lcom/smrtbeat/f0$e;

    invoke-virtual {v0}, [Lcom/smrtbeat/f0$e;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/smrtbeat/f0$e;

    return-object v0
.end method
