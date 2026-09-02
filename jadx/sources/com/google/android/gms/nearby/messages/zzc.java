package com.google.android.gms.nearby.messages;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.internal.nearby.zzgp;
import com.google.android.gms.internal.nearby.zzgu;
import com.google.android.gms.nearby.messages.internal.zzad;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzc implements Parcelable.Creator<MessageFilter> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ MessageFilter createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        ArrayList arrayListCreateTypedList = null;
        ArrayList arrayListCreateTypedList2 = null;
        ArrayList arrayListCreateTypedList3 = null;
        int i = 0;
        boolean z = false;
        int i2 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId != 1000) {
                switch (fieldId) {
                    case 1:
                        arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, zzad.CREATOR);
                        break;
                    case 2:
                        arrayListCreateTypedList2 = SafeParcelReader.createTypedList(parcel, header, zzgu.CREATOR);
                        break;
                    case 3:
                        z = SafeParcelReader.readBoolean(parcel, header);
                        break;
                    case 4:
                        arrayListCreateTypedList3 = SafeParcelReader.createTypedList(parcel, header, zzgp.CREATOR);
                        break;
                    case 5:
                        i2 = SafeParcelReader.readInt(parcel, header);
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
        return new MessageFilter(i, arrayListCreateTypedList, arrayListCreateTypedList2, z, arrayListCreateTypedList3, i2);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ MessageFilter[] newArray(int i) {
        return new MessageFilter[i];
    }
}
