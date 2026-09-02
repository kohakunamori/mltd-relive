package com.adjust.sdk;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class SessionResponseData extends ResponseData {
    private String sdkPlatform;

    public SessionResponseData(ActivityPackage activityPackage) {
        this.sdkPlatform = Util.getSdkPrefixPlatform(activityPackage.getClientSdk());
    }

    public AdjustSessionSuccess getSuccessResponseData() {
        if (!this.success) {
            return null;
        }
        AdjustSessionSuccess adjustSessionSuccess = new AdjustSessionSuccess();
        if ("unity".equals(this.sdkPlatform)) {
            adjustSessionSuccess.message = this.message != null ? this.message : "";
            adjustSessionSuccess.timestamp = this.timestamp != null ? this.timestamp : "";
            adjustSessionSuccess.adid = this.adid != null ? this.adid : "";
            adjustSessionSuccess.jsonResponse = this.jsonResponse != null ? this.jsonResponse : new JSONObject();
        } else {
            adjustSessionSuccess.message = this.message;
            adjustSessionSuccess.timestamp = this.timestamp;
            adjustSessionSuccess.adid = this.adid;
            adjustSessionSuccess.jsonResponse = this.jsonResponse;
        }
        return adjustSessionSuccess;
    }

    public AdjustSessionFailure getFailureResponseData() {
        if (this.success) {
            return null;
        }
        AdjustSessionFailure adjustSessionFailure = new AdjustSessionFailure();
        if ("unity".equals(this.sdkPlatform)) {
            adjustSessionFailure.message = this.message != null ? this.message : "";
            adjustSessionFailure.timestamp = this.timestamp != null ? this.timestamp : "";
            adjustSessionFailure.adid = this.adid != null ? this.adid : "";
            adjustSessionFailure.willRetry = this.willRetry;
            adjustSessionFailure.jsonResponse = this.jsonResponse != null ? this.jsonResponse : new JSONObject();
        } else {
            adjustSessionFailure.message = this.message;
            adjustSessionFailure.timestamp = this.timestamp;
            adjustSessionFailure.adid = this.adid;
            adjustSessionFailure.willRetry = this.willRetry;
            adjustSessionFailure.jsonResponse = this.jsonResponse;
        }
        return adjustSessionFailure;
    }
}
