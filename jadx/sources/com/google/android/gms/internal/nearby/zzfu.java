package com.google.android.gms.internal.nearby;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Arrays;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "SendPayloadParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzfu extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfu> CREATOR = new zzfx();

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzdz zzar;

    @Nullable
    @SafeParcelable.Field(getter = "getPayload", m22id = 3)
    private zzfh zzdk;

    @SafeParcelable.Field(getter = "getRemoteEndpointIds", m22id = 2)
    private String[] zzee;

    @SafeParcelable.Field(getter = "getSendReliably", m22id = 4)
    private boolean zzef;

    private zzfu() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzfu(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @SafeParcelable.Param(m23id = 2) String[] strArr, @Nullable @SafeParcelable.Param(m23id = 3) zzfh zzfhVar, @SafeParcelable.Param(m23id = 4) boolean z) {
        zzdz zzebVar;
        if (iBinder == null) {
            zzebVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IResultListener");
            zzebVar = iInterfaceQueryLocalInterface instanceof zzdz ? (zzdz) iInterfaceQueryLocalInterface : new zzeb(iBinder);
        }
        this(zzebVar, strArr, zzfhVar, z);
    }

    private zzfu(@Nullable zzdz zzdzVar, String[] strArr, @Nullable zzfh zzfhVar, boolean z) {
        this.zzar = zzdzVar;
        this.zzee = strArr;
        this.zzdk = zzfhVar;
        this.zzef = z;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzfu) {
            zzfu zzfuVar = (zzfu) obj;
            if (Objects.equal(this.zzar, zzfuVar.zzar) && Arrays.equals(this.zzee, zzfuVar.zzee) && Objects.equal(this.zzdk, zzfuVar.zzdk) && Objects.equal(Boolean.valueOf(this.zzef), Boolean.valueOf(zzfuVar.zzef))) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzar, Integer.valueOf(Arrays.hashCode(this.zzee)), this.zzdk, Boolean.valueOf(this.zzef));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzar == null ? null : this.zzar.asBinder(), false);
        SafeParcelWriter.writeStringArray(parcel, 2, this.zzee, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzdk, i, false);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzef);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
