.class public final Lcom/google/android/gms/games/internal/player/zzd;
.super Ljava/lang/Object;


# instance fields
.field public final name:Ljava/lang/String;

.field public final zzcd:Ljava/lang/String;

.field public final zzci:Ljava/lang/String;

.field public final zzmc:Ljava/lang/String;

.field public final zzmd:Ljava/lang/String;

.field public final zzme:Ljava/lang/String;

.field public final zzmf:Ljava/lang/String;

.field public final zzmg:Ljava/lang/String;

.field public final zzmh:Ljava/lang/String;

.field public final zzmi:Ljava/lang/String;

.field public final zzmj:Ljava/lang/String;

.field public final zzmk:Ljava/lang/String;

.field public final zzml:Ljava/lang/String;

.field public final zzmm:Ljava/lang/String;

.field public final zzmn:Ljava/lang/String;

.field public final zzmo:Ljava/lang/String;

.field public final zzmp:Ljava/lang/String;

.field public final zzmq:Ljava/lang/String;

.field public final zzmr:Ljava/lang/String;

.field private final zzms:Ljava/lang/String;

.field public final zzmt:Ljava/lang/String;

.field public final zzmu:Ljava/lang/String;

.field public final zzmv:Ljava/lang/String;

.field public final zzmw:Ljava/lang/String;

.field public final zzmx:Ljava/lang/String;

.field public final zzmy:Ljava/lang/String;

.field public final zzmz:Ljava/lang/String;

.field public final zzna:Ljava/lang/String;

.field public final zznb:Ljava/lang/String;

.field public final zznc:Ljava/lang/String;

.field public final zznd:Ljava/lang/String;

.field public final zzne:Ljava/lang/String;

.field public final zznf:Ljava/lang/String;

.field public final zzng:Ljava/lang/String;

.field public final zznh:Ljava/lang/String;

.field public final zzni:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p1, "external_player_id"

    .line 3
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmc:Ljava/lang/String;

    const-string p1, "profile_name"

    .line 4
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmd:Ljava/lang/String;

    const-string p1, "profile_icon_image_uri"

    .line 5
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzme:Ljava/lang/String;

    const-string p1, "profile_icon_image_url"

    .line 6
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmf:Ljava/lang/String;

    const-string p1, "profile_hi_res_image_uri"

    .line 7
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmg:Ljava/lang/String;

    const-string p1, "profile_hi_res_image_url"

    .line 8
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmh:Ljava/lang/String;

    const-string p1, "last_updated"

    .line 9
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmi:Ljava/lang/String;

    const-string p1, "is_in_circles"

    .line 10
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmj:Ljava/lang/String;

    const-string p1, "played_with_timestamp"

    .line 11
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmk:Ljava/lang/String;

    const-string p1, "current_xp_total"

    .line 12
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzml:Ljava/lang/String;

    const-string p1, "current_level"

    .line 13
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmm:Ljava/lang/String;

    const-string p1, "current_level_min_xp"

    .line 14
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmn:Ljava/lang/String;

    const-string p1, "current_level_max_xp"

    .line 15
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmo:Ljava/lang/String;

    const-string p1, "next_level"

    .line 16
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmp:Ljava/lang/String;

    const-string p1, "next_level_max_xp"

    .line 17
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmq:Ljava/lang/String;

    const-string p1, "last_level_up_timestamp"

    .line 18
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmr:Ljava/lang/String;

    const-string p1, "player_title"

    .line 19
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzcd:Ljava/lang/String;

    const-string p1, "has_all_public_acls"

    .line 20
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzms:Ljava/lang/String;

    const-string p1, "is_profile_visible"

    .line 21
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmt:Ljava/lang/String;

    const-string p1, "most_recent_external_game_id"

    .line 22
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmu:Ljava/lang/String;

    const-string p1, "most_recent_game_name"

    .line 23
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmv:Ljava/lang/String;

    const-string p1, "most_recent_activity_timestamp"

    .line 24
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmw:Ljava/lang/String;

    const-string p1, "most_recent_game_icon_uri"

    .line 25
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmx:Ljava/lang/String;

    const-string p1, "most_recent_game_hi_res_uri"

    .line 26
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmy:Ljava/lang/String;

    const-string p1, "most_recent_game_featured_uri"

    .line 27
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmz:Ljava/lang/String;

    const-string p1, "has_debug_access"

    .line 28
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzna:Ljava/lang/String;

    const-string p1, "gamer_tag"

    .line 29
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzci:Ljava/lang/String;

    const-string p1, "real_name"

    .line 30
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->name:Ljava/lang/String;

    const-string p1, "banner_image_landscape_uri"

    .line 31
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznb:Ljava/lang/String;

    const-string p1, "banner_image_landscape_url"

    .line 32
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznc:Ljava/lang/String;

    const-string p1, "banner_image_portrait_uri"

    .line 33
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznd:Ljava/lang/String;

    const-string p1, "banner_image_portrait_url"

    .line 34
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzne:Ljava/lang/String;

    const-string p1, "gamer_friend_status"

    .line 35
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznf:Ljava/lang/String;

    const-string p1, "gamer_friend_update_timestamp"

    .line 36
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzng:Ljava/lang/String;

    const-string p1, "is_muted"

    .line 37
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznh:Ljava/lang/String;

    const-string p1, "total_unlocked_achievements"

    goto/16 :goto_23

    .line 39
    :cond_0
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "external_player_id"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_0
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmc:Ljava/lang/String;

    .line 40
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "profile_name"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_2

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_2
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmd:Ljava/lang/String;

    .line 41
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "profile_icon_image_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_3
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_2
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzme:Ljava/lang/String;

    .line 42
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "profile_icon_image_url"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    :cond_4
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_3
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmf:Ljava/lang/String;

    .line 43
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "profile_hi_res_image_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_5

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_5
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_4
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmg:Ljava/lang/String;

    .line 44
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "profile_hi_res_image_url"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_6

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_5

    :cond_6
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_5
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmh:Ljava/lang/String;

    .line 45
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "last_updated"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_7

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_6

    :cond_7
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_6
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmi:Ljava/lang/String;

    .line 46
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "is_in_circles"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_8

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_7

    :cond_8
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_7
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmj:Ljava/lang/String;

    .line 47
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "played_with_timestamp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_9

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_8

    :cond_9
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_8
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmk:Ljava/lang/String;

    .line 48
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "current_xp_total"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_a

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_9

    :cond_a
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_9
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzml:Ljava/lang/String;

    .line 49
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "current_level"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_b

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_a

    :cond_b
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_a
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmm:Ljava/lang/String;

    .line 50
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "current_level_min_xp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_c

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_b

    :cond_c
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_b
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmn:Ljava/lang/String;

    .line 51
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "current_level_max_xp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_d

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_c

    :cond_d
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_c
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmo:Ljava/lang/String;

    .line 52
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "next_level"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_e

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_d

    :cond_e
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_d
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmp:Ljava/lang/String;

    .line 53
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "next_level_max_xp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_f

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_e

    :cond_f
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_e
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmq:Ljava/lang/String;

    .line 54
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "last_level_up_timestamp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_10

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_f

    :cond_10
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmr:Ljava/lang/String;

    .line 55
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "player_title"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_11

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_10

    :cond_11
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_10
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzcd:Ljava/lang/String;

    .line 56
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "has_all_public_acls"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_12

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_11

    :cond_12
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_11
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzms:Ljava/lang/String;

    .line 57
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "is_profile_visible"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_13

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_12

    :cond_13
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_12
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmt:Ljava/lang/String;

    .line 58
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "most_recent_external_game_id"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_14

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_13

    :cond_14
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_13
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmu:Ljava/lang/String;

    .line 59
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "most_recent_game_name"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_15

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_14

    :cond_15
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_14
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmv:Ljava/lang/String;

    .line 60
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "most_recent_activity_timestamp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_16

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_15

    :cond_16
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_15
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmw:Ljava/lang/String;

    .line 61
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "most_recent_game_icon_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_17

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_16

    :cond_17
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_16
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmx:Ljava/lang/String;

    .line 62
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "most_recent_game_hi_res_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_18

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_17

    :cond_18
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_17
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmy:Ljava/lang/String;

    .line 63
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "most_recent_game_featured_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_19

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_18

    :cond_19
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_18
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzmz:Ljava/lang/String;

    .line 64
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "has_debug_access"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1a

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_19

    :cond_1a
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_19
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzna:Ljava/lang/String;

    .line 65
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "gamer_tag"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1b

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1a

    :cond_1b
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1a
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzci:Ljava/lang/String;

    .line 66
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "real_name"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1c

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1b

    :cond_1c
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1b
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->name:Ljava/lang/String;

    .line 67
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "banner_image_landscape_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1d

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1c

    :cond_1d
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1c
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznb:Ljava/lang/String;

    .line 68
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "banner_image_landscape_url"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1e

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1d

    :cond_1e
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1d
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznc:Ljava/lang/String;

    .line 69
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "banner_image_portrait_uri"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_1f

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1e

    :cond_1f
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1e
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznd:Ljava/lang/String;

    .line 70
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "banner_image_portrait_url"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_20

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1f

    :cond_20
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_1f
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzne:Ljava/lang/String;

    .line 71
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "gamer_friend_status"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_21

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_20

    :cond_21
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_20
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznf:Ljava/lang/String;

    .line 72
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "gamer_friend_update_timestamp"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_22

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_21

    :cond_22
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_21
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzng:Ljava/lang/String;

    .line 73
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "is_muted"

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_23

    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_22

    :cond_23
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object v0, v1

    :goto_22
    iput-object v0, p0, Lcom/google/android/gms/games/internal/player/zzd;->zznh:Ljava/lang/String;

    .line 74
    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "total_unlocked_achievements"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_24

    invoke-virtual {p1, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_23

    :cond_24
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    move-object p1, v0

    :goto_23
    iput-object p1, p0, Lcom/google/android/gms/games/internal/player/zzd;->zzni:Ljava/lang/String;

    return-void
.end method
