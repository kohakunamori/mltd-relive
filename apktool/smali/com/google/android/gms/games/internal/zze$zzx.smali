.class final Lcom/google/android/gms/games/internal/zze$zzx;
.super Lcom/google/android/gms/games/internal/zze$zzl;

# interfaces
.implements Lcom/google/android/gms/games/event/Events$LoadEventsResult;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/internal/zze;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "zzx"
.end annotation


# instance fields
.field private final zzhz:Lcom/google/android/gms/games/event/EventBuffer;


# direct methods
.method constructor <init>(Lcom/google/android/gms/common/data/DataHolder;)V
    .locals 1

    .line 1
    invoke-direct {p0, p1}, Lcom/google/android/gms/games/internal/zze$zzl;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    .line 2
    new-instance v0, Lcom/google/android/gms/games/event/EventBuffer;

    invoke-direct {v0, p1}, Lcom/google/android/gms/games/event/EventBuffer;-><init>(Lcom/google/android/gms/common/data/DataHolder;)V

    iput-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzx;->zzhz:Lcom/google/android/gms/games/event/EventBuffer;

    return-void
.end method


# virtual methods
.method public final getEvents()Lcom/google/android/gms/games/event/EventBuffer;
    .locals 1

    .line 4
    iget-object v0, p0, Lcom/google/android/gms/games/internal/zze$zzx;->zzhz:Lcom/google/android/gms/games/event/EventBuffer;

    return-object v0
.end method
