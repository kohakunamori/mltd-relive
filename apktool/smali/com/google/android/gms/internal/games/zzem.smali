.class public final Lcom/google/android/gms/internal/games/zzem;
.super Ljava/lang/Object;


# instance fields
.field private statusCode:I

.field private zzns:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/google/android/gms/internal/games/zzem;->zzns:Ljava/util/HashMap;

    const/4 v0, 0x0

    .line 3
    iput v0, p0, Lcom/google/android/gms/internal/games/zzem;->statusCode:I

    return-void
.end method


# virtual methods
.method public final zzdh()Lcom/google/android/gms/internal/games/zzek;
    .locals 4

    .line 14
    new-instance v0, Lcom/google/android/gms/internal/games/zzek;

    iget v1, p0, Lcom/google/android/gms/internal/games/zzem;->statusCode:I

    iget-object v2, p0, Lcom/google/android/gms/internal/games/zzem;->zzns:Ljava/util/HashMap;

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/internal/games/zzek;-><init>(ILjava/util/HashMap;Lcom/google/android/gms/internal/games/zzel;)V

    return-object v0
.end method

.method public final zzh(Ljava/lang/String;I)Lcom/google/android/gms/internal/games/zzem;
    .locals 1

    packed-switch p2, :pswitch_data_0

    const/4 v0, 0x0

    goto :goto_0

    :pswitch_0
    const/4 v0, 0x1

    :goto_0
    if-eqz v0, :cond_0

    .line 10
    iget-object v0, p0, Lcom/google/android/gms/internal/games/zzem;->zzns:Ljava/util/HashMap;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-object p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public final zzo(I)Lcom/google/android/gms/internal/games/zzem;
    .locals 0

    .line 12
    iput p1, p0, Lcom/google/android/gms/internal/games/zzem;->statusCode:I

    return-object p0
.end method
