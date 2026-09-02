package com.google.android.gms.internal.nearby;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.nearby.connection.PayloadTransferUpdate;

/* JADX INFO: loaded from: classes.dex */
public final class zzey implements Parcelable.Creator<zzex> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzex createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        PayloadTransferUpdate payloadTransferUpdate = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 2:
                    payloadTransferUpdate = (PayloadTransferUpdate) SafeParcelReader.createParcelable(parcel, header, PayloadTransferUpdate.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzex(strCreateString, payloadTransferUpdate);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzex[] newArray(int i) {
        return new zzex[i];
    }
}
