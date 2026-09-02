package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzgv implements Parcelable.Creator<zzgu> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzgu createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        int i = 0;
        byte[] bArrCreateByteArray = null;
        int i2 = 0;
        boolean z = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId != 1000) {
                switch (fieldId) {
                    case 1:
                        i2 = SafeParcelReader.readInt(parcel, header);
                        break;
                    case 2:
                        bArrCreateByteArray = SafeParcelReader.createByteArray(parcel, header);
                        break;
                    case 3:
                        z = SafeParcelReader.readBoolean(parcel, header);
                        break;
                    default:
                        SafeParcelReader.skipUnknownField(parcel, header);
                        break;
                }
            } else {
                i = SafeParcelReader.readInt(parcel, header);
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzgu(i, i2, bArrCreateByteArray, z);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzgu[] newArray(int i) {
        return new zzgu[i];
    }
}
