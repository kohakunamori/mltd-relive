package com.google.android.gms.nearby.messages.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.nearby.messages.Message;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "MessageWrapperCreator")
public final class zzaf extends AbstractSafeParcelable {
    public static final Parcelable.Creator<zzaf> CREATOR = new zzag();

    @SafeParcelable.VersionField(m24id = 1000)
    private final int versionCode;

    @SafeParcelable.Field(m22id = 1)
    private final Message zzhk;

    @SafeParcelable.Constructor
    zzaf(@SafeParcelable.Param(m23id = 1000) int i, @SafeParcelable.Param(m23id = 1) Message message) {
        this.versionCode = i;
        this.zzhk = (Message) Preconditions.checkNotNull(message);
    }

    public static final zzaf zza(Message message) {
        return new zzaf(1, message);
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj instanceof zzaf) {
            return Objects.equal(this.zzhk, ((zzaf) obj).zzhk);
        }
        return false;
    }

    public final int hashCode() {
        return Objects.hashCode(this.zzhk);
    }

    public final String toString() {
        String string = this.zzhk.toString();
        StringBuilder sb = new StringBuilder(String.valueOf(string).length() + 24);
        sb.append("MessageWrapper{message=");
        sb.append(string);
        sb.append("}");
        return sb.toString();
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeParcelable(parcel, 1, this.zzhk, i, false);
        SafeParcelWriter.writeInt(parcel, 1000, this.versionCode);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
