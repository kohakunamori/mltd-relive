package com.google.firebase.iid;

import android.os.Bundle;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzab extends zzae<Void> {
    zzab(int i, int i2, Bundle bundle) {
        super(i, 2, bundle);
    }

    @Override // com.google.firebase.iid.zzae
    final boolean zza() {
        return true;
    }

    @Override // com.google.firebase.iid.zzae
    final void zza(Bundle bundle) {
        if (bundle.getBoolean("ack", false)) {
            zza((Object) null);
        } else {
            zza(new zzad(4, "Invalid response to one way request"));
        }
    }
}
