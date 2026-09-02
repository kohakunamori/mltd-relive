package com.google.android.gms.nearby.connection;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzg implements Parcelable.Creator<DiscoveryOptions> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ DiscoveryOptions createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        boolean z = true;
        Strategy strategy = null;
        boolean z2 = false;
        boolean z3 = true;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strategy = (Strategy) SafeParcelReader.createParcelable(parcel, header, Strategy.CREATOR);
                    break;
                case 2:
                    z2 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 3:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 4:
                    z3 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new DiscoveryOptions(strategy, z2, z, z3);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ DiscoveryOptions[] newArray(int i) {
        return new DiscoveryOptions[i];
    }
}
