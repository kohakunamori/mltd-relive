package com.google.android.gms.internal.games;

import java.util.HashMap;

/* JADX INFO: loaded from: classes.dex */
public final class zzem {
    private HashMap<String, Integer> zzns = new HashMap<>();
    private int statusCode = 0;

    public final zzem zzh(String str, int i) {
        boolean z;
        switch (i) {
            case 0:
            case 1:
            case 2:
            case 3:
                z = true;
                break;
            default:
                z = false;
                break;
        }
        if (z) {
            this.zzns.put(str, Integer.valueOf(i));
        }
        return this;
    }

    public final zzem zzo(int i) {
        this.statusCode = i;
        return this;
    }

    public final zzek zzdh() {
        return new zzek(this.statusCode, this.zzns);
    }
}
