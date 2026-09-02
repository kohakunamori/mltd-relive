package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.DriveId;
import com.google.android.gms.drive.metadata.internal.MetadataBundle;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "CreateFolderRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzy extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzy> CREATOR = new zzz();

    @SafeParcelable.Field(m22id = 3)
    private final MetadataBundle zzdl;

    @SafeParcelable.Field(m22id = 2)
    private final DriveId zzdn;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzy(@SafeParcelable.Param(m23id = 2) DriveId driveId, @SafeParcelable.Param(m23id = 3) MetadataBundle metadataBundle) {
        this.zzdn = (DriveId) Preconditions.checkNotNull(driveId);
        this.zzdl = (MetadataBundle) Preconditions.checkNotNull(metadataBundle);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzdn, i, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzdl, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
