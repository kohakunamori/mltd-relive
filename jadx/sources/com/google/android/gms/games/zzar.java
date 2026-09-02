package com.google.android.gms.games;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzar implements Parcelable.Creator<PlayerLevelInfo> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ PlayerLevelInfo[] newArray(int i) {
        return new PlayerLevelInfo[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ PlayerLevelInfo createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        PlayerLevel playerLevel = null;
        PlayerLevel playerLevel2 = null;
        long j = 0;
        long j2 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    j = SafeParcelReader.readLong(parcel, header);
                    break;
                case 2:
                    j2 = SafeParcelReader.readLong(parcel, header);
                    break;
                case 3:
                    playerLevel = (PlayerLevel) SafeParcelReader.createParcelable(parcel, header, PlayerLevel.CREATOR);
                    break;
                case 4:
                    playerLevel2 = (PlayerLevel) SafeParcelReader.createParcelable(parcel, header, PlayerLevel.CREATOR);
                    break;
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new PlayerLevelInfo(j, j2, playerLevel, playerLevel2);
    }
}
