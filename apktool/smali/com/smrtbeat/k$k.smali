.class final enum Lcom/smrtbeat/k$k;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/smrtbeat/k;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "k"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/smrtbeat/k$k;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum e:Lcom/smrtbeat/k$k;

.field public static final enum f:Lcom/smrtbeat/k$k;

.field public static final enum g:Lcom/smrtbeat/k$k;

.field public static final enum h:Lcom/smrtbeat/k$k;

.field public static final enum i:Lcom/smrtbeat/k$k;

.field public static final enum j:Lcom/smrtbeat/k$k;

.field public static final enum k:Lcom/smrtbeat/k$k;

.field public static final enum l:Lcom/smrtbeat/k$k;

.field public static final enum m:Lcom/smrtbeat/k$k;

.field public static final enum n:Lcom/smrtbeat/k$k;

.field private static final synthetic o:[Lcom/smrtbeat/k$k;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Z


# direct methods
.method static constructor <clinit>()V
    .locals 22

    new-instance v7, Lcom/smrtbeat/k$k;

    const-string v1, "Start"

    const-string v3, "/start"

    const-string v4, ""

    const-string v5, ""

    const/4 v2, 0x0

    const/4 v6, 0x0

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v7, Lcom/smrtbeat/k$k;->e:Lcom/smrtbeat/k$k;

    new-instance v0, Lcom/smrtbeat/k$k;

    const-string v9, "Crash"

    const-string v11, "/crash"

    const-string v12, "%1$s-%2$s"

    const-string v13, ".dat"

    const/4 v10, 0x1

    const/4 v14, 0x0

    move-object v8, v0

    invoke-direct/range {v8 .. v14}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v0, Lcom/smrtbeat/k$k;->f:Lcom/smrtbeat/k$k;

    new-instance v1, Lcom/smrtbeat/k$k;

    const-string v16, "NativeCrash"

    const-string v18, "/dump"

    const-string v19, "%3$s/%1$s-%2$s"

    const-string v20, ".dat"

    const/16 v17, 0x2

    const/16 v21, 0x1

    move-object v15, v1

    invoke-direct/range {v15 .. v21}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v1, Lcom/smrtbeat/k$k;->g:Lcom/smrtbeat/k$k;

    new-instance v2, Lcom/smrtbeat/k$k;

    const-string v9, "NativeCrashTmp"

    const-string v11, "/dump_tmp"

    const-string v12, "%1$s-%2$s"

    const-string v13, ".dat"

    const/4 v10, 0x3

    move-object v8, v2

    invoke-direct/range {v8 .. v14}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v2, Lcom/smrtbeat/k$k;->h:Lcom/smrtbeat/k$k;

    new-instance v3, Lcom/smrtbeat/k$k;

    const-string v16, "NativeCrashDump"

    const-string v18, "/dump"

    const-string v19, "%3$s/%3$s"

    const-string v20, ".dmp"

    const/16 v17, 0x4

    move-object v15, v3

    invoke-direct/range {v15 .. v21}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v3, Lcom/smrtbeat/k$k;->i:Lcom/smrtbeat/k$k;

    new-instance v4, Lcom/smrtbeat/k$k;

    const-string v9, "Exception"

    const-string v11, "/exception"

    const-string v12, "%1$s-%2$s"

    const-string v13, ".dat"

    const/4 v10, 0x5

    move-object v8, v4

    invoke-direct/range {v8 .. v14}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v4, Lcom/smrtbeat/k$k;->j:Lcom/smrtbeat/k$k;

    new-instance v5, Lcom/smrtbeat/k$k;

    const-string v16, "CrashId"

    const-string v18, ""

    const-string v19, "%3$s"

    const-string v20, ".id"

    const/16 v17, 0x6

    const/16 v21, 0x0

    move-object v15, v5

    invoke-direct/range {v15 .. v21}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v5, Lcom/smrtbeat/k$k;->k:Lcom/smrtbeat/k$k;

    new-instance v6, Lcom/smrtbeat/k$k;

    const-string v9, "Capture"

    const-string v11, "/capture"

    const-string v12, ""

    const-string v13, ""

    const/4 v10, 0x7

    move-object v8, v6

    invoke-direct/range {v8 .. v14}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v6, Lcom/smrtbeat/k$k;->l:Lcom/smrtbeat/k$k;

    new-instance v8, Lcom/smrtbeat/k$k;

    const-string v16, "Abort"

    const-string v18, "/abort"

    const-string v19, "%1$s-%2$s"

    const-string v20, ".dat"

    const/16 v17, 0x8

    move-object v15, v8

    invoke-direct/range {v15 .. v21}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v8, Lcom/smrtbeat/k$k;->m:Lcom/smrtbeat/k$k;

    new-instance v16, Lcom/smrtbeat/k$k;

    const-string v10, "AbortFootprint"

    const-string v12, ""

    const-string v13, "last_active"

    const-string v14, ".dat"

    const/16 v11, 0x9

    const/4 v15, 0x0

    move-object/from16 v9, v16

    invoke-direct/range {v9 .. v15}, Lcom/smrtbeat/k$k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    sput-object v16, Lcom/smrtbeat/k$k;->n:Lcom/smrtbeat/k$k;

    const/16 v9, 0xa

    new-array v9, v9, [Lcom/smrtbeat/k$k;

    const/4 v10, 0x0

    aput-object v7, v9, v10

    const/4 v7, 0x1

    aput-object v0, v9, v7

    const/4 v0, 0x2

    aput-object v1, v9, v0

    const/4 v0, 0x3

    aput-object v2, v9, v0

    const/4 v0, 0x4

    aput-object v3, v9, v0

    const/4 v0, 0x5

    aput-object v4, v9, v0

    const/4 v0, 0x6

    aput-object v5, v9, v0

    const/4 v0, 0x7

    aput-object v6, v9, v0

    const/16 v0, 0x8

    aput-object v8, v9, v0

    const/16 v0, 0x9

    aput-object v16, v9, v0

    sput-object v9, Lcom/smrtbeat/k$k;->o:[Lcom/smrtbeat/k$k;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Z)V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/smrtbeat/k$k;->a:Ljava/lang/String;

    iput-object p4, p0, Lcom/smrtbeat/k$k;->b:Ljava/lang/String;

    iput-object p5, p0, Lcom/smrtbeat/k$k;->c:Ljava/lang/String;

    iput-boolean p6, p0, Lcom/smrtbeat/k$k;->d:Z

    return-void
.end method

.method static synthetic a(Lcom/smrtbeat/k$k;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/smrtbeat/k$k;->c:Ljava/lang/String;

    return-object p0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/smrtbeat/k$k;
    .locals 1

    const-class v0, Lcom/smrtbeat/k$k;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/smrtbeat/k$k;

    return-object p0
.end method

.method public static values()[Lcom/smrtbeat/k$k;
    .locals 1

    sget-object v0, Lcom/smrtbeat/k$k;->o:[Lcom/smrtbeat/k$k;

    invoke-virtual {v0}, [Lcom/smrtbeat/k$k;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/smrtbeat/k$k;

    return-object v0
.end method


# virtual methods
.method a()I
    .locals 2

    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-boolean v1, p0, Lcom/smrtbeat/k$k;->d:Z

    if-eqz v1, :cond_0

    new-instance v1, Lcom/smrtbeat/k$k$a;

    invoke-direct {v1, p0}, Lcom/smrtbeat/k$k$a;-><init>(Lcom/smrtbeat/k$k;)V

    invoke-virtual {v0, v1}, Ljava/io/File;->listFiles(Ljava/io/FileFilter;)[Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    array-length v0, v0

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/smrtbeat/k$k$b;

    invoke-direct {v1, p0}, Lcom/smrtbeat/k$k$b;-><init>(Lcom/smrtbeat/k$k;)V

    invoke-virtual {v0, v1}, Ljava/io/File;->list(Ljava/io/FilenameFilter;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    array-length v0, v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method b()Ljava/lang/String;
    .locals 7

    new-instance v0, Ljava/util/Formatter;

    invoke-direct {v0}, Ljava/util/Formatter;-><init>()V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/smrtbeat/k$k;->c()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/smrtbeat/k$k;->b:Ljava/lang/String;

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    new-instance v4, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-direct {v4, v5, v6}, Ljava/util/Random;-><init>(J)V

    invoke-virtual {v4}, Ljava/util/Random;->nextInt()I

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    aput-object v4, v3, v5

    sget-object v4, Lcom/smrtbeat/j;->D:Ljava/lang/String;

    const/4 v5, 0x2

    aput-object v4, v3, v5

    invoke-virtual {v0, v2, v3}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/smrtbeat/k$k;->c:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method c()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/smrtbeat/j;->C:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/smrtbeat/k$k;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
