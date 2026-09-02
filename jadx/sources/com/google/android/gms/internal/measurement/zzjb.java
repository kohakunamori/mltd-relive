package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjb implements zzdb<zzje> {
    private static zzjb zzapk = new zzjb();
    private final zzdb<zzje> zzapj;

    public static boolean zzxh() {
        return ((zzje) zzapk.get()).zzxh();
    }

    private zzjb(zzdb<zzje> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjb() {
        this(zzda.zzg(new zzjd()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzje get() {
        return this.zzapj.get();
    }
}
