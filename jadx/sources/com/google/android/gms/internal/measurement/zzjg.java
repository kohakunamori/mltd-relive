package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjg implements zzdb<zzjf> {
    private static zzjg zzapn = new zzjg();
    private final zzdb<zzjf> zzapj;

    public static boolean zzxi() {
        return ((zzjf) zzapn.get()).zzxi();
    }

    private zzjg(zzdb<zzjf> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjg() {
        this(zzda.zzg(new zzji()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzjf get() {
        return this.zzapj.get();
    }
}
