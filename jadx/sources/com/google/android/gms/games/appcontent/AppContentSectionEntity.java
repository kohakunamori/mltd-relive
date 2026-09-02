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
@SafeParcelable.Class(creator = "AppContentSectionEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AppContentSectionEntity extends com.google.android.gms.games.internal.zzd implements zzi {
    public static final Parcelable.Creator<AppContentSectionEntity> CREATOR = new zzj();

    @SafeParcelable.Field(getter = "getExtras", m22id = 5)
    private final Bundle extras;

    @SafeParcelable.Field(getter = "getType", m22id = 8)
    private final String type;

    @SafeParcelable.Field(getter = "getTitle", m22id = 7)
    private final String zzcd;

    @SafeParcelable.Field(getter = "getContentDescription", m22id = 4)
    private final String zzfq;

    @SafeParcelable.Field(getter = "getId", m22id = 9)
    private final String zzfr;

    @SafeParcelable.Field(getter = "getActions", m22id = 1)
    private final ArrayList<AppContentActionEntity> zzga;

    @SafeParcelable.Field(getter = "getAnnotations", m22id = 14)
    private final ArrayList<AppContentAnnotationEntity> zzgb;

    @SafeParcelable.Field(getter = "getSubtitle", m22id = 6)
    private final String zzgd;

    @SafeParcelable.Field(getter = "getCards", m22id = 3)
    private final ArrayList<AppContentCardEntity> zzgj;

    @SafeParcelable.Field(getter = "getCardType", m22id = 10)
    private final String zzgk;

    @SafeParcelable.Constructor
    AppContentSectionEntity(@SafeParcelable.Param(m23id = 1) ArrayList<AppContentActionEntity> arrayList, @SafeParcelable.Param(m23id = 3) ArrayList<AppContentCardEntity> arrayList2, @SafeParcelable.Param(m23id = 4) String str, @SafeParcelable.Param(m23id = 5) Bundle bundle, @SafeParcelable.Param(m23id = 6) String str2, @SafeParcelable.Param(m23id = 7) String str3, @SafeParcelable.Param(m23id = 8) String str4, @SafeParcelable.Param(m23id = 9) String str5, @SafeParcelable.Param(m23id = 10) String str6, @SafeParcelable.Param(m23id = 14) ArrayList<AppContentAnnotationEntity> arrayList3) {
        this.zzga = arrayList;
        this.zzgb = arrayList3;
        this.zzgj = arrayList2;
        this.zzgk = str6;
        this.zzfq = str;
        this.extras = bundle;
        this.zzfr = str5;
        this.zzgd = str2;
        this.zzcd = str3;
        this.type = str4;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zzi freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final List<zza> getActions() {
        return new ArrayList(this.zzga);
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final List<zzc> zzai() {
        return new ArrayList(this.zzgb);
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final List<zze> zzaq() {
        return new ArrayList(this.zzgj);
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final String zzar() {
        return this.zzgk;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final String zzaa() {
        return this.zzfq;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final Bundle getExtras() {
        return this.extras;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final String zzak() {
        return this.zzgd;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final String getId() {
        return this.zzfr;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final String getTitle() {
        return this.zzcd;
    }

    @Override // com.google.android.gms.games.appcontent.zzi
    public final String getType() {
        return this.type;
    }

    public final int hashCode() {
        return Objects.hashCode(getActions(), zzai(), zzaq(), zzar(), zzaa(), Integer.valueOf(com.google.android.gms.games.internal.zzc.zza(getExtras())), getId(), zzak(), getTitle(), getType());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zzi)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        zzi zziVar = (zzi) obj;
        return Objects.equal(zziVar.getActions(), getActions()) && Objects.equal(zziVar.zzai(), zzai()) && Objects.equal(zziVar.zzaq(), zzaq()) && Objects.equal(zziVar.zzar(), zzar()) && Objects.equal(zziVar.zzaa(), zzaa()) && com.google.android.gms.games.internal.zzc.zza(zziVar.getExtras(), getExtras()) && Objects.equal(zziVar.getId(), getId()) && Objects.equal(zziVar.zzak(), zzak()) && Objects.equal(zziVar.getTitle(), getTitle()) && Objects.equal(zziVar.getType(), getType());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Actions", getActions()).add("Annotations", zzai()).add("Cards", zzaq()).add("CardType", zzar()).add("ContentDescription", zzaa()).add("Extras", getExtras()).add("Id", getId()).add("Subtitle", zzak()).add("Title", getTitle()).add("Type", getType()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeTypedList(parcel, 1, getActions(), false);
        SafeParcelWriter.writeTypedList(parcel, 3, zzaq(), false);
        SafeParcelWriter.writeString(parcel, 4, this.zzfq, false);
        SafeParcelWriter.writeBundle(parcel, 5, this.extras, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzgd, false);
        SafeParcelWriter.writeString(parcel, 7, this.zzcd, false);
        SafeParcelWriter.writeString(parcel, 8, this.type, false);
        SafeParcelWriter.writeString(parcel, 9, this.zzfr, false);
        SafeParcelWriter.writeString(parcel, 10, this.zzgk, false);
        SafeParcelWriter.writeTypedList(parcel, 14, zzai(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
