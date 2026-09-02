package com.google.android.gms.internal.games;

import android.os.Handler;
import android.os.Looper;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzeh {
    private Handler zzli;
    private boolean zzlj;
    private final Object zzlh = new Object();
    private HashMap<String, AtomicInteger> zzlk = new HashMap<>();
    private int zzll = 1000;

    public zzeh(Looper looper, int i) {
        this.zzli = new zzen(looper);
    }

    protected abstract void zzf(String str, int i);

    public final void zzg(String str, int i) {
        synchronized (this.zzlh) {
            if (!this.zzlj) {
                this.zzlj = true;
                this.zzli.postDelayed(new zzei(this), this.zzll);
            }
            AtomicInteger atomicInteger = this.zzlk.get(str);
            if (atomicInteger == null) {
                atomicInteger = new AtomicInteger();
                this.zzlk.put(str, atomicInteger);
            }
            atomicInteger.addAndGet(i);
        }
    }

    public final void flush() {
        synchronized (this.zzlh) {
            for (Map.Entry<String, AtomicInteger> entry : this.zzlk.entrySet()) {
                zzf(entry.getKey(), entry.getValue().get());
            }
            this.zzlk.clear();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzct() {
        synchronized (this.zzlh) {
            this.zzlj = false;
            flush();
        }
    }
}
