package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjs implements zzdb<zzjr> {
    private static zzjs zzarh = new zzjs();
    private final zzdb<zzjr> zzapj;

    public static boolean zzyx() {
        return ((zzjr) zzarh.get()).zzyx();
    }

    private zzjs(zzdb<zzjr> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjs() {
        this(zzda.zzg(new zzju()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzjr get() {
        return this.zzapj.get();
    }
}
