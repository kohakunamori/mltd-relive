package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "StringListResponseCreator")
@SafeParcelable.Reserved({1})
public final class zzgt extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgt> CREATOR = new zzgu();

    @SafeParcelable.Field(getter = "getList", m22id = 2)
    private final List<String> zzie;

    @SafeParcelable.Constructor
    public zzgt(@SafeParcelable.Param(m23id = 2) List<String> list) {
        this.zzie = list;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeStringList(parcel, 2, this.zzie, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
