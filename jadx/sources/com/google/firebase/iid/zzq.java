package com.google.firebase.iid;

import android.os.IBinder;
import android.os.Message;
import android.os.Parcel;
import android.os.RemoteException;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public final class zzq implements zzn {
    private final IBinder zza;

    zzq(IBinder iBinder) {
        this.zza = iBinder;
    }

    @Override // com.google.firebase.iid.zzn
    public final void zza(Message message) throws RemoteException {
        Parcel parcelObtain = Parcel.obtain();
        parcelObtain.writeInterfaceToken("com.google.android.gms.iid.IMessengerCompat");
        parcelObtain.writeInt(1);
        message.writeToParcel(parcelObtain, 0);
        try {
            this.zza.transact(1, parcelObtain, null, 1);
        } finally {
            parcelObtain.recycle();
        }
    }

    @Override // android.os.IInterface
    public final IBinder asBinder() {
        return this.zza;
    }
}
