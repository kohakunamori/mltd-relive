package com.smrtbeat;

import java.util.Arrays;

/* JADX INFO: renamed from: com.smrtbeat.l */
/* JADX INFO: loaded from: classes.dex */
class C0384l {

    /* JADX INFO: renamed from: a */
    private static final String[] f297a = {"HTL23", "LGL22", "Nexus 5", "SH-04F", "SH-06F", "SM-G900K", "SO-02F", "SOL23", "SOL25"};

    C0384l() {
    }

    /* JADX INFO: renamed from: a */
    static boolean m274a(String str) {
        return Arrays.binarySearch(f297a, str) >= 0;
    }
}
