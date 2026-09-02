package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.request.GameRequestBuffer;
import com.google.android.gms.games.request.Requests;

/* JADX INFO: loaded from: classes.dex */
final class zzce implements Requests.LoadRequestsResult {
    private final /* synthetic */ Status zzbd;

    zzce(zzcd zzcdVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.request.Requests.LoadRequestsResult
    public final GameRequestBuffer getRequests(int i) {
        return new GameRequestBuffer(DataHolder.empty(this.zzbd.getStatusCode()));
    }
}
