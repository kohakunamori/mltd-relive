package com.google.android.gms.internal.games;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzej {
    private final AtomicReference<zzeh> zzln = new AtomicReference<>();

    protected abstract zzeh zzcj();

    public final void flush() {
        zzeh zzehVar = this.zzln.get();
        if (zzehVar != null) {
            zzehVar.flush();
        }
    }

    public final void zza(String str, int i) {
        zzeh zzehVarZzcj = this.zzln.get();
        if (zzehVarZzcj == null) {
            zzehVarZzcj = zzcj();
            if (!this.zzln.compareAndSet(null, zzehVarZzcj)) {
                zzehVarZzcj = this.zzln.get();
            }
        }
        zzehVarZzcj.zzg(str, i);
    }
}
