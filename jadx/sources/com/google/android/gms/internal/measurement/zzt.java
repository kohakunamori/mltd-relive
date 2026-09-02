package com.google.android.gms.internal.measurement;

import android.os.Bundle;
import android.os.Parcel;
import android.os.RemoteException;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzt extends zza implements zzq {
    public zzt() {
        super("com.google.android.gms.measurement.api.internal.IEventHandlerProxy");
    }

    @Override // com.google.android.gms.internal.measurement.zza
    protected final boolean zza(int i, Parcel parcel, Parcel parcel2, int i2) throws RemoteException {
        switch (i) {
            case 1:
                onEvent(parcel.readString(), parcel.readString(), (Bundle) zzd.zza(parcel, Bundle.CREATOR), parcel.readLong());
                parcel2.writeNoException();
                return true;
            case 2:
                int iId = mo42id();
                parcel2.writeNoException();
                parcel2.writeInt(iId);
                return true;
            default:
                return false;
        }
    }
}
