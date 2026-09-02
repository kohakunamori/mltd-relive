package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnRealtimeLoadedResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzfr extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfr> CREATOR = new zzfw();

    @SafeParcelable.Field(m22id = 2)
    private final boolean zzhu;

    @SafeParcelable.Constructor
    public zzfr(@SafeParcelable.Param(m23id = 2) boolean z) {
        this.zzhu = z;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeBoolean(parcel, 2, this.zzhu);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
