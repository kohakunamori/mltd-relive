package com.google.android.gms.games.appcontent;

import android.net.Uri;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "AppContentAnnotationEntityCreator")
@SafeParcelable.Reserved({1000})
public final class AppContentAnnotationEntity extends com.google.android.gms.games.internal.zzd implements zzc {
    public static final Parcelable.Creator<AppContentAnnotationEntity> CREATOR = new zzd();

    @SafeParcelable.Field(getter = "getDescription", m22id = 1)
    private final String description;

    @SafeParcelable.Field(getter = "getTitle", m22id = 3)
    private final String zzcd;

    @SafeParcelable.Field(getter = "getId", m22id = 5)
    private final String zzfr;

    @SafeParcelable.Field(getter = "getImageUri", m22id = 2)
    private final Uri zzfu;

    @SafeParcelable.Field(getter = "getLayoutSlot", m22id = 6)
    private final String zzfv;

    @SafeParcelable.Field(getter = "getImageDefaultId", m22id = 7)
    private final String zzfw;

    @SafeParcelable.Field(getter = "getImageHeight", m22id = 8)
    private final int zzfx;

    @SafeParcelable.Field(getter = "getImageWidth", m22id = 9)
    private final int zzfy;

    @SafeParcelable.Field(getter = "getModifiers", m22id = 10)
    private final Bundle zzfz;

    @SafeParcelable.Constructor
    AppContentAnnotationEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) Uri uri, @SafeParcelable.Param(m23id = 3) String str2, @SafeParcelable.Param(m23id = 5) String str3, @SafeParcelable.Param(m23id = 6) String str4, @SafeParcelable.Param(m23id = 7) String str5, @SafeParcelable.Param(m23id = 8) int i, @SafeParcelable.Param(m23id = 9) int i2, @SafeParcelable.Param(m23id = 10) Bundle bundle) {
        this.description = str;
        this.zzfr = str3;
        this.zzfw = str5;
        this.zzfx = i;
        this.zzfu = uri;
        this.zzfy = i2;
        this.zzfv = str4;
        this.zzfz = bundle;
        this.zzcd = str2;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ zzc freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final String getId() {
        return this.zzfr;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final String zzac() {
        return this.zzfw;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final int zzad() {
        return this.zzfx;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final Uri zzae() {
        return this.zzfu;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final int zzag() {
        return this.zzfy;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final String zzah() {
        return this.zzfv;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final Bundle zzaf() {
        return this.zzfz;
    }

    @Override // com.google.android.gms.games.appcontent.zzc
    public final String getTitle() {
        return this.zzcd;
    }

    public final int hashCode() {
        return Objects.hashCode(getDescription(), getId(), zzac(), Integer.valueOf(zzad()), zzae(), Integer.valueOf(zzag()), zzah(), Integer.valueOf(com.google.android.gms.games.internal.zzc.zza(zzaf())), getTitle());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof zzc)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        zzc zzcVar = (zzc) obj;
        return Objects.equal(zzcVar.getDescription(), getDescription()) && Objects.equal(zzcVar.getId(), getId()) && Objects.equal(zzcVar.zzac(), zzac()) && Objects.equal(Integer.valueOf(zzcVar.zzad()), Integer.valueOf(zzad())) && Objects.equal(zzcVar.zzae(), zzae()) && Objects.equal(Integer.valueOf(zzcVar.zzag()), Integer.valueOf(zzag())) && Objects.equal(zzcVar.zzah(), zzah()) && com.google.android.gms.games.internal.zzc.zza(zzcVar.zzaf(), zzaf()) && Objects.equal(zzcVar.getTitle(), getTitle());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Description", getDescription()).add("Id", getId()).add("ImageDefaultId", zzac()).add("ImageHeight", Integer.valueOf(zzad())).add("ImageUri", zzae()).add("ImageWidth", Integer.valueOf(zzag())).add("LayoutSlot", zzah()).add("Modifiers", zzaf()).add("Title", getTitle()).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, this.description, false);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzfu, i, false);
        SafeParcelWriter.writeString(parcel, 3, this.zzcd, false);
        SafeParcelWriter.writeString(parcel, 5, this.zzfr, false);
        SafeParcelWriter.writeString(parcel, 6, this.zzfv, false);
        SafeParcelWriter.writeString(parcel, 7, this.zzfw, false);
        SafeParcelWriter.writeInt(parcel, 8, this.zzfx);
        SafeParcelWriter.writeInt(parcel, 9, this.zzfy);
        SafeParcelWriter.writeBundle(parcel, 10, this.zzfz, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
