package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzbk implements zzbn {
    static final zzbn zzjs = new zzbk();

    private zzbk() {
    }

    @Override // com.google.android.gms.games.internal.zzbn
    public final boolean zza(Status status) {
        return status.isSuccess();
    }
}
