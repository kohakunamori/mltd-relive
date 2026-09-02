package com.google.android.gms.nearby.connection;

import android.app.Activity;
import android.content.Context;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApi;
import com.google.android.gms.tasks.Task;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public abstract class ConnectionsClient extends GoogleApi<Api.ApiOptions.NoOptions> {
    public static int MAX_BYTES_DATA_SIZE = 32768;

    protected ConnectionsClient(Activity activity, Api<Api.ApiOptions.NoOptions> api, GoogleApi.Settings settings) {
        super(activity, (Api<Api.ApiOptions>) api, (Api.ApiOptions) null, settings);
    }

    protected ConnectionsClient(Context context, Api<Api.ApiOptions.NoOptions> api, GoogleApi.Settings settings) {
        super(context, api, (Api.ApiOptions) null, settings);
    }

    public abstract Task<Void> acceptConnection(@NonNull String str, @NonNull PayloadCallback payloadCallback);

    public abstract Task<Void> cancelPayload(long j);

    public abstract void disconnectFromEndpoint(@NonNull String str);

    public abstract Task<Void> rejectConnection(@NonNull String str);

    public abstract Task<Void> requestConnection(@NonNull String str, @NonNull String str2, @NonNull ConnectionLifecycleCallback connectionLifecycleCallback);

    public abstract Task<Void> sendPayload(@NonNull String str, @NonNull Payload payload);

    public abstract Task<Void> sendPayload(@NonNull List<String> list, @NonNull Payload payload);

    public abstract Task<Void> startAdvertising(@NonNull String str, @NonNull String str2, @NonNull ConnectionLifecycleCallback connectionLifecycleCallback, @NonNull AdvertisingOptions advertisingOptions);

    public abstract Task<Void> startDiscovery(@NonNull String str, @NonNull EndpointDiscoveryCallback endpointDiscoveryCallback, @NonNull DiscoveryOptions discoveryOptions);

    public abstract void stopAdvertising();

    public abstract void stopAllEndpoints();

    public abstract void stopDiscovery();
}
