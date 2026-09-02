package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzkw implements zzdb<zzkv> {
    private static zzkw zzash = new zzkw();
    private final zzdb<zzkv> zzapj;

    public static boolean zzzm() {
        return ((zzkv) zzash.get()).zzzm();
    }

    public static boolean zzzn() {
        return ((zzkv) zzash.get()).zzzn();
    }

    private zzkw(zzdb<zzkv> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzkw() {
        this(zzda.zzg(new zzky()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzkv get() {
        return this.zzapj.get();
    }
}
