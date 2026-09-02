package com.google.android.gms.internal.games;

/* JADX INFO: loaded from: classes.dex */
public final class zzeg {
    public static String zzn(int i) {
        switch (i) {
            case 0:
                return "DAILY";
            case 1:
                return "WEEKLY";
            case 2:
                return "ALL_TIME";
            default:
                StringBuilder sb = new StringBuilder(29);
                sb.append("Unknown time span ");
                sb.append(i);
                throw new IllegalArgumentException(sb.toString());
        }
    }
}
