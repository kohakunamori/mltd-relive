package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzkr implements zzdb<zzku> {
    private static zzkr zzasc = new zzkr();
    private final zzdb<zzku> zzapj;

    public static boolean zzzj() {
        return ((zzku) zzasc.get()).zzzj();
    }

    public static boolean zzzk() {
        return ((zzku) zzasc.get()).zzzk();
    }

    public static boolean zzzl() {
        return ((zzku) zzasc.get()).zzzl();
    }

    private zzkr(zzdb<zzku> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzkr() {
        this(zzda.zzg(new zzkt()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzku get() {
        return this.zzapj.get();
    }
}
