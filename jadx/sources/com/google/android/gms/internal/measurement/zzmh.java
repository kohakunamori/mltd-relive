package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzmh implements zzdb<zzmk> {
    private static zzmh zzatv = new zzmh();
    private final zzdb<zzmk> zzapj;

    public static boolean zzaan() {
        return ((zzmk) zzatv.get()).zzaan();
    }

    private zzmh(zzdb<zzmk> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzmh() {
        this(zzda.zzg(new zzmj()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzmk get() {
        return this.zzapj.get();
    }
}
