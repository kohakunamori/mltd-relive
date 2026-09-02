package com.google.firebase.iid;

import android.os.Bundle;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzag extends zzae<Bundle> {
    zzag(int i, int i2, Bundle bundle) {
        super(i, 1, bundle);
    }

    @Override // com.google.firebase.iid.zzae
    final boolean zza() {
        return false;
    }

    @Override // com.google.firebase.iid.zzae
    final void zza(Bundle bundle) {
        Bundle bundle2 = bundle.getBundle("data");
        if (bundle2 == null) {
            bundle2 = Bundle.EMPTY;
        }
        zza(bundle2);
    }
}
