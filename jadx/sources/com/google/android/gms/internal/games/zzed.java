package com.google.android.gms.internal.games;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.video.VideoCapabilities;
import com.google.android.gms.games.video.Videos;

/* JADX INFO: loaded from: classes.dex */
final class zzed implements Videos.CaptureCapabilitiesResult {
    private final /* synthetic */ Status zzbd;

    zzed(zzec zzecVar, Status status) {
        this.zzbd = status;
    }

    @Override // com.google.android.gms.games.video.Videos.CaptureCapabilitiesResult
    public final VideoCapabilities getCapabilities() {
        return null;
    }

    @Override // com.google.android.gms.common.api.Result
    public final Status getStatus() {
        return this.zzbd;
    }
}
