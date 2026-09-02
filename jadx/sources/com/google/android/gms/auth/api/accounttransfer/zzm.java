package com.google.android.gms.auth.api.accounttransfer;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import java.util.ArrayList;
import java.util.HashSet;

/* JADX INFO: loaded from: classes.dex */
public final class zzm implements Parcelable.Creator<zzl> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzl[] newArray(int i) {
        return new zzl[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzl createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        HashSet hashSet = new HashSet();
        int i = 0;
        ArrayList arrayListCreateTypedList = null;
        zzo zzoVar = null;
        int i2 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    i = SafeParcelReader.readInt(parcel, header);
                    hashSet.add(1);
                    break;
                case 2:
                    arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, zzr.CREATOR);
                    hashSet.add(2);
                    break;
                case 3:
                    i2 = SafeParcelReader.readInt(parcel, header);
                    hashSet.add(3);
                    break;
                case 4:
                    zzoVar = (zzo) SafeParcelReader.createParcelable(parcel, header, zzo.CREATOR);
                    hashSet.add(4);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        if (parcel.dataPosition() != iValidateObjectHeader) {
            StringBuilder sb = new StringBuilder(37);
            sb.append("Overread allowed size end=");
            sb.append(iValidateObjectHeader);
            throw new SafeParcelReader.ParseException(sb.toString(), parcel);
        }
        return new zzl(hashSet, i, arrayListCreateTypedList, i2, zzoVar);
    }
}
