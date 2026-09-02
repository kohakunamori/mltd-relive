package com.google.android.gms.games.internal;

import com.google.android.gms.common.data.DataHolder;

/* JADX INFO: Add missing generic type declarations: [T] */
/* JADX INFO: loaded from: classes.dex */
final class zzv<T> extends zze.zzv<T> {
    private final /* synthetic */ zze.zzaw zzhe;
    private final /* synthetic */ DataHolder zzhf;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzv(zze.zzaw zzawVar, DataHolder dataHolder) {
        super(null);
        this.zzhe = zzawVar;
        this.zzhf = dataHolder;
    }

    @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
    public final void notifyListener(T t) {
        this.zzhe.zza(t, zze.zzay(this.zzhf));
    }
}
