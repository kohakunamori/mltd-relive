package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.events.ChangeEvent;
import com.google.android.gms.drive.events.CompletionEvent;
import com.google.android.gms.drive.events.DriveEvent;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "OnEventResponseCreator")
@SafeParcelable.Reserved({1, 4, 8})
public final class zzfj extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzfj> CREATOR = new zzfk();

    @SafeParcelable.Field(m22id = 2)
    private final int zzcy;

    @SafeParcelable.Field(m22id = 3)
    private final ChangeEvent zzhl;

    @SafeParcelable.Field(m22id = 5)
    private final CompletionEvent zzhm;

    @SafeParcelable.Field(m22id = 6)
    private final com.google.android.gms.drive.events.zzo zzhn;

    @SafeParcelable.Field(m22id = 7)
    private final com.google.android.gms.drive.events.zzb zzho;

    @SafeParcelable.Field(m22id = 9)
    private final com.google.android.gms.drive.events.zzv zzhp;

    @SafeParcelable.Field(m22id = 10)
    private final com.google.android.gms.drive.events.zzr zzhq;

    @SafeParcelable.Constructor
    zzfj(@SafeParcelable.Param(m23id = 2) int i, @SafeParcelable.Param(m23id = 3) ChangeEvent changeEvent, @SafeParcelable.Param(m23id = 5) CompletionEvent completionEvent, @SafeParcelable.Param(m23id = 6) com.google.android.gms.drive.events.zzo zzoVar, @SafeParcelable.Param(m23id = 7) com.google.android.gms.drive.events.zzb zzbVar, @SafeParcelable.Param(m23id = 9) com.google.android.gms.drive.events.zzv zzvVar, @SafeParcelable.Param(m23id = 10) com.google.android.gms.drive.events.zzr zzrVar) {
        this.zzcy = i;
        this.zzhl = changeEvent;
        this.zzhm = completionEvent;
        this.zzhn = zzoVar;
        this.zzho = zzbVar;
        this.zzhp = zzvVar;
        this.zzhq = zzrVar;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 2, this.zzcy);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzhl, i, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzhm, i, false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzhn, i, false);
        SafeParcelWriter.writeParcelable(parcel, 7, this.zzho, i, false);
        SafeParcelWriter.writeParcelable(parcel, 9, this.zzhp, i, false);
        SafeParcelWriter.writeParcelable(parcel, 10, this.zzhq, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final DriveEvent zzak() {
        switch (this.zzcy) {
            case 1:
                return this.zzhl;
            case 2:
                return this.zzhm;
            case 3:
                return this.zzhn;
            case 4:
                return this.zzho;
            case 5:
            case 6:
            default:
                int i = this.zzcy;
                StringBuilder sb = new StringBuilder(33);
                sb.append("Unexpected event type ");
                sb.append(i);
                throw new IllegalStateException(sb.toString());
            case 7:
                return this.zzhp;
            case 8:
                return this.zzhq;
        }
    }
}
