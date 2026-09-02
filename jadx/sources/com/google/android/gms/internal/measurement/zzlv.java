package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzlv implements zzdb<zzly> {
    private static zzlv zzatd = new zzlv();
    private final zzdb<zzly> zzapj;

    public static boolean zzaad() {
        return ((zzly) zzatd.get()).zzaad();
    }

    public static boolean zzaae() {
        return ((zzly) zzatd.get()).zzaae();
    }

    private zzlv(zzdb<zzly> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzlv() {
        this(zzda.zzg(new zzlx()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzly get() {
        return this.zzapj.get();
    }
}
