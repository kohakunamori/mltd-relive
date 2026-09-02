package com.google.android.gms.auth.api.credentials;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "CredentialPickerConfigCreator")
public final class CredentialPickerConfig extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<CredentialPickerConfig> CREATOR = new zze();

    @SafeParcelable.Field(getter = "shouldShowCancelButton", m22id = 2)
    private final boolean mShowCancelButton;

    @SafeParcelable.Field(m22id = 1000)
    private final int zzu;

    @SafeParcelable.Field(getter = "shouldShowAddAccountButton", m22id = 1)
    private final boolean zzv;

    @SafeParcelable.Field(getter = "isForNewAccount", m22id = 3)
    @Deprecated
    private final boolean zzw;

    @SafeParcelable.Field(getter = "getPromptInternalId", m22id = 4)
    private final int zzx;

    @Retention(RetentionPolicy.SOURCE)
    public @interface Prompt {
        public static final int CONTINUE = 1;
        public static final int SIGN_IN = 2;
        public static final int SIGN_UP = 3;
    }

    @SafeParcelable.Constructor
    CredentialPickerConfig(@SafeParcelable.Param(m23id = 1000) int i, @SafeParcelable.Param(m23id = 1) boolean z, @SafeParcelable.Param(m23id = 2) boolean z2, @SafeParcelable.Param(m23id = 3) boolean z3, @SafeParcelable.Param(m23id = 4) int i2) {
        this.zzu = i;
        this.zzv = z;
        this.mShowCancelButton = z2;
        if (i < 2) {
            this.zzw = z3;
            this.zzx = z3 ? 3 : 1;
        } else {
            this.zzw = i2 == 3;
            this.zzx = i2;
        }
    }

    public static class Builder {
        private boolean zzv = false;
        private boolean mShowCancelButton = true;
        private int zzy = 1;

        public Builder setShowAddAccountButton(boolean z) {
            this.zzv = z;
            return this;
        }

        public Builder setShowCancelButton(boolean z) {
            this.mShowCancelButton = z;
            return this;
        }

        public Builder setPrompt(int i) {
            this.zzy = i;
            return this;
        }

        @Deprecated
        public Builder setForNewAccount(boolean z) {
            this.zzy = z ? 3 : 1;
            return this;
        }

        public CredentialPickerConfig build() {
            return new CredentialPickerConfig(this);
        }
    }

    private CredentialPickerConfig(Builder builder) {
        this(2, builder.zzv, builder.mShowCancelButton, false, builder.zzy);
    }

    public final boolean shouldShowAddAccountButton() {
        return this.zzv;
    }

    public final boolean shouldShowCancelButton() {
        return this.mShowCancelButton;
    }

    @Deprecated
    public final boolean isForNewAccount() {
        return this.zzx == 3;
    }

    @Override // android.os.Parcelable
    public final void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeBoolean(parcel, 1, shouldShowAddAccountButton());
        SafeParcelWriter.writeBoolean(parcel, 2, shouldShowCancelButton());
        SafeParcelWriter.writeBoolean(parcel, 3, isForNewAccount());
        SafeParcelWriter.writeInt(parcel, 4, this.zzx);
        SafeParcelWriter.writeInt(parcel, 1000, this.zzu);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
