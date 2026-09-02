package com.google.firebase.iid;

import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzr {
    private final String zza;
    private final long zzb;

    @VisibleForTesting
    zzr(String str, long j) {
        this.zza = (String) Preconditions.checkNotNull(str);
        this.zzb = j;
    }

    final String zza() {
        return this.zza;
    }

    final long zzb() {
        return this.zzb;
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zzr)) {
            return false;
        }
        zzr zzrVar = (zzr) obj;
        return this.zzb == zzrVar.zzb && this.zza.equals(zzrVar.zza);
    }

    public final int hashCode() {
        return Objects.hashCode(this.zza, Long.valueOf(this.zzb));
    }
}
