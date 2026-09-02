package com.google.android.gms.drive.events;

import androidx.annotation.Nullable;
import com.google.android.gms.drive.DriveId;

/* JADX INFO: loaded from: classes.dex */
public final class zzj {
    public static boolean zza(int i, @Nullable DriveId driveId) {
        if (i != 1) {
            if (i != 4) {
                switch (i) {
                    case 7:
                        break;
                    case 8:
                        break;
                    default:
                        return false;
                }
            }
            return driveId == null;
        }
        return driveId != null;
    }
}
