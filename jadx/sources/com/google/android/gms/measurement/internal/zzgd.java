package com.google.android.gms.measurement.internal;

/* JADX INFO: loaded from: classes.dex */
final class zzgd implements Runnable {
    private final /* synthetic */ zzn zzpg;
    private final /* synthetic */ zzfk zzph;

    zzgd(zzfk zzfkVar, zzn zznVar) {
        this.zzph = zzfkVar;
        this.zzpg = zznVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzph.zzkz.zzjq();
        this.zzph.zzkz.zzf(this.zzpg);
    }
}
