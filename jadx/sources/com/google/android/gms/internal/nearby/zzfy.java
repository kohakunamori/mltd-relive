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
import com.google.android.gms.nearby.connection.AdvertisingOptions;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "StartAdvertisingParamsCreator")
@SafeParcelable.Reserved({1000})
public final class zzfy extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfy> CREATOR = new zzgb();

    @SafeParcelable.Field(getter = "getDurationMillis", m22id = 5)
    private long durationMillis;

    @SafeParcelable.Field(getter = "getName", m22id = 3)
    private String name;

    @Nullable
    @SafeParcelable.Field(getter = "getConnectionLifecycleListenerAsBinder", m22id = 7, type = "android.os.IBinder")
    private zzdj zzec;

    @Nullable
    @SafeParcelable.Field(getter = "getResultListenerAsBinder", m22id = 1, type = "android.os.IBinder")
    private zzec zzeh;

    @Nullable
    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 2, type = "android.os.IBinder")
    private zzdd zzei;

    @SafeParcelable.Field(getter = "getOptions", m22id = 6)
    private AdvertisingOptions zzej;

    @SafeParcelable.Field(getter = "getServiceId", m22id = 4)
    private String zzu;

    private zzfy() {
    }

    /* JADX WARN: Illegal instructions before constructor call */
    @SafeParcelable.Constructor
    zzfy(@Nullable @SafeParcelable.Param(m23id = 1) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 2) IBinder iBinder2, @SafeParcelable.Param(m23id = 3) String str, @SafeParcelable.Param(m23id = 4) String str2, @SafeParcelable.Param(m23id = 5) long j, @SafeParcelable.Param(m23id = 6) AdvertisingOptions advertisingOptions, @Nullable @SafeParcelable.Param(m23id = 7) IBinder iBinder3) {
        zzec zzeeVar;
        zzdd zzdfVar;
        zzdj zzdlVar = null;
        if (iBinder == null) {
            zzeeVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IStartAdvertisingResultListener");
            zzeeVar = iInterfaceQueryLocalInterface instanceof zzec ? (zzec) iInterfaceQueryLocalInterface : new zzee(iBinder);
        }
        if (iBinder2 == null) {
            zzdfVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IAdvertisingCallback");
            zzdfVar = iInterfaceQueryLocalInterface2 instanceof zzdd ? (zzdd) iInterfaceQueryLocalInterface2 : new zzdf(iBinder2);
        }
        if (iBinder3 != null) {
            IInterface iInterfaceQueryLocalInterface3 = iBinder3.queryLocalInterface("com.google.android.gms.nearby.internal.connection.IConnectionLifecycleListener");
            zzdlVar = iInterfaceQueryLocalInterface3 instanceof zzdj ? (zzdj) iInterfaceQueryLocalInterface3 : new zzdl(iBinder3);
        }
        this(zzeeVar, zzdfVar, str, str2, j, advertisingOptions, zzdlVar);
    }

    private zzfy(@Nullable zzec zzecVar, @Nullable zzdd zzddVar, String str, String str2, long j, AdvertisingOptions advertisingOptions, @Nullable zzdj zzdjVar) {
        this.zzeh = zzecVar;
        this.zzei = zzddVar;
        this.name = str;
        this.zzu = str2;
        this.durationMillis = j;
        this.zzej = advertisingOptions;
        this.zzec = zzdjVar;
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzfy) {
            zzfy zzfyVar = (zzfy) obj;
            if (Objects.equal(this.zzeh, zzfyVar.zzeh) && Objects.equal(this.zzei, zzfyVar.zzei) && Objects.equal(this.name, zzfyVar.name) && Objects.equal(this.zzu, zzfyVar.zzu) && Objects.equal(Long.valueOf(this.durationMillis), Long.valueOf(zzfyVar.durationMillis)) && Objects.equal(this.zzej, zzfyVar.zzej) && Objects.equal(this.zzec, zzfyVar.zzec)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzeh, this.zzei, this.name, this.zzu, Long.valueOf(this.durationMillis), this.zzej, this.zzec);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeIBinder(parcel, 1, this.zzeh == null ? null : this.zzeh.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzei == null ? null : this.zzei.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 3, this.name, false);
        SafeParcelWriter.writeString(parcel, 4, this.zzu, false);
        SafeParcelWriter.writeLong(parcel, 5, this.durationMillis);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzej, i, false);
        SafeParcelWriter.writeIBinder(parcel, 7, this.zzec != null ? this.zzec.asBinder() : null, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
