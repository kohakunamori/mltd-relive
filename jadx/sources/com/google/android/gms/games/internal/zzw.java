package com.google.android.gms.games.internal;

import com.google.android.gms.common.data.DataHolder;
import java.util.ArrayList;

/* JADX INFO: Add missing generic type declarations: [T] */
/* JADX INFO: loaded from: classes.dex */
final class zzw<T> extends zze.zzv<T> {
    private final /* synthetic */ DataHolder zzhf;
    private final /* synthetic */ zze.zzav zzhg;
    private final /* synthetic */ ArrayList zzhh;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzw(zze.zzav zzavVar, DataHolder dataHolder, ArrayList arrayList) {
        super(null);
        this.zzhg = zzavVar;
        this.zzhf = dataHolder;
        this.zzhh = arrayList;
    }

    @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
    public final void notifyListener(T t) {
        this.zzhg.zza(t, zze.zzay(this.zzhf), this.zzhh);
    }
}
