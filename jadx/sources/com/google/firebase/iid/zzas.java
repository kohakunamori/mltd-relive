package com.google.firebase.iid;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.PowerManager;
import android.util.Log;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseApp;
import java.io.IOException;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzas implements Runnable {
    private final long zza;
    private final PowerManager.WakeLock zzb = ((PowerManager) zza().getSystemService("power")).newWakeLock(1, "fiid-sync");
    private final FirebaseInstanceId zzc;
    private final zzau zzd;

    @VisibleForTesting
    zzas(FirebaseInstanceId firebaseInstanceId, zzaf zzafVar, zzau zzauVar, long j) {
        this.zzc = firebaseInstanceId;
        this.zzd = zzauVar;
        this.zza = j;
        this.zzb.setReferenceCounted(false);
    }

    @Override // java.lang.Runnable
    @SuppressLint({"Wakelock"})
    public final void run() {
        boolean zZza;
        if (zzan.zza().zza(zza())) {
            this.zzb.acquire();
        }
        try {
            this.zzc.zza(true);
            if (!this.zzc.zzf()) {
                this.zzc.zza(false);
            } else {
                if (zzan.zza().zzb(zza()) && !zzb()) {
                    new zzar(this).zza();
                    if (zZza) {
                        return;
                    } else {
                        return;
                    }
                }
                if (zzc() && this.zzd.zza(this.zzc)) {
                    this.zzc.zza(false);
                } else {
                    this.zzc.zza(this.zza);
                }
            }
        } catch (IOException e) {
            String message = e.getMessage();
            StringBuilder sb = new StringBuilder(String.valueOf(message).length() + 93);
            sb.append("Topic sync or token retrieval failed on hard failure exceptions: ");
            sb.append(message);
            sb.append(". Won't retry the operation.");
            Log.e("FirebaseInstanceId", sb.toString());
            this.zzc.zza(false);
        } finally {
            if (zzan.zza().zza(zza())) {
                this.zzb.release();
            }
        }
    }

    @VisibleForTesting
    private final boolean zzc() throws IOException {
        zzap zzapVarZzb = this.zzc.zzb();
        if (!this.zzc.zza(zzapVarZzb)) {
            return true;
        }
        try {
            String strZzc = this.zzc.zzc();
            if (strZzc == null) {
                Log.e("FirebaseInstanceId", "Token retrieval failed: null");
                return false;
            }
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                Log.d("FirebaseInstanceId", "Token successfully retrieved");
            }
            if ((zzapVarZzb == null || (zzapVarZzb != null && !strZzc.equals(zzapVarZzb.zza))) && FirebaseApp.DEFAULT_APP_NAME.equals(this.zzc.zza().getName())) {
                if (Log.isLoggable("FirebaseInstanceId", 3)) {
                    String strValueOf = String.valueOf(this.zzc.zza().getName());
                    Log.d("FirebaseInstanceId", strValueOf.length() != 0 ? "Invoking onNewToken for app: ".concat(strValueOf) : new String("Invoking onNewToken for app: "));
                }
                Intent intent = new Intent("com.google.firebase.messaging.NEW_TOKEN");
                intent.putExtra("token", strZzc);
                Context contextZza = zza();
                Intent intent2 = new Intent(contextZza, (Class<?>) FirebaseInstanceIdReceiver.class);
                intent2.setAction("com.google.firebase.MESSAGING_EVENT");
                intent2.putExtra("wrapped_intent", intent);
                contextZza.sendBroadcast(intent2);
            }
            return true;
        } catch (IOException e) {
            if ("SERVICE_NOT_AVAILABLE".equals(e.getMessage()) || "INTERNAL_SERVER_ERROR".equals(e.getMessage())) {
                Log.e("FirebaseInstanceId", "Token retrieval failed without exception message. Will retry token retrieval");
                return false;
            }
            if (e.getMessage() == null) {
                String message = e.getMessage();
                StringBuilder sb = new StringBuilder(String.valueOf(message).length() + 52);
                sb.append("Token retrieval failed: ");
                sb.append(message);
                sb.append(". Will retry token retrieval");
                Log.e("FirebaseInstanceId", sb.toString());
                return false;
            }
            throw e;
        } catch (SecurityException unused) {
            Log.e("FirebaseInstanceId", "Token retrieval failed with SecurityException. Will retry token retrieval");
            return false;
        }
    }

    final Context zza() {
        return this.zzc.zza().getApplicationContext();
    }

    final boolean zzb() {
        ConnectivityManager connectivityManager = (ConnectivityManager) zza().getSystemService("connectivity");
        NetworkInfo activeNetworkInfo = connectivityManager != null ? connectivityManager.getActiveNetworkInfo() : null;
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }
}
