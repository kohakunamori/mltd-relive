.class final Lcom/google/android/gms/games/internal/zze$zzy;
.super Lcom/google/android/gms/games/internal/zze$zzl;

# interfaces
.implements Lcom/google/android/gms/games/GamesMetadata$LoadGamesResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/internal/zze;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "zzy"
.end annotation


# instance fields
.field private final zzia:Lcom/google/android/gms/games/GameBuffer;


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 1

    .line 1
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzl;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    .line 2
    new-instance v0, Lcom/google/android/gms/games/GameBuffer;

    invoke-direct {v0, p1}, Lcom/google/android/gms/games/GameBuffer;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    iput-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzy;->zzia:Lcom/google/android/gms/games/GameBuffer;

    return-void
.end method


# virtual methods
.method public final getGames()Lcom/google/android/gms/games/GameBuffer;
    .locals 1

    .line 4
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzy;->zzia:Lcom/google/android/gms/games/GameBuffer;

    return-object v0
.end method
