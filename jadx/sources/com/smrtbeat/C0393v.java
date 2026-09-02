package com.smrtbeat;

import android.annotation.TargetApi;
import android.graphics.Point;
import android.opengl.EGL14;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;

/* JADX INFO: renamed from: com.smrtbeat.v */
/* JADX INFO: loaded from: classes.dex */
@TargetApi(17)
class C0393v {
    C0393v() {
    }

    /* JADX INFO: renamed from: a */
    public static Point m348a() {
        int[] iArr = new int[2];
        EGLDisplay eGLDisplayEglGetCurrentDisplay = EGL14.eglGetCurrentDisplay();
        EGLSurface eGLSurfaceEglGetCurrentSurface = EGL14.eglGetCurrentSurface(12377);
        EGL14.eglQuerySurface(eGLDisplayEglGetCurrentDisplay, eGLSurfaceEglGetCurrentSurface, 12375, iArr, 0);
        EGL14.eglQuerySurface(eGLDisplayEglGetCurrentDisplay, eGLSurfaceEglGetCurrentSurface, 12374, iArr, 1);
        return new Point(iArr[0], iArr[1]);
    }
}
