package com.google.android.gms.games.internal;

import android.R;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.os.IBinder;
import android.view.Display;
import android.view.View;
import android.view.ViewTreeObserver;
import com.google.android.gms.common.util.PlatformVersion;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
public final class zzby implements View.OnAttachStateChangeListener, ViewTreeObserver.OnGlobalLayoutListener {
    private boolean zzgt = false;
    private zze zzjv;
    private zzca zzjw;
    private WeakReference<View> zzjx;

    public static zzby zza(zze zzeVar, int i) {
        return new zzby(zzeVar, i);
    }

    private zzby(zze zzeVar, int i) {
        this.zzjv = zzeVar;
        this.zzjw = new zzca(i);
    }

    public final void setGravity(int i) {
        this.zzjw.gravity = i;
    }

    public final Bundle zzco() {
        return this.zzjw.zzcs();
    }

    public final IBinder zzcp() {
        return this.zzjw.zzju;
    }

    public final zzca zzcq() {
        return this.zzjw;
    }

    @TargetApi(16)
    public final void zzb(View view) {
        this.zzjv.zzci();
        if (this.zzjx != null) {
            View decorView = this.zzjx.get();
            Context context = this.zzjv.getContext();
            if (decorView == null && (context instanceof Activity)) {
                decorView = ((Activity) context).getWindow().getDecorView();
            }
            if (decorView != null) {
                decorView.removeOnAttachStateChangeListener(this);
                ViewTreeObserver viewTreeObserver = decorView.getViewTreeObserver();
                if (PlatformVersion.isAtLeastJellyBean()) {
                    viewTreeObserver.removeOnGlobalLayoutListener(this);
                } else {
                    viewTreeObserver.removeGlobalOnLayoutListener(this);
                }
            }
        }
        this.zzjx = null;
        Context context2 = this.zzjv.getContext();
        if (view == null && (context2 instanceof Activity)) {
            Activity activity = (Activity) context2;
            view = activity.findViewById(R.id.content);
            if (view == null) {
                view = activity.getWindow().getDecorView();
            }
            zzbd.m39w("PopupManager", "You have not specified a View to use as content view for popups. Falling back to the Activity content view. Note that this may not work as expected in multi-screen environments");
        }
        if (view != null) {
            zzc(view);
            this.zzjx = new WeakReference<>(view);
            view.addOnAttachStateChangeListener(this);
            view.getViewTreeObserver().addOnGlobalLayoutListener(this);
            return;
        }
        zzbd.m36e("PopupManager", "No content view usable to display popups. Popups will not be displayed in response to this client's calls. Use setViewForPopups() to set your content view.");
    }

    public final void zzcr() {
        if (this.zzjw.zzju != null) {
            this.zzjv.zza(this.zzjw.zzju, this.zzjw.zzcs());
            this.zzgt = false;
        } else {
            this.zzgt = true;
        }
    }

    @Override // android.view.View.OnAttachStateChangeListener
    public final void onViewAttachedToWindow(View view) {
        zzc(view);
    }

    @Override // android.view.View.OnAttachStateChangeListener
    public final void onViewDetachedFromWindow(View view) {
        this.zzjv.zzci();
        view.removeOnAttachStateChangeListener(this);
    }

    @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
    public final void onGlobalLayout() {
        View view;
        if (this.zzjx == null || (view = this.zzjx.get()) == null) {
            return;
        }
        zzc(view);
    }

    @TargetApi(17)
    private final void zzc(View view) {
        Display display;
        int displayId = -1;
        if (PlatformVersion.isAtLeastJellyBeanMR1() && (display = view.getDisplay()) != null) {
            displayId = display.getDisplayId();
        }
        IBinder windowToken = view.getWindowToken();
        int[] iArr = new int[2];
        view.getLocationInWindow(iArr);
        int width = view.getWidth();
        int height = view.getHeight();
        this.zzjw.zzjy = displayId;
        this.zzjw.zzju = windowToken;
        this.zzjw.left = iArr[0];
        this.zzjw.top = iArr[1];
        this.zzjw.right = iArr[0] + width;
        this.zzjw.bottom = iArr[1] + height;
        if (this.zzgt) {
            zzcr();
        }
    }
}
