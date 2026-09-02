package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.Contents;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "CloseContentsRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzo extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzo> CREATOR = new zzp();

    @Nullable
    @SafeParcelable.Field(m22id = 2)
    private final Contents zzdd;

    @SafeParcelable.Field(m22id = 4)
    private final int zzdf;

    @SafeParcelable.Field(m22id = 3)
    private final Boolean zzdh;

    @VisibleForTesting
    public zzo(int i, boolean z) {
        this(null, false, i);
    }

    @SafeParcelable.Constructor
    zzo(@SafeParcelable.Param(m23id = 2) Contents contents, @SafeParcelable.Param(m23id = 3) Boolean bool, @SafeParcelable.Param(m23id = 4) int i) {
        this.zzdd = contents;
        this.zzdh = bool;
        this.zzdf = i;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzdd, i, false);
        SafeParcelWriter.writeBooleanObject(parcel, 3, this.zzdh, false);
        SafeParcelWriter.writeInt(parcel, 4, this.zzdf);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
