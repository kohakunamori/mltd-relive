.class Lcom/smrtbeat/b0;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/smrtbeat/b0$a;
    }
.end annotation


# instance fields
.field a:I

.field b:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/smrtbeat/b0;->a:I

    const-string v0, ""

    iput-object v0, p0, Lcom/smrtbeat/b0;->b:Ljava/lang/String;

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p1, "filesSaved"

    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    :goto_0
    :try_start_1
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-ge v0, v2, :cond_1

    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    if-eqz v2, :cond_0

    const/4 v1, 0x1

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    const/4 v1, 0x0

    :catch_1
    :cond_1
    return v1
.end method

.method private static b(Ljava/lang/String;)Z
    .locals 2

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string p0, "OK"

    :try_start_1
    const-string v1, "status"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method


# virtual methods
.method a()Lcom/smrtbeat/b0$a;
    .locals 2

    iget-object v0, p0, Lcom/smrtbeat/b0;->b:Ljava/lang/String;

    invoke-static {v0}, Lcom/smrtbeat/b0;->b(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    return-object v0

    :cond_0
    iget v0, p0, Lcom/smrtbeat/b0;->a:I

    const/16 v1, 0x190

    if-eq v0, v1, :cond_2

    const/16 v1, 0x1f4

    if-eq v0, v1, :cond_1

    sget-object v0, Lcom/smrtbeat/b0$a;->d:Lcom/smrtbeat/b0$a;

    return-object v0

    :cond_1
    sget-object v0, Lcom/smrtbeat/b0$a;->c:Lcom/smrtbeat/b0$a;

    return-object v0

    :cond_2
    sget-object v0, Lcom/smrtbeat/b0$a;->b:Lcom/smrtbeat/b0$a;

    return-object v0
.end method

.method a(Ljava/lang/String;)Lcom/smrtbeat/b0$a;
    .locals 2

    iget v0, p0, Lcom/smrtbeat/b0;->a:I

    const/16 v1, 0xc8

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/smrtbeat/b0;->b:Ljava/lang/String;

    invoke-direct {p0, v0, p1}, Lcom/smrtbeat/b0;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Lcom/smrtbeat/b0$a;->a:Lcom/smrtbeat/b0$a;

    return-object p1

    :cond_0
    iget p1, p0, Lcom/smrtbeat/b0;->a:I

    const/16 v0, 0x190

    if-eq p1, v0, :cond_2

    const/16 v0, 0x1f4

    if-eq p1, v0, :cond_1

    sget-object p1, Lcom/smrtbeat/b0$a;->d:Lcom/smrtbeat/b0$a;

    return-object p1

    :cond_1
    sget-object p1, Lcom/smrtbeat/b0$a;->c:Lcom/smrtbeat/b0$a;

    return-object p1

    :cond_2
    sget-object p1, Lcom/smrtbeat/b0$a;->b:Lcom/smrtbeat/b0$a;

    return-object p1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\"code\":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/smrtbeat/b0;->a:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", \"data\":\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/smrtbeat/b0;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
