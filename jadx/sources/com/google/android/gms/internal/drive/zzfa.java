package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.DriveId;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzfa implements Parcelable.Creator<zzez> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzez createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        DataHolder dataHolder = null;
        ArrayList arrayListCreateTypedList = null;
        com.google.android.gms.drive.zza zzaVar = null;
        boolean z = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    dataHolder = (DataHolder) SafeParcelReader.createParcelable(parcel, header, DataHolder.CREATOR);
                    break;
                case 3:
                    arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, DriveId.CREATOR);
                    break;
                case 4:
                    zzaVar = (com.google.android.gms.drive.zza) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.zza.CREATOR);
                    break;
                case 5:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzez(dataHolder, arrayListCreateTypedList, zzaVar, z);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzez[] newArray(int i) {
        return new zzez[i];
    }
}
