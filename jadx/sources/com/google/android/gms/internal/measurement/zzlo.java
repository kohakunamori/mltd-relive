package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzlo implements zzdb<zzln> {
    private static zzlo zzasy = new zzlo();
    private final zzdb<zzln> zzapj;

    public static boolean zzzx() {
        return ((zzln) zzasy.get()).zzzx();
    }

    private zzlo(zzdb<zzln> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzlo() {
        this(zzda.zzg(new zzlq()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzln get() {
        return this.zzapj.get();
    }
}
