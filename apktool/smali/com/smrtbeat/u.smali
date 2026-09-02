.class Lcom/smrtbeat/u;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation


# static fields
.field private static final a:Ljava/lang/String; = "ActivityLifecycle"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(Z)Landroid/app/Application$ActivityLifecycleCallbacks;
    .locals 1

    new-instance v0, Lcom/smrtbeat/u$a;

    invoke-direct {v0, p0}, Lcom/smrtbeat/u$a;-><init>(Z)V

    return-object v0
.end method

.method static a(Landroid/app/Application;Z)V
    .locals 0

    if-eqz p0, :cond_0

    invoke-static {p1}, Lcom/smrtbeat/u;->a(Z)Landroid/app/Application$ActivityLifecycleCallbacks;

    move-result-object p1

    invoke-virtual {p0, p1}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    goto :goto_0

    :cond_0
    sget-object p0, Lcom/smrtbeat/f0$e;->a:Lcom/smrtbeat/f0$e;

    const-string p1, "Failed to register activity lifecycle callback"

    invoke-static {p0, p1}, Lcom/smrtbeat/f0;->a(Lcom/smrtbeat/f0$e;Ljava/lang/String;)V

    :goto_0
    return-void
.end method
