package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzke implements zzdb<zzkd> {
    private static zzke zzars = new zzke();
    private final zzdb<zzkd> zzapj;

    public static boolean zzzd() {
        return ((zzkd) zzars.get()).zzzd();
    }

    private zzke(zzdb<zzkd> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzke() {
        this(zzda.zzg(new zzkg()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzkd get() {
        return this.zzapj.get();
    }
}
