.class final Lcom/google/android/gms/games/internal/zze$zzae;
.super Lcom/google/android/gms/games/internal/zze$zzl;

# interfaces
.implements Lcom/google/android/gms/games/Players$LoadPlayersResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/internal/zze;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "zzae"
.end annotation


# instance fields
.field private final zzif:Lcom/google/android/gms/games/PlayerBuffer;


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 1

    .line 1
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzl;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    .line 2
    new-instance v0, Lcom/google/android/gms/games/PlayerBuffer;

    invoke-direct {v0, p1}, Lcom/google/android/gms/games/PlayerBuffer;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    iput-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzae;->zzif:Lcom/google/android/gms/games/PlayerBuffer;

    return-void
.end method


# virtual methods
.method public final getPlayers()Lcom/google/android/gms/games/PlayerBuffer;
    .locals 1

    .line 4
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzae;->zzif:Lcom/google/android/gms/games/PlayerBuffer;

    return-object v0
.end method
