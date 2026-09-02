package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzlp implements zzdb<zzls> {
    private static zzlp zzasz = new zzlp();
    private final zzdb<zzls> zzapj;

    public static boolean zzzy() {
        return ((zzls) zzasz.get()).zzzy();
    }

    private zzlp(zzdb<zzls> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzlp() {
        this(zzda.zzg(new zzlr()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzls get() {
        return this.zzapj.get();
    }
}
