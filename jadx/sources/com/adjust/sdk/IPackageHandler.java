package com.adjust.sdk;

import android.content.Context;
import com.adjust.sdk.network.IActivityPackageSender;

/* JADX INFO: loaded from: classes.dex */
public interface IPackageHandler {
    void addPackage(ActivityPackage activityPackage);

    void flush();

    void init(IActivityHandler iActivityHandler, Context context, boolean z, IActivityPackageSender iActivityPackageSender);

    void pauseSending();

    void resumeSending();

    void sendFirstPackage();

    void teardown();

    void updatePackages(SessionParameters sessionParameters);
}
