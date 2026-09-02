package com.google.android.gms.internal.games;

import com.google.android.gms.common.data.DataHolder;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.HashMap;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public final class zzek {
    private static final String[] zznr = {"requestId", "outcome"};
    private final int statusCode;
    private final HashMap<String, Integer> zzns;

    private zzek(int i, HashMap<String, Integer> map) {
        this.statusCode = i;
        this.zzns = map;
    }

    @VisibleForTesting
    public final int getRequestOutcome(String str) {
        boolean zContainsKey = this.zzns.containsKey(str);
        StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 46);
        sb.append("Request ");
        sb.append(str);
        sb.append(" was not part of the update operation!");
        Preconditions.checkArgument(zContainsKey, sb.toString());
        return this.zzns.get(str).intValue();
    }

    @VisibleForTesting
    public final Set<String> getRequestIds() {
        return this.zzns.keySet();
    }

    @VisibleForTesting
    public static zzek zzbb(DataHolder dataHolder) {
        zzem zzemVar = new zzem();
        zzemVar.zzo(dataHolder.getStatusCode());
        int count = dataHolder.getCount();
        for (int i = 0; i < count; i++) {
            int windowIndex = dataHolder.getWindowIndex(i);
            zzemVar.zzh(dataHolder.getString("requestId", i, windowIndex), dataHolder.getInteger("outcome", i, windowIndex));
        }
        return zzemVar.zzdh();
    }
}
