package com.google.android.gms.drive.query.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.drive.query.Filter;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "FilterHolderCreator")
@SafeParcelable.Reserved({1000})
public class FilterHolder extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<FilterHolder> CREATOR = new zzh();
    private final Filter zzba;

    @SafeParcelable.Field(m22id = 1)
    private final zzb<?> zzln;

    @SafeParcelable.Field(m22id = 2)
    private final zzd zzlo;

    @SafeParcelable.Field(m22id = 3)
    private final zzr zzlp;

    @SafeParcelable.Field(m22id = 4)
    private final zzv zzlq;

    @SafeParcelable.Field(m22id = 5)
    private final zzp<?> zzlr;

    @SafeParcelable.Field(m22id = 6)
    private final zzt zzls;

    @SafeParcelable.Field(m22id = 7)
    private final zzn zzlt;

    @SafeParcelable.Field(m22id = 8)
    private final zzl zzlu;

    @SafeParcelable.Field(m22id = 9)
    private final zzz zzlv;

    public FilterHolder(Filter filter) {
        Preconditions.checkNotNull(filter, "Null filter.");
        this.zzln = filter instanceof zzb ? (zzb) filter : null;
        this.zzlo = filter instanceof zzd ? (zzd) filter : null;
        this.zzlp = filter instanceof zzr ? (zzr) filter : null;
        this.zzlq = filter instanceof zzv ? (zzv) filter : null;
        this.zzlr = filter instanceof zzp ? (zzp) filter : null;
        this.zzls = filter instanceof zzt ? (zzt) filter : null;
        this.zzlt = filter instanceof zzn ? (zzn) filter : null;
        this.zzlu = filter instanceof zzl ? (zzl) filter : null;
        this.zzlv = filter instanceof zzz ? (zzz) filter : null;
        if (this.zzln == null && this.zzlo == null && this.zzlp == null && this.zzlq == null && this.zzlr == null && this.zzls == null && this.zzlt == null && this.zzlu == null && this.zzlv == null) {
            throw new IllegalArgumentException("Invalid filter type.");
        }
        this.zzba = filter;
    }

    @SafeParcelable.Constructor
    FilterHolder(@SafeParcelable.Param(m23id = 1) zzb<?> zzbVar, @SafeParcelable.Param(m23id = 2) zzd zzdVar, @SafeParcelable.Param(m23id = 3) zzr zzrVar, @SafeParcelable.Param(m23id = 4) zzv zzvVar, @SafeParcelable.Param(m23id = 5) zzp<?> zzpVar, @SafeParcelable.Param(m23id = 6) zzt zztVar, @SafeParcelable.Param(m23id = 7) zzn<?> zznVar, @SafeParcelable.Param(m23id = 8) zzl zzlVar, @SafeParcelable.Param(m23id = 9) zzz zzzVar) {
        Filter filter;
        this.zzln = zzbVar;
        this.zzlo = zzdVar;
        this.zzlp = zzrVar;
        this.zzlq = zzvVar;
        this.zzlr = zzpVar;
        this.zzls = zztVar;
        this.zzlt = zznVar;
        this.zzlu = zzlVar;
        this.zzlv = zzzVar;
        if (this.zzln != null) {
            filter = this.zzln;
        } else if (this.zzlo != null) {
            filter = this.zzlo;
        } else if (this.zzlp != null) {
            filter = this.zzlp;
        } else if (this.zzlq != null) {
            filter = this.zzlq;
        } else if (this.zzlr != null) {
            filter = this.zzlr;
        } else if (this.zzls != null) {
            filter = this.zzls;
        } else if (this.zzlt != null) {
            filter = this.zzlt;
        } else if (this.zzlu != null) {
            filter = this.zzlu;
        } else {
            if (this.zzlv == null) {
                throw new IllegalArgumentException("At least one filter must be set.");
            }
            filter = this.zzlv;
        }
        this.zzba = filter;
    }

    public final Filter getFilter() {
        return this.zzba;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzln, i, false);
        SafeParcelWriter.writeParcelable(parcel, 2, this.zzlo, i, false);
        SafeParcelWriter.writeParcelable(parcel, 3, this.zzlp, i, false);
        SafeParcelWriter.writeParcelable(parcel, 4, this.zzlq, i, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzlr, i, false);
        SafeParcelWriter.writeParcelable(parcel, 6, this.zzls, i, false);
        SafeParcelWriter.writeParcelable(parcel, 7, this.zzlt, i, false);
        SafeParcelWriter.writeParcelable(parcel, 8, this.zzlu, i, false);
        SafeParcelWriter.writeParcelable(parcel, 9, this.zzlv, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
