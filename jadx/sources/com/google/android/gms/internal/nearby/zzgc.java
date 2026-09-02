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
import com.google.android.gms.nearby.connection.DiscoveryOptions;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "StartDiscoveryParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzgc extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgc> CREATOR = new zzgf();

    @SafeParcelable.Field(getter = "getDurationMillis", m22id = 4)
    private long durationMillis;

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzdz zzar;

    @Nullable
    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 2, type = "android.os.IBinder")
    private zzdp zzel;

    @SafeParcelable.Field(getter = "getOptions", m22id = 5)
    private DiscoveryOptions zzem;

    @Nullable
    @SafeParcelable.Field(getter = "getDiscoveryListenerAsBinder", m22id = 6, type = "android.os.IBinder")
    private zzdr zzen;

    @SafeParcelable.Field(getter = "getServiceId", m22id = 3)
    private String zzu;

    private zzgc() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzgc(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 2) IBinder iBinder2, @SafeParcelable.Param(m23id = 3) String str, @SafeParcelable.Param(m23id = 4) long j, @SafeParcelable.Param(m23id = 5) DiscoveryOptions discoveryOptions, @Nullable @SafeParcelable.Param(m23id = 6) IBinder iBinder3) {
        zzdz zzebVar;
        zzdp zzdqVar;
        zzdr zzdtVar = null;
        if (iBinder == null) {
            zzebVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IResultListener");
            zzebVar = iInterfaceQueryLocalInterface instanceof zzdz ? (zzdz) iInterfaceQueryLocalInterface : new zzeb(iBinder);
        }
        if (iBinder2 == null) {
            zzdqVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IDiscoveryCallback");
            zzdqVar = iInterfaceQueryLocalInterface2 instanceof zzdp ? (zzdp) iInterfaceQueryLocalInterface2 : new zzdq(iBinder2);
        }
        if (iBinder3 != null) {
            IInterface iInterfaceQueryLocalInterface3 = iBinder3.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IDiscoveryListener");
            zzdtVar = iInterfaceQueryLocalInterface3 instanceof zzdr ? (zzdr) iInterfaceQueryLocalInterface3 : new zzdt(iBinder3);
        }
        this(zzebVar, zzdqVar, str, j, discoveryOptions, zzdtVar);
    }

    private zzgc(@Nullable zzdz zzdzVar, @Nullable zzdp zzdpVar, String str, long j, DiscoveryOptions discoveryOptions, @Nullable zzdr zzdrVar) {
        this.zzar = zzdzVar;
        this.zzel = zzdpVar;
        this.zzu = str;
        this.durationMillis = j;
        this.zzem = discoveryOptions;
        this.zzen = zzdrVar;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzgc) {
            zzgc zzgcVar = (zzgc) obj;
            if (Objects.equal(this.zzar, zzgcVar.zzar) && Objects.equal(this.zzel, zzgcVar.zzel) && Objects.equal(this.zzu, zzgcVar.zzu) && Objects.equal(Long.valueOf(this.durationMillis), Long.valueOf(zzgcVar.durationMillis)) && Objects.equal(this.zzem, zzgcVar.zzem) && Objects.equal(this.zzen, zzgcVar.zzen)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzar, this.zzel, this.zzu, Long.valueOf(this.durationMillis), this.zzem, this.zzen);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzar == null ? null : this.zzar.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzel == null ? null : this.zzel.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 3, this.zzu, false);
        SafeParcelWriter.writeLong(parcel, 4, this.durationMillis);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzem, i, false);
        SafeParcelWriter.writeIBinder(parcel, 6, this.zzen != null ? this.zzen.asBinder() : null, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
