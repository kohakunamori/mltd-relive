package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjh implements zzdb<zzjk> {
    private static zzjh zzapo = new zzjh();
    private final zzdb<zzjk> zzapj;

    public static boolean zzxj() {
        return ((zzjk) zzapo.get()).zzxj();
    }

    public static boolean zzxk() {
        return ((zzjk) zzapo.get()).zzxk();
    }

    public static boolean zzxl() {
        return ((zzjk) zzapo.get()).zzxl();
    }

    private zzjh(zzdb<zzjk> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjh() {
        this(zzda.zzg(new zzjj()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzjk get() {
        return this.zzapj.get();
    }
}
