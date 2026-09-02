package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjy implements zzdb<zzjx> {
    private static zzjy zzarl = new zzjy();
    private final zzdb<zzjx> zzapj;

    public static boolean zzyz() {
        return ((zzjx) zzarl.get()).zzyz();
    }

    private zzjy(zzdb<zzjx> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjy() {
        this(zzda.zzg(new zzka()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzjx get() {
        return this.zzapj.get();
    }
}
