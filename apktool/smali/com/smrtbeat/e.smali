.class final enum Lcom/smrtbeat/e;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/smrtbeat/e;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum b:Lcom/smrtbeat/e;

.field public static final enum c:Lcom/smrtbeat/e;

.field public static final enum d:Lcom/smrtbeat/e;

.field public static final enum e:Lcom/smrtbeat/e;

.field public static final enum f:Lcom/smrtbeat/e;

.field public static final enum g:Lcom/smrtbeat/e;

.field public static final enum h:Lcom/smrtbeat/e;

.field public static final enum i:Lcom/smrtbeat/e;

.field static final j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/smrtbeat/e;",
            ">;"
        }
    .end annotation
.end field

.field private static final synthetic k:[Lcom/smrtbeat/e;


# instance fields
.field a:I


# direct methods
.method static constructor <clinit>()V
    .locals 16

    new-instance v0, Lcom/smrtbeat/e;

    const-string v1, "BC2_TYPE_LEGACY_BREADCRUMB"

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-direct {v0, v1, v2, v3}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/smrtbeat/e;->b:Lcom/smrtbeat/e;

    new-instance v1, Lcom/smrtbeat/e;

    const-string v4, "BC2_TYPE_BREADCRUMB_META"

    const/4 v5, 0x3

    invoke-direct {v1, v4, v3, v5}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lcom/smrtbeat/e;->c:Lcom/smrtbeat/e;

    new-instance v4, Lcom/smrtbeat/e;

    const-string v6, "BC2_TYPE_BREADCRUMB_META_DROP"

    const/4 v7, 0x4

    const/4 v8, 0x2

    invoke-direct {v4, v6, v8, v7}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v4, Lcom/smrtbeat/e;->d:Lcom/smrtbeat/e;

    new-instance v6, Lcom/smrtbeat/e;

    const-string v9, "BC2_TYPE_AUTO_BREADCRUMB"

    const/4 v10, 0x5

    invoke-direct {v6, v9, v5, v10}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v6, Lcom/smrtbeat/e;->e:Lcom/smrtbeat/e;

    new-instance v9, Lcom/smrtbeat/e;

    const-string v11, "BC2_TYPE_AUTO_BREADCRUMB_DROP"

    const/4 v12, 0x6

    invoke-direct {v9, v11, v7, v12}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v9, Lcom/smrtbeat/e;->f:Lcom/smrtbeat/e;

    new-instance v11, Lcom/smrtbeat/e;

    const-string v13, "BC2_TYPE_ERROR_BREADCRUMB"

    const/4 v14, 0x7

    invoke-direct {v11, v13, v10, v14}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v11, Lcom/smrtbeat/e;->g:Lcom/smrtbeat/e;

    new-instance v13, Lcom/smrtbeat/e;

    const-string v15, "BC2_TYPE_ERROR_BREADCRUMB_DROP"

    const/16 v10, 0x8

    invoke-direct {v13, v15, v12, v10}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v13, Lcom/smrtbeat/e;->h:Lcom/smrtbeat/e;

    new-instance v15, Lcom/smrtbeat/e;

    const-string v12, "BC2_TYPE_SB_BREADCRUMB"

    const/16 v7, 0x9

    invoke-direct {v15, v12, v14, v7}, Lcom/smrtbeat/e;-><init>(Ljava/lang/String;II)V

    sput-object v15, Lcom/smrtbeat/e;->i:Lcom/smrtbeat/e;

    new-array v7, v10, [Lcom/smrtbeat/e;

    aput-object v0, v7, v2

    aput-object v1, v7, v3

    aput-object v4, v7, v8

    aput-object v6, v7, v5

    const/4 v0, 0x4

    aput-object v9, v7, v0

    const/4 v0, 0x5

    aput-object v11, v7, v0

    const/4 v0, 0x6

    aput-object v13, v7, v0

    aput-object v15, v7, v14

    sput-object v7, Lcom/smrtbeat/e;->k:[Lcom/smrtbeat/e;

    new-array v0, v5, [Lcom/smrtbeat/e;

    aput-object v1, v0, v2

    aput-object v6, v0, v3

    aput-object v11, v0, v8

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/smrtbeat/e;->j:Ljava/util/List;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/smrtbeat/e;->a:I

    return-void
.end method

.method static a(I)Lcom/smrtbeat/e;
    .locals 5

    invoke-static {}, Lcom/smrtbeat/e;->values()[Lcom/smrtbeat/e;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    invoke-virtual {v3}, Lcom/smrtbeat/e;->a()I

    move-result v4

    if-ne v4, p0, :cond_0

    return-object v3

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/smrtbeat/e;
    .locals 1

    const-class v0, Lcom/smrtbeat/e;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/smrtbeat/e;

    return-object p0
.end method

.method public static values()[Lcom/smrtbeat/e;
    .locals 1

    sget-object v0, Lcom/smrtbeat/e;->k:[Lcom/smrtbeat/e;

    invoke-virtual {v0}, [Lcom/smrtbeat/e;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/smrtbeat/e;

    return-object v0
.end method


# virtual methods
.method a()I
    .locals 1

    iget v0, p0, Lcom/smrtbeat/e;->a:I

    return v0
.end method
