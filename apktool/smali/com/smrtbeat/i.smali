.class final enum Lcom/smrtbeat/i;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/smrtbeat/i;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum f:Lcom/smrtbeat/i;

.field public static final enum g:Lcom/smrtbeat/i;

.field public static final enum h:Lcom/smrtbeat/i;

.field public static final enum i:Lcom/smrtbeat/i;

.field private static final synthetic j:[Lcom/smrtbeat/i;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Z

.field private d:Z

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 25

    new-instance v8, Lcom/smrtbeat/i;

    const-string v1, "UNITY"

    const-string v3, "unity"

    const-string v4, "unity-exception-report"

    const/4 v2, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/smrtbeat/i;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/String;)V

    sput-object v8, Lcom/smrtbeat/i;->f:Lcom/smrtbeat/i;

    new-instance v0, Lcom/smrtbeat/i;

    const-string v1, "engineVersion"

    const-string v2, "scriptDirPath"

    filled-new-array {v1, v2}, [Ljava/lang/String;

    move-result-object v16

    const-string v10, "COCOS2DJS"

    const-string v12, "cocos2djs"

    const-string v13, "cocos2djs-exception-report"

    const/4 v11, 0x1

    const/4 v14, 0x1

    const/4 v15, 0x1

    move-object v9, v0

    invoke-direct/range {v9 .. v16}, Lcom/smrtbeat/i;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/String;)V

    sput-object v0, Lcom/smrtbeat/i;->g:Lcom/smrtbeat/i;

    new-instance v1, Lcom/smrtbeat/i;

    const-string v2, "engineVersion"

    filled-new-array {v2}, [Ljava/lang/String;

    move-result-object v24

    const-string v18, "UNREAL"

    const-string v20, "unreal"

    const-string v21, "unreal-exception-report"

    const/16 v19, 0x2

    const/16 v22, 0x1

    const/16 v23, 0x1

    move-object/from16 v17, v1

    invoke-direct/range {v17 .. v24}, Lcom/smrtbeat/i;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/String;)V

    sput-object v1, Lcom/smrtbeat/i;->h:Lcom/smrtbeat/i;

    new-instance v2, Lcom/smrtbeat/i;

    const-string v3, "engineVersion"

    filled-new-array {v3}, [Ljava/lang/String;

    move-result-object v16

    const-string v10, "CORDOVA"

    const-string v12, "cordova"

    const-string v13, "cordova-exception-report"

    const/4 v11, 0x3

    move-object v9, v2

    invoke-direct/range {v9 .. v16}, Lcom/smrtbeat/i;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/String;)V

    sput-object v2, Lcom/smrtbeat/i;->i:Lcom/smrtbeat/i;

    const/4 v3, 0x4

    new-array v3, v3, [Lcom/smrtbeat/i;

    const/4 v4, 0x0

    aput-object v8, v3, v4

    const/4 v4, 0x1

    aput-object v0, v3, v4

    const/4 v0, 0x2

    aput-object v1, v3, v0

    const/4 v0, 0x3

    aput-object v2, v3, v0

    sput-object v3, Lcom/smrtbeat/i;->j:[Lcom/smrtbeat/i;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "ZZ[",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/smrtbeat/i;->a:Ljava/lang/String;

    iput-object p4, p0, Lcom/smrtbeat/i;->b:Ljava/lang/String;

    iput-boolean p5, p0, Lcom/smrtbeat/i;->c:Z

    iput-boolean p6, p0, Lcom/smrtbeat/i;->d:Z

    if-eqz p7, :cond_0

    invoke-static {p7}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lcom/smrtbeat/i;->e:Ljava/util/List;

    :cond_0
    return-void
.end method

.method static a(Ljava/lang/String;)Lcom/smrtbeat/i;
    .locals 5

    invoke-static {}, Lcom/smrtbeat/i;->values()[Lcom/smrtbeat/i;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    iget-object v4, v3, Lcom/smrtbeat/i;->a:Ljava/lang/String;

    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    return-object v3

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/smrtbeat/i;
    .locals 1

    const-class v0, Lcom/smrtbeat/i;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/smrtbeat/i;

    return-object p0
.end method

.method public static values()[Lcom/smrtbeat/i;
    .locals 1

    sget-object v0, Lcom/smrtbeat/i;->j:[Lcom/smrtbeat/i;

    invoke-virtual {v0}, [Lcom/smrtbeat/i;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/smrtbeat/i;

    return-object v0
.end method


# virtual methods
.method a(Ljava/util/Map;)Ljava/util/Map;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/smrtbeat/i;->e:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_3

    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iget-object v2, p0, Lcom/smrtbeat/i;->e:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    if-eqz p1, :cond_1

    invoke-interface {p1, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    goto :goto_1

    :cond_1
    move-object v4, v1

    :goto_1
    if-eqz v4, :cond_2

    goto :goto_2

    :cond_2
    const-string v4, ""

    :goto_2
    invoke-interface {v0, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_3
    return-object v0

    :cond_4
    :goto_3
    return-object v1
.end method

.method a()Z
    .locals 1

    iget-boolean v0, p0, Lcom/smrtbeat/i;->d:Z

    return v0
.end method

.method b()Z
    .locals 1

    iget-boolean v0, p0, Lcom/smrtbeat/i;->c:Z

    return v0
.end method

.method c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/i;->a:Ljava/lang/String;

    return-object v0
.end method

.method d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/i;->b:Ljava/lang/String;

    return-object v0
.end method
