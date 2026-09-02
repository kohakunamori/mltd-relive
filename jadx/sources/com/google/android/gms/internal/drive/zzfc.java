package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.Contents;

/* JADX INFO: loaded from: classes.dex */
public final class zzfc implements Parcelable.Creator<zzfb> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzfb createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        Contents contents = null;
        boolean z = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    contents = (Contents) SafeParcelReader.createParcelable(parcel, header, Contents.CREATOR);
                    break;
                case 3:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzfb(contents, z);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzfb[] newArray(int i) {
        return new zzfb[i];
    }
}
