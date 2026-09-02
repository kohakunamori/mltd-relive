package com.google.android.gms.nearby.messages.internal;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "HandleClientLifecycleEventRequestCreator")
public final class zzj extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzj> CREATOR = new zzk();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 2)
    @Deprecated
    private final ClientAppContext zzhi;

    @SafeParcelable.Field(m22id = 3)
    private final int zzhj;

    public zzj(int i) {
        this(1, null, i);
    }

    @SafeParcelable.Constructor
    zzj(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) ClientAppContext clientAppContext, @SafeParcelable.Param(m23id = 3) int i2) {
        this.versionCode = i;
        this.zzhi = clientAppContext;
        this.zzhj = i2;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzhi, i, false);
        SafeParcelWriter.writeInt(parcel, 3, this.zzhj);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
