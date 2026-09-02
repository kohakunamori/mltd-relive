package com.google.firebase.iid;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.VisibleForTesting;
import com.google.android.gms.common.util.concurrent.NamedThreadFactory;
import com.google.android.gms.tasks.Task;
import java.util.concurrent.ScheduledExecutorService;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public final class zzu {

    @GuardedBy("MessengerIpcClient.class")
    private static zzu zza;
    private final Context zzb;
    private final ScheduledExecutorService zzc;

    @GuardedBy("this")
    private zzv zzd = new zzv(this);

    @GuardedBy("this")
    private int zze = 1;

    public static synchronized zzu zza(Context context) {
        if (zza == null) {
            zza = new zzu(context, com.google.android.gms.internal.firebase_messaging.zza.zza().zza(1, new NamedThreadFactory("MessengerIpcClient"), com.google.android.gms.internal.firebase_messaging.zzf.zza));
        }
        return zza;
    }

    @VisibleForTesting
    private zzu(Context context, ScheduledExecutorService scheduledExecutorService) {
        this.zzc = scheduledExecutorService;
        this.zzb = context.getApplicationContext();
    }

    public final Task<Void> zza(int i, Bundle bundle) {
        return zza(new zzab(zza(), 2, bundle));
    }

    public final Task<Bundle> zzb(int i, Bundle bundle) {
        return zza(new zzag(zza(), 1, bundle));
    }

    private final synchronized <T> Task<T> zza(zzae<T> zzaeVar) {
        if (Log.isLoggable("MessengerIpcClient", 3)) {
            String strValueOf = String.valueOf(zzaeVar);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 9);
            sb.append("Queueing ");
            sb.append(strValueOf);
            Log.d("MessengerIpcClient", sb.toString());
        }
        if (!this.zzd.zza((zzae<?>) zzaeVar)) {
            this.zzd = new zzv(this);
            this.zzd.zza((zzae<?>) zzaeVar);
        }
        return zzaeVar.zzb.getTask();
    }

    private final synchronized int zza() {
        int i;
        i = this.zze;
        this.zze = i + 1;
        return i;
    }
}
