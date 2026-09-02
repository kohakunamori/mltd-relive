package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzli implements zzdb<zzlh> {
    private static zzli zzasu = new zzli();
    private final zzdb<zzlh> zzapj;

    public static boolean zzzv() {
        return ((zzlh) zzasu.get()).zzzv();
    }

    private zzli(zzdb<zzlh> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzli() {
        this(zzda.zzg(new zzlk()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzlh get() {
        return this.zzapj.get();
    }
}
