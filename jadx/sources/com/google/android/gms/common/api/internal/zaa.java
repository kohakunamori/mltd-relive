package com.google.android.gms.common.api.internal;

import android.app.Activity;
import androidx.annotation.MainThread;
import androidx.annotation.VisibleForTesting;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zaa extends ActivityLifecycleObserver {
    private final WeakReference<C0526zaa> zacl;

    public zaa(Activity activity) {
        this(C0526zaa.zaa(activity));
    }

    @VisibleForTesting(otherwise = 2)
    private zaa(C0526zaa c0526zaa) {
        this.zacl = new WeakReference<>(c0526zaa);
    }

    @Override // com.google.android.gms.common.api.internal.ActivityLifecycleObserver
    public final ActivityLifecycleObserver onStopCallOnce(Runnable runnable) {
        C0526zaa c0526zaa = this.zacl.get();
        if (c0526zaa == null) {
            throw new IllegalStateException("The target activity has already been GC'd");
        }
        c0526zaa.zaa(runnable);
        return this;
    }

    /* JADX INFO: renamed from: com.google.android.gms.common.api.internal.zaa$zaa, reason: collision with other inner class name */
    @VisibleForTesting(otherwise = 2)
    static class C0526zaa extends LifecycleCallback {
        private List<Runnable> zacm;

        /* JADX INFO: Access modifiers changed from: private */
        public static C0526zaa zaa(Activity activity) {
            C0526zaa c0526zaa;
            synchronized (activity) {
                LifecycleFragment fragment = getFragment(activity);
                c0526zaa = (C0526zaa) fragment.getCallbackOrNull("LifecycleObserverOnStop", C0526zaa.class);
                if (c0526zaa == null) {
                    c0526zaa = new C0526zaa(fragment);
                }
            }
            return c0526zaa;
        }

        private C0526zaa(LifecycleFragment lifecycleFragment) {
            super(lifecycleFragment);
            this.zacm = new ArrayList();
            this.mLifecycleFragment.addCallback("LifecycleObserverOnStop", this);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final synchronized void zaa(Runnable runnable) {
            this.zacm.add(runnable);
        }

        @Override // com.google.android.gms.common.api.internal.LifecycleCallback
        @MainThread
        public void onStop() {
            List<Runnable> list;
            synchronized (this) {
                list = this.zacm;
                this.zacm = new ArrayList();
            }
            Iterator<Runnable> it = list.iterator();
            while (it.hasNext()) {
                it.next().run();
            }
        }
    }
}
