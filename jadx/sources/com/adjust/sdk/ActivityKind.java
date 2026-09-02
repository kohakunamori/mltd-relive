package com.adjust.sdk;

import androidx.core.app.NotificationCompat;
import androidx.core.os.EnvironmentCompat;

/* JADX INFO: loaded from: classes.dex */
public enum ActivityKind {
    UNKNOWN,
    SESSION,
    EVENT,
    CLICK,
    ATTRIBUTION,
    REVENUE,
    REATTRIBUTION,
    INFO,
    GDPR,
    AD_REVENUE,
    DISABLE_THIRD_PARTY_SHARING,
    SUBSCRIPTION,
    THIRD_PARTY_SHARING,
    MEASUREMENT_CONSENT;

    public static ActivityKind fromString(String str) {
        if ("session".equals(str)) {
            return SESSION;
        }
        if (NotificationCompat.CATEGORY_EVENT.equals(str)) {
            return EVENT;
        }
        if ("click".equals(str)) {
            return CLICK;
        }
        if ("attribution".equals(str)) {
            return ATTRIBUTION;
        }
        if ("info".equals(str)) {
            return INFO;
        }
        if ("gdpr".equals(str)) {
            return GDPR;
        }
        if ("disable_third_party_sharing".equals(str)) {
            return DISABLE_THIRD_PARTY_SHARING;
        }
        if ("ad_revenue".equals(str)) {
            return AD_REVENUE;
        }
        if ("subscription".equals(str)) {
            return SUBSCRIPTION;
        }
        if ("third_party_sharing".equals(str)) {
            return THIRD_PARTY_SHARING;
        }
        if ("measurement_consent".equals(str)) {
            return MEASUREMENT_CONSENT;
        }
        return UNKNOWN;
    }

    @Override // java.lang.Enum
    public String toString() {
        switch (this) {
            case SESSION:
                return "session";
            case EVENT:
                return NotificationCompat.CATEGORY_EVENT;
            case CLICK:
                return "click";
            case ATTRIBUTION:
                return "attribution";
            case INFO:
                return "info";
            case GDPR:
                return "gdpr";
            case DISABLE_THIRD_PARTY_SHARING:
                return "disable_third_party_sharing";
            case AD_REVENUE:
                return "ad_revenue";
            case SUBSCRIPTION:
                return "subscription";
            case THIRD_PARTY_SHARING:
                return "third_party_sharing";
            case MEASUREMENT_CONSENT:
                return "measurement_consent";
            default:
                return EnvironmentCompat.MEDIA_UNKNOWN;
        }
    }
}
