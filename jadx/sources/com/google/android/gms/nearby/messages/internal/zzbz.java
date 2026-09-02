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
import com.google.android.gms.nearby.messages.Strategy;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "PublishRequestCreator")
public final class zzbz extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzbz> CREATOR = new zzca();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 5)
    @Deprecated
    private final String zzff;

    @SafeParcelable.Field(m22id = 9)
    @Deprecated
    private final boolean zzfg;

    @Nullable
    @SafeParcelable.Field(m22id = 6)
    @Deprecated
    private final String zzfj;

    @SafeParcelable.Field(m22id = 11)
    private final int zzhf;

    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 4, type = "android.os.IBinder")
    private final zzp zzhh;

    @SafeParcelable.Field(m22id = 10)
    @Deprecated
    private final ClientAppContext zzhi;

    @SafeParcelable.Field(m22id = 2)
    private final zzaf zzis;

    @SafeParcelable.Field(m22id = 3)
    private final Strategy zzit;

    @SafeParcelable.Field(m22id = 7)
    @Deprecated
    private final boolean zziu;

    @Nullable
    @SafeParcelable.Field(getter = "getPublishCallbackAsBinder", m22id = 8, type = "android.os.IBinder")
    private final zzu zziv;

    @SafeParcelable.Constructor
    zzbz(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) zzaf zzafVar, @SafeParcelable.Param(m23id = 3) Strategy strategy, @SafeParcelable.Param(m23id = 4) IBinder iBinder, @Nullable @SafeParcelable.Param(m23id = 5) String str, @Nullable @SafeParcelable.Param(m23id = 6) String str2, @SafeParcelable.Param(m23id = 7) boolean z, @Nullable @SafeParcelable.Param(m23id = 8) IBinder iBinder2, @SafeParcelable.Param(m23id = 9) boolean z2, @Nullable @SafeParcelable.Param(m23id = 10) ClientAppContext clientAppContext, @SafeParcelable.Param(m23id = 11) int i2) {
        zzp zzrVar;
        this.versionCode = i;
        this.zzis = zzafVar;
        this.zzit = strategy;
        zzu zzwVar = null;
        if (iBinder == null) {
            zzrVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.messages.internal.INearbyMessagesCallback");
            zzrVar = iInterfaceQueryLocalInterface instanceof zzp ? (zzp) iInterfaceQueryLocalInterface : new zzr(iBinder);
        }
        this.zzhh = zzrVar;
        this.zzff = str;
        this.zzfj = str2;
        this.zziu = z;
        if (iBinder2 != null && iBinder2 != null) {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.messages.internal.IPublishCallback");
            zzwVar = iInterfaceQueryLocalInterface2 instanceof zzu ? (zzu) iInterfaceQueryLocalInterface2 : new zzw(iBinder2);
        }
        this.zziv = zzwVar;
        this.zzfg = z2;
        this.zzhi = ClientAppContext.zza(clientAppContext, str2, str, z2);
        this.zzhf = i2;
    }

    @VisibleForTesting
    public zzbz(zzaf zzafVar, Strategy strategy, IBinder iBinder, @Nullable IBinder iBinder2, int i) {
        this(2, zzafVar, strategy, iBinder, null, null, false, iBinder2, false, null, i);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzis, i, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzit, i, false);
        SafeParcelWriter.writeIBinder(parcel, 4, this.zzhh.asBinder(), false);
        SafeParcelWriter.writeString(parcel, 5, this.zzff, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzfj, false);
        SafeParcelWriter.writeBoolean(parcel, 7, this.zziu);
        SafeParcelWriter.writeIBinder(parcel, 8, this.zziv == null ? null : this.zziv.asBinder(), false);
        SafeParcelWriter.writeBoolean(parcel, 9, this.zzfg);
        SafeParcelWriter.writeParcelable(parcel, 10, this.zzhi, i, false);
        SafeParcelWriter.writeInt(parcel, 11, this.zzhf);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
