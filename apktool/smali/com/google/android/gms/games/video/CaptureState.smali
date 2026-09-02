.class public final Lcom/google/android/gms/games/video/CaptureState;
.super Ljava/lang/Object;


# instance fields
.field private final zzst:Z

.field private final zzsu:I

.field private final zzsv:I

.field private final zzsw:Z

.field private final zzsx:Z


# direct methods
.method private constructor <init>(ZIIZZ)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    .line 3
    invoke-static {p2, v0}, Lcom/google/android/gms/games/video/VideoConfiguration;->isValidCaptureMode(IZ)Z

    move-result v1

    .line 4
    invoke-static {v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(Z)V

    .line 6
    invoke-static {p3, v0}, Lcom/google/android/gms/games/video/VideoConfiguration;->isValidQualityLevel(IZ)Z

    move-result v0

    .line 7
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkArgument(Z)V

    .line 8
    iput-boolean p1, p0, Lcom/google/android/gms/games/video/CaptureState;->zzst:Z

    .line 9
    iput p2, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsu:I

    .line 10
    iput p3, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsv:I

    .line 11
    iput-boolean p4, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsw:Z

    .line 12
    iput-boolean p5, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsx:Z

    return-void
.end method

.method public static zzb(Landroid/os/Bundle;)Lcom/google/android/gms/games/video/CaptureState;
    .locals 7

    if-eqz p0, :cond_1

    const-string v0, "IsCapturing"

    .line 27
    invoke-virtual {p0, v0}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 29
    :cond_0
    new-instance v0, Lcom/google/android/gms/games/video/CaptureState;

    const-string v1, "IsCapturing"

    const/4 v2, 0x0

    .line 30
    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v3

    const-string v1, "CaptureMode"

    const/4 v4, -0x1

    .line 31
    invoke-virtual {p0, v1, v4}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v5

    const-string v1, "CaptureQuality"

    .line 32
    invoke-virtual {p0, v1, v4}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v4

    const-string v1, "IsOverlayVisible"

    .line 33
    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v6

    const-string v1, "IsPaused"

    .line 34
    invoke-virtual {p0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    move-object v1, v0

    move v2, v3

    move v3, v5

    move v5, v6

    move v6, p0

    invoke-direct/range {v1 .. v6}, Lcom/google/android/gms/games/video/CaptureState;-><init>(ZIIZZ)V

    return-object v0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method public final getCaptureMode()I
    .locals 1

    .line 15
    iget v0, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsu:I

    return v0
.end method

.method public final getCaptureQuality()I
    .locals 1

    .line 16
    iget v0, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsv:I

    return v0
.end method

.method public final isCapturing()Z
    .locals 1

    .line 14
    iget-boolean v0, p0, Lcom/google/android/gms/games/video/CaptureState;->zzst:Z

    return v0
.end method

.method public final isOverlayVisible()Z
    .locals 1

    .line 17
    iget-boolean v0, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsw:Z

    return v0
.end method

.method public final isPaused()Z
    .locals 1

    .line 18
    iget-boolean v0, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsx:Z

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 3

    .line 19
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IsCapturing"

    iget-boolean v2, p0, Lcom/google/android/gms/games/video/CaptureState;->zzst:Z

    .line 20
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "CaptureMode"

    iget v2, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsu:I

    .line 21
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "CaptureQuality"

    iget v2, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsv:I

    .line 22
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IsOverlayVisible"

    iget-boolean v2, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsw:Z

    .line 23
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IsPaused"

    iget-boolean v2, p0, Lcom/google/android/gms/games/video/CaptureState;->zzsx:Z

    .line 24
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    .line 25
    invoke-virtual {v0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
