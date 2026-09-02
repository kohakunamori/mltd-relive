package com.google.android.gms.games.internal.player;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zze implements Parcelable.Creator<ProfileSettingsEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ ProfileSettingsEntity[] newArray(int i) {
        return new ProfileSettingsEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ ProfileSettingsEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        Status status = null;
        String strCreateString = null;
        StockProfileImageEntity stockProfileImageEntity = null;
        boolean z = false;
        boolean z2 = false;
        boolean z3 = false;
        boolean z4 = false;
        boolean z5 = false;
        int i = 0;
        boolean z6 = false;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    status = (Status) SafeParcelReader.createParcelable(parcel, header, Status.CREATOR);
                    break;
                case 2:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    z = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 4:
                    z2 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 5:
                    z3 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 6:
                    stockProfileImageEntity = (StockProfileImageEntity) SafeParcelReader.createParcelable(parcel, header, StockProfileImageEntity.CREATOR);
                    break;
                case 7:
                    z4 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 8:
                    z5 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                case 9:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 10:
                    z6 = SafeParcelReader.readBoolean(parcel, header);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new ProfileSettingsEntity(status, strCreateString, z, z2, z3, stockProfileImageEntity, z4, z5, i, z6);
    }
}
