package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.DriveId;
import com.google.android.gms.drive.query.internal.FilterHolder;

/* JADX INFO: loaded from: classes.dex */
public final class zzgh implements Parcelable.Creator<zzgg> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzgg createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        String[] strArrCreateStringArray = null;
        DriveId driveId = null;
        FilterHolder filterHolder = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    strArrCreateStringArray = SafeParcelReader.createStringArray(parcel, header);
                    break;
                case 4:
                    driveId = (DriveId) SafeParcelReader.createParcelable(parcel, header, DriveId.CREATOR);
                    break;
                case 5:
                    filterHolder = (FilterHolder) SafeParcelReader.createParcelable(parcel, header, FilterHolder.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzgg(strCreateString, strArrCreateStringArray, driveId, filterHolder);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzgg[] newArray(int i) {
        return new zzgg[i];
    }
}
