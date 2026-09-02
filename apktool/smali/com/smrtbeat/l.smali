.class Lcom/smrtbeat/l;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final a:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    const-string v0, "HTL23"

    const-string v1, "LGL22"

    const-string v2, "Nexus 5"

    const-string v3, "SH-04F"

    const-string v4, "SH-06F"

    const-string v5, "SM-G900K"

    const-string v6, "SO-02F"

    const-string v7, "SOL23"

    const-string v8, "SOL25"

    filled-new-array/range {v0 .. v8}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/l;->a:[Ljava/lang/String;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lcom/smrtbeat/l;->a:[Ljava/lang/String;

    invoke-static {v0, p0}, Ljava/util/Arrays;->binarySearch([Ljava/lang/Object;Ljava/lang/Object;)I

    move-result p0

    if-ltz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method
