package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzmg implements zzdb<zzmf> {
    private static zzmg zzatu = new zzmg();
    private final zzdb<zzmf> zzapj;

    public static boolean zzaam() {
        return ((zzmf) zzatu.get()).zzaam();
    }

    private zzmg(zzdb<zzmf> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzmg() {
        this(zzda.zzg(new zzmi()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzmf get() {
        return this.zzapj.get();
    }
}
