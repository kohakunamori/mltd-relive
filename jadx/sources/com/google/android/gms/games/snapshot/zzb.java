package com.google.android.gms.games.snapshot;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzb implements Parcelable.Creator<SnapshotEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SnapshotEntity[] newArray(int i) {
        return new SnapshotEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ SnapshotEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        SnapshotMetadataEntity snapshotMetadataEntity = null;
        SnapshotContentsEntity snapshotContentsEntity = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId == 1) {
                snapshotMetadataEntity = (SnapshotMetadataEntity) SafeParcelReader.createParcelable(parcel, header, SnapshotMetadataEntity.CREATOR);
            } else if (fieldId == 3) {
                snapshotContentsEntity = (SnapshotContentsEntity) SafeParcelReader.createParcelable(parcel, header, SnapshotContentsEntity.CREATOR);
            } else {
                SafeParcelReader.skipUnknownField(parcel, header);
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new SnapshotEntity(snapshotMetadataEntity, snapshotContentsEntity);
    }
}
