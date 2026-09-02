package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzew implements Parcelable.Creator<zzev> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzev createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        zzfh zzfhVar = null;
        boolean z = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 2:
                    zzfhVar = (zzfh) SafeParcelReader.createParcelable(parcel, header, zzfh.CREATOR);
                    break;
                case 3:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzev(strCreateString, zzfhVar, z);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzev[] newArray(int i) {
        return new zzev[i];
    }
}
