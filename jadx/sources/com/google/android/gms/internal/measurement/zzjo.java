package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes.dex */
public final class zzjo implements zzjl {
    private static final zzcm<Boolean> zzapv;
    private static final zzcm<Long> zzapw;

    @Override // com.google.android.gms.internal.measurement.zzjl
    public final boolean zzxm() {
        return zzapv.get().booleanValue();
    }

    static {
        zzct zzctVar = new zzct(zzcn.zzdh("com.google.android.gms.measurement"));
        zzapv = zzctVar.zzb("measurement.app_launch.event_ordering_fix", false);
        zzapw = zzctVar.zze("measurement.id.app_launch.event_ordering_fix", 0L);
    }
}
