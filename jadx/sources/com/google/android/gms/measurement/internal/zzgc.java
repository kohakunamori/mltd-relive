package com.google.android.gms.measurement.internal;

/* JADX INFO: loaded from: classes.dex */
final class zzgc implements Runnable {
    private final /* synthetic */ String zzax;
    private final /* synthetic */ String zzdn;
    private final /* synthetic */ zzfk zzph;
    private final /* synthetic */ String zzpj;
    private final /* synthetic */ long zzpk;

    zzgc(zzfk zzfkVar, String str, String str2, String str3, long j) {
        this.zzph = zzfkVar;
        this.zzpj = str;
        this.zzdn = str2;
        this.zzax = str3;
        this.zzpk = j;
    }

    @Override // java.lang.Runnable
    public final void run() {
        if (this.zzpj == null) {
            this.zzph.zzkz.zzjt().zzt().zza(this.zzdn, (zzhr) null);
        } else {
            this.zzph.zzkz.zzjt().zzt().zza(this.zzdn, new zzhr(this.zzax, this.zzpj, this.zzpk));
        }
    }
}
