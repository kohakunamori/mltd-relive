package com.google.android.gms.games.appcontent;

import android.net.Uri;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;

/* JADX INFO: loaded from: classes.dex */
public final class zzd implements Parcelable.Creator<AppContentAnnotationEntity> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentAnnotationEntity[] newArray(int i) {
        return new AppContentAnnotationEntity[i];
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ AppContentAnnotationEntity createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        String strCreateString = null;
        Uri uri = null;
        String strCreateString2 = null;
        String strCreateString3 = null;
        String strCreateString4 = null;
        String strCreateString5 = null;
        Bundle bundleCreateBundle = null;
        int i = 0;
        int i2 = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 1:
                    strCreateString = SafeParcelReader.createString(parcel, header);
                    break;
                case 2:
                    uri = (Uri) SafeParcelReader.createParcelable(parcel, header, Uri.CREATOR);
                    break;
                case 3:
                    strCreateString2 = SafeParcelReader.createString(parcel, header);
                    break;
                case 4:
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
                case 5:
                    strCreateString3 = SafeParcelReader.createString(parcel, header);
                    break;
                case 6:
                    strCreateString4 = SafeParcelReader.createString(parcel, header);
                    break;
                case 7:
                    strCreateString5 = SafeParcelReader.createString(parcel, header);
                    break;
                case 8:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 9:
                    i2 = SafeParcelReader.readInt(parcel, header);
                    break;
                case 10:
                    bundleCreateBundle = SafeParcelReader.createBundle(parcel, header);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new AppContentAnnotationEntity(strCreateString, uri, strCreateString2, strCreateString3, strCreateString4, strCreateString5, i, i2, bundleCreateBundle);
    }
}
