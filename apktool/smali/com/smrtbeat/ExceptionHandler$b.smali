.class final Lcom/smrtbeat/ExceptionHandler$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/smrtbeat/ExceptionHandler;->a(Landroid/content/Context;Ljava/lang/Throwable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Lorg/json/JSONObject;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method a(Lorg/json/JSONObject;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/ExceptionHandler$b;->a:Lorg/json/JSONObject;

    return-object p0
.end method

.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/ExceptionHandler$b;->a:Lorg/json/JSONObject;

    invoke-static {v0}, Lcom/smrtbeat/k;->b(Lorg/json/JSONObject;)V

    return-void
.end method
