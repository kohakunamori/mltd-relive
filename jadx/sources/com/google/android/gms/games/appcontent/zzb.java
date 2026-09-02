package com.google.android.gms.games.appcontent;

import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public final class zzb implements Parcelable.Creator<AppContentActionEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentActionEntity[] newArray(int i) {
        return new AppContentActionEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentActionEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        ArrayList arrayListCreateTypedList = null;
        String strCreateString = null;
        Bundle bundleCreateBundle = null;
        String strCreateString2 = null;
        String strCreateString3 = null;
        AppContentAnnotationEntity appContentAnnotationEntity = null;
        String strCreateString4 = null;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    arrayListCreateTypedList = SafeParcelReader.createTypedList(parcel, header, AppContentConditionEntity.CREATOR);
                    break;
                case 2:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 3:
                    bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                    break;
                case 4:
                case 5:
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
                case 6:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 7:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 8:
                    appContentAnnotationEntity = (AppContentAnnotationEntity) SafeParcelReader.createParcelable(parcel, header, AppContentAnnotationEntity.CREATOR);
                    break;
                case 9:
                    strCreateString4 = SafeParcelReader.createString(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new AppContentActionEntity(arrayListCreateTypedList, strCreateString, bundleCreateBundle, strCreateString2, strCreateString3, appContentAnnotationEntity, strCreateString4);
    }
}
