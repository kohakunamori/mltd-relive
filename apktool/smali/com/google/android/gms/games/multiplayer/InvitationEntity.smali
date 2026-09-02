.class public final Lcom/google/android/gms/games/multiplayer/InvitationEntity;
.super Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;

# interfaces
.implements Lcom/google/android/gms/games/multiplayer/Invitation;


# annotations
.annotation build Lcom/google/android/apps/common/proguard/UsedByReflection;
    value = "GamesClientImpl.java"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "InvitationEntityCreator"
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
        Lcom/google/android/gms/games/multiplayer/InvitationEntity$zza;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/games/multiplayer/InvitationEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final zzlp:Lcom/google/android/gms/games/GameEntity;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getGame"
        id = 0x1
    .end annotation
.end field

.field private final zzoy:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getInvitationId"
        id = 0x2
    .end annotation
.end field

.field private final zzoz:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCreationTimestamp"
        id = 0x3
    .end annotation
.end field

.field private final zzpa:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getInvitationType"
        id = 0x4
    .end annotation
.end field

.field private final zzpb:Lcom/google/android/gms/games/multiplayer/ParticipantEntity;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getInviter"
        id = 0x5
    .end annotation
.end field

.field private final zzpc:Ljava/util/ArrayList;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getParticipants"
        id = 0x6
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/google/android/gms/games/multiplayer/ParticipantEntity;",
            ">;"
        }
    .end annotation
.end field

.field private final zzpd:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getVariant"
        id = 0x7
    .end annotation
.end field

.field private final zzpe:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getAvailableAutoMatchSlots"
        id = 0x8
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 131
    new-instance v0, Lcom/google/android/gms/games/multiplayer/InvitationEntity$zza;

    invoke-direct {v0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity$zza;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method constructor <init>(Lcom/google/android/gms/games/GameEntity;Ljava/lang/String;JILcom/google/android/gms/games/multiplayer/ParticipantEntity;Ljava/util/ArrayList;II)V
    .locals 0
    .param p1    # Lcom/google/android/gms/games/GameEntity;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p3    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x3
        .end annotation
    .end param
    .param p5    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p6    # Lcom/google/android/gms/games/multiplayer/ParticipantEntity;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p7    # Ljava/util/ArrayList;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .param p8    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x7
        .end annotation
    .end param
    .param p9    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x8
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/GameEntity;",
            "Ljava/lang/String;",
            "JI",
            "Lcom/google/android/gms/games/multiplayer/ParticipantEntity;",
            "Ljava/util/ArrayList<",
            "Lcom/google/android/gms/games/multiplayer/ParticipantEntity;",
            ">;II)V"
        }
    .end annotation

    .line 21
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;-><init>()V

    .line 22
    iput-object p1, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    .line 23
    iput-object p2, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoy:Ljava/lang/String;

    .line 24
    iput-wide p3, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoz:J

    .line 25
    iput p5, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpa:I

    .line 26
    iput-object p6, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpb:Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    .line 27
    iput-object p7, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    .line 28
    iput p8, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpd:I

    .line 29
    iput p9, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpe:I

    return-void
.end method

.method constructor <init>(Lcom/google/android/gms/games/multiplayer/Invitation;)V
    .locals 1
    .param p1    # Lcom/google/android/gms/games/multiplayer/Invitation;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param

    .line 1
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getParticipants()Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->zza(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;-><init>(Lcom/google/android/gms/games/multiplayer/Invitation;Ljava/util/ArrayList;)V

    return-void
.end method

.method private constructor <init>(Lcom/google/android/gms/games/multiplayer/Invitation;Ljava/util/ArrayList;)V
    .locals 4
    .param p1    # Lcom/google/android/gms/games/multiplayer/Invitation;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Ljava/util/ArrayList;
        .annotation build Landroidx/annotation/NonNull;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/multiplayer/Invitation;",
            "Ljava/util/ArrayList<",
            "Lcom/google/android/gms/games/multiplayer/ParticipantEntity;",
            ">;)V"
        }
    .end annotation

    .line 3
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;-><init>()V

    .line 4
    new-instance v0, Lcom/google/android/gms/games/GameEntity;

    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/google/android/gms/games/GameEntity;-><init>(Lcom/google/android/gms/games/Game;)V

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    .line 5
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoy:Ljava/lang/String;

    .line 6
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getCreationTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoz:J

    .line 7
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationType()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpa:I

    .line 8
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getVariant()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpd:I

    .line 9
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getAvailableAutoMatchSlots()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpe:I

    .line 10
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInviter()Lcom/google/android/gms/games/multiplayer/Participant;

    move-result-object p1

    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Participant;->getParticipantId()Ljava/lang/String;

    move-result-object p1

    .line 11
    iput-object p2, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    .line 13
    check-cast p2, Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :cond_0
    if-ge v1, v0, :cond_1

    invoke-virtual {p2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    add-int/lit8 v1, v1, 0x1

    check-cast v2, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    .line 14
    invoke-virtual {v2}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->getParticipantId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    const-string p1, "Must have a valid inviter!"

    .line 18
    invoke-static {v2, p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 19
    iput-object v2, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpb:Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    return-void
.end method

.method static zza(Lcom/google/android/gms/games/multiplayer/Invitation;)I
    .locals 3

    const/16 v0, 0x8

    .line 49
    new-array v0, v0, [Ljava/lang/Object;

    .line 50
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 51
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationId()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 52
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getCreationTimestamp()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 53
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationType()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 54
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInviter()Lcom/google/android/gms/games/multiplayer/Participant;

    move-result-object v1

    const/4 v2, 0x4

    aput-object v1, v0, v2

    .line 55
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getParticipants()Ljava/util/ArrayList;

    move-result-object v1

    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 56
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getVariant()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 57
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getAvailableAutoMatchSlots()I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    const/4 v1, 0x7

    aput-object p0, v0, v1

    .line 58
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Objects;->hashCode([Ljava/lang/Object;)I

    move-result p0

    return p0
.end method

.method static zza(Lcom/google/android/gms/games/multiplayer/Invitation;Ljava/lang/Object;)Z
    .locals 5

    .line 60
    instance-of v0, p1, Lcom/google/android/gms/games/multiplayer/Invitation;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    if-ne p0, p1, :cond_1

    return v0

    .line 64
    :cond_1
    check-cast p1, Lcom/google/android/gms/games/multiplayer/Invitation;

    .line 65
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 66
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationId()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 67
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getCreationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getCreationTimestamp()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 68
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationType()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 69
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInviter()Lcom/google/android/gms/games/multiplayer/Participant;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInviter()Lcom/google/android/gms/games/multiplayer/Participant;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 70
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getParticipants()Ljava/util/ArrayList;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getParticipants()Ljava/util/ArrayList;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 71
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getVariant()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getVariant()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 72
    invoke-interface {p1}, Lcom/google/android/gms/games/multiplayer/Invitation;->getAvailableAutoMatchSlots()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getAvailableAutoMatchSlots()I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    .line 73
    invoke-static {p1, p0}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    return v0

    :cond_2
    return v1
.end method

.method static synthetic zza(Ljava/lang/Integer;)Z
    .locals 0

    .line 129
    invoke-static {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzb(Ljava/lang/Integer;)Z

    move-result p0

    return p0
.end method

.method static synthetic zza(Ljava/lang/String;)Z
    .locals 0

    .line 130
    invoke-static {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->canUnparcelSafely(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static zzb(Lcom/google/android/gms/games/multiplayer/Invitation;)Ljava/lang/String;
    .locals 4

    .line 76
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Game"

    .line 77
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "InvitationId"

    .line 78
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "CreationTimestamp"

    .line 79
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getCreationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "InvitationType"

    .line 80
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInvitationType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Inviter"

    .line 81
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getInviter()Lcom/google/android/gms/games/multiplayer/Participant;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Participants"

    .line 82
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getParticipants()Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Variant"

    .line 83
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getVariant()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "AvailableAutoMatchSlots"

    .line 84
    invoke-interface {p0}, Lcom/google/android/gms/games/multiplayer/Invitation;->getAvailableAutoMatchSlots()I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    invoke-virtual {v0, v1, p0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object p0

    .line 85
    invoke-virtual {p0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic zzf()Ljava/lang/Integer;
    .locals 1

    .line 128
    invoke-static {}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getUnparcelClientVersion()Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 0

    .line 59
    invoke-static {p0, p1}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zza(Lcom/google/android/gms/games/multiplayer/Invitation;Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final freeze()Lcom/google/android/gms/games/multiplayer/Invitation;
    .locals 0

    return-object p0
.end method

.method public final bridge synthetic freeze()Ljava/lang/Object;
    .locals 1

    .line 127
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->freeze()Lcom/google/android/gms/games/multiplayer/Invitation;

    move-result-object v0

    return-object v0
.end method

.method public final getAvailableAutoMatchSlots()I
    .locals 1

    .line 38
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpe:I

    return v0
.end method

.method public final getCreationTimestamp()J
    .locals 2

    .line 34
    iget-wide v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoz:J

    return-wide v0
.end method

.method public final getGame()Lcom/google/android/gms/games/Game;
    .locals 1

    .line 31
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    return-object v0
.end method

.method public final getInvitationId()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoy:Ljava/lang/String;

    return-object v0
.end method

.method public final getInvitationType()I
    .locals 1

    .line 36
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpa:I

    return v0
.end method

.method public final getInviter()Lcom/google/android/gms/games/multiplayer/Participant;
    .locals 1

    .line 33
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpb:Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    return-object v0
.end method

.method public final getParticipants()Ljava/util/ArrayList;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/google/android/gms/games/multiplayer/Participant;",
            ">;"
        }
    .end annotation

    .line 35
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method public final getVariant()I
    .locals 1

    .line 37
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpd:I

    return v0
.end method

.method public final hashCode()I
    .locals 1

    .line 48
    invoke-static {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zza(Lcom/google/android/gms/games/multiplayer/Invitation;)I

    move-result v0

    return v0
.end method

.method public final isDataValid()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public final setShouldDowngrade(Z)V
    .locals 3

    .line 41
    invoke-super {p0, p1}, Lcom/google/android/gms/games/internal/GamesDowngradeableSafeParcel;->setShouldDowngrade(Z)V

    .line 42
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/GameEntity;->setShouldDowngrade(Z)V

    .line 43
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpb:Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    invoke-virtual {v0, p1}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->setShouldDowngrade(Z)V

    .line 44
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    .line 45
    iget-object v2, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    invoke-virtual {v2, p1}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->setShouldDowngrade(Z)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    .line 75
    invoke-static {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzb(Lcom/google/android/gms/games/multiplayer/Invitation;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 5

    .line 87
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->shouldDowngrade()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 89
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    .line 91
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    const/4 v3, 0x1

    .line 92
    invoke-static {p1, v3, v2, p2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/4 v2, 0x2

    .line 94
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getInvitationId()Ljava/lang/String;

    move-result-object v3

    .line 95
    invoke-static {p1, v2, v3, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/4 v2, 0x3

    .line 97
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getCreationTimestamp()J

    move-result-wide v3

    .line 98
    invoke-static {p1, v2, v3, v4}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    const/4 v2, 0x4

    .line 100
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getInvitationType()I

    move-result v3

    .line 101
    invoke-static {p1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    const/4 v2, 0x5

    .line 103
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getInviter()Lcom/google/android/gms/games/multiplayer/Participant;

    move-result-object v3

    .line 104
    invoke-static {p1, v2, v3, p2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/4 p2, 0x6

    .line 106
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getParticipants()Ljava/util/ArrayList;

    move-result-object v2

    .line 107
    invoke-static {p1, p2, v2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeTypedList(Landroid/os/Parcel;ILjava/util/List;Z)V

    const/4 p2, 0x7

    .line 109
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getVariant()I

    move-result v1

    .line 110
    invoke-static {p1, p2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    const/16 p2, 0x8

    .line 112
    invoke-virtual {p0}, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->getAvailableAutoMatchSlots()I

    move-result v1

    .line 113
    invoke-static {p1, p2, v1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 114
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void

    .line 116
    :cond_0
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/GameEntity;->writeToParcel(Landroid/os/Parcel;I)V

    .line 117
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoy:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    .line 118
    iget-wide v2, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzoz:J

    invoke-virtual {p1, v2, v3}, Landroid/os/Parcel;->writeLong(J)V

    .line 119
    iget v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpa:I

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    .line 120
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpb:Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    invoke-virtual {v0, p1, p2}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->writeToParcel(Landroid/os/Parcel;I)V

    .line 121
    iget-object v0, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 122
    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    :goto_0
    if-ge v1, v0, :cond_1

    .line 124
    iget-object v2, p0, Lcom/google/android/gms/games/multiplayer/InvitationEntity;->zzpc:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    invoke-virtual {v2, p1, p2}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->writeToParcel(Landroid/os/Parcel;I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method
