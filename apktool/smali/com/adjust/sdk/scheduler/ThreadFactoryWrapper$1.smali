.class Lcom/adjust/sdk/scheduler/ThreadFactoryWrapper$1;
.super Ljava/lang/Object;
.source "ThreadFactoryWrapper.java"

# interfaces
.implements Ljava/lang/Thread$UncaughtExceptionHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adjust/sdk/scheduler/ThreadFactoryWrapper;->newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adjust/sdk/scheduler/ThreadFactoryWrapper;


# direct methods
.method constructor <init>(Lcom/adjust/sdk/scheduler/ThreadFactoryWrapper;)V
    .locals 0

    .line 26
    iput-object p1, p0, Lcom/adjust/sdk/scheduler/ThreadFactoryWrapper$1;->this$0:Lcom/adjust/sdk/scheduler/ThreadFactoryWrapper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 4

    .line 29
    invoke-static {}, Lcom/adjust/sdk/AdjustFactory;->getLogger()Lcom/adjust/sdk/ILogger;

    move-result-object v0

    const-string v1, "Thread [%s] with error [%s]"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    .line 30
    invoke-virtual {p1}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object p1

    const/4 v3, 0x0

    aput-object p1, v2, v3

    invoke-virtual {p2}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    aput-object p1, v2, p2

    .line 29
    invoke-interface {v0, v1, v2}, Lcom/adjust/sdk/ILogger;->error(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
