package com.google.android.gms.games.snapshot;

import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.data.BitmapTeleporter;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "SnapshotMetadataChangeCreator")
@SafeParcelable.Reserved({1000})
public final class SnapshotMetadataChangeEntity extends com.google.android.gms.games.internal.zzd implements SnapshotMetadataChange {
    public static final Parcelable.Creator<SnapshotMetadataChangeEntity> CREATOR = new zzc();

    @SafeParcelable.Field(getter = "getDescription", m22id = 1)
    private final String description;

    @SafeParcelable.Field(getter = "getProgressValue", m22id = 6)
    private final Long zzru;

    @SafeParcelable.Field(getter = "getCoverImageUri", m22id = 4)
    private final Uri zzrw;

    @SafeParcelable.Field(getter = "getPlayedTimeMillis", m22id = 2)
    private final Long zzrx;

    @SafeParcelable.Field(getter = "getCoverImageTeleporter", m22id = 5)
    private BitmapTeleporter zzry;

    SnapshotMetadataChangeEntity() {
        this(null, null, null, null, null);
    }

    @SafeParcelable.Constructor
    SnapshotMetadataChangeEntity(@SafeParcelable.Param(m23id = 1) String str, @SafeParcelable.Param(m23id = 2) Long l, @SafeParcelable.Param(m23id = 5) BitmapTeleporter bitmapTeleporter, @SafeParcelable.Param(m23id = 4) Uri uri, @SafeParcelable.Param(m23id = 6) Long l2) {
        this.description = str;
        this.zzrx = l;
        this.zzry = bitmapTeleporter;
        this.zzrw = uri;
        this.zzru = l2;
        if (this.zzry != null) {
            Preconditions.checkState(this.zzrw == null, "Cannot set both a URI and an image");
        } else if (this.zzrw != null) {
            Preconditions.checkState(this.zzry == null, "Cannot set both a URI and an image");
        }
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadataChange
    public final String getDescription() {
        return this.description;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadataChange
    public final Long getPlayedTimeMillis() {
        return this.zzrx;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadataChange
    public final Long getProgressValue() {
        return this.zzru;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadataChange
    public final BitmapTeleporter zzdt() {
        return this.zzry;
    }

    @Override // com.google.android.gms.games.snapshot.SnapshotMetadataChange
    public final Bitmap getCoverImage() {
        if (this.zzry == null) {
            return null;
        }
        return this.zzry.get();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getDescription(), false);
        SafeParcelWriter.writeLongObject(parcel, 2, getPlayedTimeMillis(), false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzrw, i, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzry, i, false);
        SafeParcelWriter.writeLongObject(parcel, 6, getProgressValue(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
