package com.google.android.gms.games.appcontent;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzj implements Parcelable.Creator<AppContentSectionEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentSectionEntity[] newArray(int i) {
        return new AppContentSectionEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentSectionEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        ArrayList arrayListCreateTypedList = null;
        ArrayList arrayListCreateTypedList2 = null;
        String strCreateString = null;
        Bundle bundleCreateBundle = null;
        String strCreateString2 = null;
        String strCreateString3 = null;
        String strCreateString4 = null;
        String strCreateString5 = null;
        String strCreateString6 = null;
        ArrayList arrayListCreateTypedList3 = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            int fieldId = SafeParcelReader.getFieldId(header);
            if (fieldId == 1) {
                arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, AppContentActionEntity.CREATOR);
            } else if (fieldId != 14) {
                switch (fieldId) {
                    case 3:
                        arrayListCreateTypedList2 = SafeParcelReader.createTypedList(parcel, header, AppContentCardEntity.CREATOR);
                        break;
                    case 4:
                        strCreateString = SafeParcelReader.createString(parcel, header);
                        break;
                    case 5:
                        bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                        break;
                    case 6:
                        strCreateString2 = SafeParcelReader.createString(parcel, header);
                        break;
                    case 7:
                        strCreateString3 = SafeParcelReader.createString(parcel, header);
                        break;
                    case 8:
                        strCreateString4 = SafeParcelReader.createString(parcel, header);
                        break;
                    case 9:
                        strCreateString5 = SafeParcelReader.createString(parcel, header);
                        break;
                    case 10:
                        strCreateString6 = SafeParcelReader.createString(parcel, header);
                        break;
                    default:
                        SafeParcelReader.skipUnknownField(parcel, header);
                        break;
                }
            } else {
                arrayListCreateTypedList3 = SafeParcelReader.createTypedList(parcel, header, AppContentAnnotationEntity.CREATOR);
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new AppContentSectionEntity(arrayListCreateTypedList, arrayListCreateTypedList2, strCreateString, bundleCreateBundle, strCreateString2, strCreateString3, strCreateString4, strCreateString5, strCreateString6, arrayListCreateTypedList3);
    }
}
