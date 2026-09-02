package com.adjust.sdk;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class EventResponseData extends ResponseData {
    private String callbackId;
    private String eventToken;
    private String sdkPlatform;

    public EventResponseData(ActivityPackage activityPackage) {
        this.eventToken = activityPackage.getParameters().get("event_token");
        this.callbackId = activityPackage.getParameters().get("event_callback_id");
        this.sdkPlatform = Util.getSdkPrefixPlatform(activityPackage.getClientSdk());
    }

    public AdjustEventSuccess getSuccessResponseData() {
        if (!this.success) {
            return null;
        }
        AdjustEventSuccess adjustEventSuccess = new AdjustEventSuccess();
        if ("unity".equals(this.sdkPlatform)) {
            adjustEventSuccess.eventToken = this.eventToken != null ? this.eventToken : "";
            adjustEventSuccess.message = this.message != null ? this.message : "";
            adjustEventSuccess.timestamp = this.timestamp != null ? this.timestamp : "";
            adjustEventSuccess.adid = this.adid != null ? this.adid : "";
            adjustEventSuccess.callbackId = this.callbackId != null ? this.callbackId : "";
            adjustEventSuccess.jsonResponse = this.jsonResponse != null ? this.jsonResponse : new JSONObject();
        } else {
            adjustEventSuccess.eventToken = this.eventToken;
            adjustEventSuccess.message = this.message;
            adjustEventSuccess.timestamp = this.timestamp;
            adjustEventSuccess.adid = this.adid;
            adjustEventSuccess.callbackId = this.callbackId;
            adjustEventSuccess.jsonResponse = this.jsonResponse;
        }
        return adjustEventSuccess;
    }

    public AdjustEventFailure getFailureResponseData() {
        if (this.success) {
            return null;
        }
        AdjustEventFailure adjustEventFailure = new AdjustEventFailure();
        if ("unity".equals(this.sdkPlatform)) {
            adjustEventFailure.eventToken = this.eventToken != null ? this.eventToken : "";
            adjustEventFailure.message = this.message != null ? this.message : "";
            adjustEventFailure.timestamp = this.timestamp != null ? this.timestamp : "";
            adjustEventFailure.adid = this.adid != null ? this.adid : "";
            adjustEventFailure.callbackId = this.callbackId != null ? this.callbackId : "";
            adjustEventFailure.willRetry = this.willRetry;
            adjustEventFailure.jsonResponse = this.jsonResponse != null ? this.jsonResponse : new JSONObject();
        } else {
            adjustEventFailure.eventToken = this.eventToken;
            adjustEventFailure.message = this.message;
            adjustEventFailure.timestamp = this.timestamp;
            adjustEventFailure.adid = this.adid;
            adjustEventFailure.callbackId = this.callbackId;
            adjustEventFailure.willRetry = this.willRetry;
            adjustEventFailure.jsonResponse = this.jsonResponse;
        }
        return adjustEventFailure;
    }
}
