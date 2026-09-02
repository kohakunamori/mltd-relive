.class final Lcom/google/android/gms/games/internal/zzf;
.super Lcom/google/android/gms/internal/games/zzej;


# instance fields
.field private final synthetic zzgz:Lcom/google/android/gms/games/internal/zze;


# direct methods
.method constructor <init>(Lcom/google/android/gms/games/internal/zze;)V
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzf;->zzgz:Lcom/google/android/gms/games/internal/zze;

    invoke-direct {p0}, Lcom/google/android/gms/internal/games/zzej;-><init>()V

    return-void
.end method


# virtual methods
.method public final zzcj()Lcom/google/android/gms/internal/games/zzeh;
    .locals 2

    .line 2
    new-instance v0, Lcom/google/android/gms/games/internal/zze$zzk;

    iget-object v1, p0, Lcom/google/android/gms/games/internal/zzf;->zzgz:Lcom/google/android/gms/games/internal/zze;

    invoke-direct {v0, v1}, Lcom/google/android/gms/games/internal/zze$zzk;-><init>(Lcom/google/android/gms/games/internal/zze;)V

    return-object v0
.end method
