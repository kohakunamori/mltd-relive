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

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "CancelPayloadParamsCreator")
public final class zzq extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzq> CREATOR = new zzt();

    @SafeParcelable.Field(getter = "getPayloadId", m22id = 2)
    private long zzaf;

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzdz zzar;

    private zzq() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzq(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @SafeParcelable.Param(m23id = 2) long j) {
        zzdz zzebVar;
        if (iBinder == null) {
            zzebVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IResultListener");
            zzebVar = iInterfaceQueryLocalInterface instanceof zzdz ? (zzdz) iInterfaceQueryLocalInterface : new zzeb(iBinder);
        }
        this(zzebVar, j);
    }

    private zzq(@Nullable zzdz zzdzVar, long j) {
        this.zzar = zzdzVar;
        this.zzaf = j;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzq) {
            zzq zzqVar = (zzq) obj;
            if (Objects.equal(this.zzar, zzqVar.zzar) && Objects.equal(Long.valueOf(this.zzaf), Long.valueOf(zzqVar.zzaf))) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzar, Long.valueOf(this.zzaf));
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzar == null ? null : this.zzar.asBinder(), false);
        SafeParcelWriter.writeLong(parcel, 2, this.zzaf);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
