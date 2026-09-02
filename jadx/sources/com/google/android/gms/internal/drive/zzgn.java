package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.DriveId;

/* JADX INFO: loaded from: classes.dex */
public final class zzgn implements Parcelable.Creator<zzgm> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzgm createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        DriveId driveId = null;
        int i = 0;
        com.google.android.gms.drive.events.zzt zztVar = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    driveId = (DriveId) SafeParcelReader.createParcelable(parcel, header, DriveId.CREATOR);
                    break;
                case 3:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 4:
                    zztVar = (com.google.android.gms.drive.events.zzt) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzt.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzgm(driveId, i, zztVar);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzgm[] newArray(int i) {
        return new zzgm[i];
    }
}
