.class public Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;
.super Ljava/lang/Object;
.source "UnsupportedUtils.java"


# static fields
.field private static final SMART_CAPTURE_DIRECTORY:Ljava/lang/String; = "/smartar/capture/"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static defaultImageSensorRotation(Z)I
    .locals 0

    if-eqz p0, :cond_0

    const/16 p0, 0x10e

    return p0

    :cond_0
    const/16 p0, 0x5a

    return p0
.end method

.method private static getCameraParams(Z)Landroid/hardware/Camera$Parameters;
    .locals 4

    .line 128
    invoke-static {p0}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    .line 133
    :cond_0
    new-instance v2, Landroid/hardware/Camera$CameraInfo;

    invoke-direct {v2}, Landroid/hardware/Camera$CameraInfo;-><init>()V

    .line 134
    invoke-static {p0, v2}, Landroid/hardware/Camera;->getCameraInfo(ILandroid/hardware/Camera$CameraInfo;)V

    .line 135
    iget v2, v2, Landroid/hardware/Camera$CameraInfo;->facing:I

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1

    if-nez p0, :cond_1

    .line 137
    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V

    return-object v1

    .line 142
    :cond_1
    invoke-virtual {v0}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object p0

    .line 143
    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V

    return-object p0
.end method

.method public static getFocalLength(Z)F
    .locals 0

    .line 69
    invoke-static {p0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;->getCameraParams(Z)Landroid/hardware/Camera$Parameters;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 73
    :cond_0
    invoke-virtual {p0}, Landroid/hardware/Camera$Parameters;->getFocalLength()F

    move-result p0

    return p0
.end method

.method public static getFovY(Z)F
    .locals 0

    .line 61
    invoke-static {p0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;->getCameraParams(Z)Landroid/hardware/Camera$Parameters;

    move-result-object p0

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return p0

    .line 65
    :cond_0
    invoke-virtual {p0}, Landroid/hardware/Camera$Parameters;->getVerticalViewAngle()F

    move-result p0

    return p0
.end method

.method public static getImageSensorRotation(ZLandroid/content/Context;)I
    .locals 7

    .line 77
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x15

    if-lt v0, v1, :cond_4

    :try_start_0
    const-string v0, "camera"

    .line 79
    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/hardware/camera2/CameraManager;

    const/4 v0, 0x0

    .line 82
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraManager;->getCameraIdList()[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-lt v3, v2, :cond_0

    goto :goto_2

    :cond_0
    aget-object v4, v1, v3

    .line 83
    invoke-virtual {p1, v4}, Landroid/hardware/camera2/CameraManager;->getCameraCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v5

    .line 84
    sget-object v6, Landroid/hardware/camera2/CameraCharacteristics;->LENS_FACING:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v5, v6}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    if-eqz v5, :cond_1

    .line 85
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-nez v6, :cond_1

    if-eqz p0, :cond_3

    goto :goto_1

    :cond_1
    if-eqz v5, :cond_3

    .line 92
    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const/4 v6, 0x1

    if-ne v5, v6, :cond_3

    if-nez p0, :cond_3

    :goto_1
    move-object v0, v4

    :goto_2
    if-nez v0, :cond_2

    .line 101
    invoke-static {p0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;->defaultImageSensorRotation(Z)I

    move-result p1

    return p1

    .line 105
    :cond_2
    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CameraManager;->getCameraCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object p1

    .line 106
    sget-object v0, Landroid/hardware/camera2/CameraCharacteristics;->SENSOR_ORIENTATION:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p1, v0}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 109
    :catch_0
    invoke-static {p0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;->defaultImageSensorRotation(Z)I

    move-result p0

    return p0

    .line 113
    :cond_4
    invoke-static {p0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils;->defaultImageSensorRotation(Z)I

    move-result p0

    return p0
.end method

.method public static moveToExternalDir(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .line 30
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 31
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    const/4 v1, 0x0

    if-nez p0, :cond_0

    return-object v1

    .line 33
    :cond_0
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "/smartar/capture/"

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 34
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_1

    .line 35
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 37
    :cond_1
    new-instance v2, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, p0, v3}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 38
    invoke-virtual {v0, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result p0

    if-eqz p0, :cond_2

    .line 40
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    :cond_2
    return-object v1
.end method

.method public static scanCaptureImage(Ljava/lang/String;)V
    .locals 3

    .line 44
    sget-object v0, Lcom/unity3d/player/UnityPlayer;->currentActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x1

    .line 45
    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    const-string p0, "image/*"

    .line 46
    filled-new-array {p0}, [Ljava/lang/String;

    move-result-object p0

    .line 47
    new-instance v2, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;

    invoke-direct {v2, v0}, Lcom/sony/smartar/unsupportedutils/UnsupportedUtils$1;-><init>(Landroid/content/Context;)V

    invoke-static {v0, v1, p0, v2}, Landroid/media/MediaScannerConnection;->scanFile(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;Landroid/media/MediaScannerConnection$OnScanCompletedListener;)V

    return-void
.end method
