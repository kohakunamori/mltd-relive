.class Lcom/smrtbeat/q;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/q$a;
    }
.end annotation


# static fields
.field private static final d:Ljava/lang/String; = "yyyy-MM-dd HH:mm:ss.SSS Z"

.field private static e:Lcom/smrtbeat/q;


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/smrtbeat/q$a;",
            ">;"
        }
    .end annotation
.end field

.field private b:I

.field private c:Ljava/text/SimpleDateFormat;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/smrtbeat/q;

    invoke-direct {v0}, Lcom/smrtbeat/q;-><init>()V

    sput-object v0, Lcom/smrtbeat/q;->e:Lcom/smrtbeat/q;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    const/4 v0, 0x0

    iput v0, p0, Lcom/smrtbeat/q;->b:I

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd HH:mm:ss.SSS Z"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/smrtbeat/q;->c:Ljava/text/SimpleDateFormat;

    const-string v1, "UTC"

    invoke-static {v1}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    return-void
.end method

.method static a()Lcom/smrtbeat/q;
    .locals 1

    sget-object v0, Lcom/smrtbeat/q;->e:Lcom/smrtbeat/q;

    return-object v0
.end method

.method private a(II)V
    .locals 6

    iget-object v0, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-gt v0, p1, :cond_0

    iget v3, p0, Lcom/smrtbeat/q;->b:I

    if-le v3, p2, :cond_1

    :cond_0
    if-gtz v0, :cond_3

    sget-object p1, Lcom/smrtbeat/f0$e;->b:Lcom/smrtbeat/f0$e;

    const-string p2, "Count or size of log data is strange."

    invoke-static {p1, p2}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :cond_1
    iget-object p1, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-le p1, v0, :cond_2

    iget-object p1, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    sub-int/2addr p2, v0

    invoke-interface {p1, v1, p2}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->clear()V

    :cond_2
    return-void

    :cond_3
    iget v3, p0, Lcom/smrtbeat/q;->b:I

    iget-object v4, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    add-int/lit8 v5, v2, 0x1

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/smrtbeat/q$a;

    iget v2, v2, Lcom/smrtbeat/q$a;->b:I

    sub-int/2addr v3, v2

    iput v3, p0, Lcom/smrtbeat/q;->b:I

    add-int/lit8 v0, v0, -0x1

    move v2, v5

    goto :goto_0
.end method


# virtual methods
.method a(Ljava/lang/String;)V
    .locals 4

    monitor-enter p0

    :try_start_0
    new-instance v0, Lcom/smrtbeat/q$a;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/smrtbeat/q;->c:Ljava/text/SimpleDateFormat;

    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/smrtbeat/q$a;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget p1, p0, Lcom/smrtbeat/q;->b:I

    iget v0, v0, Lcom/smrtbeat/q$a;->b:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/smrtbeat/q;->b:I

    const/16 p1, 0x1f4

    const/high16 v0, 0x10000

    invoke-direct {p0, p1, v0}, Lcom/smrtbeat/q;->a(II)V

    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/smrtbeat/q;->a:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/smrtbeat/q$a;

    iget-object v2, v2, Lcom/smrtbeat/q$a;->a:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_0
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method
