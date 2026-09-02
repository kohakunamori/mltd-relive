.class public final Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;
.super Lcom/google/android/gms/games/internal/zzd;

# interfaces
.implements Lcom/google/android/gms/games/appcontent/zzc;


# annotations
.annotation build Lcom/google/android/apps/common/proguard/UsedByReflection;
    value = "GamesClientImpl.java"
.end annotation

.annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Class;
    creator = "AppContentAnnotationEntityCreator"
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
            "Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;",
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

.field private final zzcd:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getTitle"
        id = 0x3
    .end annotation
.end field

.field private final zzfr:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getId"
        id = 0x5
    .end annotation
.end field

.field private final zzfu:Landroid/net/Uri;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getImageUri"
        id = 0x2
    .end annotation
.end field

.field private final zzfv:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getLayoutSlot"
        id = 0x6
    .end annotation
.end field

.field private final zzfw:Ljava/lang/String;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getImageDefaultId"
        id = 0x7
    .end annotation
.end field

.field private final zzfx:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getImageHeight"
        id = 0x8
    .end annotation
.end field

.field private final zzfy:I
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getImageWidth"
        id = 0x9
    .end annotation
.end field

.field private final zzfz:Landroid/os/Bundle;
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Field;
        getter = "getModifiers"
        id = 0xa
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 102
    new-instance v0, Lcom/google/android/gms/games/appcontent/zzd;

    invoke-direct {v0}, Lcom/google/android/gms/games/appcontent/zzd;-><init>()V

    sput-object v0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Landroid/net/Uri;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IILandroid/os/Bundle;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x1
        .end annotation
    .end param
    .param p2    # Landroid/net/Uri;
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
            id = 0x5
        .end annotation
    .end param
    .param p5    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x6
        .end annotation
    .end param
    .param p6    # Ljava/lang/String;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x7
        .end annotation
    .end param
    .param p7    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x8
        .end annotation
    .end param
    .param p8    # I
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0x9
        .end annotation
    .end param
    .param p9    # Landroid/os/Bundle;
        .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Param;
            id = 0xa
        .end annotation
    .end param
    .annotation build Lcom/google/android/gms/common/internal/safeparcel/SafeParcelable$Constructor;
    .end annotation

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/games/internal/zzd;-><init>()V

    .line 2
    iput-object p1, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->description:Ljava/lang/String;

    .line 3
    iput-object p4, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfr:Ljava/lang/String;

    .line 4
    iput-object p6, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfw:Ljava/lang/String;

    .line 5
    iput p7, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfx:I

    .line 6
    iput-object p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfu:Landroid/net/Uri;

    .line 7
    iput p8, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfy:I

    .line 8
    iput-object p5, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfv:Ljava/lang/String;

    .line 9
    iput-object p9, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfz:Landroid/os/Bundle;

    .line 10
    iput-object p3, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzcd:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 3

    .line 36
    instance-of v0, p1, Lcom/google/android/gms/games/appcontent/zzc;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 39
    :cond_0
    check-cast p1, Lcom/google/android/gms/games/appcontent/zzc;

    .line 40
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->getDescription()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getDescription()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 41
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->getId()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 42
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->zzac()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzac()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 43
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->zzad()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzad()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 44
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->zzae()Landroid/net/Uri;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzae()Landroid/net/Uri;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 45
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->zzag()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzag()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 46
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->zzah()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzah()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/common/internal/Objects;->equal(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 47
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->zzaf()Landroid/os/Bundle;

    move-result-object v1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzaf()Landroid/os/Bundle;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/google/android/gms/games/internal/zzc;->zza(Landroid/os/Bundle;Landroid/os/Bundle;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 48
    invoke-interface {p1}, Lcom/google/android/gms/games/appcontent/zzc;->getTitle()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getTitle()Ljava/lang/String;

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

.method public final getDescription()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->description:Ljava/lang/String;

    return-object v0
.end method

.method public final getId()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfr:Ljava/lang/String;

    return-object v0
.end method

.method public final getTitle()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzcd:Ljava/lang/String;

    return-object v0
.end method

.method public final hashCode()I
    .locals 3

    const/16 v0, 0x9

    .line 23
    new-array v0, v0, [Ljava/lang/Object;

    .line 24
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getDescription()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 25
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getId()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 26
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzac()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 27
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzad()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 28
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzae()Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x4

    aput-object v1, v0, v2

    .line 29
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzag()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 30
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzah()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 31
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzaf()Landroid/os/Bundle;

    move-result-object v1

    invoke-static {v1}, Lcom/google/android/gms/games/internal/zzc;->zza(Landroid/os/Bundle;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v2, 0x7

    aput-object v1, v0, v2

    .line 32
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getTitle()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x8

    aput-object v1, v0, v2

    .line 33
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
    .locals 3

    .line 51
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Description"

    .line 52
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Id"

    .line 53
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "ImageDefaultId"

    .line 54
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzac()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "ImageHeight"

    .line 55
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzad()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "ImageUri"

    .line 56
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzae()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "ImageWidth"

    .line 57
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzag()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "LayoutSlot"

    .line 58
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzah()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Modifiers"

    .line 59
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->zzaf()Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    const-string v1, "Title"

    .line 60
    invoke-interface {p0}, Lcom/google/android/gms/games/appcontent/zzc;->getTitle()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    .line 61
    invoke-virtual {v0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 4

    .line 64
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    .line 66
    iget-object v1, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->description:Ljava/lang/String;

    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 68
    invoke-static {p1, v3, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 70
    iget-object v1, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfu:Landroid/net/Uri;

    const/4 v3, 0x2

    .line 72
    invoke-static {p1, v3, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 74
    iget-object p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzcd:Ljava/lang/String;

    const/4 v1, 0x3

    .line 76
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 78
    iget-object p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfr:Ljava/lang/String;

    const/4 v1, 0x5

    .line 80
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 82
    iget-object p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfv:Ljava/lang/String;

    const/4 v1, 0x6

    .line 84
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 86
    iget-object p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfw:Ljava/lang/String;

    const/4 v1, 0x7

    .line 88
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    .line 90
    iget p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfx:I

    const/16 v1, 0x8

    .line 91
    invoke-static {p1, v1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 93
    iget p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfy:I

    const/16 v1, 0x9

    .line 94
    invoke-static {p1, v1, p2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    .line 96
    iget-object p2, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfz:Landroid/os/Bundle;

    const/16 v1, 0xa

    .line 98
    invoke-static {p1, v1, p2, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeBundle(Landroid/os/Parcel;ILandroid/os/Bundle;Z)V

    .line 99
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zzac()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfw:Ljava/lang/String;

    return-object v0
.end method

.method public final zzad()I
    .locals 1

    .line 15
    iget v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfx:I

    return v0
.end method

.method public final zzae()Landroid/net/Uri;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfu:Landroid/net/Uri;

    return-object v0
.end method

.method public final zzaf()Landroid/os/Bundle;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfz:Landroid/os/Bundle;

    return-object v0
.end method

.method public final zzag()I
    .locals 1

    .line 17
    iget v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfy:I

    return v0
.end method

.method public final zzah()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/google/android/gms/games/appcontent/AppContentAnnotationEntity;->zzfv:Ljava/lang/String;

    return-object v0
.end method
