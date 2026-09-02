package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.DriveId;

/* JADX INFO: loaded from: classes.dex */
public final class zzk implements Parcelable.Creator<zzj> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzj createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        DriveId driveId = null;
        com.google.android.gms.drive.events.zze zzeVar = null;
        com.google.android.gms.drive.events.zzx zzxVar = null;
        com.google.android.gms.drive.events.zzt zztVar = null;
        int i = 0;
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
                    zzeVar = (com.google.android.gms.drive.events.zze) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zze.CREATOR);
                    break;
                case 5:
                    zzxVar = (com.google.android.gms.drive.events.zzx) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzx.CREATOR);
                    break;
                case 6:
                    zztVar = (com.google.android.gms.drive.events.zzt) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzt.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzj(driveId, i, zzeVar, zzxVar, zztVar);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzj[] newArray(int i) {
        return new zzj[i];
    }
}
