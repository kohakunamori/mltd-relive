package com.google.firebase.iid;

import android.content.Context;
import android.content.SharedPreferences;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import androidx.annotation.Nullable;
import androidx.annotation.WorkerThread;
import androidx.core.content.ContextCompat;
import com.adjust.sdk.Constants;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Properties;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzp {
    zzp() {
    }

    @WorkerThread
    final zzr zza(Context context, String str) throws Throwable {
        zzr zzrVarZzc = zzc(context, str);
        return zzrVarZzc != null ? zzrVarZzc : zzb(context, str);
    }

    @WorkerThread
    final zzr zzb(Context context, String str) throws Throwable {
        zzr zzrVar = new zzr(zzaf.zza(zza.zza().getPublic()), System.currentTimeMillis());
        zzr zzrVarZza = zza(context, str, zzrVar, true);
        if (zzrVarZza != null && !zzrVarZza.equals(zzrVar)) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                Log.d("FirebaseInstanceId", "Loaded key after generating new one, using loaded one");
            }
            return zzrVarZza;
        }
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            Log.d("FirebaseInstanceId", "Generated new key");
        }
        zza(context, str, zzrVar);
        return zzrVar;
    }

    static void zza(Context context) {
        for (File file : zzb(context).listFiles()) {
            if (file.getName().startsWith("com.google.InstanceId")) {
                file.delete();
            }
        }
    }

    @Nullable
    private final zzr zzc(Context context, String str) throws Throwable {
        try {
            zzr zzrVarZzd = zzd(context, str);
            if (zzrVarZzd != null) {
                zza(context, str, zzrVarZzd);
                return zzrVarZzd;
            }
            e = null;
        } catch (zzs e) {
            e = e;
        }
        try {
            zzr zzrVarZza = zza(context.getSharedPreferences("com.google.android.gms.appid", 0), str);
            if (zzrVarZza != null) {
                zza(context, str, zzrVarZza, false);
                return zzrVarZza;
            }
        } catch (zzs e2) {
            e = e2;
        }
        if (e == null) {
            return null;
        }
        throw e;
    }

    private static PublicKey zza(String str) throws zzs {
        try {
            try {
                return KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(Base64.decode(str, 8)));
            } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
                String strValueOf = String.valueOf(e);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 19);
                sb.append("Invalid key stored ");
                sb.append(strValueOf);
                Log.w("FirebaseInstanceId", sb.toString());
                throw new zzs(e);
            }
        } catch (IllegalArgumentException e2) {
            throw new zzs(e2);
        }
    }

    @Nullable
    private final zzr zzd(Context context, String str) throws zzs {
        File fileZze = zze(context, str);
        if (!fileZze.exists()) {
            return null;
        }
        try {
            return zza(fileZze);
        } catch (zzs | IOException e) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf = String.valueOf(e);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 39);
                sb.append("Failed to read ID from file, retrying: ");
                sb.append(strValueOf);
                Log.d("FirebaseInstanceId", sb.toString());
            }
            try {
                return zza(fileZze);
            } catch (IOException e2) {
                String strValueOf2 = String.valueOf(e2);
                StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf2).length() + 45);
                sb2.append("IID file exists, but failed to read from it: ");
                sb2.append(strValueOf2);
                Log.w("FirebaseInstanceId", sb2.toString());
                throw new zzs(e2);
            }
        }
    }

    /* JADX WARN: Code duplicated, block: B:34:0x00a8 A[Catch: all -> 0x00ac, Throwable -> 0x00af, TRY_ENTER, TryCatch #8 {Throwable -> 0x00af, all -> 0x00ac, blocks: (B:7:0x003a, B:15:0x0056, B:24:0x0096, B:34:0x00a8, B:35:0x00ab), top: B:54:0x003a }] */
    /* JADX WARN: Code duplicated, block: B:57:? A[Catch: all -> 0x00ac, Throwable -> 0x00af, SYNTHETIC, TRY_LEAVE, TryCatch #8 {Throwable -> 0x00af, all -> 0x00ac, blocks: (B:7:0x003a, B:15:0x0056, B:24:0x0096, B:34:0x00a8, B:35:0x00ab), top: B:54:0x003a }] */
    @Nullable
    private final zzr zza(Context context, String str, zzr zzrVar, boolean z) throws Throwable {
        Throwable th;
        Throwable th2;
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            Log.d("FirebaseInstanceId", "Writing ID to properties file");
        }
        Properties properties = new Properties();
        properties.setProperty("id", zzrVar.zza());
        properties.setProperty("cre", String.valueOf(zzrVar.zzb));
        File fileZze = zze(context, str);
        try {
            fileZze.createNewFile();
            RandomAccessFile randomAccessFile = new RandomAccessFile(fileZze, "rw");
            try {
                FileChannel channel = randomAccessFile.getChannel();
                try {
                    channel.lock();
                    if (z && channel.size() > 0) {
                        try {
                            channel.position(0L);
                            zzr zzrVarZza = zza(channel);
                            if (channel != null) {
                                zza((Throwable) null, channel);
                            }
                            zza((Throwable) null, randomAccessFile);
                            return zzrVarZza;
                        } catch (zzs | IOException e) {
                            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                                String strValueOf = String.valueOf(e);
                                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 58);
                                sb.append("Tried reading ID before writing new one, but failed with: ");
                                sb.append(strValueOf);
                                Log.d("FirebaseInstanceId", sb.toString());
                            }
                        }
                    }
                    channel.truncate(0L);
                    properties.store(Channels.newOutputStream(channel), (String) null);
                    if (channel != null) {
                        zza((Throwable) null, channel);
                    }
                    zza((Throwable) null, randomAccessFile);
                    return zzrVar;
                } catch (Throwable th3) {
                    th = th3;
                    th2 = null;
                    if (channel != null) {
                        throw th;
                    }
                    zza(th2, channel);
                    throw th;
                }
            } catch (Throwable th4) {
                th = th4;
                th = null;
                zza(th, randomAccessFile);
                throw th;
            }
        } catch (IOException e2) {
            String strValueOf2 = String.valueOf(e2);
            StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf2).length() + 21);
            sb2.append("Failed to write key: ");
            sb2.append(strValueOf2);
            Log.w("FirebaseInstanceId", sb2.toString());
            return null;
        }
    }

    private static File zzb(Context context) {
        File noBackupFilesDir = ContextCompat.getNoBackupFilesDir(context);
        if (noBackupFilesDir != null && noBackupFilesDir.isDirectory()) {
            return noBackupFilesDir;
        }
        Log.w("FirebaseInstanceId", "noBackupFilesDir doesn't exist, using regular files directory instead");
        return context.getFilesDir();
    }

    private static File zze(Context context, String str) {
        String string;
        if (TextUtils.isEmpty(str)) {
            string = "com.google.InstanceId.properties";
        } else {
            try {
                String strEncodeToString = Base64.encodeToString(str.getBytes(Constants.ENCODING), 11);
                StringBuilder sb = new StringBuilder(String.valueOf(strEncodeToString).length() + 33);
                sb.append("com.google.InstanceId_");
                sb.append(strEncodeToString);
                sb.append(".properties");
                string = sb.toString();
            } catch (UnsupportedEncodingException e) {
                throw new AssertionError(e);
            }
        }
        return new File(zzb(context), string);
    }

    /* JADX WARN: Code duplicated, block: B:17:0x002e A[Catch: all -> 0x0032, Throwable -> 0x0034, TRY_ENTER, TryCatch #3 {, blocks: (B:3:0x0006, B:7:0x001c, B:17:0x002e, B:18:0x0031), top: B:25:0x0006, outer: #0 }] */
    /* JADX WARN: Code duplicated, block: B:30:? A[Catch: all -> 0x0032, Throwable -> 0x0034, SYNTHETIC, TRY_LEAVE, TryCatch #3 {, blocks: (B:3:0x0006, B:7:0x001c, B:17:0x002e, B:18:0x0031), top: B:25:0x0006, outer: #0 }] */
    private final zzr zza(File file) throws IOException, zzs {
        Throwable th;
        Throwable th2;
        FileInputStream fileInputStream = new FileInputStream(file);
        try {
            FileChannel channel = fileInputStream.getChannel();
            try {
                channel.lock(0L, Long.MAX_VALUE, true);
                zzr zzrVarZza = zza(channel);
                if (channel != null) {
                    zza((Throwable) null, channel);
                }
                zza((Throwable) null, fileInputStream);
                return zzrVarZza;
            } catch (Throwable th3) {
                try {
                    throw th3;
                } catch (Throwable th4) {
                    th = th3;
                    th2 = th4;
                    if (channel != null) {
                        throw th2;
                    }
                    zza(th, channel);
                    throw th2;
                }
            }
        } catch (Throwable th5) {
            zza((Throwable) null, fileInputStream);
            throw th5;
        }
    }

    private static zzr zza(FileChannel fileChannel) throws IOException, zzs {
        Properties properties = new Properties();
        properties.load(Channels.newInputStream(fileChannel));
        try {
            long j = Long.parseLong(properties.getProperty("cre"));
            String property = properties.getProperty("id");
            if (property == null) {
                String property2 = properties.getProperty("pub");
                if (property2 == null) {
                    throw new zzs("Invalid properties file");
                }
                property = zzaf.zza(zza(property2));
            }
            return new zzr(property, j);
        } catch (NumberFormatException e) {
            throw new zzs(e);
        }
    }

    @Nullable
    private static zzr zza(SharedPreferences sharedPreferences, String str) throws zzs {
        long jZzb = zzb(sharedPreferences, str);
        String string = sharedPreferences.getString(zzaq.zza(str, "id"), null);
        if (string == null) {
            String string2 = sharedPreferences.getString(zzaq.zza(str, "|P|"), null);
            if (string2 == null) {
                return null;
            }
            string = zzaf.zza(zza(string2));
        }
        return new zzr(string, jZzb);
    }

    private final void zza(Context context, String str, zzr zzrVar) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("com.google.android.gms.appid", 0);
        try {
            if (zzrVar.equals(zza(sharedPreferences, str))) {
                return;
            }
        } catch (zzs unused) {
        }
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            Log.d("FirebaseInstanceId", "Writing key to shared preferences");
        }
        SharedPreferences.Editor editorEdit = sharedPreferences.edit();
        editorEdit.putString(zzaq.zza(str, "id"), zzrVar.zza());
        editorEdit.putString(zzaq.zza(str, "cre"), String.valueOf(zzrVar.zzb));
        editorEdit.commit();
    }

    private static long zzb(SharedPreferences sharedPreferences, String str) {
        String string = sharedPreferences.getString(zzaq.zza(str, "cre"), null);
        if (string == null) {
            return 0L;
        }
        try {
            return Long.parseLong(string);
        } catch (NumberFormatException unused) {
            return 0L;
        }
    }

    private static /* synthetic */ void zza(Throwable th, FileChannel fileChannel) {
        if (th == null) {
            fileChannel.close();
            return;
        }
        try {
            fileChannel.close();
        } catch (Throwable th2) {
            com.google.android.gms.internal.firebase_messaging.zzn.zza(th, th2);
        }
    }

    private static /* synthetic */ void zza(Throwable th, RandomAccessFile randomAccessFile) throws IOException {
        if (th == null) {
            randomAccessFile.close();
            return;
        }
        try {
            randomAccessFile.close();
        } catch (Throwable th2) {
            com.google.android.gms.internal.firebase_messaging.zzn.zza(th, th2);
        }
    }

    private static /* synthetic */ void zza(Throwable th, FileInputStream fileInputStream) throws IOException {
        if (th == null) {
            fileInputStream.close();
            return;
        }
        try {
            fileInputStream.close();
        } catch (Throwable th2) {
            com.google.android.gms.internal.firebase_messaging.zzn.zza(th, th2);
        }
    }
}
