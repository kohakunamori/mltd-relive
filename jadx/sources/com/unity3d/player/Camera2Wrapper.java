package com.unity3d.player;

import android.content.Context;
import android.graphics.Rect;
import android.hardware.Camera;

/* JADX INFO: loaded from: classes.dex */
public class Camera2Wrapper implements InterfaceC0455d {

    /* JADX INFO: renamed from: a */
    private Context f446a;

    /* JADX INFO: renamed from: b */
    private C0452a f447b = null;

    /* JADX INFO: renamed from: c */
    private final int f448c = 100;

    public Camera2Wrapper(Context context) {
        this.f446a = context;
        initCamera2Jni();
    }

    /* JADX INFO: renamed from: a */
    private static int m358a(float f) {
        return (int) Math.min(Math.max((f * 2000.0f) - 1000.0f, -900.0f), 900.0f);
    }

    private final native void initCamera2Jni();

    private final native void nativeFrameReady(Object obj, Object obj2, Object obj3, int i, int i2, int i3);

    private final native void nativeSurfaceTextureReady(Object obj);

    /* JADX INFO: renamed from: a */
    public final void m359a() {
        closeCamera2();
    }

    @Override // com.unity3d.player.InterfaceC0455d
    /* JADX INFO: renamed from: a */
    public final void mo360a(Object obj) {
        nativeSurfaceTextureReady(obj);
    }

    @Override // com.unity3d.player.InterfaceC0455d
    /* JADX INFO: renamed from: a */
    public final void mo361a(Object obj, Object obj2, Object obj3, int i, int i2, int i3) {
        nativeFrameReady(obj, obj2, obj3, i, i2, i3);
    }

    protected void closeCamera2() {
        if (this.f447b != null) {
            this.f447b.m495b();
        }
        this.f447b = null;
    }

    protected int getCamera2Count() {
        if (C0461j.f652b) {
            return C0452a.m458a(this.f446a);
        }
        return 0;
    }

    protected int[] getCamera2Resolutions(int i) {
        if (C0461j.f652b) {
            return C0452a.m480d(this.f446a, i);
        }
        return null;
    }

    protected int getCamera2SensorOrientation(int i) {
        if (C0461j.f652b) {
            return C0452a.m459a(this.f446a, i);
        }
        return 0;
    }

    protected Object getCameraFocusArea(float f, float f2) {
        int iM358a = m358a(f);
        int iM358a2 = m358a(1.0f - f2);
        return new Camera.Area(new Rect(iM358a - 100, iM358a2 - 100, iM358a + 100, iM358a2 + 100), 1000);
    }

    protected Rect getFrameSizeCamera2() {
        return this.f447b != null ? this.f447b.m492a() : new Rect();
    }

    protected boolean initializeCamera2(int i, int i2, int i3, int i4, int i5) {
        if (!C0461j.f652b || this.f447b != null || UnityPlayer.currentActivity == null) {
            return false;
        }
        this.f447b = new C0452a(this);
        return this.f447b.m494a(this.f446a, i, i2, i3, i4, i5);
    }

    protected boolean isCamera2AutoFocusPointSupported(int i) {
        if (C0461j.f652b) {
            return C0452a.m477c(this.f446a, i);
        }
        return false;
    }

    protected boolean isCamera2FrontFacing(int i) {
        if (C0461j.f652b) {
            return C0452a.m475b(this.f446a, i);
        }
        return false;
    }

    protected void pauseCamera2() {
        if (this.f447b != null) {
            this.f447b.m497d();
        }
    }

    protected boolean setAutoFocusPoint(float f, float f2) {
        if (!C0461j.f652b || this.f447b == null) {
            return false;
        }
        return this.f447b.m493a(f, f2);
    }

    protected void startCamera2() {
        if (this.f447b != null) {
            this.f447b.m496c();
        }
    }

    protected void stopCamera2() {
        if (this.f447b != null) {
            this.f447b.m498e();
        }
    }
}
