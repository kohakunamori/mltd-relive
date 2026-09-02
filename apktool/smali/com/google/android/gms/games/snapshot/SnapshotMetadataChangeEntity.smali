.class public final Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;
.super Lcom/google/android/gms/games/internal/zzd;

# interfaces
.implements Lcom/google/android/gms/games/snapshot/SnapshotMetadataChange;


# annotations
.annotation build Lcom/google/android/apps/common/proguard/UsedByReflection;
    value = "GamesClientImpl.java"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "SnapshotMetadataChangeCreator"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Reserved;
    value = {
        0x3e8
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final description:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getDescription"
        id = 0x1
    .end annotation
.end field

.field private final zzru:Ljava/lang/Long;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getProgressValue"
        id = 0x6
    .end annotation
.end field

.field private final zzrw:Landroid/net/Uri;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCoverImageUri"
        id = 0x4
    .end annotation
.end field

.field private final zzrx:Ljava/lang/Long;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getPlayedTimeMillis"
        id = 0x2
    .end annotation
.end field

.field private zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCoverImageTeleporter"
        id = 0x5
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 40
    new-instance v0, Lcom/google/android/gms/games/snapshot/zzc;

    invoke-direct {v0}, Lcom/google/android/gms/games/snapshot/zzc;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method constructor <init>()V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    .line 1
    invoke-direct/range {v0 .. v5}, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;-><init>(Ljava/lang/String;Ljava/lang/Long;Lcom/google/android/gms/common/data/BitmapTeleporter;Landroid/net/Uri;Ljava/lang/Long;)V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/Long;Lcom/google/android/gms/common/data/BitmapTeleporter;Landroid/net/Uri;Ljava/lang/Long;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Ljava/lang/Long;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p3    # Lcom/google/android/gms/common/data/BitmapTeleporter;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p4    # Landroid/net/Uri;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p5    # Ljava/lang/Long;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    .line 3
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/zzd;-><init>()V

    .line 4
    iput-object p1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->description:Ljava/lang/String;

    .line 5
    iput-object p2, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzrx:Ljava/lang/Long;

    .line 6
    iput-object p3, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    .line 7
    iput-object p4, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzrw:Landroid/net/Uri;

    .line 8
    iput-object p5, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzru:Ljava/lang/Long;

    .line 9
    iget-object p1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    const/4 p2, 0x0

    const/4 p3, 0x1

    if-eqz p1, :cond_1

    .line 10
    iget-object p1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzrw:Landroid/net/Uri;

    if-nez p1, :cond_0

    const/4 p2, 0x1

    :cond_0
    const-string p1, "Cannot set both a URI and an image"

    invoke-static {p2, p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    return-void

    .line 11
    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzrw:Landroid/net/Uri;

    if-eqz p1, :cond_3

    .line 12
    iget-object p1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    if-nez p1, :cond_2

    const/4 p2, 0x1

    :cond_2
    const-string p1, "Cannot set both a URI and an image"

    invoke-static {p2, p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    :cond_3
    return-void
.end method


# virtual methods
.method public final getCoverImage()Landroid/graphics/Bitmap;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    invoke-virtual {v0}, Lcom/google/android/gms/common/data/BitmapTeleporter;->get()Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public final getDescription()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->description:Ljava/lang/String;

    return-object v0
.end method

.method public final getPlayedTimeMillis()Ljava/lang/Long;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzrx:Ljava/lang/Long;

    return-object v0
.end method

.method public final getProgressValue()Ljava/lang/Long;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzru:Ljava/lang/Long;

    return-object v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 4

    .line 20
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    .line 22
    invoke-virtual {p0}, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->getDescription()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 23
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 25
    invoke-virtual {p0}, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->getPlayedTimeMillis()Ljava/lang/Long;

    move-result-object v1

    const/4 v3, 0x2

    .line 26
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLongObject(Landroid/os/Parcel;ILjava/lang/Long;Z)V

    .line 28
    iget-object v1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzrw:Landroid/net/Uri;

    const/4 v3, 0x4

    .line 30
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 32
    iget-object v1, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    const/4 v3, 0x5

    .line 34
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 36
    invoke-virtual {p0}, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->getProgressValue()Ljava/lang/Long;

    move-result-object p2

    const/4 v1, 0x6

    .line 37
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLongObject(Landroid/os/Parcel;ILjava/lang/Long;Z)V

    .line 38
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zzdt()Lcom/google/android/gms/common/data/BitmapTeleporter;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/google/android/gms/games/snapshot/SnapshotMetadataChangeEntity;->zzry:Lcom/google/android/gms/common/data/BitmapTeleporter;

    return-object v0
.end method
