.class public final Lcom/google/android/gms/games/internal/zzca;
.super Ljava/lang/Object;


# instance fields
.field public bottom:I

.field public gravity:I

.field public left:I

.field public right:I

.field public top:I

.field public zzju:Landroid/os/IBinder;

.field public zzjy:I


# direct methods
.method private constructor <init>(ILandroid/os/IBinder;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p2, -0x1

    .line 2
    iput p2, p0, Lcom/google/android/gms/games/internal/zzca;->zzjy:I

    const/4 p2, 0x0

    .line 3
    iput p2, p0, Lcom/google/android/gms/games/internal/zzca;->left:I

    .line 4
    iput p2, p0, Lcom/google/android/gms/games/internal/zzca;->top:I

    .line 5
    iput p2, p0, Lcom/google/android/gms/games/internal/zzca;->right:I

    .line 6
    iput p2, p0, Lcom/google/android/gms/games/internal/zzca;->bottom:I

    .line 7
    iput p1, p0, Lcom/google/android/gms/games/internal/zzca;->gravity:I

    const/4 p1, 0x0

    .line 8
    iput-object p1, p0, Lcom/google/android/gms/games/internal/zzca;->zzju:Landroid/os/IBinder;

    return-void
.end method

.method synthetic constructor <init>(ILandroid/os/IBinder;Lcom/google/android/gms/games/internal/zzbz;)V
    .locals 0

    const/4 p2, 0x0

    .line 18
    invoke-direct {p0, p1, p2}, Lcom/google/android/gms/games/internal/zzca;-><init>(ILandroid/os/IBinder;)V

    return-void
.end method


# virtual methods
.method public final zzcs()Landroid/os/Bundle;
    .locals 3

    .line 10
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "popupLocationInfo.gravity"

    .line 11
    iget v2, p0, Lcom/google/android/gms/games/internal/zzca;->gravity:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "popupLocationInfo.displayId"

    .line 12
    iget v2, p0, Lcom/google/android/gms/games/internal/zzca;->zzjy:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "popupLocationInfo.left"

    .line 13
    iget v2, p0, Lcom/google/android/gms/games/internal/zzca;->left:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "popupLocationInfo.top"

    .line 14
    iget v2, p0, Lcom/google/android/gms/games/internal/zzca;->top:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "popupLocationInfo.right"

    .line 15
    iget v2, p0, Lcom/google/android/gms/games/internal/zzca;->right:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    const-string v1, "popupLocationInfo.bottom"

    .line 16
    iget v2, p0, Lcom/google/android/gms/games/internal/zzca;->bottom:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    return-object v0
.end method
