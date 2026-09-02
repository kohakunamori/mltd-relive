package com.google.android.gms.games.snapshot;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.Contents;

/* JADX INFO: loaded from: classes.dex */
public final class zza implements Parcelable.Creator<SnapshotContentsEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SnapshotContentsEntity[] newArray(int i) {
        return new SnapshotContentsEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SnapshotContentsEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        Contents contents = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            if (SafeParcelReader.getFieldId(header) == 1) {
                contents = (Contents) SafeParcelReader.createParcelable(parcel, header, Contents.CREATOR);
            } else {
                SafeParcelReader.skipUnknownField(parcel, header);
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new SnapshotContentsEntity(contents);
    }
}
