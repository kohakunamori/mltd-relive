package com.adjust.sdk;

import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ResponseData {
    public ActivityKind activityKind;
    public ActivityPackage activityPackage;
    public String adid;
    public Long askIn;
    public AdjustAttribution attribution;
    public Long continueIn;
    public JSONObject jsonResponse;
    public String message;
    public Long retryIn;
    public Map<String, String> sendingParameters;
    public String timestamp;
    public TrackingState trackingState;
    public boolean success = false;
    public boolean willRetry = false;

    protected ResponseData() {
    }

    public static ResponseData buildResponseData(ActivityPackage activityPackage, Map<String, String> map) {
        ResponseData sessionResponseData;
        ActivityKind activityKind = activityPackage.getActivityKind();
        switch (activityKind) {
            case SESSION:
                sessionResponseData = new SessionResponseData(activityPackage);
                break;
            case CLICK:
                sessionResponseData = new SdkClickResponseData();
                break;
            case ATTRIBUTION:
                sessionResponseData = new AttributionResponseData();
                break;
            case EVENT:
                sessionResponseData = new EventResponseData(activityPackage);
                break;
            default:
                sessionResponseData = new ResponseData();
                break;
        }
        sessionResponseData.activityKind = activityKind;
        sessionResponseData.activityPackage = activityPackage;
        sessionResponseData.sendingParameters = map;
        return sessionResponseData;
    }

    public String toString() {
        return Util.formatString("message:%s timestamp:%s json:%s", this.message, this.timestamp, this.jsonResponse);
    }
}
