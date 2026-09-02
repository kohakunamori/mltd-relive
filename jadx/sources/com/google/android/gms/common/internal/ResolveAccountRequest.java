package com.google.android.gms.common.internal;

import android.accounts.Account;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "ResolveAccountRequestCreator")
public class ResolveAccountRequest extends AbstractSafeParcelable {
    public static final Parcelable.Creator<ResolveAccountRequest> CREATOR = new zam();

    @SafeParcelable.VersionField(m24id = 1)
    private final int zalf;

    @SafeParcelable.Field(getter = "getSessionId", m22id = 3)
    private final int zapa;

    @SafeParcelable.Field(getter = "getSignInAccountHint", m22id = 4)
    private final GoogleSignInAccount zapb;

    @SafeParcelable.Field(getter = "getAccount", m22id = 2)
    private final Account zax;

    @SafeParcelable.Constructor
    ResolveAccountRequest(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) Account account, @SafeParcelable.Param(m23id = 3) int i2, @SafeParcelable.Param(m23id = 4) GoogleSignInAccount googleSignInAccount) {
        this.zalf = i;
        this.zax = account;
        this.zapa = i2;
        this.zapb = googleSignInAccount;
    }

    public ResolveAccountRequest(Account account, int i, GoogleSignInAccount googleSignInAccount) {
        this(2, account, i, googleSignInAccount);
    }

    public Account getAccount() {
        return this.zax;
    }

    public int getSessionId() {
        return this.zapa;
    }

    @Nullable
    public GoogleSignInAccount getSignInAccountHint() {
        return this.zapb;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zalf);
        SafeParcelWriter.writeParcelable(parcel, 2, getAccount(), i, false);
        SafeParcelWriter.writeInt(parcel, 3, getSessionId());
        SafeParcelWriter.writeParcelable(parcel, 4, getSignInAccountHint(), i, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
