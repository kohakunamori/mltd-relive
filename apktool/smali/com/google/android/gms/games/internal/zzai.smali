.class final synthetic Lcom/google/android/gms/games/internal/zzai;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/games/internal/zze$zzap;


# instance fields
.field private final zzin:Lcom/google/android/gms/games/quest/Quest;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/quest/Quest;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzai;->zzin:Lcom/google/android/gms/games/quest/Quest;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zzai;->zzin:Lcom/google/android/gms/games/quest/Quest;

    check-cast p1, Lcom/google/android/gms/games/quest/QuestUpdateListener;

    .line 2
    invoke-interface {p1, v0}, Lcom/google/android/gms/games/quest/QuestUpdateListener;->onQuestCompleted(Lcom/google/android/gms/games/quest/Quest;)V

    return-void
.end method
