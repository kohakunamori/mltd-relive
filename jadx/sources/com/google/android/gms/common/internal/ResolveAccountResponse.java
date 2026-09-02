package com.google.android.gms.common.internal;

import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "ResolveAccountResponseCreator")
public class ResolveAccountResponse extends AbstractSafeParcelable {
    public static final Parcelable.Creator<ResolveAccountResponse> CREATOR = new zan();

    @SafeParcelable.Field(getter = "getConnectionResult", m22id = 3)
    private ConnectionResult zadi;

    @SafeParcelable.Field(getter = "getSaveDefaultAccount", m22id = 4)
    private boolean zagg;

    @SafeParcelable.VersionField(m24id = 1)
    private final int zalf;

    @SafeParcelable.Field(m22id = 2)
    private IBinder zanx;

    @SafeParcelable.Field(getter = "isFromCrossClientAuth", m22id = 5)
    private boolean zapc;

    @SafeParcelable.Constructor
    ResolveAccountResponse(@SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) IBinder iBinder, @SafeParcelable.Param(m23id = 3) ConnectionResult connectionResult, @SafeParcelable.Param(m23id = 4) boolean z, @SafeParcelable.Param(m23id = 5) boolean z2) {
        this.zalf = i;
        this.zanx = iBinder;
        this.zadi = connectionResult;
        this.zagg = z;
        this.zapc = z2;
    }

    public ResolveAccountResponse(ConnectionResult connectionResult) {
        this(1, null, connectionResult, false, false);
    }

    public ResolveAccountResponse(int i) {
        this(new ConnectionResult(i, null));
    }

    public IAccountAccessor getAccountAccessor() {
        return IAccountAccessor.Stub.asInterface(this.zanx);
    }

    public ResolveAccountResponse setAccountAccessor(IAccountAccessor iAccountAccessor) {
        this.zanx = iAccountAccessor == null ? null : iAccountAccessor.asBinder();
        return this;
    }

    public ConnectionResult getConnectionResult() {
        return this.zadi;
    }

    public boolean getSaveDefaultAccount() {
        return this.zagg;
    }

    public ResolveAccountResponse setSaveDefaultAccount(boolean z) {
        this.zagg = z;
        return this;
    }

    public boolean isFromCrossClientAuth() {
        return this.zapc;
    }

    public ResolveAccountResponse setIsFromCrossClientAuth(boolean z) {
        this.zapc = z;
        return this;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeInt(parcel, 1, this.zalf);
        SafeParcelWriter.writeIBinder(parcel, 2, this.zanx, false);
        SafeParcelWriter.writeParcelable(parcel, 3, getConnectionResult(), i, false);
        SafeParcelWriter.writeBoolean(parcel, 4, getSaveDefaultAccount());
        SafeParcelWriter.writeBoolean(parcel, 5, isFromCrossClientAuth());
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof ResolveAccountResponse)) {
            return false;
        }
        ResolveAccountResponse resolveAccountResponse = (ResolveAccountResponse) obj;
        return this.zadi.equals(resolveAccountResponse.zadi) && getAccountAccessor().equals(resolveAccountResponse.getAccountAccessor());
    }
}
