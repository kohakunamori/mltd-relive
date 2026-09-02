package com.google.android.gms.games.appcontent;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzf implements Parcelable.Creator<AppContentCardEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentCardEntity[] newArray(int i) {
        return new AppContentCardEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentCardEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        ArrayList arrayListCreateTypedList = null;
        ArrayList arrayListCreateTypedList2 = null;
        ArrayList arrayListCreateTypedList3 = null;
        String strCreateString = null;
        String strCreateString2 = null;
        Bundle bundleCreateBundle = null;
        String strCreateString3 = null;
        String strCreateString4 = null;
        String strCreateString5 = null;
        String strCreateString6 = null;
        int i = 0;
        int i2 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, AppContentActionEntity.CREATOR);
                    break;
                case 2:
                    arrayListCreateTypedList2 = SafeParcelReader.createTypedList(parcel, header, AppContentAnnotationEntity.CREATOR);
                    break;
                case 3:
                    arrayListCreateTypedList3 = SafeParcelReader.createTypedList(parcel, header, AppContentConditionEntity.CREATOR);
                    break;
                case 4:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 5:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 6:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 7:
                    bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                    break;
                case 8:
                case 9:
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
                case 10:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 11:
                    strCreateString4 = SafeParcelReader.createString(parcel, header);
                    break;
                case 12:
                    i2 = SafeParcelReader.readInt(parcel, header);
                    break;
                case 13:
                    strCreateString5 = SafeParcelReader.createString(parcel, header);
                    break;
                case 14:
                    strCreateString6 = SafeParcelReader.createString(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new AppContentCardEntity(arrayListCreateTypedList, arrayListCreateTypedList2, arrayListCreateTypedList3, strCreateString, i, strCreateString2, bundleCreateBundle, strCreateString3, strCreateString4, i2, strCreateString5, strCreateString6);
    }
}
