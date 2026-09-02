package com.google.android.gms.games.internal;

import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.video.VideoCapabilities;
import com.google.android.gms.games.video.Videos;

/* JADX INFO: loaded from: classes.dex */
final class zzo extends zze.zzat<Videos.CaptureCapabilitiesResult> {
    zzo(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zza(int i, VideoCapabilities videoCapabilities) {
        setResult(new zze.C0527zze(new Status(i), videoCapabilities));
    }
}
