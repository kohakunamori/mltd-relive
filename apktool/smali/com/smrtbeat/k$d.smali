.class final Lcom/smrtbeat/k$d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/smrtbeat/c0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;J)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Lcom/smrtbeat/b0;

.field b:Lorg/json/JSONObject;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/smrtbeat/k$d;->a:Lcom/smrtbeat/b0;

    iput-object v0, p0, Lcom/smrtbeat/k$d;->b:Lorg/json/JSONObject;

    return-void
.end method


# virtual methods
.method public a()Lcom/smrtbeat/b0;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/k$d;->a:Lcom/smrtbeat/b0;

    return-object v0
.end method

.method a(Lorg/json/JSONObject;)Lcom/smrtbeat/c0;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/k$d;->b:Lorg/json/JSONObject;

    return-object p0
.end method

.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/smrtbeat/k$d;->b:Lorg/json/JSONObject;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;Z)Lcom/smrtbeat/b0;

    move-result-object v0

    iput-object v0, p0, Lcom/smrtbeat/k$d;->a:Lcom/smrtbeat/b0;

    return-void
.end method
