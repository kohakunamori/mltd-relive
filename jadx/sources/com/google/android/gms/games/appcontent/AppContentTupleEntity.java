package com.google.android.gms.games.appcontent;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "AppContentTupleEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AppContentTupleEntity extends com.google.android.gms.games.internal.zzd implements zzk {
    public static final Parcelable.Creator<AppContentTupleEntity> CREATOR = new zzl();

    @SafeParcelable.Field(getter = "getName", m22id = 1)
    private final String name;

    @SafeParcelable.Field(getter = "getValue", m22id = 2)
    private final String value;

    @SafeParcelable.Constructor
    AppContentTupleEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2) {
        this.name = str;
        this.value = str2;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zzk freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.appcontent.zzk
    public final String getName() {
        return this.name;
    }

    @Override // com.google.android.gms.games.appcontent.zzk
    public final String getValue() {
        return this.value;
    }

    public final int hashCode() {
        return Objects.hashCode(getName(), getValue());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zzk)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        zzk zzkVar = (zzk) obj;
        return Objects.equal(zzkVar.getName(), getName()) && Objects.equal(zzkVar.getValue(), getValue());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Name", getName()).add("Value", getValue()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.name, false);
        SafeParcelWriter.writeString(parcel, 2, this.value, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
