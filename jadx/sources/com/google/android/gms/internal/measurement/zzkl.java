package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzkl implements zzdb<zzko> {
    private static zzkl zzarx = new zzkl();
    private final zzdb<zzko> zzapj;

    public static boolean zzzh() {
        return ((zzko) zzarx.get()).zzzh();
    }

    private zzkl(zzdb<zzko> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzkl() {
        this(zzda.zzg(new zzkn()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzko get() {
        return this.zzapj.get();
    }
}
