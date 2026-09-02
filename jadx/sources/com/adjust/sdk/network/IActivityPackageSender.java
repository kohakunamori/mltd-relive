package com.adjust.sdk.network;

import com.adjust.sdk.ActivityPackage;
import com.adjust.sdk.ResponseData;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public interface IActivityPackageSender {

    public interface ResponseDataCallbackSubscriber {
        void onResponseDataCallback(ResponseData responseData);
    }

    void sendActivityPackage(ActivityPackage activityPackage, Map<String, String> map, ResponseDataCallbackSubscriber responseDataCallbackSubscriber);

    ResponseData sendActivityPackageSync(ActivityPackage activityPackage, Map<String, String> map);
}
