package com.google.android.gms.nearby.messages.internal;

import android.app.PendingIntent;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.nearby.messages.MessageFilter;
import com.google.android.gms.nearby.messages.Strategy;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "SubscribeRequestCreator")
public final class SubscribeRequest extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<SubscribeRequest> CREATOR = new zzcd();

    @SafeParcelable.VersionField(m24id = 1)
    private final int versionCode;

    @Nullable
    @SafeParcelable.Field(m22id = 8)
    @Deprecated
    private final String zzff;

    @SafeParcelable.Field(m22id = 13)
    @Deprecated
    private final boolean zzfg;

    @Nullable
    @SafeParcelable.Field(m22id = 9)
    @Deprecated
    private final String zzfj;

    @SafeParcelable.Field(m22id = 15)
    private final boolean zzgb;

    @SafeParcelable.Field(m22id = 16)
    private final int zzgc;

    @SafeParcelable.Field(m22id = 17)
    private final int zzhf;

    @SafeParcelable.Field(getter = "getCallbackAsBinder", m22id = 4, type = "android.os.IBinder")
    private final zzp zzhh;

    @SafeParcelable.Field(m22id = 14)
    @Deprecated
    private final ClientAppContext zzhi;

    @SafeParcelable.Field(m22id = 3)
    private final Strategy zzit;

    @SafeParcelable.Field(m22id = 11)
    @Deprecated
    private final boolean zziu;

    @Nullable
    @SafeParcelable.Field(getter = "getMessageListenerAsBinder", m22id = 2, type = "android.os.IBinder")
    private final zzm zziy;

    @SafeParcelable.Field(m22id = 5)
    private final MessageFilter zziz;

    @Nullable
    @SafeParcelable.Field(m22id = 6)
    private final PendingIntent zzja;

    @SafeParcelable.Field(m22id = 7)
    @Deprecated
    private final int zzjb;

    @Nullable
    @SafeParcelable.Field(m22id = 10)
    private final byte[] zzjc;

    @Nullable
    @SafeParcelable.Field(getter = "getSubscribeCallbackAsBinder", m22id = 12, type = "android.os.IBinder")
    private final zzaa zzjd;

    @SafeParcelable.Constructor
    @VisibleForTesting
    public SubscribeRequest(@SafeParcelable.Param(m23id = 1) int i, @Nullable @SafeParcelable.Param(m23id = 2) IBinder iBinder, @SafeParcelable.Param(m23id = 3) Strategy strategy, @SafeParcelable.Param(m23id = 4) IBinder iBinder2, @SafeParcelable.Param(m23id = 5) MessageFilter messageFilter, @Nullable @SafeParcelable.Param(m23id = 6) PendingIntent pendingIntent, @SafeParcelable.Param(m23id = 7) int i2, @Nullable @SafeParcelable.Param(m23id = 8) String str, @Nullable @SafeParcelable.Param(m23id = 9) String str2, @Nullable @SafeParcelable.Param(m23id = 10) byte[] bArr, @SafeParcelable.Param(m23id = 11) boolean z, @Nullable @SafeParcelable.Param(m23id = 12) IBinder iBinder3, @SafeParcelable.Param(m23id = 13) boolean z2, @Nullable @SafeParcelable.Param(m23id = 14) ClientAppContext clientAppContext, @SafeParcelable.Param(m23id = 15) boolean z3, @SafeParcelable.Param(m23id = 16) int i3, @SafeParcelable.Param(m23id = 17) int i4) {
        zzm zzoVar;
        zzp zzrVar;
        this.versionCode = i;
        zzaa zzacVar = null;
        if (iBinder == null) {
            zzoVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.nearby.messages.internal.IMessageListener");
            zzoVar = iInterfaceQueryLocalInterface instanceof zzm ? (zzm) iInterfaceQueryLocalInterface : new zzo(iBinder);
        }
        this.zziy = zzoVar;
        this.zzit = strategy;
        if (iBinder2 == null) {
            zzrVar = null;
        } else {
            IInterface iInterfaceQueryLocalInterface2 = iBinder2.queryLocalInterface("com.google.android.gms.nearby.messages.internal.INearbyMessagesCallback");
            zzrVar = iInterfaceQueryLocalInterface2 instanceof zzp ? (zzp) iInterfaceQueryLocalInterface2 : new zzr(iBinder2);
        }
        this.zzhh = zzrVar;
        this.zziz = messageFilter;
        this.zzja = pendingIntent;
        this.zzjb = i2;
        this.zzff = str;
        this.zzfj = str2;
        this.zzjc = bArr;
        this.zziu = z;
        if (iBinder3 != null && iBinder3 != null) {
            IInterface iInterfaceQueryLocalInterface3 = iBinder3.queryLocalInterface("com.google.android.gms.nearby.messages.internal.ISubscribeCallback");
            zzacVar = iInterfaceQueryLocalInterface3 instanceof zzaa ? (zzaa) iInterfaceQueryLocalInterface3 : new zzac(iBinder3);
        }
        this.zzjd = zzacVar;
        this.zzfg = z2;
        this.zzhi = ClientAppContext.zza(clientAppContext, str2, str, z2);
        this.zzgb = z3;
        this.zzgc = i3;
        this.zzhf = i4;
    }

    public SubscribeRequest(IBinder iBinder, Strategy strategy, IBinder iBinder2, MessageFilter messageFilter, PendingIntent pendingIntent, @Nullable byte[] bArr, @Nullable IBinder iBinder3, boolean z, int i) {
        this(iBinder, strategy, iBinder2, messageFilter, null, bArr, iBinder3, z, 0, i);
    }

    public SubscribeRequest(IBinder iBinder, Strategy strategy, IBinder iBinder2, MessageFilter messageFilter, PendingIntent pendingIntent, @Nullable byte[] bArr, @Nullable IBinder iBinder3, boolean z, int i, int i2) {
        this(3, iBinder, strategy, iBinder2, messageFilter, pendingIntent, 0, null, null, bArr, false, iBinder3, false, null, z, i, i2);
    }

    public final String toString() {
        String string;
        String strValueOf = String.valueOf(this.zziy);
        String strValueOf2 = String.valueOf(this.zzit);
        String strValueOf3 = String.valueOf(this.zzhh);
        String strValueOf4 = String.valueOf(this.zziz);
        String strValueOf5 = String.valueOf(this.zzja);
        if (this.zzjc == null) {
            string = null;
        } else {
            int length = this.zzjc.length;
            StringBuilder sb = new StringBuilder(19);
            sb.append("<");
            sb.append(length);
            sb.append(" bytes>");
            string = sb.toString();
        }
        String strValueOf6 = String.valueOf(this.zzjd);
        boolean z = this.zzfg;
        String strValueOf7 = String.valueOf(this.zzhi);
        boolean z2 = this.zzgb;
        String str = this.zzff;
        String str2 = this.zzfj;
        boolean z3 = this.zziu;
        int i = this.zzhf;
        StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf).length() + 291 + String.valueOf(strValueOf2).length() + String.valueOf(strValueOf3).length() + String.valueOf(strValueOf4).length() + String.valueOf(strValueOf5).length() + String.valueOf(string).length() + String.valueOf(strValueOf6).length() + String.valueOf(strValueOf7).length() + String.valueOf(str).length() + String.valueOf(str2).length());
        sb2.append("SubscribeRequest{messageListener=");
        sb2.append(strValueOf);
        sb2.append(", strategy=");
        sb2.append(strValueOf2);
        sb2.append(", callback=");
        sb2.append(strValueOf3);
        sb2.append(", filter=");
        sb2.append(strValueOf4);
        sb2.append(", pendingIntent=");
        sb2.append(strValueOf5);
        sb2.append(", hint=");
        sb2.append(string);
        sb2.append(", subscribeCallback=");
        sb2.append(strValueOf6);
        sb2.append(", useRealClientApiKey=");
        sb2.append(z);
        sb2.append(", clientAppContext=");
        sb2.append(strValueOf7);
        sb2.append(", isDiscardPendingIntent=");
        sb2.append(z2);
        sb2.append(", zeroPartyPackageName=");
        sb2.append(str);
        sb2.append(", realClientPackageName=");
        sb2.append(str2);
        sb2.append(", isIgnoreNearbyPermission=");
        sb2.append(z3);
        sb2.append(", callingContext=");
        sb2.append(i);
        sb2.append("}");
        return sb2.toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.versionCode);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zziy == null ? null : this.zziy.asBinder(), false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzit, i, false);
        SafeParcelWriter.writeIBinder(parcel, 4, this.zzhh == null ? null : this.zzhh.asBinder(), false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zziz, i, false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzja, i, false);
        SafeParcelWriter.writeInt(parcel, 7, this.zzjb);
        SafeParcelWriter.writeString(parcel, 8, this.zzff, false);
        SafeParcelWriter.writeString(parcel, 9, this.zzfj, false);
        SafeParcelWriter.writeByteArray(parcel, 10, this.zzjc, false);
        SafeParcelWriter.writeBoolean(parcel, 11, this.zziu);
        SafeParcelWriter.writeIBinder(parcel, 12, this.zzjd != null ? this.zzjd.asBinder() : null, false);
        SafeParcelWriter.writeBoolean(parcel, 13, this.zzfg);
        SafeParcelWriter.writeParcelable(parcel, 14, this.zzhi, i, false);
        SafeParcelWriter.writeBoolean(parcel, 15, this.zzgb);
        SafeParcelWriter.writeInt(parcel, 16, this.zzgc);
        SafeParcelWriter.writeInt(parcel, 17, this.zzhf);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
