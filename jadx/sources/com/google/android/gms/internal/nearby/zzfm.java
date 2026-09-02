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
@SafeParcelable.Class(creator = "RejectConnectionRequestParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzfm extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfm> CREATOR = new zzfp();

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzdz zzar;

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 2)
    private String zzat;

    private zzfm() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzfm(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @SafeParcelable.Param(m23id = 2) String str) {
        zzdz zzebVar;
        if (iBinder == null) {
            zzebVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IResultListener");
            zzebVar = iInterfaceQueryLocalInterface instanceof zzdz ? (zzdz) iInterfaceQueryLocalInterface : new zzeb(iBinder);
        }
        this(zzebVar, str);
    }

    private zzfm(@Nullable zzdz zzdzVar, String str) {
        this.zzar = zzdzVar;
        this.zzat = str;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzfm) {
            zzfm zzfmVar = (zzfm) obj;
            if (Objects.equal(this.zzar, zzfmVar.zzar) && Objects.equal(this.zzat, zzfmVar.zzat)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzar, this.zzat);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzar == null ? null : this.zzar.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 2, this.zzat, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
