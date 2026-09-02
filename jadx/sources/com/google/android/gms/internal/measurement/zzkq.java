package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzkq implements zzdb<zzkp> {
    private static zzkq zzasb = new zzkq();
    private final zzdb<zzkp> zzapj;

    public static boolean zzzi() {
        return ((zzkp) zzasb.get()).zzzi();
    }

    private zzkq(zzdb<zzkp> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzkq() {
        this(zzda.zzg(new zzks()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzkp get() {
        return this.zzapj.get();
    }
}
