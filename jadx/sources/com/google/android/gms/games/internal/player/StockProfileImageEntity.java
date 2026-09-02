package com.google.android.gms.games.internal.player;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "StockProfileImageEntityCreator")
@SafeParcelable.Reserved({1000})
public final class StockProfileImageEntity extends com.google.android.gms.games.internal.zzd implements StockProfileImage {
    public static final Parcelable.Creator<StockProfileImageEntity> CREATOR = new zzf();

    @SafeParcelable.Field(getter = "getImageUri", m22id = 2)
    private final Uri zzfu;

    @SafeParcelable.Field(getter = "getImageUrl", m22id = 1)
    private final String zznq;

    @SafeParcelable.Constructor
    public StockProfileImageEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) Uri uri) {
        this.zznq = str;
        this.zzfu = uri;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ StockProfileImage freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.internal.player.StockProfileImage
    public final String getImageUrl() {
        return this.zznq;
    }

    @Override // com.google.android.gms.games.internal.player.StockProfileImage
    public final Uri zzae() {
        return this.zzfu;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zznq, this.zzfu);
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof StockProfileImage)) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        StockProfileImage stockProfileImage = (StockProfileImage) obj;
        return Objects.equal(this.zznq, stockProfileImage.getImageUrl()) && Objects.equal(this.zzfu, stockProfileImage.zzae());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("ImageId", this.zznq).add("ImageUri", this.zzfu).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getImageUrl(), false);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzfu, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
