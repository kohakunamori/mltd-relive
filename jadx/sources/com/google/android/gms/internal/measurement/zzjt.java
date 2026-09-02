package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjt implements zzdb<zzjw> {
    private static zzjt zzari = new zzjt();
    private final zzdb<zzjw> zzapj;

    public static boolean zzyy() {
        return ((zzjw) zzari.get()).zzyy();
    }

    private zzjt(zzdb<zzjw> zzdbVar) {
        this.zzapj = zzda.zza(zzdbVar);
    }

    public zzjt() {
        this(zzda.zzg(new zzjv()));
    }

    @Override // com.google.android.gms.internal.measurement.zzdb
    public final /* synthetic */ zzjw get() {
        return this.zzapj.get();
    }
}
