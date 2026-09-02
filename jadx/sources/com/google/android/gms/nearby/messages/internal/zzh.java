package com.google.android.gms.nearby.messages.internal;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "GetPermissionStatusRequestCreator")
@Deprecated
public final class zzh extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzh> CREATOR = new zzi();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 3)
    @Deprecated
    private final String zzff;

    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 2, type = "android.os.IBinder")
    private final zzp zzhh;

    @Nullable
    @SafeParcelable.Field(m22id = 4)
    @Deprecated
    private final ClientAppContext zzhi;

    @SafeParcelable.Constructor
    zzh(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 3) String str, @Nullable @SafeParcelable.Param(m23id = 4) ClientAppContext clientAppContext) {
        zzp zzrVar;
        this.versionCode = i;
        if (iBinder == null) {
            zzrVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.messages.internal.INearbyMessagesCallback");
            zzrVar = iInterfaceQueryLocalInterface instanceof zzp ? (zzp) iInterfaceQueryLocalInterface : new zzr(iBinder);
        }
        this.zzhh = zzrVar;
        this.zzff = str;
        this.zzhi = ClientAppContext.zza(clientAppContext, null, str, false);
    }

    zzh(IBinder iBinder) {
        this(1, iBinder, null, null);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzhh.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 3, this.zzff, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzhi, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
