package com.google.firebase.messaging;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v4.media.session.PlaybackStateCompat;
import android.text.TextUtils;
import android.util.Log;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.internal.firebase_messaging.zzn;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.Callable;
import java.util.concurrent.Executor;

/* JADX INFO: compiled from: com.google.firebase:firebase-messaging@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzi implements Closeable {
    private final URL zza;

    @Nullable
    private Task<Bitmap> zzb;

    @Nullable
    private volatile InputStream zzc;

    @Nullable
    public static zzi zza(String str) {
        if (TextUtils.isEmpty(str)) {
            return null;
        }
        try {
            return new zzi(new URL(str));
        } catch (MalformedURLException unused) {
            String strValueOf = String.valueOf(str);
            Log.w("FirebaseMessaging", strValueOf.length() != 0 ? "Not downloading image, bad URL: ".concat(strValueOf) : new String("Not downloading image, bad URL: "));
            return null;
        }
    }

    private zzi(URL url) {
        this.zza = url;
    }

    public final void zza(Executor executor) {
        this.zzb = Tasks.call(executor, new Callable(this) { // from class: com.google.firebase.messaging.zzj
            private final zzi zza;

            {
                this.zza = this;
            }

            @Override // java.util.concurrent.Callable
            public final Object call() {
                return this.zza.zzb();
            }
        });
    }

    public final Task<Bitmap> zza() {
        return (Task) Preconditions.checkNotNull(this.zzb);
    }

    public final Bitmap zzb() throws IOException {
        Throwable th;
        Throwable th2;
        String strValueOf = String.valueOf(this.zza);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 22);
        sb.append("Starting download of: ");
        sb.append(strValueOf);
        Log.i("FirebaseMessaging", sb.toString());
        try {
            InputStream inputStream = this.zza.openConnection().getInputStream();
            try {
                InputStream inputStreamZza = com.google.android.gms.internal.firebase_messaging.zzj.zza(inputStream, PlaybackStateCompat.ACTION_SET_CAPTIONING_ENABLED);
                try {
                    this.zzc = inputStream;
                    Bitmap bitmapDecodeStream = BitmapFactory.decodeStream(inputStreamZza);
                    if (bitmapDecodeStream == null) {
                        String strValueOf2 = String.valueOf(this.zza);
                        StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf2).length() + 24);
                        sb2.append("Failed to decode image: ");
                        sb2.append(strValueOf2);
                        String string = sb2.toString();
                        Log.w("FirebaseMessaging", string);
                        throw new IOException(string);
                    }
                    if (Log.isLoggable("FirebaseMessaging", 3)) {
                        String strValueOf3 = String.valueOf(this.zza);
                        StringBuilder sb3 = new StringBuilder(String.valueOf(strValueOf3).length() + 31);
                        sb3.append("Successfully downloaded image: ");
                        sb3.append(strValueOf3);
                        Log.d("FirebaseMessaging", sb3.toString());
                    }
                    zza(null, inputStreamZza);
                    if (inputStream != null) {
                        zza(null, inputStream);
                    }
                    return bitmapDecodeStream;
                } catch (Throwable th3) {
                    try {
                        throw th3;
                    } catch (Throwable th4) {
                        th = th3;
                        th2 = th4;
                        zza(th, inputStreamZza);
                        throw th2;
                    }
                }
            } catch (Throwable th5) {
                if (inputStream != null) {
                    zza(null, inputStream);
                }
                throw th5;
            }
        } catch (IOException e) {
            String strValueOf4 = String.valueOf(this.zza);
            StringBuilder sb4 = new StringBuilder(String.valueOf(strValueOf4).length() + 26);
            sb4.append("Failed to download image: ");
            sb4.append(strValueOf4);
            Log.w("FirebaseMessaging", sb4.toString());
            throw e;
        }
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public final void close() {
        com.google.android.gms.internal.firebase_messaging.zzk.zza(this.zzc);
    }

    private static /* synthetic */ void zza(Throwable th, InputStream inputStream) throws IOException {
        if (th == null) {
            inputStream.close();
            return;
        }
        try {
            inputStream.close();
        } catch (Throwable th2) {
            zzn.zza(th, th2);
        }
    }
}
