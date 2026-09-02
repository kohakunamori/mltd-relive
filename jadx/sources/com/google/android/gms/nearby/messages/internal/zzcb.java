package com.google.android.gms.nearby.messages.internal;

import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "RegisterStatusCallbackRequestCreator")
public final class zzcb extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzcb> CREATOR = new zzcc();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 5)
    @Deprecated
    private String zzff;

    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 2, type = "android.os.IBinder")
    private final zzp zzhh;

    @Nullable
    @SafeParcelable.Field(m22id = 6)
    @Deprecated
    private final ClientAppContext zzhi;

    @SafeParcelable.Field(getter = "getStatusCallbackAsBinder", m22id = 3, type = "android.os.IBinder")
    private final zzx zziw;

    @SafeParcelable.Field(m22id = 4)
    public boolean zzix;

    @SafeParcelable.Constructor
    zzcb(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) IBinder iBinder, @SafeParcelable.Param(m23id = 3) IBinder iBinder2, @SafeParcelable.Param(m23id = 4) boolean z, @Nullable @SafeParcelable.Param(m23id = 5) String str, @Nullable @SafeParcelable.Param(m23id = 6) ClientAppContext clientAppContext) {
        zzp zzrVar;
        zzx zzzVar;
        this.versionCode = i;
        if (iBinder == null) {
            zzrVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.messages.internal.INearbyMessagesCallback");
            zzrVar = iInterfaceQueryLocalInterface instanceof zzp ? (zzp) iInterfaceQueryLocalInterface : new zzr(iBinder);
        }
        this.zzhh = zzrVar;
        if (iBinder2 == null) {
            zzzVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.messages.internal.IStatusCallback");
            zzzVar = iInterfaceQueryLocalInterface2 instanceof zzx ? (zzx) iInterfaceQueryLocalInterface2 : new zzz(iBinder2);
        }
        this.zziw = zzzVar;
        this.zzix = z;
        this.zzff = str;
        this.zzhi = ClientAppContext.zza(clientAppContext, null, str, false);
    }

    @VisibleForTesting
    public zzcb(IBinder iBinder, IBinder iBinder2) {
        this(1, iBinder, iBinder2, false, null, null);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zzhh.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 3, this.zziw.asBinder(), false);
        SafeParcelWriter.writeBoolean(parcel, 4, this.zzix);
        SafeParcelWriter.writeString(parcel, 5, this.zzff, false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzhi, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
