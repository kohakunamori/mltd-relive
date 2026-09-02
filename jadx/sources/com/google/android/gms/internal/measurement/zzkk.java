package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzkk implements zzdb<zzkj> {
    private static zzkk zzarw = new zzkk();
    private final zzdb<zzkj> zzapj;

    public static boolean zzzf() {
        return ((zzkj) zzarw.get()).zzzf();
    }

    public static boolean zzzg() {
        return ((zzkj) zzarw.get()).zzzg();
    }

    private zzkk(zzdb<zzkj> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzkk() {
        this(zzda.zzg(new zzkm()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzkj get() {
        return this.zzapj.get();
    }
}
