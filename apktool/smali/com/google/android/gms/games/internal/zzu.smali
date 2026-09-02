.class final Lcom/google/android/gms/games/internal/zzu;
.super Lcom/google/android/gms/games/internal/zze$zzv;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/android/gms/games/internal/zze$zzv<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private final synthetic zzhd:Lcom/google/android/gms/games/internal/zze$zzap;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/internal/zze$zzap;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzu;->zzhd:Lcom/google/android/gms/games/internal/zze$zzap;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzv;-><init>(Lcom/google/android/gms/games/internal/zzf;)V

    return-void
.end method


# virtual methods
.method public final notifyListener(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .line 2
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zzu;->zzhd:Lcom/google/android/gms/games/internal/zze$zzap;

    invoke-interface {v0, p1}, Lcom/google/android/gms/games/internal/zze$zzap;->accept(Ljava/lang/Object;)V

    return-void
.end method
