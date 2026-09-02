.class public final Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;
.super Lcom/google/android/gms/games/internal/zzd;

# interfaces
.implements Lcom/google/android/gms/games/internal/experience/ExperienceEvent;


# annotations
.annotation build Lcom/google/android/apps/common/proguard/UsedByReflection;
    value = "GamesClientImpl.java"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "ExperienceEventEntityCreator"
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
            "Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final type:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getType"
        id = 0xa
    .end annotation
.end field

.field private final zzac:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getIconImageUrl"
        id = 0x5
    .end annotation
.end field

.field private final zzlo:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getExperienceId"
        id = 0x1
    .end annotation
.end field

.field private final zzlp:Lcom/google/android/gms/games/GameEntity;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getGame"
        id = 0x2
    .end annotation
.end field

.field private final zzlq:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getDisplayTitle"
        id = 0x3
    .end annotation
.end field

.field private final zzlr:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getDisplayDescription"
        id = 0x4
    .end annotation
.end field

.field private final zzls:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCreatedTimestamp"
        id = 0x7
    .end annotation
.end field

.field private final zzlt:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getXpEarned"
        id = 0x8
    .end annotation
.end field

.field private final zzlu:J
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getCurrentXp"
        id = 0x9
    .end annotation
.end field

.field private final zzlv:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getNewLevel"
        id = 0xb
    .end annotation
.end field

.field private final zzr:Landroid/net/Uri;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getIconImageUri"
        id = 0x6
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 116
    new-instance v0, Lcom/google/android/gms/games/internal/experience/zza;

    invoke-direct {v0}, Lcom/google/android/gms/games/internal/experience/zza;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Lcom/google/android/gms/games/GameEntity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;JJJII)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Lcom/google/android/gms/games/GameEntity;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x2
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x3
        .end annotation
    .end param
    .param p4    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x4
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x5
        .end annotation
    .end param
    .param p6    # Landroid/net/Uri;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .param p7    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x7
        .end annotation
    .end param
    .param p9    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x8
        .end annotation
    .end param
    .param p11    # J
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x9
        .end annotation
    .end param
    .param p13    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xa
        .end annotation
    .end param
    .param p14    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xb
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/zzd;-><init>()V

    .line 2
    iput-object p1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlo:Ljava/lang/String;

    .line 3
    iput-object p2, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    .line 4
    iput-object p3, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlq:Ljava/lang/String;

    .line 5
    iput-object p4, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlr:Ljava/lang/String;

    .line 6
    iput-object p5, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzac:Ljava/lang/String;

    .line 7
    iput-object p6, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzr:Landroid/net/Uri;

    .line 8
    iput-wide p7, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzls:J

    .line 9
    iput-wide p9, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlt:J

    .line 10
    iput-wide p11, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlu:J

    .line 11
    iput p13, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->type:I

    .line 12
    iput p14, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlv:I

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 4

    .line 41
    instance-of v0, p1, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 44
    :cond_0
    check-cast p1, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;

    .line 45
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcu()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcu()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 46
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 47
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcv()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcv()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 48
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcw()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcw()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 49
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUrl()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUrl()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 50
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUri()Landroid/net/Uri;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUri()Landroid/net/Uri;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 51
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcx()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcx()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 52
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcy()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcy()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 53
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcz()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcz()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 54
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getType()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 55
    invoke-interface {p1}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzda()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzda()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {p1, v1}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    return v0

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public final bridge synthetic freeze()Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public final getGame()Lcom/google/android/gms/games/Game;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    return-object v0
.end method

.method public final getIconImageUri()Landroid/net/Uri;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzr:Landroid/net/Uri;

    return-object v0
.end method

.method public final getIconImageUrl()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzac:Ljava/lang/String;

    return-object v0
.end method

.method public final getType()I
    .locals 1

    .line 23
    iget v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->type:I

    return v0
.end method

.method public final hashCode()I
    .locals 3

    const/16 v0, 0xb

    .line 26
    new-array v0, v0, [Ljava/lang/Object;

    .line 27
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcu()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 28
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 29
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcv()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 30
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcw()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 31
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUrl()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x4

    aput-object v1, v0, v2

    .line 32
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUri()Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 33
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcx()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 34
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcy()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v2, 0x7

    aput-object v1, v0, v2

    .line 35
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcz()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/16 v2, 0x8

    aput-object v1, v0, v2

    .line 36
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getType()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0x9

    aput-object v1, v0, v2

    .line 37
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzda()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/16 v2, 0xa

    aput-object v1, v0, v2

    .line 38
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Objects;->hashCode([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public final isDataValid()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 4

    .line 58
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "ExperienceId"

    .line 59
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcu()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Game"

    .line 60
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getGame()Lcom/google/android/gms/games/Game;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "DisplayTitle"

    .line 61
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcv()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "DisplayDescription"

    .line 62
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcw()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IconImageUrl"

    .line 63
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUrl()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "IconImageUri"

    .line 64
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getIconImageUri()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "CreatedTimestamp"

    .line 65
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcx()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "XpEarned"

    .line 66
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcy()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "CurrentXp"

    .line 67
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzcz()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Type"

    .line 68
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->getType()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "NewLevel"

    .line 69
    invoke-interface {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEvent;->zzda()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    .line 70
    invoke-virtual {v0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 4

    .line 74
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    .line 76
    iget-object v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlo:Ljava/lang/String;

    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 78
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 80
    iget-object v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlp:Lcom/google/android/gms/games/GameEntity;

    const/4 v3, 0x2

    .line 82
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 84
    iget-object v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlq:Ljava/lang/String;

    const/4 v3, 0x3

    .line 86
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 88
    iget-object v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlr:Ljava/lang/String;

    const/4 v3, 0x4

    .line 90
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 92
    invoke-virtual {p0}, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->getIconImageUrl()Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x5

    .line 93
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 95
    iget-object v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzr:Landroid/net/Uri;

    const/4 v3, 0x6

    .line 97
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 99
    iget-wide v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzls:J

    const/4 p2, 0x7

    .line 100
    invoke-static {p1, p2, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    .line 102
    iget-wide v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlt:J

    const/16 p2, 0x8

    .line 103
    invoke-static {p1, p2, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    .line 105
    iget-wide v1, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlu:J

    const/16 p2, 0x9

    .line 106
    invoke-static {p1, p2, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeLong(Landroid/os/Parcel;IJ)V

    .line 108
    iget p2, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->type:I

    const/16 v1, 0xa

    .line 109
    invoke-static {p1, v1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 111
    iget p2, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlv:I

    const/16 v1, 0xb

    .line 112
    invoke-static {p1, v1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 113
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zzcu()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlo:Ljava/lang/String;

    return-object v0
.end method

.method public final zzcv()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlq:Ljava/lang/String;

    return-object v0
.end method

.method public final zzcw()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlr:Ljava/lang/String;

    return-object v0
.end method

.method public final zzcx()J
    .locals 2

    .line 20
    iget-wide v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzls:J

    return-wide v0
.end method

.method public final zzcy()J
    .locals 2

    .line 21
    iget-wide v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlt:J

    return-wide v0
.end method

.method public final zzcz()J
    .locals 2

    .line 22
    iget-wide v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlu:J

    return-wide v0
.end method

.method public final zzda()I
    .locals 1

    .line 24
    iget v0, p0, Lcom/google/android/gms/games/internal/experience/ExperienceEventEntity;->zzlv:I

    return v0
.end method
