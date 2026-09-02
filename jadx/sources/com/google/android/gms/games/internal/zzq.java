package com.google.android.gms.games.internal;

import android.os.Bundle;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.BaseImplementation;
import com.google.android.gms.games.video.CaptureState;
import com.google.android.gms.games.video.Videos;

/* JADX INFO: loaded from: classes.dex */
final class zzq extends zze.zzat<Videos.CaptureStateResult> {
    zzq(BaseImplementation.ResultHolder resultHolder) {
        super(resultHolder);
    }

    @Override // com.google.android.gms.games.internal.zza, com.google.android.gms.games.internal.zzbq
    public final void zze(int i, Bundle bundle) {
        setResult(new zze.zzf(new Status(i), CaptureState.zzb(bundle)));
    }
}
