package com.google.android.gms.games.video;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzb implements Parcelable.Creator<VideoConfiguration> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ VideoConfiguration[] newArray(int i) {
        return new VideoConfiguration[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ VideoConfiguration createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        int i = 0;
        int i2 = 0;
        boolean z = false;
        boolean z2 = false;
        boolean z3 = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            switch (fieldId) {
                case 1:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 2:
                    i2 = SafeParcelReader.readInt(parcel, header);
                    break;
                default:
                    switch (fieldId) {
                        case 7:
                            z = SafeParcelReader.readBoolean(parcel, header);
                            break;
                        case 8:
                            z2 = SafeParcelReader.readBoolean(parcel, header);
                            break;
                        case 9:
                            z3 = SafeParcelReader.readBoolean(parcel, header);
                            break;
                        default:
                            SafeParcelReader.skipUnknownField(parcel, header);
                            break;
                    }
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new VideoConfiguration(i, i2, z, z2, z3);
    }
}
