package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzlc implements zzdb<zzlb> {
    private static zzlc zzasm = new zzlc();
    private final zzdb<zzlb> zzapj;

    public static boolean zzzp() {
        return ((zzlb) zzasm.get()).zzzp();
    }

    private zzlc(zzdb<zzlb> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzlc() {
        this(zzda.zzg(new zzle()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzlb get() {
        return this.zzapj.get();
    }
}
