package com.adjust.sdk.network;

import com.adjust.sdk.ActivityKind;
import com.adjust.sdk.AdjustConfig;
import com.adjust.sdk.Constants;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class UrlStrategy {
    private static final String BASE_URL_CHINA = "https://app.adjust.world";
    private static final String BASE_URL_EU = "https://app.eu.adjust.com";
    private static final String BASE_URL_INDIA = "https://app.adjust.net.in";
    private static final String GDPR_URL_CHINA = "https://gdpr.adjust.world";
    private static final String GDPR_URL_EU = "https://gdpr.eu.adjust.com";
    private static final String GDPR_URL_INDIA = "https://gdpr.adjust.net.in";
    private static final String SUBSCRIPTION_URL_CHINA = "https://subscription.adjust.world";
    private static final String SUBSCRIPTION_URL_EU = "https://subscription.eu.adjust.com";
    private static final String SUBSCRIPTION_URL_INDIA = "https://subscription.adjust.net.in";
    final List<String> baseUrlChoicesList;
    private final String baseUrlOverwrite;
    final List<String> gdprUrlChoicesList;
    private final String gdprUrlOverwrite;
    final List<String> subscriptionUrlChoicesList;
    private final String subscriptionUrlOverwrite;
    boolean wasLastAttemptSuccess = false;
    int choiceIndex = 0;
    int startingChoiceIndex = 0;
    boolean wasLastAttemptWithOverwrittenUrl = false;

    public UrlStrategy(String str, String str2, String str3, String str4) {
        this.baseUrlOverwrite = str;
        this.gdprUrlOverwrite = str2;
        this.subscriptionUrlOverwrite = str3;
        this.baseUrlChoicesList = baseUrlChoices(str4);
        this.gdprUrlChoicesList = gdprUrlChoices(str4);
        this.subscriptionUrlChoicesList = subscriptionUrlChoices(str4);
    }

    public void resetAfterSuccess() {
        this.startingChoiceIndex = this.choiceIndex;
        this.wasLastAttemptSuccess = true;
    }

    public boolean shouldRetryAfterFailure(ActivityKind activityKind) {
        int size;
        this.wasLastAttemptSuccess = false;
        if (this.wasLastAttemptWithOverwrittenUrl) {
            return false;
        }
        if (activityKind == ActivityKind.GDPR) {
            size = this.gdprUrlChoicesList.size();
        } else if (activityKind == ActivityKind.SUBSCRIPTION) {
            size = this.subscriptionUrlChoicesList.size();
        } else {
            size = this.baseUrlChoicesList.size();
        }
        this.choiceIndex = (this.choiceIndex + 1) % size;
        return this.choiceIndex != this.startingChoiceIndex;
    }

    public String targetUrlByActivityKind(ActivityKind activityKind) {
        if (activityKind == ActivityKind.GDPR) {
            if (this.gdprUrlOverwrite != null) {
                this.wasLastAttemptWithOverwrittenUrl = true;
                return this.gdprUrlOverwrite;
            }
            this.wasLastAttemptWithOverwrittenUrl = false;
            return this.gdprUrlChoicesList.get(this.choiceIndex);
        }
        if (activityKind == ActivityKind.SUBSCRIPTION) {
            if (this.subscriptionUrlOverwrite != null) {
                this.wasLastAttemptWithOverwrittenUrl = true;
                return this.subscriptionUrlOverwrite;
            }
            this.wasLastAttemptWithOverwrittenUrl = false;
            return this.subscriptionUrlChoicesList.get(this.choiceIndex);
        }
        if (this.baseUrlOverwrite != null) {
            this.wasLastAttemptWithOverwrittenUrl = true;
            return this.baseUrlOverwrite;
        }
        this.wasLastAttemptWithOverwrittenUrl = false;
        return this.baseUrlChoicesList.get(this.choiceIndex);
    }

    private static List<String> baseUrlChoices(String str) {
        if (AdjustConfig.URL_STRATEGY_INDIA.equals(str)) {
            return Arrays.asList(BASE_URL_INDIA, Constants.BASE_URL);
        }
        if (AdjustConfig.URL_STRATEGY_CHINA.equals(str)) {
            return Arrays.asList(BASE_URL_CHINA, Constants.BASE_URL);
        }
        if (AdjustConfig.DATA_RESIDENCY_EU.equals(str)) {
            return Collections.singletonList(BASE_URL_EU);
        }
        return Arrays.asList(Constants.BASE_URL, BASE_URL_INDIA, BASE_URL_CHINA);
    }

    private static List<String> gdprUrlChoices(String str) {
        if (AdjustConfig.URL_STRATEGY_INDIA.equals(str)) {
            return Arrays.asList(GDPR_URL_INDIA, Constants.GDPR_URL);
        }
        if (AdjustConfig.URL_STRATEGY_CHINA.equals(str)) {
            return Arrays.asList(GDPR_URL_CHINA, Constants.GDPR_URL);
        }
        if (AdjustConfig.DATA_RESIDENCY_EU.equals(str)) {
            return Collections.singletonList(GDPR_URL_EU);
        }
        return Arrays.asList(Constants.GDPR_URL, GDPR_URL_INDIA, GDPR_URL_CHINA);
    }

    private static List<String> subscriptionUrlChoices(String str) {
        if (AdjustConfig.URL_STRATEGY_INDIA.equals(str)) {
            return Arrays.asList(SUBSCRIPTION_URL_INDIA, Constants.SUBSCRIPTION_URL);
        }
        if (AdjustConfig.URL_STRATEGY_CHINA.equals(str)) {
            return Arrays.asList(SUBSCRIPTION_URL_CHINA, Constants.SUBSCRIPTION_URL);
        }
        if (AdjustConfig.DATA_RESIDENCY_EU.equals(str)) {
            return Collections.singletonList(SUBSCRIPTION_URL_EU);
        }
        return Arrays.asList(Constants.SUBSCRIPTION_URL, SUBSCRIPTION_URL_INDIA, SUBSCRIPTION_URL_CHINA);
    }
}
