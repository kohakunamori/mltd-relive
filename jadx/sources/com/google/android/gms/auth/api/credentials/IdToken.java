package com.google.android.gms.auth.api.credentials;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import androidx.annotation.NonNull;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "IdTokenCreator")
@SafeParcelable.Reserved({1000})
public final class IdToken extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<IdToken> CREATOR = new zzk();

    @NonNull
    @SafeParcelable.Field(getter = "getIdToken", m22id = 2)
    private final String zzak;

    @NonNull
    @SafeParcelable.Field(getter = "getAccountType", m22id = 1)
    private final String zzr;

    @SafeParcelable.Constructor
    public IdToken(@NonNull @SafeParcelable.Param(m23id = 1) String str, @NonNull @SafeParcelable.Param(m23id = 2) String str2) {
        Preconditions.checkArgument(!TextUtils.isEmpty(str), "account type string cannot be null or empty");
        Preconditions.checkArgument(!TextUtils.isEmpty(str2), "id token string cannot be null or empty");
        this.zzr = str;
        this.zzak = str2;
    }

    @NonNull
    public final String getAccountType() {
        return this.zzr;
    }

    @NonNull
    public final String getIdToken() {
        return this.zzak;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 1, getAccountType(), false);
        SafeParcelWriter.writeString(parcel, 2, getIdToken(), false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof IdToken)) {
            return false;
        }
        IdToken idToken = (IdToken) obj;
        return Objects.equal(this.zzr, idToken.zzr) && Objects.equal(this.zzak, idToken.zzak);
    }
}
