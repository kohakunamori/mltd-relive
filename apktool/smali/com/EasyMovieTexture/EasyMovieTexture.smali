.class public Lcom/EasyMovieTexture/EasyMovieTexture;
.super Ljava/lang/Object;
.source "EasyMovieTexture.java"

# interfaces
.implements Landroid/media/MediaPlayer$OnPreparedListener;
.implements Landroid/media/MediaPlayer$OnBufferingUpdateListener;
.implements Landroid/media/MediaPlayer$OnCompletionListener;
.implements Landroid/media/MediaPlayer$OnErrorListener;
.implements Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;
    }
.end annotation


# static fields
.field private static final GL_TEXTURE_EXTERNAL_OES:I = 0x8d65

.field public static m_objCtrl:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/EasyMovieTexture/EasyMovieTexture;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private m_MediaPlayer:Landroid/media/MediaPlayer;

.field private m_Surface:Landroid/view/Surface;

.field private m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

.field private m_UnityActivity:Landroid/app/Activity;

.field private m_bRockchip:Z

.field private m_bSplitOBB:Z

.field public m_bUpdate:Z

.field private m_iCurrentSeekPercent:I

.field private m_iCurrentSeekPosition:I

.field m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

.field private m_iErrorCode:I

.field private m_iErrorCodeExtra:I

.field public m_iNativeMgrID:I

.field private m_iSurfaceTextureID:I

.field private m_iUnityTextureID:I

.field private m_strFileName:Ljava/lang/String;

.field private m_strOBBName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 56
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    const-string v0, "BlueDoveMediaRender"

    .line 92
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 38
    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_UnityActivity:Landroid/app/Activity;

    .line 39
    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    const/4 v1, -0x1

    .line 41
    iput v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iUnityTextureID:I

    .line 42
    iput v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    .line 43
    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    .line 44
    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_Surface:Landroid/view/Surface;

    const/4 v0, 0x0

    .line 45
    iput v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPercent:I

    .line 46
    iput v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPosition:I

    const/4 v1, 0x1

    .line 51
    iput-boolean v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bRockchip:Z

    .line 52
    iput-boolean v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bSplitOBB:Z

    .line 54
    iput-boolean v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bUpdate:Z

    .line 95
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-void
.end method

.method public static GetObject(I)Lcom/EasyMovieTexture/EasyMovieTexture;
    .locals 2

    const/4 v0, 0x0

    .line 60
    :goto_0
    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v0, v1, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 62
    :cond_0
    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/EasyMovieTexture/EasyMovieTexture;

    iget v1, v1, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    if-ne v1, p0, :cond_1

    .line 64
    sget-object p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {p0, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/EasyMovieTexture/EasyMovieTexture;

    return-object p0

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method


# virtual methods
.method public Destroy()V
    .locals 5

    .line 100
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    .line 102
    new-array v3, v0, [I

    .line 103
    iget v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    aput v4, v3, v2

    .line 104
    invoke-static {v0, v3, v2}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 105
    iput v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    .line 109
    :cond_0
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, v0}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    .line 110
    invoke-virtual {p0}, Lcom/EasyMovieTexture/EasyMovieTexture;->QuitApplication()V

    .line 113
    :goto_0
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt v2, v0, :cond_1

    return-void

    .line 115
    :cond_1
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/EasyMovieTexture/EasyMovieTexture;

    iget v0, v0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    iget v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    if-ne v0, v1, :cond_2

    const-string v0, "jni"

    .line 118
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 120
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0
.end method

.method public GetCurrentSeekPercent()I
    .locals 1

    .line 489
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPercent:I

    return v0
.end method

.method public GetDuration()I
    .locals 1

    .line 616
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 618
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v0

    return v0

    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method public GetError()I
    .locals 1

    .line 729
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iErrorCode:I

    return v0
.end method

.method public GetErrorExtra()I
    .locals 1

    .line 734
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iErrorCodeExtra:I

    return v0
.end method

.method public native GetManagerID()I
.end method

.method public GetSeekPosition()I
    .locals 2

    .line 468
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_1

    .line 470
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_1

    .line 473
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result v0

    iput v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPosition:I
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 479
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_0

    :catch_1
    move-exception v0

    .line 476
    invoke-virtual {v0}, Ljava/lang/SecurityException;->printStackTrace()V

    .line 484
    :cond_1
    :goto_0
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPosition:I

    return v0
.end method

.method public GetSoundTrack()[I
    .locals 6

    .line 637
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_4

    .line 639
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getTrackInfo()[Landroid/media/MediaPlayer$TrackInfo;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    .line 642
    :goto_0
    array-length v4, v0

    const/4 v5, 0x2

    if-lt v2, v4, :cond_2

    if-eqz v3, :cond_4

    .line 652
    new-array v2, v3, [I

    const/4 v3, 0x0

    .line 656
    :goto_1
    array-length v4, v0

    if-lt v1, v4, :cond_0

    goto :goto_2

    .line 658
    :cond_0
    aget-object v4, v0, v1

    invoke-virtual {v4}, Landroid/media/MediaPlayer$TrackInfo;->getTrackType()I

    move-result v4

    if-ne v4, v5, :cond_1

    .line 660
    aput v1, v2, v3

    add-int/lit8 v3, v3, 0x1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 644
    :cond_2
    aget-object v4, v0, v2

    invoke-virtual {v4}, Landroid/media/MediaPlayer$TrackInfo;->getTrackType()I

    move-result v4

    if-ne v4, v5, :cond_3

    add-int/lit8 v3, v3, 0x1

    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_4
    const/4 v2, 0x0

    :goto_2
    return-object v2
.end method

.method public GetStatus()I
    .locals 1

    .line 710
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    invoke-virtual {v0}, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->GetValue()I

    move-result v0

    return v0
.end method

.method public GetVideoHeight()I
    .locals 1

    .line 574
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 576
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getVideoHeight()I

    move-result v0

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public GetVideoWidth()I
    .locals 1

    .line 564
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 566
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getVideoWidth()I

    move-result v0

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public native InitApplication()I
.end method

.method public native InitExtTexture()I
.end method

.method public InitJniManager()V
    .locals 1

    .line 701
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, v0}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    .line 702
    invoke-virtual {p0}, Lcom/EasyMovieTexture/EasyMovieTexture;->InitApplication()I

    return-void
.end method

.method public native InitNDK(Ljava/lang/Object;)I
.end method

.method public InitNative(Lcom/EasyMovieTexture/EasyMovieTexture;)I
    .locals 0

    .line 677
    invoke-virtual {p0, p1}, Lcom/EasyMovieTexture/EasyMovieTexture;->InitNDK(Ljava/lang/Object;)I

    move-result p1

    iput p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    .line 678
    sget-object p1, Lcom/EasyMovieTexture/EasyMovieTexture;->m_objCtrl:Ljava/util/ArrayList;

    invoke-virtual {p1, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 680
    iget p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    return p1
.end method

.method public IsUpdateFrame()Z
    .locals 1

    .line 584
    iget-boolean v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bUpdate:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public Load()Z
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/SecurityException;,
            Ljava/lang/IllegalStateException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 196
    invoke-virtual {p0}, Lcom/EasyMovieTexture/EasyMovieTexture;->UnLoad()V

    .line 199
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 202
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    .line 203
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    const/4 v0, 0x0

    .line 206
    iput-boolean v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bUpdate:Z

    .line 208
    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    const-string v2, "file://"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 211
    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    const-string v2, "file://"

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 213
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 215
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 216
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;)V

    .line 217
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_1

    :catch_0
    move-exception v0

    const-string v1, "Unity"

    .line 220
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Error m_MediaPlayer.setDataSource() : "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 221
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 223
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    goto/16 :goto_1

    .line 229
    :cond_0
    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    const-string v2, "://"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 232
    :try_start_1
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    const-string v2, "rtsp_transport"

    const-string v3, "tcp"

    .line 233
    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "max_analyze_duration"

    const-string v3, "500"

    .line 234
    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 263
    iget-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    iget-object v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_UnityActivity:Landroid/app/Activity;

    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {v2, v3, v4, v1}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;Ljava/util/Map;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_1

    :catch_1
    move-exception v1

    const-string v2, "Unity"

    .line 273
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Error m_MediaPlayer.setDataSource() : "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 274
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 276
    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return v0

    .line 284
    :cond_1
    iget-boolean v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bSplitOBB:Z

    if-eqz v1, :cond_3

    .line 290
    :try_start_2
    new-instance v1, Lcom/android/vending/expansion/zipfile/ZipResourceFile;

    iget-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strOBBName:Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;-><init>(Ljava/lang/String;)V

    const-string v2, "unity"

    .line 292
    new-instance v3, Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strOBBName:Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 293
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "assets/"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;->getAssetFileDescriptor(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v2

    .line 295
    invoke-virtual {v1}, Lcom/android/vending/expansion/zipfile/ZipResourceFile;->getAllEntries()[Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;

    move-result-object v1

    const/4 v3, 0x0

    .line 297
    :goto_0
    array-length v4, v1

    if-lt v3, v4, :cond_2

    const-string v1, "unity"

    .line 302
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 303
    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/content/res/AssetFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v5

    invoke-virtual {v2}, Landroid/content/res/AssetFileDescriptor;->getStartOffset()J

    move-result-wide v6

    invoke-virtual {v2}, Landroid/content/res/AssetFileDescriptor;->getLength()J

    move-result-wide v8

    invoke-virtual/range {v4 .. v9}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V

    goto :goto_1

    :cond_2
    const-string v4, "unity"

    .line 299
    aget-object v5, v1, v3

    iget-object v5, v5, Lcom/android/vending/expansion/zipfile/ZipResourceFile$ZipEntryRO;->mFileName:Ljava/lang/String;

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :catch_2
    move-exception v1

    .line 307
    sget-object v2, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 308
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    return v0

    .line 316
    :cond_3
    :try_start_3
    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_UnityActivity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    iget-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v1

    .line 317
    iget-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v3

    invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->getStartOffset()J

    move-result-wide v4

    invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->getLength()J

    move-result-wide v6

    invoke-virtual/range {v2 .. v7}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V

    .line 318
    invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .line 332
    :cond_4
    :goto_1
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_5

    .line 334
    invoke-virtual {p0}, Lcom/EasyMovieTexture/EasyMovieTexture;->InitExtTexture()I

    move-result v0

    iput v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    .line 338
    :cond_5
    new-instance v0, Landroid/graphics/SurfaceTexture;

    iget v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    invoke-direct {v0, v1}, Landroid/graphics/SurfaceTexture;-><init>(I)V

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    .line 339
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v0, p0}, Landroid/graphics/SurfaceTexture;->setOnFrameAvailableListener(Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;)V

    .line 340
    new-instance v0, Landroid/view/Surface;

    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-direct {v0, v1}, Landroid/view/Surface;-><init>(Landroid/graphics/SurfaceTexture;)V

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_Surface:Landroid/view/Surface;

    .line 342
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_Surface:Landroid/view/Surface;

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setSurface(Landroid/view/Surface;)V

    .line 343
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    .line 344
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    .line 345
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 348
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepareAsync()V

    const/4 v0, 0x1

    return v0

    :catch_3
    move-exception v1

    const-string v2, "Unity"

    .line 321
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Error m_MediaPlayer.setDataSource() : "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 323
    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return v0
.end method

.method public NDK_SetFileName(Ljava/lang/String;)V
    .locals 0

    .line 695
    iput-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strFileName:Ljava/lang/String;

    return-void
.end method

.method public Pause()V
    .locals 2

    .line 552
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 554
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_0

    .line 556
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->pause()V

    .line 557
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    :cond_0
    return-void
.end method

.method public Play(I)V
    .locals 1

    .line 495
    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz p1, :cond_1

    .line 497
    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->END:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne p1, v0, :cond_1

    .line 501
    :cond_0
    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->start()V

    .line 503
    sget-object p1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    :cond_1
    return-void
.end method

.method public native QuitApplication()V
.end method

.method public RePlay()V
    .locals 2

    .line 539
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 541
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_0

    .line 543
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    .line 544
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    :cond_0
    return-void
.end method

.method public native RenderScene([FII)V
.end method

.method public Reset()V
    .locals 2

    .line 511
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 513
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_0

    .line 515
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V

    .line 520
    :cond_0
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-void
.end method

.method public SelectTrack(I)V
    .locals 1

    .line 626
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 628
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->selectTrack(I)V

    :cond_0
    return-void
.end method

.method public native SetAssetManager(Landroid/content/res/AssetManager;)V
.end method

.method public SetLooping(Z)V
    .locals 1

    .line 428
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 429
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->setLooping(Z)V

    :cond_0
    return-void
.end method

.method public native SetManagerID(I)V
.end method

.method public SetNotReady()V
    .locals 1

    .line 715
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-void
.end method

.method public SetRockchip(Z)V
    .locals 0

    .line 422
    iput-boolean p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bRockchip:Z

    return-void
.end method

.method public SetSeekPosition(I)V
    .locals 2

    .line 457
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_1

    .line 459
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_1

    .line 461
    :cond_0
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->seekTo(I)V

    :cond_1
    return-void
.end method

.method public SetSpeed(F)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0x17
    .end annotation

    .line 369
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    iget-object v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->getPlaybackParams()Landroid/media/PlaybackParams;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/media/PlaybackParams;->setSpeed(F)Landroid/media/PlaybackParams;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/media/MediaPlayer;->setPlaybackParams(Landroid/media/PlaybackParams;)V

    return-void
.end method

.method public SetSplitOBB(ZLjava/lang/String;)V
    .locals 0

    .line 610
    iput-boolean p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bSplitOBB:Z

    .line 611
    iput-object p2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_strOBBName:Ljava/lang/String;

    return-void
.end method

.method public SetUnityActivity(Landroid/app/Activity;)V
    .locals 1

    .line 687
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, v0}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    .line 688
    iput-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_UnityActivity:Landroid/app/Activity;

    .line 689
    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_UnityActivity:Landroid/app/Activity;

    invoke-virtual {p1}, Landroid/app/Activity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetAssetManager(Landroid/content/res/AssetManager;)V

    return-void
.end method

.method public SetUnityTexture(I)V
    .locals 0

    .line 597
    iput p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iUnityTextureID:I

    .line 598
    iget p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, p1}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    .line 599
    iget p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iUnityTextureID:I

    invoke-virtual {p0, p1}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetUnityTextureID(I)V

    return-void
.end method

.method public native SetUnityTextureID(I)V
.end method

.method public SetUnityTextureID(Ljava/lang/Object;)V
    .locals 0

    return-void
.end method

.method public SetVolume(F)V
    .locals 1

    .line 435
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 437
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1, p1}, Landroid/media/MediaPlayer;->setVolume(FF)V

    :cond_0
    return-void
.end method

.method public SetVolume2(FF)V
    .locals 1

    .line 446
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 448
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1, p2}, Landroid/media/MediaPlayer;->setVolume(FF)V

    :cond_0
    return-void
.end method

.method public SetWindowSize()V
    .locals 4

    .line 721
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, v0}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    .line 722
    invoke-virtual {p0}, Lcom/EasyMovieTexture/EasyMovieTexture;->GetVideoWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/EasyMovieTexture/EasyMovieTexture;->GetVideoHeight()I

    move-result v1

    iget v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iUnityTextureID:I

    iget-boolean v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bRockchip:Z

    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetWindowSize(IIIZ)V

    return-void
.end method

.method public native SetWindowSize(IIIZ)V
.end method

.method public Stop()V
    .locals 2

    .line 525
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    .line 527
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_0

    .line 529
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 534
    :cond_0
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-void
.end method

.method public UnLoad()V
    .locals 5

    .line 133
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_3

    .line 135
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    const/4 v2, 0x0

    if-eq v0, v1, :cond_0

    .line 138
    :try_start_0
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 139
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 147
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_0

    :catch_1
    move-exception v0

    .line 144
    invoke-virtual {v0}, Ljava/lang/SecurityException;->printStackTrace()V

    .line 149
    :goto_0
    iput-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    goto :goto_2

    .line 155
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V
    :try_end_1
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_1

    :catch_2
    move-exception v0

    .line 163
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_1

    :catch_3
    move-exception v0

    .line 160
    invoke-virtual {v0}, Ljava/lang/SecurityException;->printStackTrace()V

    .line 165
    :goto_1
    iput-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    .line 168
    :goto_2
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_Surface:Landroid/view/Surface;

    if-eqz v0, :cond_1

    .line 170
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_Surface:Landroid/view/Surface;

    invoke-virtual {v0}, Landroid/view/Surface;->release()V

    .line 171
    iput-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_Surface:Landroid/view/Surface;

    .line 174
    :cond_1
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    if-eqz v0, :cond_2

    .line 176
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v0}, Landroid/graphics/SurfaceTexture;->release()V

    .line 177
    iput-object v2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    .line 180
    :cond_2
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_3

    const/4 v0, 0x1

    .line 182
    new-array v2, v0, [I

    .line 183
    iget v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    const/4 v4, 0x0

    aput v3, v2, v4

    .line 184
    invoke-static {v0, v2, v4}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .line 185
    iput v1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    .line 189
    :cond_3
    sget-object v0, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->NOT_READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return-void
.end method

.method public UpdateVideoTexture()V
    .locals 6

    .line 376
    iget-boolean v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bUpdate:Z

    if-nez v0, :cond_0

    return-void

    .line 379
    :cond_0
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_2

    .line 381
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PLAYING:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    sget-object v1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->PAUSED:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    if-ne v0, v1, :cond_2

    .line 384
    :cond_1
    iget v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, v0}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    const/4 v0, 0x1

    .line 387
    new-array v0, v0, [Z

    const/4 v1, 0x0

    const/16 v2, 0xb71

    .line 388
    invoke-static {v2, v0, v1}, Landroid/opengl/GLES20;->glGetBooleanv(I[ZI)V

    .line 389
    invoke-static {v2}, Landroid/opengl/GLES20;->glDisable(I)V

    .line 390
    iget-object v3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v3}, Landroid/graphics/SurfaceTexture;->updateTexImage()V

    const/16 v3, 0x10

    .line 396
    new-array v3, v3, [F

    .line 399
    iget-object v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_SurfaceTexture:Landroid/graphics/SurfaceTexture;

    invoke-virtual {v4, v3}, Landroid/graphics/SurfaceTexture;->getTransformMatrix([F)V

    .line 401
    iget v4, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iSurfaceTextureID:I

    iget v5, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iUnityTextureID:I

    invoke-virtual {p0, v3, v4, v5}, Lcom/EasyMovieTexture/EasyMovieTexture;->RenderScene([FII)V

    .line 404
    aget-boolean v0, v0, v1

    if-eqz v0, :cond_2

    .line 406
    invoke-static {v2}, Landroid/opengl/GLES20;->glEnable(I)V

    :cond_2
    return-void
.end method

.method public onBufferingUpdate(Landroid/media/MediaPlayer;I)V
    .locals 1

    .line 793
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-ne p1, v0, :cond_0

    .line 794
    iput p2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPercent:I

    :cond_0
    return-void
.end method

.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 1

    .line 782
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-ne p1, v0, :cond_0

    .line 783
    sget-object p1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->END:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    :cond_0
    return-void
.end method

.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 2

    .line 742
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-ne p1, v0, :cond_1

    const/4 p1, 0x1

    if-eq p2, p1, :cond_0

    const/16 v0, 0x64

    if-eq p2, v0, :cond_0

    const/16 v0, 0xc8

    if-eq p2, v0, :cond_0

    .line 758
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Unknown error "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 761
    :cond_0
    iput p2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iErrorCode:I

    .line 762
    iput p3, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iErrorCodeExtra:I

    .line 768
    sget-object p2, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->ERROR:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object p2, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public declared-synchronized onFrameAvailable(Landroid/graphics/SurfaceTexture;)V
    .locals 0

    monitor-enter p0

    const/4 p1, 0x1

    .line 361
    :try_start_0
    iput-boolean p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_bUpdate:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 362
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    .line 360
    monitor-exit p0

    throw p1
.end method

.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 1

    .line 804
    iget-object v0, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    if-ne p1, v0, :cond_0

    .line 806
    sget-object p1, Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;->READY:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    iput-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentState:Lcom/EasyMovieTexture/EasyMovieTexture$MEDIAPLAYER_STATE;

    .line 808
    iget p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iNativeMgrID:I

    invoke-virtual {p0, p1}, Lcom/EasyMovieTexture/EasyMovieTexture;->SetManagerID(I)V

    const/4 p1, 0x0

    .line 809
    iput p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_iCurrentSeekPercent:I

    .line 810
    iget-object p1, p0, Lcom/EasyMovieTexture/EasyMovieTexture;->m_MediaPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {p1, p0}, Landroid/media/MediaPlayer;->setOnBufferingUpdateListener(Landroid/media/MediaPlayer$OnBufferingUpdateListener;)V

    :cond_0
    return-void
.end method
