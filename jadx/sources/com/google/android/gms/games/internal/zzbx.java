package com.google.android.gms.games.internal;

import android.os.Bundle;
import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzbx implements Parcelable.Creator<zzbw> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzbw[] newArray(int i) {
        return new zzbw[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzbw createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        Bundle bundleCreateBundle = null;
        IBinder iBinder = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                    break;
                case 2:
                    iBinder = SafeParcelReader.readIBinder(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzbw(bundleCreateBundle, iBinder);
    }
}
