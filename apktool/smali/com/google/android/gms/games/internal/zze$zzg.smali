.class final Lcom/google/android/gms/games/internal/zze$zzg;
.super Lcom/google/android/gms/games/internal/zze$zzl;

# interfaces
.implements Lcom/google/android/gms/games/quest/Quests$ClaimMilestoneResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/internal/zze;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "zzg"
.end annotation


# instance fields
.field private final zzhk:Lcom/google/android/gms/games/quest/Quest;

.field private final zzhq:Lcom/google/android/gms/games/quest/Milestone;


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/data/DataHolder;Ljava/lang/String;)V
    .locals 5

    .line 1
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzl;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    .line 2
    new-instance v0, Lcom/google/android/gms/games/quest/QuestBuffer;

    invoke-direct {v0, p1}, Lcom/google/android/gms/games/quest/QuestBuffer;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    .line 3
    :try_start_0
    invoke-virtual {v0}, Lcom/google/android/gms/games/quest/QuestBuffer;->getCount()I

    move-result p1

    const/4 v1, 0x0

    if-lez p1, :cond_2

    .line 4
    new-instance p1, Lcom/google/android/gms/games/quest/QuestEntity;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/google/android/gms/games/quest/QuestBuffer;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/android/gms/games/quest/Quest;

    invoke-direct {p1, v3}, Lcom/google/android/gms/games/quest/QuestEntity;-><init>(Lcom/google/android/gms/games/quest/Quest;)V

    iput-object p1, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhk:Lcom/google/android/gms/games/quest/Quest;

    .line 5
    iget-object p1, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhk:Lcom/google/android/gms/games/quest/Quest;

    invoke-interface {p1}, Lcom/google/android/gms/games/quest/Quest;->zzdq()Ljava/util/List;

    move-result-object p1

    .line 6
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    :goto_0
    if-ge v2, v3, :cond_1

    .line 7
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/google/android/gms/games/quest/Milestone;

    invoke-interface {v4}, Lcom/google/android/gms/games/quest/Milestone;->getMilestoneId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 8
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/games/quest/Milestone;

    iput-object p1, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhq:Lcom/google/android/gms/games/quest/Milestone;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 9
    invoke-virtual {v0}, Lcom/google/android/gms/games/quest/QuestBuffer;->release()V

    return-void

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 12
    :cond_1
    :try_start_1
    iput-object v1, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhq:Lcom/google/android/gms/games/quest/Milestone;

    goto :goto_1

    .line 14
    :cond_2
    iput-object v1, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhq:Lcom/google/android/gms/games/quest/Milestone;

    .line 15
    iput-object v1, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhk:Lcom/google/android/gms/games/quest/Quest;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 16
    :goto_1
    invoke-virtual {v0}, Lcom/google/android/gms/games/quest/QuestBuffer;->release()V

    return-void

    :catchall_0
    move-exception p1

    .line 18
    invoke-virtual {v0}, Lcom/google/android/gms/games/quest/QuestBuffer;->release()V

    throw p1
.end method


# virtual methods
.method public final getMilestone()Lcom/google/android/gms/games/quest/Milestone;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhq:Lcom/google/android/gms/games/quest/Milestone;

    return-object v0
.end method

.method public final getQuest()Lcom/google/android/gms/games/quest/Quest;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzg;->zzhk:Lcom/google/android/gms/games/quest/Quest;

    return-object v0
.end method
