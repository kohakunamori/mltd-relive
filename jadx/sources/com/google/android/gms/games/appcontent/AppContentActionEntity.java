package com.google.android.gms.games.appcontent;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "AppContentActionEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AppContentActionEntity extends com.google.android.gms.games.internal.zzd implements zza {
    public static final Parcelable.Creator<AppContentActionEntity> CREATOR = new zzb();

    @SafeParcelable.Field(getter = "getExtras", m22id = 3)
    private final Bundle extras;

    @SafeParcelable.Field(getter = "getType", m22id = 6)
    private final String type;

    @SafeParcelable.Field(getter = "getConditions", m22id = 1)
    private final ArrayList<AppContentConditionEntity> zzfp;

    @SafeParcelable.Field(getter = "getContentDescription", m22id = 2)
    private final String zzfq;

    @SafeParcelable.Field(getter = "getId", m22id = 7)
    private final String zzfr;

    @SafeParcelable.Field(getter = "getAnnotation", m22id = 8)
    private final AppContentAnnotationEntity zzfs;

    @SafeParcelable.Field(getter = "getOverflowText", m22id = 9)
    private final String zzft;

    @SafeParcelable.Constructor
    AppContentActionEntity(@SafeParcelable.Param(m23id = 1) ArrayList<AppContentConditionEntity> arrayList, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) Bundle bundle, @SafeParcelable.Param(m23id = 6) String str2, @SafeParcelable.Param(m23id = 7) String str3, @SafeParcelable.Param(m23id = 8) AppContentAnnotationEntity appContentAnnotationEntity, @SafeParcelable.Param(m23id = 9) String str4) {
        this.zzfs = appContentAnnotationEntity;
        this.zzfp = arrayList;
        this.zzfq = str;
        this.extras = bundle;
        this.zzfr = str3;
        this.zzft = str4;
        this.type = str2;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zza freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final zzc zzy() {
        return this.zzfs;
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final List<zzg> zzz() {
        return new ArrayList(this.zzfp);
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final String zzaa() {
        return this.zzfq;
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final Bundle getExtras() {
        return this.extras;
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final String getId() {
        return this.zzfr;
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final String zzab() {
        return this.zzft;
    }

    @Override // com.google.android.gms.games.appcontent.zza
    public final String getType() {
        return this.type;
    }

    public final int hashCode() {
        return Objects.hashCode(zzy(), zzz(), zzaa(), Integer.valueOf(com.google.android.gms.games.internal.zzc.zza(getExtras())), getId(), zzab(), getType());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zza)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        zza zzaVar = (zza) obj;
        return Objects.equal(zzaVar.zzy(), zzy()) && Objects.equal(zzaVar.zzz(), zzz()) && Objects.equal(zzaVar.zzaa(), zzaa()) && com.google.android.gms.games.internal.zzc.zza(zzaVar.getExtras(), getExtras()) && Objects.equal(zzaVar.getId(), getId()) && Objects.equal(zzaVar.zzab(), zzab()) && Objects.equal(zzaVar.getType(), getType());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Annotation", zzy()).add("Conditions", zzz()).add("ContentDescription", zzaa()).add("Extras", getExtras()).add("Id", getId()).add("OverflowText", zzab()).add("Type", getType()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 1, zzz(), false);
        SafeParcelWriter.writeString(parcel, 2, this.zzfq, false);
        SafeParcelWriter.writeBundle(parcel, 3, this.extras, false);
        SafeParcelWriter.writeString(parcel, 6, this.type, false);
        SafeParcelWriter.writeString(parcel, 7, this.zzfr, false);
        SafeParcelWriter.writeParcelable(parcel, 8, this.zzfs, i, false);
        SafeParcelWriter.writeString(parcel, 9, this.zzft, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
