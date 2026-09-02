package com.google.android.gms.internal.p005authapi;

import android.os.Parcel;
import android.os.RemoteException;
import com.google.android.gms.auth.api.credentials.Credential;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzv extends zzd implements zzu {
    public zzv() {
        super("com.google.android.gms.auth.api.credentials.internal.ICredentialsCallbacks");
    }

    @Override // com.google.android.gms.internal.p005authapi.zzd
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) throws RemoteException {
        switch (i) {
            case 1:
                zzc((Status) zze.zzc(parcel, Status.CREATOR), (Credential) zze.zzc(parcel, Credential.CREATOR));
                break;
            case 2:
                zzc((Status) zze.zzc(parcel, Status.CREATOR));
                break;
            case 3:
                zzc((Status) zze.zzc(parcel, Status.CREATOR), parcel.readString());
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}
