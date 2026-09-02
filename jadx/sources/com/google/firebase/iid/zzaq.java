package com.google.firebase.iid;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;
import androidx.annotation.GuardedBy;
import androidx.collection.ArrayMap;
import androidx.core.content.ContextCompat;
import java.io.File;
import java.io.IOException;
import java.util.Map;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzaq {
    private final SharedPreferences zza;
    private final Context zzb;
    private final zzp zzc;

    @GuardedBy("this")
    private final Map<String, zzr> zzd;

    public zzaq(Context context) {
        this(context, new zzp());
    }

    private zzaq(Context context, zzp zzpVar) {
        this.zzd = new ArrayMap();
        this.zzb = context;
        this.zza = context.getSharedPreferences("com.google.android.gms.appid", 0);
        this.zzc = zzpVar;
        File file = new File(ContextCompat.getNoBackupFilesDir(this.zzb), "com.google.android.gms.appid-no-backup");
        if (file.exists()) {
            return;
        }
        try {
            if (!file.createNewFile() || zzc()) {
                return;
            }
            Log.i("FirebaseInstanceId", "App restored, clearing state");
            zzb();
            FirebaseInstanceId.getInstance().zze();
        } catch (IOException e) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.d("FirebaseInstanceId", strValueOf.length() != 0 ? "Error creating file in no backup dir: ".concat(strValueOf) : new String("Error creating file in no backup dir: "));
            }
        }
    }

    public final synchronized String zza() {
        return this.zza.getString("topic_operation_queue", "");
    }

    public final synchronized void zza(String str) {
        this.zza.edit().putString("topic_operation_queue", str).apply();
    }

    private final synchronized boolean zzc() {
        return this.zza.getAll().isEmpty();
    }

    private static String zzc(String str, String str2, String str3) {
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 4 + String.valueOf(str2).length() + String.valueOf(str3).length());
        sb.append(str);
        sb.append("|T|");
        sb.append(str2);
        sb.append("|");
        sb.append(str3);
        return sb.toString();
    }

    static String zza(String str, String str2) {
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 3 + String.valueOf(str2).length());
        sb.append(str);
        sb.append("|S|");
        sb.append(str2);
        return sb.toString();
    }

    public final synchronized void zzb() {
        this.zzd.clear();
        zzp.zza(this.zzb);
        this.zza.edit().clear().commit();
    }

    public final synchronized zzap zza(String str, String str2, String str3) {
        return zzap.zza(this.zza.getString(zzc(str, str2, str3), null));
    }

    public final synchronized void zza(String str, String str2, String str3, String str4, String str5) {
        String strZza = zzap.zza(str4, str5, System.currentTimeMillis());
        if (strZza == null) {
            return;
        }
        SharedPreferences.Editor editorEdit = this.zza.edit();
        editorEdit.putString(zzc(str, str2, str3), strZza);
        editorEdit.commit();
    }

    public final synchronized void zzb(String str, String str2, String str3) {
        String strZzc = zzc(str, str2, str3);
        SharedPreferences.Editor editorEdit = this.zza.edit();
        editorEdit.remove(strZzc);
        editorEdit.commit();
    }

    public final synchronized zzr zzb(String str) {
        zzr zzrVarZzb;
        zzr zzrVar = this.zzd.get(str);
        if (zzrVar != null) {
            return zzrVar;
        }
        try {
            zzrVarZzb = this.zzc.zza(this.zzb, str);
        } catch (zzs unused) {
            Log.w("FirebaseInstanceId", "Stored data is corrupt, generating new identity");
            FirebaseInstanceId.getInstance().zze();
            zzrVarZzb = this.zzc.zzb(this.zzb, str);
        }
        this.zzd.put(str, zzrVarZzb);
        return zzrVarZzb;
    }

    public final synchronized void zzc(String str) {
        String strConcat = String.valueOf(str).concat("|T|");
        SharedPreferences.Editor editorEdit = this.zza.edit();
        for (String str2 : this.zza.getAll().keySet()) {
            if (str2.startsWith(strConcat)) {
                editorEdit.remove(str2);
            }
        }
        editorEdit.commit();
    }
}
