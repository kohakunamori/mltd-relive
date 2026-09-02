package com.smrtbeat;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.os.Handler;
import android.view.Window;

/* JADX INFO: renamed from: com.smrtbeat.g */
/* JADX INFO: loaded from: classes.dex */
class RunnableC0378g implements Runnable {

    /* JADX INFO: renamed from: h */
    private static final int f166h = 3;

    /* JADX INFO: renamed from: i */
    private static final long f167i = 1000;

    /* JADX INFO: renamed from: a */
    private Window f168a = null;

    /* JADX INFO: renamed from: b */
    private Context f169b = null;

    /* JADX INFO: renamed from: c */
    private int f170c = 0;

    /* JADX INFO: renamed from: d */
    private Object f171d = new Object();

    /* JADX INFO: renamed from: e */
    Canvas f172e;

    /* JADX INFO: renamed from: f */
    Bitmap f173f;

    /* JADX INFO: renamed from: g */
    Handler f174g;

    RunnableC0378g() {
    }

    /* JADX INFO: renamed from: b */
    private boolean m208b() {
        Context context;
        Handler handler;
        synchronized (this.f171d) {
            Window window = this.f168a;
            if (window != null && (context = this.f169b) != null && (handler = this.f174g) != null) {
                C0373d0.m137a(window, context, this, handler);
                return true;
            }
            this.f170c++;
            return false;
        }
    }

    /* JADX INFO: renamed from: a */
    void m209a(Activity activity) {
        synchronized (this.f171d) {
            if (this.f168a == activity.getWindow()) {
                this.f168a = null;
                this.f169b = null;
            }
        }
    }

    /* JADX INFO: renamed from: b */
    void m210b(Activity activity) {
        synchronized (this.f171d) {
            this.f170c = 0;
            if (C0382j.f218Z) {
                this.f168a = null;
                this.f169b = null;
            } else {
                this.f168a = activity.getWindow();
                this.f169b = activity.getApplicationContext();
                this.f174g = new Handler(activity.getMainLooper());
            }
        }
    }

    @Override // java.lang.Runnable
    public void run() {
        while (true) {
            try {
                Thread.sleep(f167i);
            } catch (InterruptedException unused) {
            }
            if (!C0377f0.m193h()) {
                return;
            }
            synchronized (this.f171d) {
                if (this.f170c > 3) {
                    return;
                }
            }
            m208b();
        }
    }
}
