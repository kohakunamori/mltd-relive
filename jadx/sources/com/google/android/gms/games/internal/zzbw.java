package com.google.android.gms.games.internal;

import android.os.Bundle;
import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "PopupLocationInfoParcelableCreator")
@SafeParcelable.Reserved({1000})
public final class zzbw extends zzd {
    public static final Parcelable.Creator<zzbw> CREATOR = new zzbx();

    @SafeParcelable.Field(getter = "getInfoBundle", m22id = 1)
    private final Bundle zzjt;

    @SafeParcelable.Field(getter = "getWindowToken", m22id = 2)
    private final IBinder zzju;

    public zzbw(zzca zzcaVar) {
        this.zzjt = zzcaVar.zzcs();
        this.zzju = zzcaVar.zzju;
    }

    @SafeParcelable.Constructor
    zzbw(@SafeParcelable.Param(m23id = 1) Bundle bundle, @SafeParcelable.Param(m23id = 2) IBinder iBinder) {
        this.zzjt = bundle;
        this.zzju = iBinder;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeBundle(parcel, 1, this.zzjt, false);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzju, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
