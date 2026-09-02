package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.Contents;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnContentsResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzfb extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfb> CREATOR = new zzfc();

    @SafeParcelable.Field(m22id = 2)
    final Contents zzeq;

    @SafeParcelable.Field(m22id = 3)
    final boolean zzhf;

    @SafeParcelable.Constructor
    public zzfb(@SafeParcelable.Param(m23id = 2) Contents contents, @SafeParcelable.Param(m23id = 3) boolean z) {
        this.zzeq = contents;
        this.zzhf = z;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzeq, i, false);
        SafeParcelWriter.writeBoolean(parcel, 3, this.zzhf);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final Contents zzai() {
        return this.zzeq;
    }
}
