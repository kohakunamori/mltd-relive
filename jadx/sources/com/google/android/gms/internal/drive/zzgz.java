package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.DriveId;
import com.google.android.gms.drive.metadata.internal.MetadataBundle;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "UpdateMetadataRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzgz extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgz> CREATOR = new zzha();

    @SafeParcelable.Field(m22id = 2)
    private final DriveId zzdb;

    @SafeParcelable.Field(m22id = 3)
    private final MetadataBundle zzdc;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzgz(@SafeParcelable.Param(m23id = 2) DriveId driveId, @SafeParcelable.Param(m23id = 3) MetadataBundle metadataBundle) {
        this.zzdb = driveId;
        this.zzdc = metadataBundle;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzdb, i, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzdc, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
