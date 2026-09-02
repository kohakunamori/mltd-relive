package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzlj implements zzdb<zzlm> {
    private static zzlj zzasv = new zzlj();
    private final zzdb<zzlm> zzapj;

    public static boolean zzzw() {
        return ((zzlm) zzasv.get()).zzzw();
    }

    private zzlj(zzdb<zzlm> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzlj() {
        this(zzda.zzg(new zzll()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzlm get() {
        return this.zzapj.get();
    }
}
