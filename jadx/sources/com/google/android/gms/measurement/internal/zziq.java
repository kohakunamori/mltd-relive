package com.google.android.gms.measurement.internal;

/* JADX INFO: loaded from: classes.dex */
final class zziq implements Runnable {
    private final /* synthetic */ zzin zzrs;

    zziq(zzin zzinVar) {
        this.zzrs = zzinVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzhv.zza(this.zzrs.zzrd, (zzdx) null);
        this.zzrs.zzrd.zziv();
    }
}
