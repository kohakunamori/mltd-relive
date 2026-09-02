package com.google.android.gms.auth.api.signin.internal;

import android.os.Parcel;
import android.os.RemoteException;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzt extends com.google.android.gms.internal.p005authapi.zzd implements zzs {
    public zzt() {
        super("com.google.android.gms.auth.api.signin.internal.ISignInCallbacks");
    }

    @Override // com.google.android.gms.internal.p005authapi.zzd
    protected final boolean dispatchTransaction(int i, Parcel parcel, Parcel parcel2, int i2) throws RemoteException {
        switch (i) {
            case Quests.SELECT_COMPLETED_UNCLAIMED /* 101 */:
                zzc((GoogleSignInAccount) com.google.android.gms.internal.p005authapi.zze.zzc(parcel, GoogleSignInAccount.CREATOR), (Status) com.google.android.gms.internal.p005authapi.zze.zzc(parcel, Status.CREATOR));
                break;
            case Quests.SELECT_ENDING_SOON /* 102 */:
                zze((Status) com.google.android.gms.internal.p005authapi.zze.zzc(parcel, Status.CREATOR));
                break;
            case Quests.SELECT_RECENTLY_FAILED /* 103 */:
                zzf((Status) com.google.android.gms.internal.p005authapi.zze.zzc(parcel, Status.CREATOR));
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}
