package com.google.android.gms.measurement.internal;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Iterator;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "EventParamsCreator")
@SafeParcelable.Reserved({1})
public final class zzah extends AbstractSafeParcelable implements Iterable<String> {
    public static final Parcelable.Creator<zzah> CREATOR = new zzaj();

    @SafeParcelable.Field(getter = "z", m22id = 2)
    private final Bundle zzft;

    @SafeParcelable.Constructor
    zzah(@SafeParcelable.Param(m23id = 2) Bundle bundle) {
        this.zzft = bundle;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeBundle(parcel, 2, zzcv(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    final Object get(String str) {
        return this.zzft.get(str);
    }

    final Long getLong(String str) {
        return Long.valueOf(this.zzft.getLong(str));
    }

    final Double zzah(String str) {
        return Double.valueOf(this.zzft.getDouble(str));
    }

    final String getString(String str) {
        return this.zzft.getString(str);
    }

    public final int size() {
        return this.zzft.size();
    }

    public final String toString() {
        return this.zzft.toString();
    }

    public final Bundle zzcv() {
        return new Bundle(this.zzft);
    }

    @Override // java.lang.Iterable
    public final Iterator<String> iterator() {
        return new zzag(this);
    }
}
