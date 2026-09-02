package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import android.os.Looper;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

/* JADX INFO: renamed from: com.unity3d.player.c */
/* JADX INFO: loaded from: classes.dex */
class C0454c {

    /* JADX INFO: renamed from: b */
    protected InterfaceC0457f f643b;

    /* JADX INFO: renamed from: e */
    protected String f646e;

    /* JADX INFO: renamed from: a */
    protected C0466o f642a = null;

    /* JADX INFO: renamed from: c */
    protected Context f644c = null;

    /* JADX INFO: renamed from: d */
    protected String f645d = null;

    C0454c(String str, InterfaceC0457f interfaceC0457f) {
        this.f643b = null;
        this.f646e = "";
        this.f646e = str;
        this.f643b = interfaceC0457f;
    }

    protected void reportError(String str) {
        if (this.f643b != null) {
            this.f643b.reportError(this.f646e + " Error [" + this.f645d + "]", str);
            return;
        }
        C0458g.Log(6, this.f646e + " Error [" + this.f645d + "]: " + str);
    }

    protected void runOnUiThread(Runnable runnable) {
        if (this.f644c instanceof Activity) {
            ((Activity) this.f644c).runOnUiThread(runnable);
            return;
        }
        C0458g.Log(5, "Not running " + this.f646e + " from an Activity; Ignoring execution request...");
    }

    protected boolean runOnUiThreadWithSync(final Runnable runnable) {
        if (Looper.getMainLooper().getThread() == Thread.currentThread()) {
            runnable.run();
            return true;
        }
        final Semaphore semaphore = new Semaphore(0);
        runOnUiThread(new Runnable() { // from class: com.unity3d.player.c.1
            @Override // java.lang.Runnable
            public final void run() {
                try {
                    try {
                        runnable.run();
                    } catch (Exception e) {
                        C0454c.this.reportError("Exception unloading Google VR on UI Thread. " + e.getLocalizedMessage());
                    }
                } finally {
                    semaphore.release();
                }
            }
        });
        try {
            if (semaphore.tryAcquire(4L, TimeUnit.SECONDS)) {
                return true;
            }
            reportError("Timeout waiting for vr state change!");
            return false;
        } catch (InterruptedException e) {
            reportError("Interrupted while trying to acquire sync lock. " + e.getLocalizedMessage());
            return false;
        }
    }
}
