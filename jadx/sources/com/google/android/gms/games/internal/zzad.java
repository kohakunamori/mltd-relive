package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.common.internal.BaseGmsClient;

/* JADX INFO: loaded from: classes.dex */
final class zzad implements BaseImplementation.ResultHolder<Status> {
    private final /* synthetic */ BaseGmsClient.SignOutCallbacks zzhj;

    zzad(BaseGmsClient.SignOutCallbacks signOutCallbacks) {
        this.zzhj = signOutCallbacks;
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ResultHolder
    public final void setFailedResult(Status status) {
        this.zzhj.onSignOutComplete();
    }

    @Override // com.google.android.gms.common.api.internal.BaseImplementation.ResultHolder
    public final /* synthetic */ void setResult(Status status) {
        this.zzhj.onSignOutComplete();
    }
}
