package com.google.android.gms.measurement.internal;

import androidx.annotation.GuardedBy;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
@VisibleForTesting
public final class zzdu<V> {
    private static final Object zzjo = new Object();
    private final String zzjj;
    private final zzdv<V> zzjk;
    private final V zzjl;
    private final V zzjm;
    private final Object zzjn;

    @GuardedBy("overrideLock")
    private volatile V zzjp;

    @GuardedBy("cachingLock")
    private volatile V zzjq;

    private zzdu(@NonNull String str, @NonNull V v, @NonNull V v2, @Nullable zzdv<V> zzdvVar) {
        this.zzjn = new Object();
        this.zzjp = null;
        this.zzjq = null;
        this.zzjj = str;
        this.zzjl = v;
        this.zzjm = v2;
        this.zzjk = zzdvVar;
    }

    public final String getKey() {
        return this.zzjj;
    }

    public final V get(@Nullable V v) {
        synchronized (this.zzjn) {
            V v2 = this.zzjp;
        }
        if (v != null) {
            return v;
        }
        if (zzak.zzfv == null) {
            return this.zzjl;
        }
        zzr zzrVar = zzak.zzfv;
        synchronized (zzjo) {
            if (zzr.isMainThread()) {
                return this.zzjq == null ? this.zzjl : this.zzjq;
            }
            if (zzr.isMainThread()) {
                throw new IllegalStateException("Tried to refresh flag cache on main thread or on package side.");
            }
            zzr zzrVar2 = zzak.zzfv;
            try {
                for (zzdu zzduVar : zzak.zzfw) {
                    synchronized (zzjo) {
                        if (zzr.isMainThread()) {
                            throw new IllegalStateException("Refreshing flag cache must be done on a worker thread.");
                        }
                        zzduVar.zzjq = zzduVar.zzjk != null ? zzduVar.zzjk.get() : null;
                    }
                }
            } catch (SecurityException e) {
                zzak.zza(e);
            }
            if (this.zzjk == null) {
                zzr zzrVar3 = zzak.zzfv;
                return this.zzjl;
            }
            try {
                return this.zzjk.get();
            } catch (SecurityException e2) {
                zzak.zza(e2);
                zzr zzrVar4 = zzak.zzfv;
                return this.zzjl;
            }
        }
    }
}
