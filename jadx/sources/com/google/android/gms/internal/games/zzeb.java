package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.video.Videos;

/* JADX INFO: loaded from: classes.dex */
final class zzeb implements Videos.CaptureAvailableResult {
    private final /* synthetic */ Status zzbd;

    zzeb(zzea zzeaVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.video.Videos.CaptureAvailableResult
    public final boolean isAvailable() {
        return false;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }
}
