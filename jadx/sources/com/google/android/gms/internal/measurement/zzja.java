package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzja implements zzdb<zziz> {
    private static zzja zzapi = new zzja();
    private final zzdb<zziz> zzapj;

    public static boolean zzxg() {
        return ((zziz) zzapi.get()).zzxg();
    }

    private zzja(zzdb<zziz> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzja() {
        this(zzda.zzg(new zzjc()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zziz get() {
        return this.zzapj.get();
    }
}
