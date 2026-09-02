package com.google.android.gms.internal.p005authapi;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;

/* JADX INFO: loaded from: classes.dex */
final class zzo extends zzg {
    private BaseImplementation.ResultHolder<Status> zzap;

    zzo(BaseImplementation.ResultHolder<Status> resultHolder) {
        this.zzap = resultHolder;
    }

    @Override // com.google.android.gms.internal.p005authapi.zzg, com.google.android.gms.internal.p005authapi.zzu
    public final void zzc(Status status) {
        this.zzap.setResult(status);
    }
}
