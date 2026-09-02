.class final synthetic Lcom/google/android/gms/games/internal/zzaw;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/games/internal/zze$zzaz;


# static fields
.field static final zziw:Lcom/google/android/gms/games/internal/zze$zzaz;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/games/internal/zzaw;

    invoke-direct {v0}, Lcom/google/android/gms/games/internal/zzaw;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/internal/zzaw;->zziw:Lcom/google/android/gms/games/internal/zze$zzaz;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final zza(Ljava/lang/Object;ILcom/google/android/gms/games/multiplayer/realtime/Room;)V
    .locals 0

    check-cast p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;

    invoke-interface {p1, p2, p3}, Lcom/google/android/gms/games/multiplayer/realtime/RoomUpdateListener;->onRoomConnected(ILcom/google/android/gms/games/multiplayer/realtime/Room;)V

    return-void
.end method
