package com.google.android.gms.internal.drive;

import android.os.Parcel;
import android.os.Parcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelReader;
import com.google.android.gms.drive.events.ChangeEvent;
import com.google.android.gms.drive.events.CompletionEvent;

/* JADX INFO: loaded from: classes.dex */
public final class zzfk implements Parcelable.Creator<zzfj> {
    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzfj createFromParcel(Parcel parcel) {
        int iValidateObjectHeader = SafeParcelReader.validateObjectHeader(parcel);
        ChangeEvent changeEvent = null;
        CompletionEvent completionEvent = null;
        com.google.android.gms.drive.events.zzo zzoVar = null;
        com.google.android.gms.drive.events.zzb zzbVar = null;
        com.google.android.gms.drive.events.zzv zzvVar = null;
        com.google.android.gms.drive.events.zzr zzrVar = null;
        int i = 0;
        while (parcel.dataPosition() < iValidateObjectHeader) {
            int header = SafeParcelReader.readHeader(parcel);
            switch (SafeParcelReader.getFieldId(header)) {
                case 2:
                    i = SafeParcelReader.readInt(parcel, header);
                    break;
                case 3:
                    changeEvent = (ChangeEvent) SafeParcelReader.createParcelable(parcel, header, ChangeEvent.CREATOR);
                    break;
                case 4:
                case 8:
                default:
                    SafeParcelReader.skipUnknownField(parcel, header);
                    break;
                case 5:
                    completionEvent = (CompletionEvent) SafeParcelReader.createParcelable(parcel, header, CompletionEvent.CREATOR);
                    break;
                case 6:
                    zzoVar = (com.google.android.gms.drive.events.zzo) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzo.CREATOR);
                    break;
                case 7:
                    zzbVar = (com.google.android.gms.drive.events.zzb) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzb.CREATOR);
                    break;
                case 9:
                    zzvVar = (com.google.android.gms.drive.events.zzv) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzv.CREATOR);
                    break;
                case 10:
                    zzrVar = (com.google.android.gms.drive.events.zzr) SafeParcelReader.createParcelable(parcel, header, com.google.android.gms.drive.events.zzr.CREATOR);
                    break;
            }
        }
        SafeParcelReader.ensureAtEnd(parcel, iValidateObjectHeader);
        return new zzfj(i, changeEvent, completionEvent, zzoVar, zzbVar, zzvVar, zzrVar);
    }

    @Override // android.os.Parcelable.Creator
    public final /* synthetic */ zzfj[] newArray(int i) {
        return new zzfj[i];
    }
}
