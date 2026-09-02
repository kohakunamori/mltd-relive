package com.google.android.gms.games.snapshot;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.apps.common.proguard.UsedByReflection;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@UsedByReflection("GamesClientImpl.java")
@SafeParcelable.Class(creator = "SnapshotEntityCreator")
@SafeParcelable.Reserved({1000})
public final class SnapshotEntity extends com.google.android.gms.games.internal.zzd implements Snapshot {
    public static final Parcelable.Creator<SnapshotEntity> CREATOR = new zzb();

    @SafeParcelable.Field(getter = "getMetadata", m22id = 1)
    private final SnapshotMetadataEntity zzrr;

    @SafeParcelable.Field(getter = "getSnapshotContents", m22id = 3)
    private final SnapshotContentsEntity zzrs;

    @SafeParcelable.Constructor
    public SnapshotEntity(@SafeParcelable.Param(m23id = 1) SnapshotMetadata snapshotMetadata, @SafeParcelable.Param(m23id = 3) SnapshotContentsEntity snapshotContentsEntity) {
        this.zzrr = new SnapshotMetadataEntity(snapshotMetadata);
        this.zzrs = snapshotContentsEntity;
    }

    /* JADX WARN: Can't rename method to resolve collision */
    @Override // com.google.android.gms.common.data.Freezable
    public final Snapshot freeze() {
        return this;
    }

    @Override // com.google.android.gms.common.data.Freezable
    public final boolean isDataValid() {
        return true;
    }

    @Override // com.google.android.gms.games.snapshot.Snapshot
    public final SnapshotMetadata getMetadata() {
        return this.zzrr;
    }

    @Override // com.google.android.gms.games.snapshot.Snapshot
    public final SnapshotContents getSnapshotContents() {
        if (this.zzrs.isClosed()) {
            return null;
        }
        return this.zzrs;
    }

    public final int hashCode() {
        return Objects.hashCode(getMetadata(), getSnapshotContents());
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof Snapshot)) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        Snapshot snapshot = (Snapshot) obj;
        return Objects.equal(snapshot.getMetadata(), getMetadata()) && Objects.equal(snapshot.getSnapshotContents(), getSnapshotContents());
    }

    public final String toString() {
        return Objects.toStringHelper(this).add("Metadata", getMetadata()).add("HasContents", Boolean.valueOf(getSnapshotContents() != null)).toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, getMetadata(), i, false);
        SafeParcelWriter.writeParcelable(parcel, 3, getSnapshotContents(), i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
