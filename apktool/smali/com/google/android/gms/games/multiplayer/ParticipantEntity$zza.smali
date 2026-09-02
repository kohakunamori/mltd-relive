.class final Lcom/google/android/gms/games/multiplayer/ParticipantEntity$zza;
.super Lcom/google/android/gms/games/multiplayer/zzc;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/gms/games/multiplayer/ParticipantEntity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "zza"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/games/multiplayer/zzc;-><init>()V

    return-void
.end method


# virtual methods
.method public final synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 0

    .line 18
    invoke-virtual {p0, p1}, Lcom/google/android/gms/games/multiplayer/zzc;->zzf(Landroid/os/Parcel;)Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    move-result-object p1

    return-object p1
.end method

.method public final zzf(Landroid/os/Parcel;)Lcom/google/android/gms/games/multiplayer/ParticipantEntity;
    .locals 16

    .line 2
    invoke-static {}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->zzf()Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->zza(Ljava/lang/Integer;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 3
    const-class v0, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    invoke-virtual {v0}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;->zza(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_4

    .line 5
    :cond_0
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    .line 6
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    .line 7
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    .line 8
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v1

    .line 9
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v6

    .line 10
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v7

    .line 11
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    const/4 v5, 0x0

    const/4 v8, 0x1

    if-lez v4, :cond_1

    const/4 v9, 0x1

    goto :goto_0

    :cond_1
    const/4 v9, 0x0

    .line 12
    :goto_0
    invoke-virtual/range {p1 .. p1}, Landroid/os/Parcel;->readInt()I

    move-result v4

    if-lez v4, :cond_2

    const/4 v5, 0x1

    :cond_2
    const/4 v4, 0x0

    if-eqz v5, :cond_3

    .line 13
    sget-object v5, Lcom/google/android/gms/games/PlayerEntity;->CREATOR:Landroid/os/Parcelable$Creator;

    move-object/from16 v8, p1

    invoke-interface {v5, v8}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/google/android/gms/games/PlayerEntity;

    move-object v10, v5

    goto :goto_1

    :cond_3
    move-object v10, v4

    .line 14
    :goto_1
    new-instance v14, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    if-nez v0, :cond_4

    move-object v0, v4

    goto :goto_2

    .line 15
    :cond_4
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    :goto_2
    if-nez v1, :cond_5

    move-object v5, v4

    goto :goto_3

    .line 16
    :cond_5
    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    move-object v5, v1

    :goto_3
    const/4 v11, 0x7

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v15, 0x0

    move-object v1, v14

    move-object v4, v0

    move v8, v9

    move-object v9, v10

    move v10, v11

    move-object v11, v12

    move-object v12, v13

    move-object v13, v15

    invoke-direct/range {v1 .. v13}, Lcom/google/android/gms/games/multiplayer/ParticipantEntity;-><init>(Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Landroid/net/Uri;ILjava/lang/String;ZLcom/google/android/gms/games/PlayerEntity;ILcom/google/android/gms/games/multiplayer/ParticipantResult;Ljava/lang/String;Ljava/lang/String;)V

    return-object v14

    :cond_6
    :goto_4
    move-object/from16 v8, p1

    .line 4
    invoke-super/range {p0 .. p1}, Lcom/google/android/gms/games/multiplayer/zzc;->zzf(Landroid/os/Parcel;)Lcom/google/android/gms/games/multiplayer/ParticipantEntity;

    move-result-object v0

    return-object v0
.end method
