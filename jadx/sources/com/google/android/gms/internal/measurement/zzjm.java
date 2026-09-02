package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjm implements zzdb<zzjl> {
    private static zzjm zzapt = new zzjm();
    private final zzdb<zzjl> zzapj;

    public static boolean zzxm() {
        return ((zzjl) zzapt.get()).zzxm();
    }

    private zzjm(zzdb<zzjl> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjm() {
        this(zzda.zzg(new zzjo()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzjl get() {
        return this.zzapj.get();
    }
}
