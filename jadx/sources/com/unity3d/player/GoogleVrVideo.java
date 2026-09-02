package com.unity3d.player;

import android.view.Surface;

/* JADX INFO: loaded from: classes.dex */
public interface GoogleVrVideo {

    public interface GoogleVrVideoCallbacks {
        void onFrameAvailable();

        void onSurfaceAvailable(Surface surface);

        void onSurfaceUnavailable();
    }

    void deregisterGoogleVrVideoListener(GoogleVrVideoCallbacks googleVrVideoCallbacks);

    void registerGoogleVrVideoListener(GoogleVrVideoCallbacks googleVrVideoCallbacks);

    void setVideoLocationTransform(float[] fArr);
}
