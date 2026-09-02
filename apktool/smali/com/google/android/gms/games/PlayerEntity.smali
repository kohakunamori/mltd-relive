.class public final Lcom/google/android/gms/games/PlayerEntity;
.super Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;

# interfaces
.implements Lcom/google/android/gms/games/Player;


# annotations
.annotation build Lcom/google/android/apps/common/proguard/UsedByReflection;
    value = "GamesClientImpl.java"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "PlayerEntityCreator"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Reserved;
    value = {
        0x3e8
    }
.end annotation

.annotation build Lcom/google/android/gms/common/util/RetainForClient;
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/android/gms/games/PlayerEntity$zza;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/games/PlayerEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final name:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getName"
        id = 0x15
    .end annotation
.end field

.field private final zzac:Ljava/lang/String;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getIconImageUrl"
        id = 0x8
    .end annotation
.end field

.field private final zzad:Ljava/lang/String;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getHiResImageUrl"
        id = 0x9
    .end annotation
.end field

.field private zzbz:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getPlayerId"
        id = 0x1
    .end annotation
.end field

.field private final zzca:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getRetrievedTimestamp"
        id = 0x5
    .end annotation
.end field

.field private final zzcb:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "isInCircles"
        id = 0x6
    .end annotation
.end field

.field private final zzcc:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getLastPlayedWithTimestamp"
        id = 0x7
    .end annotation
.end field

.field private final zzcd:Ljava/lang/String;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getTitle"
        id = 0xe
    .end annotation
.end field

.field private final zzce:Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getMostRecentGameInfo"
        id = 0xf
    .end annotation
.end field

.field private final zzcf:Lcom/google/android/gms/games/PlayerLevelInfo;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getLevelInfo"
        id = 0x10
    .end annotation
.end field

.field private final zzcg:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "isProfileVisible"
        id = 0x12
    .end annotation
.end field

.field private final zzch:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "hasDebugAccess"
        id = 0x13
    .end annotation
.end field

.field private final zzci:Ljava/lang/String;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getGamerTag"
        id = 0x14
    .end annotation
.end field

.field private final zzcj:Landroid/net/Uri;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getBannerImageLandscapeUri"
        id = 0x16
    .end annotation
.end field

.field private final zzck:Ljava/lang/String;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getBannerImageLandscapeUrl"
        id = 0x17
    .end annotation
.end field

.field private final zzcl:Landroid/net/Uri;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getBannerImagePortraitUri"
        id = 0x18
    .end annotation
.end field

.field private final zzcm:Ljava/lang/String;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getBannerImagePortraitUrl"
        id = 0x19
    .end annotation
.end field

.field private final zzcn:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getGamerFriendStatus"
        id = 0x1a
    .end annotation
.end field

.field private final zzco:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getGamerFriendUpdateTimestamp"
        id = 0x1b
    .end annotation
.end field

.field private final zzcp:Z
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "isMuted"
        id = 0x1c
    .end annotation
.end field

.field private final zzcq:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        defaultValue = "-1"
        getter = "getTotalUnlockedAchievement"
        id = 0x1d
    .end annotation
.end field

.field private zzn:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getDisplayName"
        id = 0x2
    .end annotation
.end field

.field private final zzr:Landroid/net/Uri;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getIconImageUri"
        id = 0x3
    .end annotation
.end field

.field private final zzs:Landroid/net/Uri;
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getHiResImageUri"
        id = 0x4
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 248
    new-instance v0, Lcom/google/android/gms/games/PlayerEntity$zza;

    invoke-direct {v0}, Lcom/google/android/gms/games/PlayerEntity$zza;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/PlayerEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Lcom/google/android/gms/games/Player;)V
    .locals 1

    const/4 v0, 0x1

    .line 1
    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/games/PlayerEntity;-><init>(Lcom/google/android/gms/games/Player;Z)V

    return-void
.end method

.method private constructor <init>(Lcom/google/android/gms/games/Player;Z)V
    .locals 3

    .line 3
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;-><init>()V

    .line 4
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzbz:Ljava/lang/String;

    .line 5
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getDisplayName()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzn:Ljava/lang/String;

    .line 6
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getIconImageUri()Landroid/net/Uri;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzr:Landroid/net/Uri;

    .line 7
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getIconImageUrl()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzac:Ljava/lang/String;

    .line 8
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getHiResImageUri()Landroid/net/Uri;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzs:Landroid/net/Uri;

    .line 9
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getHiResImageUrl()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzad:Ljava/lang/String;

    .line 10
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getRetrievedTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzca:J

    .line 11
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzj()I

    move-result p2

    iput p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcb:I

    .line 12
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getLastPlayedWithTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcc:J

    .line 13
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getTitle()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcd:Ljava/lang/String;

    .line 14
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzk()Z

    move-result p2

    iput-boolean p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcg:Z

    .line 15
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzl()Lcom/google/android/gms/games/internal/player/zza;

    move-result-object p2

    if-nez p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    .line 16
    :cond_0
    new-instance v0, Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;

    invoke-direct {v0, p2}, Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;-><init>(Lcom/google/android/gms/games/internal/player/zza;)V

    move-object p2, v0

    :goto_0
    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzce:Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;

    .line 17
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcf:Lcom/google/android/gms/games/PlayerLevelInfo;

    .line 18
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzi()Z

    move-result p2

    iput-boolean p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzch:Z

    .line 19
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzh()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzci:Ljava/lang/String;

    .line 20
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getName()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->name:Ljava/lang/String;

    .line 21
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUri()Landroid/net/Uri;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcj:Landroid/net/Uri;

    .line 22
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUrl()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzck:Ljava/lang/String;

    .line 23
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUri()Landroid/net/Uri;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcl:Landroid/net/Uri;

    .line 24
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUrl()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcm:Ljava/lang/String;

    .line 25
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzm()I

    move-result p2

    iput p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcn:I

    .line 26
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzn()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzco:J

    .line 27
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->isMuted()Z

    move-result p2

    iput-boolean p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcp:Z

    .line 28
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzo()J

    move-result-wide p1

    iput-wide p1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcq:J

    .line 29
    iget-object p1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzbz:Ljava/lang/String;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Asserts;->checkNotNull(Ljava/lang/Object;)V

    .line 30
    iget-object p1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzn:Ljava/lang/String;

    invoke-static {p1}, Lcom/google/android/gms/common/internal/Asserts;->checkNotNull(Ljava/lang/Object;)V

    .line 31
    iget-wide p1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzca:J

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-lez v2, :cond_1

    const/4 p1, 0x1

    goto :goto_1

    :cond_1
    const/4 p1, 0x0

    :goto_1
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Asserts;->checkState(Z)V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Landroid/net/Uri;JIJLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;Lcom/google/android/gms/games/PlayerLevelInfo;ZZLjava/lang/String;Ljava/lang/String;Landroid/net/Uri;Ljava/lang/String;Landroid/net/Uri;Ljava/lang/String;IJZJ)V
    .locals 3
    .param p1    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p3    # Landroid/net/Uri;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x3
        .end annotation
    .end param
    .param p4    # Landroid/net/Uri;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p5    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p7    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .param p8    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x7
        .end annotation
    .end param
    .param p10    # Ljava/lang/String;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x8
        .end annotation
    .end param
    .param p11    # Ljava/lang/String;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x9
        .end annotation
    .end param
    .param p12    # Ljava/lang/String;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xe
        .end annotation
    .end param
    .param p13    # Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xf
        .end annotation
    .end param
    .param p14    # Lcom/google/android/gms/games/PlayerLevelInfo;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x10
        .end annotation
    .end param
    .param p15    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x12
        .end annotation
    .end param
    .param p16    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x13
        .end annotation
    .end param
    .param p17    # Ljava/lang/String;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x14
        .end annotation
    .end param
    .param p18    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x15
        .end annotation
    .end param
    .param p19    # Landroid/net/Uri;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x16
        .end annotation
    .end param
    .param p20    # Ljava/lang/String;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x17
        .end annotation
    .end param
    .param p21    # Landroid/net/Uri;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x18
        .end annotation
    .end param
    .param p22    # Ljava/lang/String;
        .annotation build Landroidx/annotation/Nullable;
        .end annotation

        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x19
        .end annotation
    .end param
    .param p23    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1a
        .end annotation
    .end param
    .param p24    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1b
        .end annotation
    .end param
    .param p26    # Z
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1c
        .end annotation
    .end param
    .param p27    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1d
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    move-object v0, p0

    .line 33
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;-><init>()V

    move-object v1, p1

    .line 34
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzbz:Ljava/lang/String;

    move-object v1, p2

    .line 35
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzn:Ljava/lang/String;

    move-object v1, p3

    .line 36
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzr:Landroid/net/Uri;

    move-object v1, p10

    .line 37
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzac:Ljava/lang/String;

    move-object v1, p4

    .line 38
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzs:Landroid/net/Uri;

    move-object v1, p11

    .line 39
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzad:Ljava/lang/String;

    move-wide v1, p5

    .line 40
    iput-wide v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzca:J

    move v1, p7

    .line 41
    iput v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcb:I

    move-wide v1, p8

    .line 42
    iput-wide v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcc:J

    move-object v1, p12

    .line 43
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcd:Ljava/lang/String;

    move/from16 v1, p15

    .line 44
    iput-boolean v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcg:Z

    move-object/from16 v1, p13

    .line 45
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzce:Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;

    move-object/from16 v1, p14

    .line 46
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcf:Lcom/google/android/gms/games/PlayerLevelInfo;

    move/from16 v1, p16

    .line 47
    iput-boolean v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzch:Z

    move-object/from16 v1, p17

    .line 48
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzci:Ljava/lang/String;

    move-object/from16 v1, p18

    .line 49
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->name:Ljava/lang/String;

    move-object/from16 v1, p19

    .line 50
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcj:Landroid/net/Uri;

    move-object/from16 v1, p20

    .line 51
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzck:Ljava/lang/String;

    move-object/from16 v1, p21

    .line 52
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcl:Landroid/net/Uri;

    move-object/from16 v1, p22

    .line 53
    iput-object v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcm:Ljava/lang/String;

    move/from16 v1, p23

    .line 54
    iput v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcn:I

    move-wide/from16 v1, p24

    .line 55
    iput-wide v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzco:J

    move/from16 v1, p26

    .line 56
    iput-boolean v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcp:Z

    move-wide/from16 v1, p27

    .line 57
    iput-wide v1, v0, Lcom/google/android/gms/games/PlayerEntity;->zzcq:J

    return-void
.end method

.method static zza(Lcom/google/android/gms/games/Player;)I
    .locals 3

    const/16 v0, 0x10

    .line 92
    new-array v0, v0, [Ljava/lang/Object;

    .line 93
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 94
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getDisplayName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 95
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzi()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 96
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getIconImageUri()Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 97
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getHiResImageUri()Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x4

    aput-object v1, v0, v2

    .line 98
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getRetrievedTimestamp()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 99
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getTitle()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 100
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;

    move-result-object v1

    const/4 v2, 0x7

    aput-object v1, v0, v2

    .line 101
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzh()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x8

    aput-object v1, v0, v2

    .line 102
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x9

    aput-object v1, v0, v2

    .line 103
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUri()Landroid/net/Uri;

    move-result-object v1

    const/16 v2, 0xa

    aput-object v1, v0, v2

    .line 104
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUri()Landroid/net/Uri;

    move-result-object v1

    const/16 v2, 0xb

    aput-object v1, v0, v2

    .line 105
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzm()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0xc

    aput-object v1, v0, v2

    .line 106
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzn()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/16 v2, 0xd

    aput-object v1, v0, v2

    .line 107
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->isMuted()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const/16 v2, 0xe

    aput-object v1, v0, v2

    .line 108
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzo()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    const/16 v1, 0xf

    aput-object p0, v0, v1

    .line 109
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Objects;->hashCode([Ljava/lang/Object;)I

    move-result p0

    return p0
.end method

.method static zza(Lcom/google/android/gms/games/Player;Ljava/lang/Object;)Z
    .locals 5

    .line 111
    instance-of v0, p1, Lcom/google/android/gms/games/Player;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    if-ne p0, p1, :cond_1

    return v0

    .line 115
    :cond_1
    check-cast p1, Lcom/google/android/gms/games/Player;

    .line 116
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 117
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getDisplayName()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getDisplayName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 118
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzi()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzi()Z

    move-result v3

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 119
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getIconImageUri()Landroid/net/Uri;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getIconImageUri()Landroid/net/Uri;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 120
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getHiResImageUri()Landroid/net/Uri;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getHiResImageUri()Landroid/net/Uri;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 121
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getRetrievedTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getRetrievedTimestamp()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 122
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getTitle()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getTitle()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 123
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 124
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzh()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzh()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 125
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 126
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUri()Landroid/net/Uri;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUri()Landroid/net/Uri;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 127
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUri()Landroid/net/Uri;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUri()Landroid/net/Uri;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 128
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzm()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzm()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 129
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzn()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzn()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    .line 130
    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 131
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->isMuted()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->isMuted()Z

    move-result v3

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 132
    invoke-interface {p1}, Lcom/google/android/gms/games/Player;->zzo()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzo()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-static {p1, p0}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    return v0

    :cond_2
    return v1
.end method

.method static synthetic zza(Ljava/lang/Integer;)Z
    .locals 0

    .line 246
    invoke-static {p0}, Lcom/google/android/gms/games/PlayerEntity;->zzb(Ljava/lang/Integer;)Z

    move-result p0

    return p0
.end method

.method static synthetic zza(Ljava/lang/String;)Z
    .locals 0

    .line 247
    invoke-static {p0}, Lcom/google/android/gms/games/PlayerEntity;->canUnparcelSafely(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static zzb(Lcom/google/android/gms/games/Player;)Ljava/lang/String;
    .locals 4

    .line 135
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "PlayerId"

    .line 136
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "DisplayName"

    .line 137
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getDisplayName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "HasDebugAccess"

    .line 138
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzi()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IconImageUri"

    .line 139
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getIconImageUri()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IconImageUrl"

    .line 140
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getIconImageUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "HiResImageUri"

    .line 141
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getHiResImageUri()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "HiResImageUrl"

    .line 142
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getHiResImageUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "RetrievedTimestamp"

    .line 143
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getRetrievedTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Title"

    .line 144
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getTitle()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "LevelInfo"

    .line 145
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "GamerTag"

    .line 146
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzh()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Name"

    .line 147
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "BannerImageLandscapeUri"

    .line 148
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUri()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "BannerImageLandscapeUrl"

    .line 149
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImageLandscapeUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "BannerImagePortraitUri"

    .line 150
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUri()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "BannerImagePortraitUrl"

    .line 151
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->getBannerImagePortraitUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "GamerFriendStatus"

    .line 152
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzm()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "GamerFriendUpdateTimestamp"

    .line 153
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzn()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IsMuted"

    .line 154
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->isMuted()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "totalUnlockedAchievement"

    .line 155
    invoke-interface {p0}, Lcom/google/android/gms/games/Player;->zzo()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-virtual {v0, v1, p0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object p0

    .line 156
    invoke-virtual {p0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic zzf()Ljava/lang/Integer;
    .locals 1

    .line 245
    invoke-static {}, Lcom/google/android/gms/games/PlayerEntity;->getUnparcelClientVersion()Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 0

    .line 110
    invoke-static {p0, p1}, Lcom/google/android/gms/games/PlayerEntity;->zza(Lcom/google/android/gms/games/Player;Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final freeze()Lcom/google/android/gms/games/Player;
    .locals 0

    return-object p0
.end method

.method public final bridge synthetic freeze()Ljava/lang/Object;
    .locals 1

    .line 244
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->freeze()Lcom/google/android/gms/games/Player;

    move-result-object v0

    return-object v0
.end method

.method public final getBannerImageLandscapeUri()Landroid/net/Uri;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 81
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcj:Landroid/net/Uri;

    return-object v0
.end method

.method public final getBannerImageLandscapeUrl()Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 82
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzck:Ljava/lang/String;

    return-object v0
.end method

.method public final getBannerImagePortraitUri()Landroid/net/Uri;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 83
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcl:Landroid/net/Uri;

    return-object v0
.end method

.method public final getBannerImagePortraitUrl()Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 84
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcm:Ljava/lang/String;

    return-object v0
.end method

.method public final getDisplayName()Ljava/lang/String;
    .locals 1

    .line 60
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzn:Ljava/lang/String;

    return-object v0
.end method

.method public final getDisplayName(Landroid/database/CharArrayBuffer;)V
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzn:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/google/android/gms/common/util/DataUtils;->copyStringToBuffer(Ljava/lang/String;Landroid/database/CharArrayBuffer;)V

    return-void
.end method

.method public final getHiResImageUri()Landroid/net/Uri;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 70
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzs:Landroid/net/Uri;

    return-object v0
.end method

.method public final getHiResImageUrl()Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 71
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzad:Ljava/lang/String;

    return-object v0
.end method

.method public final getIconImageUri()Landroid/net/Uri;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 67
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzr:Landroid/net/Uri;

    return-object v0
.end method

.method public final getIconImageUrl()Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 68
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzac:Ljava/lang/String;

    return-object v0
.end method

.method public final getLastPlayedWithTimestamp()J
    .locals 2

    .line 73
    iget-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcc:J

    return-wide v0
.end method

.method public final getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 79
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcf:Lcom/google/android/gms/games/PlayerLevelInfo;

    return-object v0
.end method

.method public final getName()Ljava/lang/String;
    .locals 1

    .line 64
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final getPlayerId()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzbz:Ljava/lang/String;

    return-object v0
.end method

.method public final getRetrievedTimestamp()J
    .locals 2

    .line 72
    iget-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzca:J

    return-wide v0
.end method

.method public final getTitle()Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 76
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcd:Ljava/lang/String;

    return-object v0
.end method

.method public final getTitle(Landroid/database/CharArrayBuffer;)V
    .locals 1

    .line 77
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcd:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/google/android/gms/common/util/DataUtils;->copyStringToBuffer(Ljava/lang/String;Landroid/database/CharArrayBuffer;)V

    return-void
.end method

.method public final hasHiResImage()Z
    .locals 1

    .line 69
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getHiResImageUri()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final hasIconImage()Z
    .locals 1

    .line 66
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getIconImageUri()Landroid/net/Uri;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public final hashCode()I
    .locals 1

    .line 91
    invoke-static {p0}, Lcom/google/android/gms/games/PlayerEntity;->zza(Lcom/google/android/gms/games/Player;)I

    move-result v0

    return v0
.end method

.method public final isDataValid()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public final isMuted()Z
    .locals 1

    .line 87
    iget-boolean v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcp:Z

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    .line 134
    invoke-static {p0}, Lcom/google/android/gms/games/PlayerEntity;->zzb(Lcom/google/android/gms/games/Player;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 6

    .line 158
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->shouldDowngrade()Z

    move-result v0

    if-nez v0, :cond_0

    .line 160
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    const/4 v1, 0x1

    .line 162
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getPlayerId()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    .line 163
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/4 v1, 0x2

    .line 165
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getDisplayName()Ljava/lang/String;

    move-result-object v2

    .line 166
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/4 v1, 0x3

    .line 168
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getIconImageUri()Landroid/net/Uri;

    move-result-object v2

    .line 169
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/4 v1, 0x4

    .line 171
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getHiResImageUri()Landroid/net/Uri;

    move-result-object v2

    .line 172
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/4 v1, 0x5

    .line 174
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getRetrievedTimestamp()J

    move-result-wide v4

    .line 175
    invoke-static {p1, v1, v4, v5}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    const/4 v1, 0x6

    .line 177
    iget v2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcb:I

    .line 178
    invoke-static {p1, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    const/4 v1, 0x7

    .line 180
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getLastPlayedWithTimestamp()J

    move-result-wide v4

    .line 181
    invoke-static {p1, v1, v4, v5}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    const/16 v1, 0x8

    .line 183
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getIconImageUrl()Ljava/lang/String;

    move-result-object v2

    .line 184
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 v1, 0x9

    .line 186
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getHiResImageUrl()Ljava/lang/String;

    move-result-object v2

    .line 187
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 v1, 0xe

    .line 189
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getTitle()Ljava/lang/String;

    move-result-object v2

    .line 190
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 v1, 0xf

    .line 192
    iget-object v2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzce:Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;

    .line 194
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0x10

    .line 196
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getLevelInfo()Lcom/google/android/gms/games/PlayerLevelInfo;

    move-result-object v2

    .line 197
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0x12

    .line 199
    iget-boolean v2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcg:Z

    .line 200
    invoke-static {p1, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    const/16 v1, 0x13

    .line 202
    iget-boolean v2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzch:Z

    .line 203
    invoke-static {p1, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    const/16 v1, 0x14

    .line 205
    iget-object v2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzci:Ljava/lang/String;

    .line 207
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 v1, 0x15

    .line 209
    iget-object v2, p0, Lcom/google/android/gms/games/PlayerEntity;->name:Ljava/lang/String;

    .line 211
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 v1, 0x16

    .line 213
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getBannerImageLandscapeUri()Landroid/net/Uri;

    move-result-object v2

    .line 214
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0x17

    .line 216
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getBannerImageLandscapeUrl()Ljava/lang/String;

    move-result-object v2

    .line 217
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 v1, 0x18

    .line 219
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getBannerImagePortraitUri()Landroid/net/Uri;

    move-result-object v2

    .line 220
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 p2, 0x19

    .line 222
    invoke-virtual {p0}, Lcom/google/android/gms/games/PlayerEntity;->getBannerImagePortraitUrl()Ljava/lang/String;

    move-result-object v1

    .line 223
    invoke-static {p1, p2, v1, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/16 p2, 0x1a

    .line 225
    iget v1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcn:I

    .line 226
    invoke-static {p1, p2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    const/16 p2, 0x1b

    .line 228
    iget-wide v1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzco:J

    .line 229
    invoke-static {p1, p2, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    const/16 p2, 0x1c

    .line 231
    iget-boolean v1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcp:Z

    .line 232
    invoke-static {p1, p2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBoolean(Landroid/os/Parcel;IZ)V

    const/16 p2, 0x1d

    .line 234
    iget-wide v1, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcq:J

    .line 235
    invoke-static {p1, p2, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    .line 236
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void

    .line 238
    :cond_0
    iget-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzbz:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 239
    iget-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzn:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 240
    iget-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzr:Landroid/net/Uri;

    const/4 v0, 0x0

    if-nez p2, :cond_1

    move-object p2, v0

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzr:Landroid/net/Uri;

    invoke-virtual {p2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 241
    iget-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzs:Landroid/net/Uri;

    if-nez p2, :cond_2

    goto :goto_1

    :cond_2
    iget-object p2, p0, Lcom/google/android/gms/games/PlayerEntity;->zzs:Landroid/net/Uri;

    invoke-virtual {p2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 242
    iget-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzca:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    return-void
.end method

.method public final zzh()Ljava/lang/String;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 63
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzci:Ljava/lang/String;

    return-object v0
.end method

.method public final zzi()Z
    .locals 1

    .line 65
    iget-boolean v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzch:Z

    return v0
.end method

.method public final zzj()I
    .locals 1

    .line 74
    iget v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcb:I

    return v0
.end method

.method public final zzk()Z
    .locals 1

    .line 75
    iget-boolean v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcg:Z

    return v0
.end method

.method public final zzl()Lcom/google/android/gms/games/internal/player/zza;
    .locals 1
    .annotation build Landroidx/annotation/Nullable;
    .end annotation

    .line 80
    iget-object v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzce:Lcom/google/android/gms/games/internal/player/MostRecentGameInfoEntity;

    return-object v0
.end method

.method public final zzm()I
    .locals 1

    .line 85
    iget v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcn:I

    return v0
.end method

.method public final zzn()J
    .locals 2

    .line 86
    iget-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzco:J

    return-wide v0
.end method

.method public final zzo()J
    .locals 2

    .line 88
    iget-wide v0, p0, Lcom/google/android/gms/games/PlayerEntity;->zzcq:J

    return-wide v0
.end method
