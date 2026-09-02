.class Lcom/adjust/sdk/scheduler/TimerOnce$1;
.super Ljava/lang/Object;
.source "TimerOnce.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adjust/sdk/scheduler/TimerOnce;->startIn(J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adjust/sdk/scheduler/TimerOnce;


# direct methods
.method constructor <init>(Lcom/adjust/sdk/scheduler/TimerOnce;)V
    .locals 0

    .line 36
    iput-object p1, p0, Lcom/adjust/sdk/scheduler/TimerOnce$1;->this$0:Lcom/adjust/sdk/scheduler/TimerOnce;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 39
    iget-object v0, p0, Lcom/adjust/sdk/scheduler/TimerOnce$1;->this$0:Lcom/adjust/sdk/scheduler/TimerOnce;

    invoke-static {v0}, Lcom/adjust/sdk/scheduler/TimerOnce;->access$100(Lcom/adjust/sdk/scheduler/TimerOnce;)Lcom/adjust/sdk/ILogger;

    move-result-object v0

    const-string v1, "%s fired"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/adjust/sdk/scheduler/TimerOnce$1;->this$0:Lcom/adjust/sdk/scheduler/TimerOnce;

    invoke-static {v3}, Lcom/adjust/sdk/scheduler/TimerOnce;->access$000(Lcom/adjust/sdk/scheduler/TimerOnce;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-interface {v0, v1, v2}, Lcom/adjust/sdk/ILogger;->verbose(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 40
    iget-object v0, p0, Lcom/adjust/sdk/scheduler/TimerOnce$1;->this$0:Lcom/adjust/sdk/scheduler/TimerOnce;

    invoke-static {v0}, Lcom/adjust/sdk/scheduler/TimerOnce;->access$200(Lcom/adjust/sdk/scheduler/TimerOnce;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 41
    iget-object v0, p0, Lcom/adjust/sdk/scheduler/TimerOnce$1;->this$0:Lcom/adjust/sdk/scheduler/TimerOnce;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adjust/sdk/scheduler/TimerOnce;->access$302(Lcom/adjust/sdk/scheduler/TimerOnce;Ljava/util/concurrent/ScheduledFuture;)Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method
