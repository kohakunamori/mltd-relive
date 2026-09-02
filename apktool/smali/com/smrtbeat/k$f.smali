.class final Lcom/smrtbeat/k$f;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Ljava/lang/String;

.field b:Lorg/json/JSONObject;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Ljava/lang/String;Lorg/json/JSONObject;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/k$f;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/smrtbeat/k$f;->b:Lorg/json/JSONObject;

    return-object p0
.end method

.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/smrtbeat/k$f;->b:Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/smrtbeat/k$f;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/smrtbeat/k;->a(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/io/File;

    return-void
.end method
