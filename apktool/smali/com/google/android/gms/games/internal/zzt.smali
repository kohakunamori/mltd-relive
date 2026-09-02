.class final synthetic Lcom/google/android/gms/games/internal/zzt;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/google/android/gms/games/internal/zze$zzap;


# instance fields
.field private final zzhc:I


# direct methods
.method constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/google/android/gms/games/internal/zzt;->zzhc:I

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 1
    iget v0, p0, Lcom/google/android/gms/games/internal/zzt;->zzhc:I

    check-cast p1, Lcom/google/android/gms/games/video/Videos$CaptureOverlayStateListener;

    .line 2
    invoke-interface {p1, v0}, Lcom/google/android/gms/games/video/Videos$CaptureOverlayStateListener;->onCaptureOverlayStateChanged(I)V

    return-void
.end method
