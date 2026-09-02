package com.google.android.gms.games.appcontent;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "AppContentConditionEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AppContentConditionEntity extends com.google.android.gms.games.internal.zzd implements zzg {
    public static final Parcelable.Creator<AppContentConditionEntity> CREATOR = new zzh();

    @SafeParcelable.Field(getter = "getDefaultValue", m22id = 1)
    private final String zzgf;

    @SafeParcelable.Field(getter = "getExpectedValue", m22id = 2)
    private final String zzgg;

    @SafeParcelable.Field(getter = "getPredicate", m22id = 3)
    private final String zzgh;

    @SafeParcelable.Field(getter = "getPredicateParameters", m22id = 4)
    private final Bundle zzgi;

    @SafeParcelable.Constructor
    AppContentConditionEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) String str2, @SafeParcelable.Param(m23id = 3) String str3, @SafeParcelable.Param(m23id = 4) Bundle bundle) {
        this.zzgf = str;
        this.zzgg = str2;
        this.zzgh = str3;
        this.zzgi = bundle;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zzg freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.appcontent.zzg
    public final String zzam() {
        return this.zzgf;
    }

    @Override // com.google.android.gms.games.appcontent.zzg
    public final String zzan() {
        return this.zzgg;
    }

    @Override // com.google.android.gms.games.appcontent.zzg
    public final String zzao() {
        return this.zzgh;
    }

    @Override // com.google.android.gms.games.appcontent.zzg
    public final Bundle zzap() {
        return this.zzgi;
    }

    public final int hashCode() {
        return Objects.hashCode(zzam(), zzan(), zzao(), zzap());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zzg)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        zzg zzgVar = (zzg) obj;
        return Objects.equal(zzgVar.zzam(), zzam()) && Objects.equal(zzgVar.zzan(), zzan()) && Objects.equal(zzgVar.zzao(), zzao()) && Objects.equal(zzgVar.zzap(), zzap());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("DefaultValue", zzam()).add("ExpectedValue", zzan()).add("Predicate", zzao()).add("PredicateParameters", zzap()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.zzgf, false);
        SafeParcelWriter.writeString(parcel, 2, this.zzgg, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzgh, false);
        SafeParcelWriter.writeBundle(parcel, 4, this.zzgi, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
