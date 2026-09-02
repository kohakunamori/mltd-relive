package com.google.android.gms.nearby.messages;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.internal.nearby.zzgs;

/* JADX INFO: loaded from: classes.dex */
public final class zza implements Parcelable.Creator<Message> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ Message createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        byte[] bArrCreateByteArray = null;
        String strCreateString = null;
        String strCreateString2 = null;
        zzgs[] zzgsVarArr = null;
        long j = 0;
        int i = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId != 1000) {
                switch (fieldId) {
                    case 1:
                        bArrCreateByteArray = SafeParcelReader.createByteArray(parcel, header);
                        break;
                    case 2:
                        strCreateString2 = SafeParcelReader.createString(parcel, header);
                        break;
                    case 3:
                        strCreateString = SafeParcelReader.createString(parcel, header);
                        break;
                    case 4:
                        zzgsVarArr = (zzgs[]) SafeParcelReader.createTypedArray(parcel, header, zzgs.CREATOR);
                        break;
                    case 5:
                        j = SafeParcelReader.readLong(parcel, header);
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
        return new Message(i, bArrCreateByteArray, strCreateString, strCreateString2, zzgsVarArr, j);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ Message[] newArray(int i) {
        return new Message[i];
    }
}
