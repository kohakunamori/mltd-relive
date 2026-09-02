package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzmm implements zzdb<zzml> {
    private static zzmm zzaty = new zzmm();
    private final zzdb<zzml> zzapj;

    public static boolean zzaao() {
        return ((zzml) zzaty.get()).zzaao();
    }

    private zzmm(zzdb<zzml> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzmm() {
        this(zzda.zzg(new zzmn()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzml get() {
        return this.zzapj.get();
    }
}
