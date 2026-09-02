.class public final Lcom/google/android/gms/games/request/GameRequestEntity;
.super Lcom/google/android/gms/games/internal/zzd;

# interfaces
.implements Lcom/google/android/gms/games/request/GameRequest;


# annotations
.annotation build Lcom/google/android/apps/common/proguard/UsedByReflection;
    value = "GamesClientImpl.java"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "GameRequestEntityCreator"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Reserved;
    value = {
        0x3e8
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/games/request/GameRequestEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final data:[B
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getData"
        id = 0x3
    .end annotation
.end field

.field private final status:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getStatus"
        id = 0xc
    .end annotation
.end field

.field private final type:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getType"
        id = 0x7
    .end annotation
.end field

.field private final zzlp:Lcom/google/android/gms/games/GameEntity;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getGame"
        id = 0x1
    .end annotation
.end field

.field private final zzoz:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCreationTimestamp"
        id = 0x9
    .end annotation
.end field

.field private final zzrk:Lcom/google/android/gms/games/PlayerEntity;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getSender"
        id = 0x2
    .end annotation
.end field

.field private final zzrl:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getRequestId"
        id = 0x4
    .end annotation
.end field

.field private final zzrm:Ljava/util/ArrayList;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getRecipients"
        id = 0x5
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/google/android/gms/games/PlayerEntity;",
            ">;"
        }
    .end annotation
.end field

.field private final zzrn:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getExpirationTimestamp"
        id = 0xa
    .end annotation
.end field

.field private final zzro:Landroid/os/Bundle;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getRecipientStatusBundle"
        id = 0xb
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 130
    new-instance v0, Lcom/google/android/gms/games/request/zza;

    invoke-direct {v0}, Lcom/google/android/gms/games/request/zza;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/request/GameRequestEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method constructor <init>(Lcom/google/android/gms/games/GameEntity;Lcom/google/android/gms/games/PlayerEntity;[BLjava/lang/String;Ljava/util/ArrayList;IJJLandroid/os/Bundle;I)V
    .locals 0
    .param p1    # Lcom/google/android/gms/games/GameEntity;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/games/PlayerEntity;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p3    # [B
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x3
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p5    # Ljava/util/ArrayList;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p6    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x7
        .end annotation
    .end param
    .param p7    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x9
        .end annotation
    .end param
    .param p9    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xa
        .end annotation
    .end param
    .param p11    # Landroid/os/Bundle;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xb
        .end annotation
    .end param
    .param p12    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xc
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/gms/games/GameEntity;",
            "Lcom/google/android/gms/games/PlayerEntity;",
            "[B",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Lcom/google/android/gms/games/PlayerEntity;",
            ">;IJJ",
            "Landroid/os/Bundle;",
            "I)V"
        }
    .end annotation

    .line 25
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/zzd;-><init>()V

    .line 26
    iput-object p1, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    .line 27
    iput-object p2, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrk:Lcom/google/android/gms/games/PlayerEntity;

    .line 28
    iput-object p3, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->data:[B

    .line 29
    iput-object p4, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrl:Ljava/lang/String;

    .line 30
    iput-object p5, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrm:Ljava/util/ArrayList;

    .line 31
    iput p6, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->type:I

    .line 32
    iput-wide p7, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzoz:J

    .line 33
    iput-wide p9, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrn:J

    .line 34
    iput-object p11, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzro:Landroid/os/Bundle;

    .line 35
    iput p12, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->status:I

    return-void
.end method

.method public constructor <init>(Lcom/google/android/gms/games/request/GameRequest;)V
    .locals 6

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/zzd;-><init>()V

    .line 2
    new-instance v0, Lcom/google/android/gms/games/GameEntity;

    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/google/android/gms/games/GameEntity;-><init>(Lcom/google/android/gms/games/Game;)V

    iput-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    .line 3
    new-instance v0, Lcom/google/android/gms/games/PlayerEntity;

    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getSender()Lcom/google/android/gms/games/Player;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/google/android/gms/games/PlayerEntity;-><init>(Lcom/google/android/gms/games/Player;)V

    iput-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrk:Lcom/google/android/gms/games/PlayerEntity;

    .line 4
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getRequestId()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrl:Ljava/lang/String;

    .line 5
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getType()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->type:I

    .line 6
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getCreationTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzoz:J

    .line 7
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getExpirationTimestamp()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrn:J

    .line 8
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getStatus()I

    move-result v0

    iput v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->status:I

    .line 9
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getData()[B

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 11
    iput-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->data:[B

    goto :goto_0

    .line 12
    :cond_0
    array-length v2, v0

    new-array v2, v2, [B

    iput-object v2, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->data:[B

    .line 13
    iget-object v2, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->data:[B

    array-length v3, v0

    invoke-static {v0, v1, v2, v1, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 14
    :goto_0
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getRecipients()Ljava/util/List;

    move-result-object v0

    .line 15
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    .line 16
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v2}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v3, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrm:Ljava/util/ArrayList;

    .line 17
    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V

    iput-object v3, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzro:Landroid/os/Bundle;

    :goto_1
    if-ge v1, v2, :cond_1

    .line 19
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/android/gms/games/Player;

    invoke-interface {v3}, Lcom/google/android/gms/games/Player;->freeze()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/android/gms/games/Player;

    .line 20
    invoke-interface {v3}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object v4

    .line 21
    iget-object v5, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrm:Ljava/util/ArrayList;

    check-cast v3, Lcom/google/android/gms/games/PlayerEntity;

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 22
    iget-object v3, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzro:Landroid/os/Bundle;

    invoke-interface {p1, v4}, Lcom/google/android/gms/games/request/GameRequest;->getRecipientStatus(Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v3, v4, v5}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method static zza(Lcom/google/android/gms/games/request/GameRequest;)I
    .locals 4

    .line 50
    invoke-static {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->zzb(Lcom/google/android/gms/games/request/GameRequest;)[I

    move-result-object v0

    invoke-static {v0}, Ljava/util/Arrays;->hashCode([I)I

    move-result v0

    mul-int/lit8 v0, v0, 0x1f

    const/4 v1, 0x7

    new-array v1, v1, [Ljava/lang/Object;

    .line 51
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, v1, v3

    .line 52
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRecipients()Ljava/util/List;

    move-result-object v2

    const/4 v3, 0x1

    aput-object v2, v1, v3

    .line 53
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRequestId()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    aput-object v2, v1, v3

    .line 54
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getSender()Lcom/google/android/gms/games/Player;

    move-result-object v2

    const/4 v3, 0x3

    aput-object v2, v1, v3

    .line 55
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x4

    aput-object v2, v1, v3

    .line 56
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getCreationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x5

    aput-object v2, v1, v3

    .line 57
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getExpirationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    const/4 v2, 0x6

    aput-object p0, v1, v2

    .line 58
    invoke-static {v1}, Lcom/google/android/gms/common/internal/Objects;->hashCode([Ljava/lang/Object;)I

    move-result p0

    add-int/2addr v0, p0

    return v0
.end method

.method static zza(Lcom/google/android/gms/games/request/GameRequest;Ljava/lang/Object;)Z
    .locals 5

    .line 61
    instance-of v0, p1, Lcom/google/android/gms/games/request/GameRequest;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    const/4 v0, 0x1

    if-ne p0, p1, :cond_1

    return v0

    .line 65
    :cond_1
    check-cast p1, Lcom/google/android/gms/games/request/GameRequest;

    .line 66
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 67
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getRecipients()Ljava/util/List;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRecipients()Ljava/util/List;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 68
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getRequestId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRequestId()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 69
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getSender()Lcom/google/android/gms/games/Player;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getSender()Lcom/google/android/gms/games/Player;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 70
    invoke-static {p1}, Lcom/google/android/gms/games/request/GameRequestEntity;->zzb(Lcom/google/android/gms/games/request/GameRequest;)[I

    move-result-object v2

    invoke-static {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->zzb(Lcom/google/android/gms/games/request/GameRequest;)[I

    move-result-object v3

    invoke-static {v2, v3}, Ljava/util/Arrays;->equals([I[I)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 71
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getType()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 72
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getCreationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getCreationTimestamp()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 73
    invoke-interface {p1}, Lcom/google/android/gms/games/request/GameRequest;->getExpirationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getExpirationTimestamp()J

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

.method private static zzb(Lcom/google/android/gms/games/request/GameRequest;)[I
    .locals 5

    .line 75
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRecipients()Ljava/util/List;

    move-result-object v0

    .line 76
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    .line 77
    new-array v2, v1, [I

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_0

    .line 79
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/google/android/gms/games/Player;

    invoke-interface {v4}, Lcom/google/android/gms/games/Player;->getPlayerId()Ljava/lang/String;

    move-result-object v4

    invoke-interface {p0, v4}, Lcom/google/android/gms/games/request/GameRequest;->getRecipientStatus(Ljava/lang/String;)I

    move-result v4

    aput v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    return-object v2
.end method

.method static zzc(Lcom/google/android/gms/games/request/GameRequest;)Ljava/lang/String;
    .locals 4

    .line 83
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Game"

    .line 84
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Sender"

    .line 85
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getSender()Lcom/google/android/gms/games/Player;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Recipients"

    .line 86
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRecipients()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Data"

    .line 87
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getData()[B

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "RequestId"

    .line 88
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getRequestId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Type"

    .line 89
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "CreationTimestamp"

    .line 90
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getCreationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "ExpirationTimestamp"

    .line 91
    invoke-interface {p0}, Lcom/google/android/gms/games/request/GameRequest;->getExpirationTimestamp()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-virtual {v0, v1, p0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object p0

    .line 92
    invoke-virtual {p0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 0

    .line 60
    invoke-static {p0, p1}, Lcom/google/android/gms/games/request/GameRequestEntity;->zza(Lcom/google/android/gms/games/request/GameRequest;Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public final bridge synthetic freeze()Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public final getCreationTimestamp()J
    .locals 2

    .line 44
    iget-wide v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzoz:J

    return-wide v0
.end method

.method public final getData()[B
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->data:[B

    return-object v0
.end method

.method public final getExpirationTimestamp()J
    .locals 2

    .line 45
    iget-wide v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrn:J

    return-wide v0
.end method

.method public final getGame()Lcom/google/android/gms/games/Game;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    return-object v0
.end method

.method public final getRecipientStatus(Ljava/lang/String;)I
    .locals 2

    .line 46
    iget-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzro:Landroid/os/Bundle;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result p1

    return p1
.end method

.method public final getRecipients()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/games/Player;",
            ">;"
        }
    .end annotation

    .line 40
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrm:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method public final getRequestId()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getSender()Lcom/google/android/gms/games/Player;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzrk:Lcom/google/android/gms/games/PlayerEntity;

    return-object v0
.end method

.method public final getStatus()I
    .locals 1

    .line 47
    iget v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->status:I

    return v0
.end method

.method public final getType()I
    .locals 1

    .line 43
    iget v0, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->type:I

    return v0
.end method

.method public final hashCode()I
    .locals 1

    .line 49
    invoke-static {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->zza(Lcom/google/android/gms/games/request/GameRequest;)I

    move-result v0

    return v0
.end method

.method public final isConsumed(Ljava/lang/String;)Z
    .locals 1

    .line 41
    invoke-virtual {p0, p1}, Lcom/google/android/gms/games/request/GameRequestEntity;->getRecipientStatus(Ljava/lang/String;)I

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    return v0

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public final isDataValid()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    .line 82
    invoke-static {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->zzc(Lcom/google/android/gms/games/request/GameRequest;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 5

    .line 95
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    .line 97
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 98
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 100
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getSender()Lcom/google/android/gms/games/Player;

    move-result-object v1

    const/4 v3, 0x2

    .line 101
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 103
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getData()[B

    move-result-object p2

    const/4 v1, 0x3

    .line 104
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeByteArray(Landroid/os/Parcel;I[BZ)V

    .line 106
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getRequestId()Ljava/lang/String;

    move-result-object p2

    const/4 v1, 0x4

    .line 107
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 109
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getRecipients()Ljava/util/List;

    move-result-object p2

    const/4 v1, 0x5

    .line 110
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeTypedList(Landroid/os/Parcel;ILjava/util/List;Z)V

    .line 112
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getType()I

    move-result p2

    const/4 v1, 0x7

    .line 113
    invoke-static {p1, v1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 115
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getCreationTimestamp()J

    move-result-wide v3

    const/16 p2, 0x9

    .line 116
    invoke-static {p1, p2, v3, v4}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    .line 118
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getExpirationTimestamp()J

    move-result-wide v3

    const/16 p2, 0xa

    .line 119
    invoke-static {p1, p2, v3, v4}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    .line 121
    iget-object p2, p0, Lcom/google/android/gms/games/request/GameRequestEntity;->zzro:Landroid/os/Bundle;

    const/16 v1, 0xb

    .line 123
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBundle(Landroid/os/Parcel;ILandroid/os/Bundle;Z)V

    .line 125
    invoke-virtual {p0}, Lcom/google/android/gms/games/request/GameRequestEntity;->getStatus()I

    move-result p2

    const/16 v1, 0xc

    .line 126
    invoke-static {p1, v1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 127
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method
