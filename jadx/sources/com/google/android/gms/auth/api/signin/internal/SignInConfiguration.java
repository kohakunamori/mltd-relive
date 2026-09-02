package com.google.android.gms.auth.api.signin.internal;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "SignInConfigurationCreator")
@SafeParcelable.Reserved({1})
public final class SignInConfiguration extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<SignInConfiguration> CREATOR = new zzx();

    @SafeParcelable.Field(getter = "getConsumerPkgName", m22id = 2)
    private final String zzbr;

    @SafeParcelable.Field(getter = "getGoogleConfig", m22id = 5)
    private GoogleSignInOptions zzbs;

    @SafeParcelable.Constructor
    public SignInConfiguration(@SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 5) GoogleSignInOptions googleSignInOptions) {
        this.zzbr = Preconditions.checkNotEmpty(str);
        this.zzbs = googleSignInOptions;
    }

    public final GoogleSignInOptions zzm() {
        return this.zzbs;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.zzbr, false);
        SafeParcelWriter.writeParcelable(parcel, 5, this.zzbs, i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public final boolean equals(Object obj) {
        if (!(obj instanceof SignInConfiguration)) {
            return false;
        }
        SignInConfiguration signInConfiguration = (SignInConfiguration) obj;
        if (this.zzbr.equals(signInConfiguration.zzbr)) {
            if (this.zzbs == null) {
                if (signInConfiguration.zzbs == null) {
                    return true;
                }
            } else if (this.zzbs.equals(signInConfiguration.zzbs)) {
                return true;
            }
        }
        return false;
    }

    public final int hashCode() {
        return new HashAccumulator().addObject(this.zzbr).addObject(this.zzbs).hash();
    }
}
