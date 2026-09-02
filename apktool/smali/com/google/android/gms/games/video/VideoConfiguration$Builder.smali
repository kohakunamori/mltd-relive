.class public final Lcom/google/android/gms/games/video/VideoConfiguration$Builder;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/video/VideoConfiguration;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private zzsu:I

.field private zztd:I

.field private zzte:Z

.field private zztf:Z

.field private zztg:Z


# direct methods
.method public constructor <init>(II)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    iput p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztd:I

    .line 3
    iput p2, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zzsu:I

    const/4 p1, 0x1

    .line 4
    iput-boolean p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztf:Z

    .line 5
    iput-boolean p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztg:Z

    .line 6
    iput-boolean p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zzte:Z

    return-void
.end method


# virtual methods
.method public final build()Lcom/google/android/gms/games/video/VideoConfiguration;
    .locals 7

    .line 16
    new-instance v6, Lcom/google/android/gms/games/video/VideoConfiguration;

    iget v1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztd:I

    iget v2, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zzsu:I

    iget-boolean v3, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zzte:Z

    iget-boolean v4, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztf:Z

    iget-boolean v5, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztg:Z

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/google/android/gms/games/video/VideoConfiguration;-><init>(IIZZZ)V

    return-object v6
.end method

.method public final setCameraEnabled(Z)Lcom/google/android/gms/games/video/VideoConfiguration$Builder;
    .locals 0

    .line 14
    iput-boolean p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztf:Z

    return-object p0
.end method

.method public final setCaptureMode(I)Lcom/google/android/gms/games/video/VideoConfiguration$Builder;
    .locals 0

    .line 10
    iput p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zzsu:I

    return-object p0
.end method

.method public final setMicEnabled(Z)Lcom/google/android/gms/games/video/VideoConfiguration$Builder;
    .locals 0

    .line 12
    iput-boolean p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztg:Z

    return-object p0
.end method

.method public final setQualityLevel(I)Lcom/google/android/gms/games/video/VideoConfiguration$Builder;
    .locals 0

    .line 8
    iput p1, p0, Lcom/google/android/gms/games/video/VideoConfiguration$Builder;->zztd:I

    return-object p0
.end method
