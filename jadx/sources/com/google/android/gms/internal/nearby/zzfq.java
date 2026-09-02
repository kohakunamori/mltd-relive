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
@SafeParcelable.Class(creator = "SendConnectionRequestParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzfq extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfq> CREATOR = new zzft();

    @Nullable
    @SafeParcelable.Field(getter = "getName", m22id = 4)
    private String name;

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzdz zzar;

    @Nullable
    @SafeParcelable.Field(getter = "getConnectionEventListenerAsBinder", m22id = 2, type = "android.os.IBinder")
    private zzdg zzas;

    @SafeParcelable.Field(getter = "getRemoteEndpointId", m22id = 5)
    private String zzat;

    @Nullable
    @SafeParcelable.Field(getter = "getHandshakeData", m22id = 6)
    private byte[] zzau;

    @Nullable
    @SafeParcelable.Field(getter = "getConnectionResponseListenerAsBinder", m22id = 3, type = "android.os.IBinder")
    private zzdm zzeb;

    @Nullable
    @SafeParcelable.Field(getter = "getConnectionLifecycleListenerAsBinder", m22id = 7, type = "android.os.IBinder")
    private zzdj zzec;

    private zzfq() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzfq(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 2) IBinder iBinder2, @Nullable @SafeParcelable.Param(m23id = 3) IBinder iBinder3, @Nullable @SafeParcelable.Param(m23id = 4) String str, @SafeParcelable.Param(m23id = 5) String str2, @Nullable @SafeParcelable.Param(m23id = 6) byte[] bArr, @Nullable @SafeParcelable.Param(m23id = 7) IBinder iBinder4) {
        zzdz zzebVar;
        zzdg zzdiVar;
        zzdm zzdoVar;
        zzdj zzdlVar = null;
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
        if (iBinder3 == null) {
            zzdoVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface3 = iBinder3.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IConnectionResponseListener");
            zzdoVar = iInterfaceQueryLocalInterface3 instanceof zzdm ? (zzdm) iInterfaceQueryLocalInterface3 : new zzdo(iBinder3);
        }
        if (iBinder4 != null) {
            IInterface iInterfaceQueryLocalInterface4 = iBinder4.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IConnectionLifecycleListener");
            zzdlVar = iInterfaceQueryLocalInterface4 instanceof zzdj ? (zzdj) iInterfaceQueryLocalInterface4 : new zzdl(iBinder4);
        }
        this(zzebVar, zzdiVar, zzdoVar, str, str2, bArr, zzdlVar);
    }

    private zzfq(@Nullable zzdz zzdzVar, @Nullable zzdg zzdgVar, @Nullable zzdm zzdmVar, @Nullable String str, String str2, @Nullable byte[] bArr, @Nullable zzdj zzdjVar) {
        this.zzar = zzdzVar;
        this.zzas = zzdgVar;
        this.zzeb = zzdmVar;
        this.name = str;
        this.zzat = str2;
        this.zzau = bArr;
        this.zzec = zzdjVar;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzfq) {
            zzfq zzfqVar = (zzfq) obj;
            if (Objects.equal(this.zzar, zzfqVar.zzar) && Objects.equal(this.zzas, zzfqVar.zzas) && Objects.equal(this.zzeb, zzfqVar.zzeb) && Objects.equal(this.name, zzfqVar.name) && Objects.equal(this.zzat, zzfqVar.zzat) && Arrays.equals(this.zzau, zzfqVar.zzau) && Objects.equal(this.zzec, zzfqVar.zzec)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzar, this.zzas, this.zzeb, this.name, this.zzat, Integer.valueOf(Arrays.hashCode(this.zzau)), this.zzec);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzar == null ? null : this.zzar.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzas == null ? null : this.zzas.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 3, this.zzeb == null ? null : this.zzeb.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 4, this.name, false);
        SafeParcelWriter.writeString(parcel, 5, this.zzat, false);
        SafeParcelWriter.writeByteArray(parcel, 6, this.zzau, false);
        SafeParcelWriter.writeIBinder(parcel, 7, this.zzec != null ? this.zzec.asBinder() : null, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
