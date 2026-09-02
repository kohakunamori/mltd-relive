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
@SafeParcelable.Class(creator = "UnpublishRequestCreator")
public final class zzce extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzce> CREATOR = new zzcf();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 4)
    @Deprecated
    private final String zzff;

    @SafeParcelable.Field(m22id = 6)
    @Deprecated
    private final boolean zzfg;

    @Nullable
    @SafeParcelable.Field(m22id = 5)
    @Deprecated
    private final String zzfj;

    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 3, type = "android.os.IBinder")
    private final zzp zzhh;

    @Nullable
    @SafeParcelable.Field(m22id = 7)
    @Deprecated
    private final ClientAppContext zzhi;

    @SafeParcelable.Field(m22id = 2)
    private final zzaf zzis;

    @SafeParcelable.Constructor
    zzce(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) zzaf zzafVar, @SafeParcelable.Param(m23id = 3) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 4) String str, @Nullable @SafeParcelable.Param(m23id = 5) String str2, @SafeParcelable.Param(m23id = 6) boolean z, @Nullable @SafeParcelable.Param(m23id = 7) ClientAppContext clientAppContext) {
        zzp zzrVar;
        this.versionCode = i;
        this.zzis = zzafVar;
        if (iBinder == null) {
            zzrVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.messages.internal.INearbyMessagesCallback");
            zzrVar = iInterfaceQueryLocalInterface instanceof zzp ? (zzp) iInterfaceQueryLocalInterface : new zzr(iBinder);
        }
        this.zzhh = zzrVar;
        this.zzff = str;
        this.zzfj = str2;
        this.zzfg = z;
        this.zzhi = ClientAppContext.zza(clientAppContext, str2, str, z);
    }

    @VisibleForTesting
    public zzce(zzaf zzafVar, IBinder iBinder) {
        this(1, zzafVar, iBinder, null, null, false, null);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzis, i, false);
        SafeParcelWriter.writeIBinder(parcel, 3, this.zzhh.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 4, this.zzff, false);
        SafeParcelWriter.writeString(parcel, 5, this.zzfj, false);
        SafeParcelWriter.writeBoolean(parcel, 6, this.zzfg);
        SafeParcelWriter.writeParcelable(parcel, 7, this.zzhi, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
