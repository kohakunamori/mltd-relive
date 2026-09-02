package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.drive.DriveId;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "RemoveEventListenerRequestCreator")
@SafeParcelable.Reserved({1})
public final class zzgm extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzgm> CREATOR = new zzgn();

    @SafeParcelable.Field(m22id = 3)
    private final int zzcy;

    @Nullable
    @SafeParcelable.Field(m22id = 4)
    private final com.google.android.gms.drive.events.zzt zzda;

    @SafeParcelable.Field(m22id = 2)
    private final DriveId zzk;

    @VisibleForTesting
    public zzgm(@Nullable DriveId driveId, int i) {
        this(driveId, i, null);
    }

    @SafeParcelable.Constructor
    zzgm(@SafeParcelable.Param(m23id = 2) DriveId driveId, @SafeParcelable.Param(m23id = 3) int i, @SafeParcelable.Param(m23id = 4) com.google.android.gms.drive.events.zzt zztVar) {
        this.zzk = driveId;
        this.zzcy = i;
        this.zzda = zztVar;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzk, i, false);
        SafeParcelWriter.writeInt(parcel, 3, this.zzcy);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzda, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
