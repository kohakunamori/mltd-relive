package com.google.android.gms.drive.query;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.query.internal.zzf;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzc implements Parcelable.Creator<SortOrder> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SortOrder createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        ArrayList arrayListCreateTypedList = null;
        boolean z = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, zzf.CREATOR);
                    break;
                case 2:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new SortOrder(arrayListCreateTypedList, z);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SortOrder[] newArray(int i) {
        return new SortOrder[i];
    }
}
