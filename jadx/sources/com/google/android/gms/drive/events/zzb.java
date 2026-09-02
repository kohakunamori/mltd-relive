package com.google.android.gms.drive.events;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "ChangesAvailableEventCreator")
@SafeParcelable.Reserved({1, 2})
public final class zzb extends AbstractSafeParcelable implements DriveEvent {
    public static final Parcelable.Creator<zzb> CREATOR = new zzc();

    @SafeParcelable.Field(m22id = 3)
    private final zze zzbt;

    @SafeParcelable.Constructor
    public zzb(@SafeParcelable.Param(m23id = 3) zze zzeVar) {
        this.zzbt = zzeVar;
    }

    public final boolean equals(Object obj) {
        if (obj == null || obj.getClass() != getClass()) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        return Objects.equal(this.zzbt, ((zzb) obj).zzbt);
    }

    @Override // com.google.android.gms.drive.events.DriveEvent
    public final int getType() {
        return 4;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzbt);
    }

    public final String toString() {
        return String.format(Locale.US, "ChangesAvailableEvent [changesAvailableOptions=%s]", this.zzbt);
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzbt, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
