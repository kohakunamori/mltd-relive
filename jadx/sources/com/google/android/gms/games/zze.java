package com.google.android.gms.games;

import androidx.annotation.NonNull;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
final class zze implements com.google.android.gms.games.internal.zzbn {
    zze() {
    }

    @Override // com.google.android.gms.games.internal.zzbn
    public final boolean zza(@NonNull Status status) {
        return status.isSuccess() || status.getStatusCode() == 3003;
    }
}
