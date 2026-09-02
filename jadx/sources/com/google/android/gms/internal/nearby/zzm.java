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
@SafeParcelable.Class(creator = "AcceptConnectionRequestParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzm extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzm> CREATOR = new zzp();

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzdz zzar;

    @Nullable
    @SafeParcelable.Field(getter = "getConnectionEventListenerAsBinder", m22id = 2, type = "android.os.IBinder")
    private zzdg zzas;

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 3)
    private String zzat;

    @Nullable
    @SafeParcelable.Field(getter = "getHandshakeData", m22id = 4)
    private byte[] zzau;

    @Nullable
    @SafeParcelable.Field(getter = "getPayloadListenerAsBinder", m22id = 5, type = "android.os.IBinder")
    private zzdw zzav;

    private zzm() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzm(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 2) IBinder iBinder2, @SafeParcelable.Param(m23id = 3) String str, @Nullable @SafeParcelable.Param(m23id = 4) byte[] bArr, @Nullable @SafeParcelable.Param(m23id = 5) IBinder iBinder3) {
        zzdz zzebVar;
        zzdg zzdiVar;
        zzdw zzdyVar = null;
        if (iBinder == null) {
            zzebVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IResultListener");
            zzebVar = iInterfaceQueryLocalInterface instanceof zzdz ? (zzdz) iInterfaceQueryLocalInterface : new zzeb(iBinder);
        }
        if (iBinder2 == null) {
            zzdiVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IConnectionEventListener");
            zzdiVar = iInterfaceQueryLocalInterface2 instanceof zzdg ? (zzdg) iInterfaceQueryLocalInterface2 : new zzdi(iBinder2);
        }
        if (iBinder3 != null) {
            IInterface iInterfaceQueryLocalInterface3 = iBinder3.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IPayloadListener");
            zzdyVar = iInterfaceQueryLocalInterface3 instanceof zzdw ? (zzdw) iInterfaceQueryLocalInterface3 : new zzdy(iBinder3);
        }
        this(zzebVar, zzdiVar, str, bArr, zzdyVar);
    }

    private zzm(@Nullable zzdz zzdzVar, @Nullable zzdg zzdgVar, String str, @Nullable byte[] bArr, @Nullable zzdw zzdwVar) {
        this.zzar = zzdzVar;
        this.zzas = zzdgVar;
        this.zzat = str;
        this.zzau = bArr;
        this.zzav = zzdwVar;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzm) {
            zzm zzmVar = (zzm) obj;
            if (Objects.equal(this.zzar, zzmVar.zzar) && Objects.equal(this.zzas, zzmVar.zzas) && Objects.equal(this.zzat, zzmVar.zzat) && Arrays.equals(this.zzau, zzmVar.zzau) && Objects.equal(this.zzav, zzmVar.zzav)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzar, this.zzas, this.zzat, Integer.valueOf(Arrays.hashCode(this.zzau)), this.zzav);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzar == null ? null : this.zzar.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzas == null ? null : this.zzas.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 3, this.zzat, false);
        SafeParcelWriter.writeByteArray(parcel, 4, this.zzau, false);
        SafeParcelWriter.writeIBinder(parcel, 5, this.zzav != null ? this.zzav.asBinder() : null, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
