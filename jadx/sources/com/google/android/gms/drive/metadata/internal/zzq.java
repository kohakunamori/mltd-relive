package com.google.android.gms.drive.metadata.internal;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "PartialDriveIdCreator")
@SafeParcelable.Reserved({1})
public final class zzq extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzq> CREATOR = new zzr();

    @Nullable
    @SafeParcelable.Field(m22id = 2)
    final String zzab;

    @SafeParcelable.Field(m22id = 3)
    final long zzac;

    @SafeParcelable.Field(defaultValueUnchecked = "com.google.android.gms.drive.DriveId.RESOURCE_TYPE_UNKNOWN", m22id = 4)
    final int zzad;

    @SafeParcelable.Constructor
    public zzq(@SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) long j, @SafeParcelable.Param(m23id = 4) int i) {
        this.zzab = str;
        this.zzac = j;
        this.zzad = i;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzab, false);
        SafeParcelWriter.writeLong(parcel, 3, this.zzac);
        SafeParcelWriter.writeInt(parcel, 4, this.zzad);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
