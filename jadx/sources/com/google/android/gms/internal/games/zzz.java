package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.games.event.EventBuffer;
import com.google.android.gms.games.event.Events;

/* JADX INFO: loaded from: classes.dex */
final class zzz implements Events.LoadEventsResult {
    private final /* synthetic */ Status zzbd;

    zzz(zzy zzyVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.common.api.Releasable
    public final void release() {
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }

    @Override // com.google.android.gms.games.event.Events.LoadEventsResult
    public final EventBuffer getEvents() {
        return new EventBuffer(DataHolder.empty(14));
    }
}
