.class public Lcom/smrtbeat/SmartBeatConfig;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private a:Ljava/lang/String;

.field private b:Z

.field private c:Z

.field private d:Z

.field private e:Ljava/util/Collection;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Collection<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/smrtbeat/SmartBeatConfig;->b:Z

    iput-boolean v0, p0, Lcom/smrtbeat/SmartBeatConfig;->c:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/smrtbeat/SmartBeatConfig;->d:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/smrtbeat/SmartBeatConfig;->e:Ljava/util/Collection;

    return-void
.end method


# virtual methods
.method a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/SmartBeatConfig;->a:Ljava/lang/String;

    return-object v0
.end method

.method public addIgnoredSignal(I)Lcom/smrtbeat/SmartBeatConfig;
    .locals 1

    iget-object v0, p0, Lcom/smrtbeat/SmartBeatConfig;->e:Ljava/util/Collection;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public addIgnoredSignals(Ljava/util/Collection;)Lcom/smrtbeat/SmartBeatConfig;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/Integer;",
            ">;)",
            "Lcom/smrtbeat/SmartBeatConfig;"
        }
    .end annotation

    iget-object v0, p0, Lcom/smrtbeat/SmartBeatConfig;->e:Ljava/util/Collection;

    invoke-interface {v0, p1}, Ljava/util/Collection;->addAll(Ljava/util/Collection;)Z

    return-object p0
.end method

.method b()Z
    .locals 1

    iget-boolean v0, p0, Lcom/smrtbeat/SmartBeatConfig;->b:Z

    return v0
.end method

.method c()Ljava/util/Collection;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Collection<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/smrtbeat/SmartBeatConfig;->e:Ljava/util/Collection;

    return-object v0
.end method

.method public getAutoBreadcrumb()Z
    .locals 1

    iget-boolean v0, p0, Lcom/smrtbeat/SmartBeatConfig;->c:Z

    return v0
.end method

.method public getCallOtherSignalHandlers()Z
    .locals 1

    iget-boolean v0, p0, Lcom/smrtbeat/SmartBeatConfig;->d:Z

    return v0
.end method

.method public setApiKey(Ljava/lang/String;)Lcom/smrtbeat/SmartBeatConfig;
    .locals 0

    iput-object p1, p0, Lcom/smrtbeat/SmartBeatConfig;->a:Ljava/lang/String;

    return-object p0
.end method

.method public setAutoBreadcrumb(Z)Lcom/smrtbeat/SmartBeatConfig;
    .locals 0

    iput-boolean p1, p0, Lcom/smrtbeat/SmartBeatConfig;->c:Z

    return-object p0
.end method

.method public setCallOtherSignalHandlers(Z)Lcom/smrtbeat/SmartBeatConfig;
    .locals 0

    iput-boolean p1, p0, Lcom/smrtbeat/SmartBeatConfig;->d:Z

    return-object p0
.end method

.method public setEnabled(Z)Lcom/smrtbeat/SmartBeatConfig;
    .locals 0

    iput-boolean p1, p0, Lcom/smrtbeat/SmartBeatConfig;->b:Z

    return-object p0
.end method
