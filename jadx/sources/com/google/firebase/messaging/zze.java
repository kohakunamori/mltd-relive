package com.google.firebase.messaging;

import android.annotation.SuppressLint;
import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;
import androidx.annotation.CallSuper;
import androidx.annotation.MainThread;
import androidx.annotation.VisibleForTesting;
import androidx.legacy.content.WakefulBroadcastReceiver;
import com.google.android.gms.common.util.concurrent.NamedThreadFactory;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.iid.zzat;
import com.google.firebase.iid.zzav;
import java.util.concurrent.ExecutorService;

/* JADX INFO: compiled from: com.google.firebase:firebase-messaging@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"UnwrappedWakefulBroadcastReceiver"})
public abstract class zze extends Service {

    @VisibleForTesting
    private final ExecutorService zza;
    private Binder zzb;
    private final Object zzc;
    private int zzd;
    private int zze;

    public zze() {
        com.google.android.gms.internal.firebase_messaging.zzb zzbVarZza = com.google.android.gms.internal.firebase_messaging.zza.zza();
        String strValueOf = String.valueOf(getClass().getSimpleName());
        this.zza = zzbVarZza.zza(new NamedThreadFactory(strValueOf.length() != 0 ? "Firebase-".concat(strValueOf) : new String("Firebase-")), com.google.android.gms.internal.firebase_messaging.zzf.zza);
        this.zzc = new Object();
        this.zze = 0;
    }

    protected Intent zza(Intent intent) {
        return intent;
    }

    public boolean zzb(Intent intent) {
        return false;
    }

    public abstract void zzc(Intent intent);

    @Override // android.app.Service
    public final synchronized IBinder onBind(Intent intent) {
        if (Log.isLoggable("EnhancedIntentService", 3)) {
            Log.d("EnhancedIntentService", "Service received bind request");
        }
        if (this.zzb == null) {
            this.zzb = new zzat(new zzav(this) { // from class: com.google.firebase.messaging.zzd
                private final zze zza;

                {
                    this.zza = this;
                }

                @Override // com.google.firebase.iid.zzav
                public final Task zza(Intent intent2) {
                    return this.zza.zzd(intent2);
                }
            });
        }
        return this.zzb;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @MainThread
    /* JADX INFO: renamed from: zze, reason: merged with bridge method [inline-methods] */
    public final Task<Void> zzd(final Intent intent) {
        if (zzb(intent)) {
            return Tasks.forResult(null);
        }
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        this.zza.execute(new Runnable(this, intent, taskCompletionSource) { // from class: com.google.firebase.messaging.zzg
            private final zze zza;
            private final Intent zzb;
            private final TaskCompletionSource zzc;

            {
                this.zza = this;
                this.zzb = intent;
                this.zzc = taskCompletionSource;
            }

            @Override // java.lang.Runnable
            public final void run() {
                zze zzeVar = this.zza;
                Intent intent2 = this.zzb;
                TaskCompletionSource taskCompletionSource2 = this.zzc;
                try {
                    zzeVar.zzc(intent2);
                } finally {
                    taskCompletionSource2.setResult(null);
                }
            }
        });
        return taskCompletionSource.getTask();
    }

    @Override // android.app.Service
    public final int onStartCommand(final Intent intent, int i, int i2) {
        synchronized (this.zzc) {
            this.zzd = i2;
            this.zze++;
        }
        Intent intentZza = zza(intent);
        if (intentZza == null) {
            zzf(intent);
            return 2;
        }
        Task<Void> taskZzd = zzd(intentZza);
        if (taskZzd.isComplete()) {
            zzf(intent);
            return 2;
        }
        taskZzd.addOnCompleteListener(zzf.zza, new OnCompleteListener(this, intent) { // from class: com.google.firebase.messaging.zzh
            private final zze zza;
            private final Intent zzb;

            {
                this.zza = this;
                this.zzb = intent;
            }

            @Override // com.google.android.gms.tasks.OnCompleteListener
            public final void onComplete(Task task) {
                this.zza.zza(this.zzb, task);
            }
        });
        return 3;
    }

    @Override // android.app.Service
    @CallSuper
    public void onDestroy() {
        this.zza.shutdown();
        super.onDestroy();
    }

    private final void zzf(Intent intent) {
        if (intent != null) {
            WakefulBroadcastReceiver.completeWakefulIntent(intent);
        }
        synchronized (this.zzc) {
            this.zze--;
            if (this.zze == 0) {
                stopSelfResult(this.zzd);
            }
        }
    }

    final /* synthetic */ void zza(Intent intent, Task task) {
        zzf(intent);
    }
}
