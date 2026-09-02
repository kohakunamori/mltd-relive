package com.google.firebase.iid;

import android.os.Build;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.RemoteException;
import android.util.Log;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public class zzd implements Parcelable {
    public static final Parcelable.Creator<zzd> CREATOR = new zzf();
    private Messenger zza;
    private zzn zzb;

    /* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
    public static final class zza extends ClassLoader {
        @Override // java.lang.ClassLoader
        protected final Class<?> loadClass(String str, boolean z) throws ClassNotFoundException {
            if (!"com.google.android.gms.iid.MessengerCompat".equals(str)) {
                return super.loadClass(str, z);
            }
            if (!FirebaseInstanceId.zzd()) {
                return zzd.class;
            }
            Log.d("FirebaseInstanceId", "Using renamed FirebaseIidMessengerCompat class");
            return zzd.class;
        }
    }

    public zzd(IBinder iBinder) {
        if (Build.VERSION.SDK_INT >= 21) {
            this.zza = new Messenger(iBinder);
        } else {
            this.zzb = new zzq(iBinder);
        }
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public final void zza(Message message) throws RemoteException {
        if (this.zza != null) {
            this.zza.send(message);
        } else {
            this.zzb.zza(message);
        }
    }

    private final IBinder zza() {
        return this.zza != null ? this.zza.getBinder() : this.zzb.asBinder();
    }

    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        try {
            return zza().equals(((zzd) obj).zza());
        } catch (ClassCastException unused) {
            return false;
        }
    }

    public int hashCode() {
        return zza().hashCode();
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        if (this.zza != null) {
            parcel.writeStrongBinder(this.zza.getBinder());
        } else {
            parcel.writeStrongBinder(this.zzb.asBinder());
        }
    }
}
