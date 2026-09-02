package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.DriveId;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OpenContentsRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzgd extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgd> CREATOR = new zzge();

    @SafeParcelable.Field(m22id = 3)
    private final int mode;

    @SafeParcelable.Field(m22id = 2)
    private final DriveId zzdb;

    @SafeParcelable.Field(m22id = 4)
    private final int zzhz;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzgd(@SafeParcelable.Param(m23id = 2) DriveId driveId, @SafeParcelable.Param(m23id = 3) int i, @SafeParcelable.Param(m23id = 4) int i2) {
        this.zzdb = driveId;
        this.mode = i;
        this.zzhz = i2;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzdb, i, false);
        SafeParcelWriter.writeInt(parcel, 3, this.mode);
        SafeParcelWriter.writeInt(parcel, 4, this.zzhz);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
