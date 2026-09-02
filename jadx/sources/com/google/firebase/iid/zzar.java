package com.google.firebase.iid;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;
import com.google.android.gms.common.util.VisibleForTesting;
import javax.annotation.Nullable;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
@VisibleForTesting
final class zzar extends BroadcastReceiver {

    @Nullable
    private zzas zza;

    public zzar(zzas zzasVar) {
        this.zza = zzasVar;
    }

    public final void zza() {
        if (FirebaseInstanceId.zzd()) {
            Log.d("FirebaseInstanceId", "Connectivity change received registered");
        }
        this.zza.zza().registerReceiver(this, new IntentFilter("android.net.conn.CONNECTIVITY_CHANGE"));
    }

    @Override // android.content.BroadcastReceiver
    public final void onReceive(Context context, Intent intent) {
        if (this.zza != null && this.zza.zzb()) {
            if (FirebaseInstanceId.zzd()) {
                Log.d("FirebaseInstanceId", "Connectivity changed. Starting background sync.");
            }
            FirebaseInstanceId.zza(this.zza, 0L);
            this.zza.zza().unregisterReceiver(this);
            this.zza = null;
        }
    }
}
