.class final synthetic Lcom/google/android/gms/games/internal/zzaq;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/games/internal/zze$zzav;


# static fields
.field static final zzix:Lcom/google/android/gms/games/internal/zze$zzav;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/games/internal/zzaq;

    invoke-direct {v0}, Lcom/google/android/gms/games/internal/zzaq;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/internal/zzaq;->zzix:Lcom/google/android/gms/games/internal/zze$zzav;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final zza(Ljava/lang/Object;Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/ArrayList;)V
    .locals 0

    check-cast p1, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;

    check-cast p3, Ljava/util/List;

    invoke-interface {p1, p2, p3}, Lcom/google/android/gms/games/multiplayer/realtime/RoomStatusUpdateListener;->onPeerLeft(Lcom/google/android/gms/games/multiplayer/realtime/Room;Ljava/util/List;)V

    return-void
.end method
