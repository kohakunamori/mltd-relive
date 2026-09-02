package com.google.android.gms.games.internal.game;

import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.data.Freezable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.games.internal.zzd;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "ScreenshotEntityCreator")
@SafeParcelable.Reserved({1000})
public final class ScreenshotEntity extends zzd implements Parcelable, Freezable {
    public static final Parcelable.Creator<ScreenshotEntity> CREATOR = new zzc();

    @SafeParcelable.Field(getter = "getHeight", m22id = 3)
    private final int height;

    @SafeParcelable.Field(getter = "getUri", m22id = 1)
    private final Uri uri;

    @SafeParcelable.Field(getter = "getWidth", m22id = 2)
    private final int width;

    @SafeParcelable.Constructor
    public ScreenshotEntity(@SafeParcelable.Param(m23id = 1) Uri uri, @SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) int i2) {
        this.uri = uri;
        this.width = i;
        this.height = i2;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final /* bridge */ /* synthetic */ Object freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    public final int hashCode() {
        return Objects.hashCode(this.uri, Integer.valueOf(this.width), Integer.valueOf(this.height));
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof ScreenshotEntity)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        ScreenshotEntity screenshotEntity = (ScreenshotEntity) obj;
        return Objects.equal(screenshotEntity.uri, this.uri) && Objects.equal(Integer.valueOf(screenshotEntity.width), Integer.valueOf(this.width)) && Objects.equal(Integer.valueOf(screenshotEntity.height), Integer.valueOf(this.height));
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Uri", this.uri).add("Width", Integer.valueOf(this.width)).add("Height", Integer.valueOf(this.height)).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.uri, i, false);
        SafeParcelWriter.writeInt(parcel, 2, this.width);
        SafeParcelWriter.writeInt(parcel, 3, this.height);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
