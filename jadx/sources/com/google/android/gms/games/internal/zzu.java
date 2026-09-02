package com.google.android.gms.games.internal;

/* JADX INFO: Add missing generic type declarations: [T] */
/* JADX INFO: loaded from: classes.dex */
final class zzu<T> extends zze.zzv<T> {
    private final /* synthetic */ zze.zzap zzhd;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzu(zze.zzap zzapVar) {
        super(null);
        this.zzhd = zzapVar;
    }

    @Override // com.google.android.gms.common.api.internal.ListenerHolder.Notifier
    public final void notifyListener(T t) {
        this.zzhd.accept(t);
    }
}
