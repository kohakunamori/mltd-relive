package com.google.android.gms.auth.api.accounttransfer;

import android.app.PendingIntent;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.collection.ArraySet;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.server.response.FastJsonResponse;
import com.google.android.gms.internal.auth.zzaz;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "AuthenticatorTransferInfoCreator")
public class zzt extends zzaz {
    public static final Parcelable.Creator<zzt> CREATOR = new zzu();
    private static final HashMap<String, FastJsonResponse.Field<?, ?>> zzaz;

    @SafeParcelable.Indicator
    private final Set<Integer> zzba;

    @SafeParcelable.Field(getter = "getAccountType", m22id = 2)
    private String zzbn;

    @SafeParcelable.Field(getter = "getStatus", m22id = 3)
    private int zzbo;

    @SafeParcelable.Field(getter = "getTransferBytes", m22id = 4)
    private byte[] zzbp;

    @SafeParcelable.Field(getter = "getPendingIntent", m22id = 5)
    private PendingIntent zzbq;

    @SafeParcelable.Field(getter = "getDeviceMetaData", m22id = 6)
    private DeviceMetaData zzbr;

    @SafeParcelable.VersionField(m24id = 1)
    private final int zzv;

    @SafeParcelable.Constructor
    zzt(@SafeParcelable.Indicator Set<Integer> set, @SafeParcelable.Param(m23id = 1) int i, @SafeParcelable.Param(m23id = 2) String str, @SafeParcelable.Param(m23id = 3) int i2, @SafeParcelable.Param(m23id = 4) byte[] bArr, @SafeParcelable.Param(m23id = 5) PendingIntent pendingIntent, @SafeParcelable.Param(m23id = 6) DeviceMetaData deviceMetaData) {
        this.zzba = set;
        this.zzv = i;
        this.zzbn = str;
        this.zzbo = i2;
        this.zzbp = bArr;
        this.zzbq = pendingIntent;
        this.zzbr = deviceMetaData;
    }

    public zzt() {
        this.zzba = new ArraySet(3);
        this.zzv = 1;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        Set<Integer> set = this.zzba;
        if (set.contains(1)) {
            SafeParcelWriter.writeInt(parcel, 1, this.zzv);
        }
        if (set.contains(2)) {
            SafeParcelWriter.writeString(parcel, 2, this.zzbn, true);
        }
        if (set.contains(3)) {
            SafeParcelWriter.writeInt(parcel, 3, this.zzbo);
        }
        if (set.contains(4)) {
            SafeParcelWriter.writeByteArray(parcel, 4, this.zzbp, true);
        }
        if (set.contains(5)) {
            SafeParcelWriter.writeParcelable(parcel, 5, this.zzbq, i, true);
        }
        if (set.contains(6)) {
            SafeParcelWriter.writeParcelable(parcel, 6, this.zzbr, i, true);
        }
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected boolean isFieldSet(FastJsonResponse.Field field) {
        return this.zzba.contains(Integer.valueOf(field.getSafeParcelableFieldId()));
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected Object getFieldValue(FastJsonResponse.Field field) {
        switch (field.getSafeParcelableFieldId()) {
            case 1:
                return Integer.valueOf(this.zzv);
            case 2:
                return this.zzbn;
            case 3:
                return Integer.valueOf(this.zzbo);
            case 4:
                return this.zzbp;
            default:
                int safeParcelableFieldId = field.getSafeParcelableFieldId();
                StringBuilder sb = new StringBuilder(37);
                sb.append("Unknown SafeParcelable id=");
                sb.append(safeParcelableFieldId);
                throw new IllegalStateException(sb.toString());
        }
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected void setStringInternal(FastJsonResponse.Field<?, ?> field, String str, String str2) {
        int safeParcelableFieldId = field.getSafeParcelableFieldId();
        if (safeParcelableFieldId == 2) {
            this.zzbn = str2;
            this.zzba.add(Integer.valueOf(safeParcelableFieldId));
            return;
        }
        throw new IllegalArgumentException(String.format("Field with id=%d is not known to be a string.", Integer.valueOf(safeParcelableFieldId)));
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected void setIntegerInternal(FastJsonResponse.Field<?, ?> field, String str, int i) {
        int safeParcelableFieldId = field.getSafeParcelableFieldId();
        if (safeParcelableFieldId == 3) {
            this.zzbo = i;
            this.zzba.add(Integer.valueOf(safeParcelableFieldId));
        } else {
            StringBuilder sb = new StringBuilder(52);
            sb.append("Field with id=");
            sb.append(safeParcelableFieldId);
            sb.append(" is not known to be an int.");
            throw new IllegalArgumentException(sb.toString());
        }
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    protected void setDecodedBytesInternal(FastJsonResponse.Field<?, ?> field, String str, byte[] bArr) {
        int safeParcelableFieldId = field.getSafeParcelableFieldId();
        if (safeParcelableFieldId == 4) {
            this.zzbp = bArr;
            this.zzba.add(Integer.valueOf(safeParcelableFieldId));
        } else {
            StringBuilder sb = new StringBuilder(59);
            sb.append("Field with id=");
            sb.append(safeParcelableFieldId);
            sb.append(" is not known to be an byte array.");
            throw new IllegalArgumentException(sb.toString());
        }
    }

    @Override // com.google.android.gms.common.server.response.FastJsonResponse
    public /* synthetic */ Map getFieldMappings() {
        return zzaz;
    }

    static {
        HashMap<String, FastJsonResponse.Field<?, ?>> map = new HashMap<>();
        zzaz = map;
        map.put("accountType", FastJsonResponse.Field.forString("accountType", 2));
        zzaz.put("status", FastJsonResponse.Field.forInteger("status", 3));
        zzaz.put("transferBytes", (FastJsonResponse.Field<?, ?>) FastJsonResponse.Field.forBase64("transferBytes", 4));
    }
}
