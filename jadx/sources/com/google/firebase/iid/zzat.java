package com.google.firebase.iid;

import android.os.Binder;
import android.os.Process;
import android.util.Log;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public final class zzat extends Binder {
    private final zzav zza;

    public zzat(zzav zzavVar) {
        this.zza = zzavVar;
    }

    final void zza(final zzax zzaxVar) {
        if (Binder.getCallingUid() != Process.myUid()) {
            throw new SecurityException("Binding only allowed within app");
        }
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            Log.d("FirebaseInstanceId", "service received new intent via bind strategy");
        }
        this.zza.zza(zzaxVar.zza).addOnCompleteListener(zzc.zza(), new OnCompleteListener(zzaxVar) { // from class: com.google.firebase.iid.zzaw
            private final zzax zza;

            {
                this.zza = zzaxVar;
            }

            @Override // com.google.android.gms.tasks.OnCompleteListener
            public final void onComplete(Task task) {
                this.zza.zza();
            }
        });
    }
}
