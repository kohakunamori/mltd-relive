.class final Lcom/google/android/gms/games/internal/zze$zzaf;
.super Lcom/google/android/gms/games/internal/zze$zzl;

# interfaces
.implements Lcom/google/android/gms/games/quest/Quests$LoadQuestsResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/internal/zze;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "zzaf"
.end annotation


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzl;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    return-void
.end method


# virtual methods
.method public final getQuests()Lcom/google/android/gms/games/quest/QuestBuffer;
    .locals 2

    .line 3
    new-instance v0, Lcom/google/android/gms/games/quest/QuestBuffer;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zze$zzaf;->mDataHolder:Lcom/google/android/gms/common/data/DataHolder;

    invoke-direct {v0, v1}, Lcom/google/android/gms/games/quest/QuestBuffer;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    return-object v0
.end method
