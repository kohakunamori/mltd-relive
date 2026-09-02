package com.google.firebase.iid;

import android.content.BroadcastReceiver;
import android.content.Intent;
import android.util.Log;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzax {
    final Intent zza;
    private final BroadcastReceiver.PendingResult zzb;
    private boolean zzc = false;
    private final ScheduledFuture<?> zzd;

    zzax(final Intent intent, BroadcastReceiver.PendingResult pendingResult, ScheduledExecutorService scheduledExecutorService) {
        this.zza = intent;
        this.zzb = pendingResult;
        this.zzd = scheduledExecutorService.schedule(new Runnable(this, intent) { // from class: com.google.firebase.iid.zzaz
            private final zzax zza;
            private final Intent zzb;

            {
                this.zza = this;
                this.zzb = intent;
            }

            @Override // java.lang.Runnable
            public final void run() {
                zzax zzaxVar = this.zza;
                String action = this.zzb.getAction();
                StringBuilder sb = new StringBuilder(String.valueOf(action).length() + 61);
                sb.append("Service took too long to process intent: ");
                sb.append(action);
                sb.append(" App may get closed.");
                Log.w("FirebaseInstanceId", sb.toString());
                zzaxVar.zza();
            }
        }, 9000L, TimeUnit.MILLISECONDS);
    }

    final synchronized void zza() {
        if (!this.zzc) {
            this.zzb.finish();
            this.zzd.cancel(false);
            this.zzc = true;
        }
    }
}
