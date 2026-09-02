package com.google.firebase.iid;

import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.util.Log;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzac {
    private final Messenger zza;
    private final zzd zzb;

    zzac(IBinder iBinder) throws RemoteException {
        String interfaceDescriptor = iBinder.getInterfaceDescriptor();
        if ("android.os.IMessenger".equals(interfaceDescriptor)) {
            this.zza = new Messenger(iBinder);
            this.zzb = null;
        } else if ("com.google.android.gms.iid.IMessengerCompat".equals(interfaceDescriptor)) {
            this.zzb = new zzd(iBinder);
            this.zza = null;
        } else {
            String strValueOf = String.valueOf(interfaceDescriptor);
            Log.w("MessengerIpcClient", strValueOf.length() != 0 ? "Invalid interface descriptor: ".concat(strValueOf) : new String("Invalid interface descriptor: "));
            throw new RemoteException();
        }
    }

    final void zza(Message message) throws RemoteException {
        if (this.zza != null) {
            this.zza.send(message);
        } else {
            if (this.zzb != null) {
                this.zzb.zza(message);
                return;
            }
            throw new IllegalStateException("Both messengers are null");
        }
    }
}
