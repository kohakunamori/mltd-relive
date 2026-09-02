package com.google.android.gms.nearby.messages.internal;

import android.app.PendingIntent;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "UnsubscribeRequestCreator")
public final class zzcg extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzcg> CREATOR = new zzch();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 6)
    @Deprecated
    private final String zzff;

    @SafeParcelable.Field(m22id = 8)
    @Deprecated
    private final boolean zzfg;

    @Nullable
    @SafeParcelable.Field(m22id = 7)
    @Deprecated
    private final String zzfj;

    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 3, type = "android.os.IBinder")
    private final zzp zzhh;

    @Nullable
    @SafeParcelable.Field(m22id = 9)
    @Deprecated
    private final ClientAppContext zzhi;

    @Nullable
    @SafeParcelable.Field(getter = "getMessageListenerAsBinder", m22id = 2, type = "android.os.IBinder")
    private final zzm zziy;

    @Nullable
    @SafeParcelable.Field(m22id = 4)
    private final PendingIntent zzja;

    @SafeParcelable.Field(m22id = 5)
    @Deprecated
    private final int zzjb;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public zzcg(@SafeParcelable.Param(m23id = 1) int i, @Nullable @SafeParcelable.Param(m23id = 2) IBinder iBinder, @SafeParcelable.Param(m23id = 3) IBinder iBinder2, @Nullable @SafeParcelable.Param(m23id = 4) PendingIntent pendingIntent, @SafeParcelable.Param(m23id = 5) int i2, @Nullable @SafeParcelable.Param(m23id = 6) String str, @Nullable @SafeParcelable.Param(m23id = 7) String str2, @SafeParcelable.Param(m23id = 8) boolean z, @Nullable @SafeParcelable.Param(m23id = 9) ClientAppContext clientAppContext) {
        zzm zzoVar;
        this.versionCode = i;
        zzp zzrVar = null;
        if (iBinder == null) {
            zzoVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.messages.internal.IMessageListener");
            zzoVar = iInterfaceQueryLocalInterface instanceof zzm ? (zzm) iInterfaceQueryLocalInterface : new zzo(iBinder);
        }
        this.zziy = zzoVar;
        if (iBinder2 != null) {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.messages.internal.INearbyMessagesCallback");
            zzrVar = iInterfaceQueryLocalInterface2 instanceof zzp ? (zzp) iInterfaceQueryLocalInterface2 : new zzr(iBinder2);
        }
        this.zzhh = zzrVar;
        this.zzja = pendingIntent;
        this.zzjb = i2;
        this.zzff = str;
        this.zzfj = str2;
        this.zzfg = z;
        this.zzhi = ClientAppContext.zza(clientAppContext, str2, str, z);
    }

    @VisibleForTesting
    public zzcg(IBinder iBinder, IBinder iBinder2, @Nullable PendingIntent pendingIntent) {
        this(1, iBinder, iBinder2, pendingIntent, 0, null, null, false, null);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zziy == null ? null : this.zziy.asBinder(), false);
        SafeParcelWriter.writeIBinder(parcel, 3, this.zzhh.asBinder(), false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzja, i, false);
        SafeParcelWriter.writeInt(parcel, 5, this.zzjb);
        SafeParcelWriter.writeString(parcel, 6, this.zzff, false);
        SafeParcelWriter.writeString(parcel, 7, this.zzfj, false);
        SafeParcelWriter.writeBoolean(parcel, 8, this.zzfg);
        SafeParcelWriter.writeParcelable(parcel, 9, this.zzhi, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
