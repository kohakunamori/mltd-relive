package com.google.android.gms.auth.api.accounttransfer;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "DeviceMetaDataCreator")
public class DeviceMetaData extends AbstractSafeParcelable {
    public static final Parcelable.Creator<DeviceMetaData> CREATOR = new zzv();

    @SafeParcelable.Field(getter = "isLockScreenSolved", m22id = 2)
    private boolean zzbs;

    @SafeParcelable.Field(getter = "getMinAgeOfLockScreen", m22id = 3)
    private long zzbt;

    @SafeParcelable.Field(getter = "isChallengeAllowed", m22id = 4)
    private final boolean zzbu;

    @SafeParcelable.VersionField(m24id = 1)
    private final int zzv;

    public boolean isLockScreenSolved() {
        return this.zzbs;
    }

    public long getMinAgeOfLockScreen() {
        return this.zzbt;
    }

    public boolean isChallengeAllowed() {
        return this.zzbu;
    }

    @SafeParcelable.Constructor
    DeviceMetaData(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) boolean z, @SafeParcelable.Param(m23id = 3) long j, @SafeParcelable.Param(m23id = 4) boolean z2) {
        this.zzv = i;
        this.zzbs = z;
        this.zzbt = j;
        this.zzbu = z2;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zzv);
        SafeParcelWriter.writeBoolean(parcel, 2, isLockScreenSolved());
        SafeParcelWriter.writeLong(parcel, 3, getMinAgeOfLockScreen());
        SafeParcelWriter.writeBoolean(parcel, 4, isChallengeAllowed());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
