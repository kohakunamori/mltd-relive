package com.google.firebase.messaging;

import android.app.ActivityManager;
import android.app.KeyguardManager;
import android.app.NotificationManager;
import android.content.Context;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Process;
import android.os.SystemClock;
import android.util.Log;
import androidx.core.app.NotificationCompat;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.tasks.Tasks;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/* JADX INFO: compiled from: com.google.firebase:firebase-messaging@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzb {
    private final Executor zza;
    private final Context zzb;
    private final zza zzc;
    private final Bundle zzd;

    public zzb(Context context, Bundle bundle, Executor executor) {
        this.zza = executor;
        this.zzb = context;
        this.zzd = bundle;
        this.zzc = new zza(context, context.getPackageName());
    }

    /* JADX WARN: Code duplicated, block: B:20:0x005e A[EDGE_INSN: B:20:0x005e->B:21:0x005f BREAK  A[LOOP:0: B:13:0x0046->B:42:?]] */
    final boolean zza() {
        boolean z;
        if ("1".equals(zza.zza(this.zzd, "gcm.n.noui"))) {
            return true;
        }
        if (!((KeyguardManager) this.zzb.getSystemService("keyguard")).inKeyguardRestrictedInputMode()) {
            if (!PlatformVersion.isAtLeastLollipop()) {
                SystemClock.sleep(10L);
            }
            int iMyPid = Process.myPid();
            List<ActivityManager.RunningAppProcessInfo> runningAppProcesses = ((ActivityManager) this.zzb.getSystemService("activity")).getRunningAppProcesses();
            if (runningAppProcesses == null) {
                z = false;
                break;
            }
            Iterator<ActivityManager.RunningAppProcessInfo> it = runningAppProcesses.iterator();
            while (true) {
                if (it.hasNext()) {
                    ActivityManager.RunningAppProcessInfo next = it.next();
                    if (next.pid == iMyPid) {
                        if (next.importance == 100) {
                            z = true;
                            break;
                        }
                    }
                }
                z = false;
                break;
            }
        }
        z = false;
        break;
        if (z) {
            return false;
        }
        zzi zziVarZza = zzi.zza(zza.zza(this.zzd, "gcm.n.image"));
        if (zziVarZza != null) {
            zziVarZza.zza(this.zza);
        }
        zzc zzcVarZza = this.zzc.zza(this.zzd);
        NotificationCompat.Builder builder = zzcVarZza.zza;
        if (zziVarZza != null) {
            try {
                Bitmap bitmap = (Bitmap) Tasks.await(zziVarZza.zza(), 5L, TimeUnit.SECONDS);
                builder.setLargeIcon(bitmap);
                builder.setStyle(new NotificationCompat.BigPictureStyle().bigPicture(bitmap).bigLargeIcon(null));
            } catch (InterruptedException unused) {
                Log.w("FirebaseMessaging", "Interrupted while downloading image, showing notification without it");
                zziVarZza.close();
                Thread.currentThread().interrupt();
            } catch (ExecutionException unused2) {
            } catch (TimeoutException unused3) {
                Log.w("FirebaseMessaging", "Failed to download image in time, showing notification without it");
                zziVarZza.close();
            }
        }
        if (Log.isLoggable("FirebaseMessaging", 3)) {
            Log.d("FirebaseMessaging", "Showing notification");
        }
        ((NotificationManager) this.zzb.getSystemService("notification")).notify(zzcVarZza.zzb, 0, zzcVarZza.zza.build());
        return true;
    }
}
