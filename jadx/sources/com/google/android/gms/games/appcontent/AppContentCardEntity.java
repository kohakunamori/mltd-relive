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
@SafeParcelable.Class(creator = "AppContentCardEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AppContentCardEntity extends com.google.android.gms.games.internal.zzd implements zze {
    public static final Parcelable.Creator<AppContentCardEntity> CREATOR = new zzf();

    @SafeParcelable.Field(getter = "getDescription", m22id = 6)
    private final String description;

    @SafeParcelable.Field(getter = "getExtras", m22id = 7)
    private final Bundle extras;

    @SafeParcelable.Field(getter = "getType", m22id = 13)
    private final String type;

    @SafeParcelable.Field(getter = "getTitle", m22id = 11)
    private final String zzcd;

    @SafeParcelable.Field(getter = "getConditions", m22id = 3)
    private final ArrayList<AppContentConditionEntity> zzfp;

    @SafeParcelable.Field(getter = "getContentDescription", m22id = 4)
    private final String zzfq;

    @SafeParcelable.Field(getter = "getId", m22id = 14)
    private final String zzfr;

    @SafeParcelable.Field(getter = "getActions", m22id = 1)
    private final ArrayList<AppContentActionEntity> zzga;

    @SafeParcelable.Field(getter = "getAnnotations", m22id = 2)
    private final ArrayList<AppContentAnnotationEntity> zzgb;

    @SafeParcelable.Field(getter = "getCurrentProgress", m22id = 5)
    private final int zzgc;

    @SafeParcelable.Field(getter = "getSubtitle", m22id = 10)
    private final String zzgd;

    @SafeParcelable.Field(getter = "getTotalProgress", m22id = 12)
    private final int zzge;

    @SafeParcelable.Constructor
    AppContentCardEntity(@SafeParcelable.Param(m23id = 1) ArrayList<AppContentActionEntity> arrayList, @SafeParcelable.Param(m23id = 2) ArrayList<AppContentAnnotationEntity> arrayList2, @SafeParcelable.Param(m23id = 3) ArrayList<AppContentConditionEntity> arrayList3, @SafeParcelable.Param(m23id = 4) String str, @SafeParcelable.Param(m23id = 5) int i, @SafeParcelable.Param(m23id = 6) String str2, @SafeParcelable.Param(m23id = 7) Bundle bundle, @SafeParcelable.Param(m23id = 10) String str3, @SafeParcelable.Param(m23id = 11) String str4, @SafeParcelable.Param(m23id = 12) int i2, @SafeParcelable.Param(m23id = 13) String str5, @SafeParcelable.Param(m23id = 14) String str6) {
        this.zzga = arrayList;
        this.zzgb = arrayList2;
        this.zzfp = arrayList3;
        this.zzfq = str;
        this.zzgc = i;
        this.description = str2;
        this.extras = bundle;
        this.zzfr = str6;
        this.zzgd = str3;
        this.zzcd = str4;
        this.zzge = i2;
        this.type = str5;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zze freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final List<zza> getActions() {
        return new ArrayList(this.zzga);
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final List<zzc> zzai() {
        return new ArrayList(this.zzgb);
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final List<zzg> zzz() {
        return new ArrayList(this.zzfp);
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final String zzaa() {
        return this.zzfq;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final int zzaj() {
        return this.zzgc;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final Bundle getExtras() {
        return this.extras;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final String getId() {
        return this.zzfr;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final String zzak() {
        return this.zzgd;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final String getTitle() {
        return this.zzcd;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final int zzal() {
        return this.zzge;
    }

    @Override // com.google.android.gms.games.appcontent.zze
    public final String getType() {
        return this.type;
    }

    public final int hashCode() {
        return Objects.hashCode(getActions(), zzai(), zzz(), zzaa(), Integer.valueOf(zzaj()), getDescription(), Integer.valueOf(com.google.android.gms.games.internal.zzc.zza(getExtras())), getId(), zzak(), getTitle(), Integer.valueOf(zzal()), getType());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zze)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        zze zzeVar = (zze) obj;
        return Objects.equal(zzeVar.getActions(), getActions()) && Objects.equal(zzeVar.zzai(), zzai()) && Objects.equal(zzeVar.zzz(), zzz()) && Objects.equal(zzeVar.zzaa(), zzaa()) && Objects.equal(Integer.valueOf(zzeVar.zzaj()), Integer.valueOf(zzaj())) && Objects.equal(zzeVar.getDescription(), getDescription()) && com.google.android.gms.games.internal.zzc.zza(zzeVar.getExtras(), getExtras()) && Objects.equal(zzeVar.getId(), getId()) && Objects.equal(zzeVar.zzak(), zzak()) && Objects.equal(zzeVar.getTitle(), getTitle()) && Objects.equal(Integer.valueOf(zzeVar.zzal()), Integer.valueOf(zzal())) && Objects.equal(zzeVar.getType(), getType());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Actions", getActions()).add("Annotations", zzai()).add("Conditions", zzz()).add("ContentDescription", zzaa()).add("CurrentSteps", Integer.valueOf(zzaj())).add("Description", getDescription()).add("Extras", getExtras()).add("Id", getId()).add("Subtitle", zzak()).add("Title", getTitle()).add("TotalSteps", Integer.valueOf(zzal())).add("Type", getType()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 1, getActions(), false);
        SafeParcelWriter.writeTypedList(parcel, 2, zzai(), false);
        SafeParcelWriter.writeTypedList(parcel, 3, zzz(), false);
        SafeParcelWriter.writeString(parcel, 4, this.zzfq, false);
        SafeParcelWriter.writeInt(parcel, 5, this.zzgc);
        SafeParcelWriter.writeString(parcel, 6, this.description, false);
        SafeParcelWriter.writeBundle(parcel, 7, this.extras, false);
        SafeParcelWriter.writeString(parcel, 10, this.zzgd, false);
        SafeParcelWriter.writeString(parcel, 11, this.zzcd, false);
        SafeParcelWriter.writeInt(parcel, 12, this.zzge);
        SafeParcelWriter.writeString(parcel, 13, this.type, false);
        SafeParcelWriter.writeString(parcel, 14, this.zzfr, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
