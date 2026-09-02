package com.google.android.gms.auth.api.signin.internal;

import android.os.IBinder;
import android.os.Parcel;
import android.os.RemoteException;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.games.quest.Quests;

/* JADX INFO: loaded from: classes.dex */
public final class zzv extends com.google.android.gms.internal.p005authapi.zzc implements zzu {
    zzv(IBinder iBinder) {
        super(iBinder, "com.google.android.gms.auth.api.signin.internal.ISignInService");
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzu
    public final void zzc(zzs zzsVar, GoogleSignInOptions googleSignInOptions) throws RemoteException {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.p005authapi.zze.zzc(parcelObtainAndWriteInterfaceToken, zzsVar);
        com.google.android.gms.internal.p005authapi.zze.zzc(parcelObtainAndWriteInterfaceToken, googleSignInOptions);
        transactAndReadExceptionReturnVoid(Quests.SELECT_COMPLETED_UNCLAIMED, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzu
    public final void zzd(zzs zzsVar, GoogleSignInOptions googleSignInOptions) throws RemoteException {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.p005authapi.zze.zzc(parcelObtainAndWriteInterfaceToken, zzsVar);
        com.google.android.gms.internal.p005authapi.zze.zzc(parcelObtainAndWriteInterfaceToken, googleSignInOptions);
        transactAndReadExceptionReturnVoid(Quests.SELECT_ENDING_SOON, parcelObtainAndWriteInterfaceToken);
    }

    @Override // com.google.android.gms.auth.api.signin.internal.zzu
    public final void zze(zzs zzsVar, GoogleSignInOptions googleSignInOptions) throws RemoteException {
        Parcel parcelObtainAndWriteInterfaceToken = obtainAndWriteInterfaceToken();
        com.google.android.gms.internal.p005authapi.zze.zzc(parcelObtainAndWriteInterfaceToken, zzsVar);
        com.google.android.gms.internal.p005authapi.zze.zzc(parcelObtainAndWriteInterfaceToken, googleSignInOptions);
        transactAndReadExceptionReturnVoid(Quests.SELECT_RECENTLY_FAILED, parcelObtainAndWriteInterfaceToken);
    }
}
