package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "GetPermissionsResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzem extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzem> CREATOR = new zzen();

    @SafeParcelable.Field(m22id = 3)
    private final int responseCode;

    @SafeParcelable.Field(m22id = 2)
    private final List<com.google.android.gms.drive.zzr> zzgz;

    @SafeParcelable.Constructor
    public zzem(@SafeParcelable.Param(m23id = 2) List<com.google.android.gms.drive.zzr> list, @SafeParcelable.Param(m23id = 3) int i) {
        this.zzgz = list;
        this.responseCode = i;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 2, this.zzgz, false);
        SafeParcelWriter.writeInt(parcel, 3, this.responseCode);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
