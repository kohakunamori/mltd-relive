package com.google.android.gms.drive;

import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ReflectedParcelable;
import com.google.android.gms.common.internal.safeparcel.AbstractSafeParcelable;
import com.google.android.gms.common.internal.safeparcel.SafeParcelWriter;
import com.google.android.gms.common.internal.safeparcel.SafeParcelable;
import com.google.android.gms.common.util.CollectionUtils;
import com.google.android.gms.stats.CodePackage;
import java.util.Set;
import java.util.regex.Pattern;

/* JADX INFO: loaded from: classes.dex */
@SafeParcelable.Class(creator = "DriveSpaceCreator")
@SafeParcelable.Reserved({1})
public class DriveSpace extends AbstractSafeParcelable implements ReflectedParcelable {
    public static final Parcelable.Creator<DriveSpace> CREATOR = new zzm();
    public static final DriveSpace zzaf = new DriveSpace(CodePackage.DRIVE);
    public static final DriveSpace zzag = new DriveSpace("APP_DATA_FOLDER");
    public static final DriveSpace zzah = new DriveSpace("PHOTOS");
    private static final Set<DriveSpace> zzai = CollectionUtils.setOf(zzaf, zzag, zzah);
    private static final String zzaj = TextUtils.join(",", zzai.toArray());
    private static final Pattern zzak = Pattern.compile("[A-Z0-9_]*");

    @SafeParcelable.Field(getter = "getName", m22id = 2)
    private final String name;

    @SafeParcelable.Constructor
    DriveSpace(@SafeParcelable.Param(m23id = 2) String str) {
        this.name = (String) Preconditions.checkNotNull(str);
    }

    public boolean equals(Object obj) {
        if (obj == null || obj.getClass() != DriveSpace.class) {
            return false;
        }
        return this.name.equals(((DriveSpace) obj).name);
    }

    public int hashCode() {
        return this.name.hashCode() ^ 1247068382;
    }

    public String toString() {
        return this.name;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        int iBeginObjectHeader = SafeParcelWriter.beginObjectHeader(parcel);
        SafeParcelWriter.writeString(parcel, 2, this.name, false);
        SafeParcelWriter.finishObjectHeader(parcel, iBeginObjectHeader);
    }
}
