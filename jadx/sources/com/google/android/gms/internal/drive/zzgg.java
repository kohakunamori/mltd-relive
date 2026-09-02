package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.DriveId;
import com.google.android.gms.drive.query.internal.FilterHolder;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OpenFileIntentSenderRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzgg extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgg> CREATOR = new zzgh();

    @SafeParcelable.Field(m22id = 2)
    private final String zzay;

    @SafeParcelable.Field(m22id = 3)
    private final String[] zzaz;

    @SafeParcelable.Field(m22id = 4)
    private final DriveId zzbb;

    @SafeParcelable.Field(m22id = 5)
    private final FilterHolder zzbc;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzgg(@SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) String[] strArr, @SafeParcelable.Param(m23id = 4) DriveId driveId, @SafeParcelable.Param(m23id = 5) FilterHolder filterHolder) {
        this.zzay = str;
        this.zzaz = strArr;
        this.zzbb = driveId;
        this.zzbc = filterHolder;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzay, false);
        SafeParcelWriter.writeStringArray(parcel, 3, this.zzaz, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzbb, i, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzbc, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
