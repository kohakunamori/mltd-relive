package com.EasyMovieTexture;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.graphics.SurfaceTexture;
import android.media.MediaPlayer;
import android.net.Uri;
import android.opengl.GLES20;
import android.util.Log;
import android.view.Surface;
import com.android.vending.expansion.zipfile.ZipResourceFile;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public class EasyMovieTexture implements MediaPlayer.OnPreparedListener, MediaPlayer.OnBufferingUpdateListener, MediaPlayer.OnCompletionListener, MediaPlayer.OnErrorListener, SurfaceTexture.OnFrameAvailableListener {
    private static final int GL_TEXTURE_EXTERNAL_OES = 36197;
    public static ArrayList<EasyMovieTexture> m_objCtrl = new ArrayList<>();
    private int m_iErrorCode;
    private int m_iErrorCodeExtra;
    public int m_iNativeMgrID;
    private String m_strFileName;
    private String m_strOBBName;
    private Activity m_UnityActivity = null;
    private MediaPlayer m_MediaPlayer = null;
    private int m_iUnityTextureID = -1;
    private int m_iSurfaceTextureID = -1;
    private SurfaceTexture m_SurfaceTexture = null;
    private Surface m_Surface = null;
    private int m_iCurrentSeekPercent = 0;
    private int m_iCurrentSeekPosition = 0;
    private boolean m_bRockchip = true;
    private boolean m_bSplitOBB = false;
    public boolean m_bUpdate = false;
    MEDIAPLAYER_STATE m_iCurrentState = MEDIAPLAYER_STATE.NOT_READY;

    public native int GetManagerID();

    public native int InitApplication();

    public native int InitExtTexture();

    public native int InitNDK(Object obj);

    public native void QuitApplication();

    public native void RenderScene(float[] fArr, int i, int i2);

    public native void SetAssetManager(AssetManager assetManager);

    public native void SetManagerID(int i);

    public native void SetUnityTextureID(int i);

    public void SetUnityTextureID(Object obj) {
    }

    public native void SetWindowSize(int i, int i2, int i3, boolean z);

    static {
        System.loadLibrary("BlueDoveMediaRender");
    }

    public static EasyMovieTexture GetObject(int i) {
        for (int i2 = 0; i2 < m_objCtrl.size(); i2++) {
            if (m_objCtrl.get(i2).m_iNativeMgrID == i) {
                return m_objCtrl.get(i2);
            }
        }
        return null;
    }

    public void Destroy() {
        if (this.m_iSurfaceTextureID != -1) {
            GLES20.glDeleteTextures(1, new int[]{this.m_iSurfaceTextureID}, 0);
            this.m_iSurfaceTextureID = -1;
        }
        SetManagerID(this.m_iNativeMgrID);
        QuitApplication();
        for (int i = 0; i < m_objCtrl.size(); i++) {
            if (m_objCtrl.get(i).m_iNativeMgrID == this.m_iNativeMgrID) {
                Log.e("jni", " " + this.m_iNativeMgrID);
                m_objCtrl.remove(i);
            }
        }
    }

    public void UnLoad() {
        if (this.m_MediaPlayer != null) {
            if (this.m_iCurrentState != MEDIAPLAYER_STATE.NOT_READY) {
                try {
                    this.m_MediaPlayer.stop();
                    this.m_MediaPlayer.release();
                } catch (IllegalStateException e) {
                    e.printStackTrace();
                } catch (SecurityException e2) {
                    e2.printStackTrace();
                }
                this.m_MediaPlayer = null;
            } else {
                try {
                    this.m_MediaPlayer.release();
                } catch (IllegalStateException e3) {
                    e3.printStackTrace();
                } catch (SecurityException e4) {
                    e4.printStackTrace();
                }
                this.m_MediaPlayer = null;
            }
            if (this.m_Surface != null) {
                this.m_Surface.release();
                this.m_Surface = null;
            }
            if (this.m_SurfaceTexture != null) {
                this.m_SurfaceTexture.release();
                this.m_SurfaceTexture = null;
            }
            if (this.m_iSurfaceTextureID != -1) {
                GLES20.glDeleteTextures(1, new int[]{this.m_iSurfaceTextureID}, 0);
                this.m_iSurfaceTextureID = -1;
            }
        }
        this.m_iCurrentState = MEDIAPLAYER_STATE.NOT_READY;
    }

    public boolean Load() throws IllegalStateException, SecurityException, IOException {
        UnLoad();
        this.m_iCurrentState = MEDIAPLAYER_STATE.NOT_READY;
        this.m_MediaPlayer = new MediaPlayer();
        this.m_MediaPlayer.setAudioStreamType(3);
        this.m_bUpdate = false;
        if (this.m_strFileName.contains("file://")) {
            try {
                File file = new File(this.m_strFileName.replace("file://", ""));
                if (file.exists()) {
                    FileInputStream fileInputStream = new FileInputStream(file);
                    this.m_MediaPlayer.setDataSource(fileInputStream.getFD());
                    fileInputStream.close();
                }
            } catch (IOException e) {
                Log.e("Unity", "Error m_MediaPlayer.setDataSource() : " + this.m_strFileName);
                e.printStackTrace();
                this.m_iCurrentState = MEDIAPLAYER_STATE.ERROR;
            }
        } else if (this.m_strFileName.contains("://")) {
            try {
                HashMap map = new HashMap();
                map.put("rtsp_transport", "tcp");
                map.put("max_analyze_duration", "500");
                this.m_MediaPlayer.setDataSource(this.m_UnityActivity, Uri.parse(this.m_strFileName), map);
            } catch (IOException e2) {
                Log.e("Unity", "Error m_MediaPlayer.setDataSource() : " + this.m_strFileName);
                e2.printStackTrace();
                this.m_iCurrentState = MEDIAPLAYER_STATE.ERROR;
                return false;
            }
        } else if (this.m_bSplitOBB) {
            try {
                ZipResourceFile zipResourceFile = new ZipResourceFile(this.m_strOBBName);
                Log.e("unity", String.valueOf(this.m_strOBBName) + " " + this.m_strFileName);
                StringBuilder sb = new StringBuilder("assets/");
                sb.append(this.m_strFileName);
                AssetFileDescriptor assetFileDescriptor = zipResourceFile.getAssetFileDescriptor(sb.toString());
                for (ZipResourceFile.ZipEntryRO zipEntryRO : zipResourceFile.getAllEntries()) {
                    Log.e("unity", zipEntryRO.mFileName);
                }
                Log.e("unity", assetFileDescriptor + " ");
                this.m_MediaPlayer.setDataSource(assetFileDescriptor.getFileDescriptor(), assetFileDescriptor.getStartOffset(), assetFileDescriptor.getLength());
            } catch (IOException e3) {
                this.m_iCurrentState = MEDIAPLAYER_STATE.ERROR;
                e3.printStackTrace();
                return false;
            }
        } else {
            try {
                AssetFileDescriptor assetFileDescriptorOpenFd = this.m_UnityActivity.getAssets().openFd(this.m_strFileName);
                this.m_MediaPlayer.setDataSource(assetFileDescriptorOpenFd.getFileDescriptor(), assetFileDescriptorOpenFd.getStartOffset(), assetFileDescriptorOpenFd.getLength());
                assetFileDescriptorOpenFd.close();
            } catch (IOException e4) {
                Log.e("Unity", "Error m_MediaPlayer.setDataSource() : " + this.m_strFileName);
                e4.printStackTrace();
                this.m_iCurrentState = MEDIAPLAYER_STATE.ERROR;
                return false;
            }
        }
        if (this.m_iSurfaceTextureID == -1) {
            this.m_iSurfaceTextureID = InitExtTexture();
        }
        this.m_SurfaceTexture = new SurfaceTexture(this.m_iSurfaceTextureID);
        this.m_SurfaceTexture.setOnFrameAvailableListener(this);
        this.m_Surface = new Surface(this.m_SurfaceTexture);
        this.m_MediaPlayer.setSurface(this.m_Surface);
        this.m_MediaPlayer.setOnPreparedListener(this);
        this.m_MediaPlayer.setOnCompletionListener(this);
        this.m_MediaPlayer.setOnErrorListener(this);
        this.m_MediaPlayer.prepareAsync();
        return true;
    }

    @Override // android.graphics.SurfaceTexture.OnFrameAvailableListener
    public synchronized void onFrameAvailable(SurfaceTexture surfaceTexture) {
        this.m_bUpdate = true;
    }

    @TargetApi(23)
    public void SetSpeed(float f) {
        this.m_MediaPlayer.setPlaybackParams(this.m_MediaPlayer.getPlaybackParams().setSpeed(f));
    }

    public void UpdateVideoTexture() {
        if (this.m_bUpdate && this.m_MediaPlayer != null) {
            if (this.m_iCurrentState == MEDIAPLAYER_STATE.PLAYING || this.m_iCurrentState == MEDIAPLAYER_STATE.PAUSED) {
                SetManagerID(this.m_iNativeMgrID);
                boolean[] zArr = new boolean[1];
                GLES20.glGetBooleanv(2929, zArr, 0);
                GLES20.glDisable(2929);
                this.m_SurfaceTexture.updateTexImage();
                float[] fArr = new float[16];
                this.m_SurfaceTexture.getTransformMatrix(fArr);
                RenderScene(fArr, this.m_iSurfaceTextureID, this.m_iUnityTextureID);
                if (zArr[0]) {
                    GLES20.glEnable(2929);
                }
            }
        }
    }

    public void SetRockchip(boolean z) {
        this.m_bRockchip = z;
    }

    public void SetLooping(boolean z) {
        if (this.m_MediaPlayer != null) {
            this.m_MediaPlayer.setLooping(z);
        }
    }

    public void SetVolume(float f) {
        if (this.m_MediaPlayer != null) {
            this.m_MediaPlayer.setVolume(f, f);
        }
    }

    public void SetVolume2(float f, float f2) {
        if (this.m_MediaPlayer != null) {
            this.m_MediaPlayer.setVolume(f, f2);
        }
    }

    public void SetSeekPosition(int i) {
        if (this.m_MediaPlayer != null) {
            if (this.m_iCurrentState == MEDIAPLAYER_STATE.READY || this.m_iCurrentState == MEDIAPLAYER_STATE.PLAYING || this.m_iCurrentState == MEDIAPLAYER_STATE.PAUSED) {
                this.m_MediaPlayer.seekTo(i);
            }
        }
    }

    public int GetSeekPosition() {
        if (this.m_MediaPlayer != null && (this.m_iCurrentState == MEDIAPLAYER_STATE.READY || this.m_iCurrentState == MEDIAPLAYER_STATE.PLAYING || this.m_iCurrentState == MEDIAPLAYER_STATE.PAUSED)) {
            try {
                this.m_iCurrentSeekPosition = this.m_MediaPlayer.getCurrentPosition();
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (SecurityException e2) {
                e2.printStackTrace();
            }
        }
        return this.m_iCurrentSeekPosition;
    }

    public int GetCurrentSeekPercent() {
        return this.m_iCurrentSeekPercent;
    }

    public void Play(int i) {
        if (this.m_MediaPlayer != null) {
            if (this.m_iCurrentState == MEDIAPLAYER_STATE.READY || this.m_iCurrentState == MEDIAPLAYER_STATE.PAUSED || this.m_iCurrentState == MEDIAPLAYER_STATE.END) {
                this.m_MediaPlayer.start();
                this.m_iCurrentState = MEDIAPLAYER_STATE.PLAYING;
            }
        }
    }

    public void Reset() {
        if (this.m_MediaPlayer != null && this.m_iCurrentState == MEDIAPLAYER_STATE.PLAYING) {
            this.m_MediaPlayer.reset();
        }
        this.m_iCurrentState = MEDIAPLAYER_STATE.NOT_READY;
    }

    public void Stop() {
        if (this.m_MediaPlayer != null && this.m_iCurrentState == MEDIAPLAYER_STATE.PLAYING) {
            this.m_MediaPlayer.stop();
        }
        this.m_iCurrentState = MEDIAPLAYER_STATE.NOT_READY;
    }

    public void RePlay() {
        if (this.m_MediaPlayer == null || this.m_iCurrentState != MEDIAPLAYER_STATE.PAUSED) {
            return;
        }
        this.m_MediaPlayer.start();
        this.m_iCurrentState = MEDIAPLAYER_STATE.PLAYING;
    }

    public void Pause() {
        if (this.m_MediaPlayer == null || this.m_iCurrentState != MEDIAPLAYER_STATE.PLAYING) {
            return;
        }
        this.m_MediaPlayer.pause();
        this.m_iCurrentState = MEDIAPLAYER_STATE.PAUSED;
    }

    public int GetVideoWidth() {
        if (this.m_MediaPlayer != null) {
            return this.m_MediaPlayer.getVideoWidth();
        }
        return 0;
    }

    public int GetVideoHeight() {
        if (this.m_MediaPlayer != null) {
            return this.m_MediaPlayer.getVideoHeight();
        }
        return 0;
    }

    public boolean IsUpdateFrame() {
        return this.m_bUpdate;
    }

    public void SetUnityTexture(int i) {
        this.m_iUnityTextureID = i;
        SetManagerID(this.m_iNativeMgrID);
        SetUnityTextureID(this.m_iUnityTextureID);
    }

    public void SetSplitOBB(boolean z, String str) {
        this.m_bSplitOBB = z;
        this.m_strOBBName = str;
    }

    public int GetDuration() {
        if (this.m_MediaPlayer != null) {
            return this.m_MediaPlayer.getDuration();
        }
        return -1;
    }

    public void SelectTrack(int i) {
        if (this.m_MediaPlayer != null) {
            this.m_MediaPlayer.selectTrack(i);
        }
    }

    public int[] GetSoundTrack() {
        if (this.m_MediaPlayer != null) {
            MediaPlayer.TrackInfo[] trackInfo = this.m_MediaPlayer.getTrackInfo();
            int i = 0;
            for (MediaPlayer.TrackInfo trackInfo2 : trackInfo) {
                if (trackInfo2.getTrackType() == 2) {
                    i++;
                }
            }
            if (i != 0) {
                int[] iArr = new int[i];
                int i2 = 0;
                for (int i3 = 0; i3 < trackInfo.length; i3++) {
                    if (trackInfo[i3].getTrackType() == 2) {
                        iArr[i2] = i3;
                        i2++;
                    }
                }
                return iArr;
            }
        }
        return null;
    }

    public int InitNative(EasyMovieTexture easyMovieTexture) {
        this.m_iNativeMgrID = InitNDK(easyMovieTexture);
        m_objCtrl.add(this);
        return this.m_iNativeMgrID;
    }

    public void SetUnityActivity(Activity activity) {
        SetManagerID(this.m_iNativeMgrID);
        this.m_UnityActivity = activity;
        SetAssetManager(this.m_UnityActivity.getAssets());
    }

    public void NDK_SetFileName(String str) {
        this.m_strFileName = str;
    }

    public void InitJniManager() {
        SetManagerID(this.m_iNativeMgrID);
        InitApplication();
    }

    public int GetStatus() {
        return this.m_iCurrentState.GetValue();
    }

    public void SetNotReady() {
        this.m_iCurrentState = MEDIAPLAYER_STATE.NOT_READY;
    }

    public void SetWindowSize() {
        SetManagerID(this.m_iNativeMgrID);
        SetWindowSize(GetVideoWidth(), GetVideoHeight(), this.m_iUnityTextureID, this.m_bRockchip);
    }

    public int GetError() {
        return this.m_iErrorCode;
    }

    public int GetErrorExtra() {
        return this.m_iErrorCodeExtra;
    }

    @Override // android.media.MediaPlayer.OnErrorListener
    public boolean onError(MediaPlayer mediaPlayer, int i, int i2) {
        if (mediaPlayer != this.m_MediaPlayer) {
            return false;
        }
        if (i != 1 && i != 100 && i != 200) {
            String str = "Unknown error " + i;
        }
        this.m_iErrorCode = i;
        this.m_iErrorCodeExtra = i2;
        this.m_iCurrentState = MEDIAPLAYER_STATE.ERROR;
        return true;
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public void onCompletion(MediaPlayer mediaPlayer) {
        if (mediaPlayer == this.m_MediaPlayer) {
            this.m_iCurrentState = MEDIAPLAYER_STATE.END;
        }
    }

    @Override // android.media.MediaPlayer.OnBufferingUpdateListener
    public void onBufferingUpdate(MediaPlayer mediaPlayer, int i) {
        if (mediaPlayer == this.m_MediaPlayer) {
            this.m_iCurrentSeekPercent = i;
        }
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public void onPrepared(MediaPlayer mediaPlayer) {
        if (mediaPlayer == this.m_MediaPlayer) {
            this.m_iCurrentState = MEDIAPLAYER_STATE.READY;
            SetManagerID(this.m_iNativeMgrID);
            this.m_iCurrentSeekPercent = 0;
            this.m_MediaPlayer.setOnBufferingUpdateListener(this);
        }
    }

    public enum MEDIAPLAYER_STATE {
        NOT_READY(0),
        READY(1),
        END(2),
        PLAYING(3),
        PAUSED(4),
        STOPPED(5),
        ERROR(6);

        private int iValue;

        /* JADX INFO: renamed from: values, reason: to resolve conflict with enum method */
        public static MEDIAPLAYER_STATE[] valuesCustom() {
            MEDIAPLAYER_STATE[] mediaplayer_stateArrValuesCustom = values();
            int length = mediaplayer_stateArrValuesCustom.length;
            MEDIAPLAYER_STATE[] mediaplayer_stateArr = new MEDIAPLAYER_STATE[length];
            System.arraycopy(mediaplayer_stateArrValuesCustom, 0, mediaplayer_stateArr, 0, length);
            return mediaplayer_stateArr;
        }

        MEDIAPLAYER_STATE(int i) {
            this.iValue = i;
        }

        public int GetValue() {
            return this.iValue;
        }
    }
}
