package com.google.android.gms.internal.measurement;

import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public abstract class zziw {
    protected volatile int zzaow = -1;

    public abstract zziw zza(zzil zzilVar) throws IOException;

    public void zza(zzio zzioVar) throws IOException {
    }

    protected int zzqy() {
        return 0;
    }

    public final int zzuk() {
        int iZzqy = zzqy();
        this.zzaow = iZzqy;
        return iZzqy;
    }

    public String toString() {
        return zziv.zzb(this);
    }

    @Override // 
    /* JADX INFO: renamed from: zzxb, reason: merged with bridge method [inline-methods] */
    public zziw clone() throws CloneNotSupportedException {
        return (zziw) super.clone();
    }
}
