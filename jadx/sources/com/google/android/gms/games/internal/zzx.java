package com.google.android.gms.games.internal;

import com.google.android.gms.common.data.DataHolder;

/* JADX INFO: Add missing generic type declarations: [T] */
/* JADX INFO: loaded from: classes.dex */
final class zzx<T> extends zze.zzv<T> {
    private final /* synthetic */ DataHolder zzhf;
    private final /* synthetic */ zze.zzaz zzhi;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzx(zze.zzaz zzazVar, DataHolder dataHolder) {
        super(null);
        this.zzhi = zzazVar;
        this.zzhf = dataHolder;
    }

    @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
    public final void notifyListener(T t) {
        this.zzhi.zza(t, this.zzhf.getStatusCode(), zze.zzay(this.zzhf));
    }
}
