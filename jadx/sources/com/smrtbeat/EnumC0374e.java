package com.smrtbeat;

import java.util.Arrays;
import java.util.List;

/* JADX INFO: renamed from: com.smrtbeat.e */
/* JADX INFO: loaded from: classes.dex */
enum EnumC0374e {
    BC2_TYPE_LEGACY_BREADCRUMB(1),
    BC2_TYPE_BREADCRUMB_META(3),
    BC2_TYPE_BREADCRUMB_META_DROP(4),
    BC2_TYPE_AUTO_BREADCRUMB(5),
    BC2_TYPE_AUTO_BREADCRUMB_DROP(6),
    BC2_TYPE_ERROR_BREADCRUMB(7),
    BC2_TYPE_ERROR_BREADCRUMB_DROP(8),
    BC2_TYPE_SB_BREADCRUMB(9);


    /* JADX INFO: renamed from: a */
    int f142a;

    /* JADX INFO: renamed from: j */
    static final List<EnumC0374e> f140j = Arrays.asList(BC2_TYPE_BREADCRUMB_META, BC2_TYPE_AUTO_BREADCRUMB, BC2_TYPE_ERROR_BREADCRUMB);

    EnumC0374e(int i) {
        this.f142a = i;
    }

    /* JADX INFO: renamed from: a */
    static EnumC0374e m143a(int i) {
        for (EnumC0374e enumC0374e : values()) {
            if (enumC0374e.m144a() == i) {
                return enumC0374e;
            }
        }
        return null;
    }

    /* JADX INFO: renamed from: a */
    int m144a() {
        return this.f142a;
    }
}
