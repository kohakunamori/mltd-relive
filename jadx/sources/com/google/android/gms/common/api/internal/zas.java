package com.google.android.gms.common.api.internal;

import android.app.PendingIntent;
import android.content.Context;
import android.os.Bundle;
import android.os.Looper;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.collection.ArrayMap;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailabilityLight;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.ClientSettings;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.signin.SignInOptions;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.WeakHashMap;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
final class zas implements zabs {
    private final Context mContext;
    private final Looper zabj;
    private final zaaw zaee;
    private final zabe zaef;
    private final zabe zaeg;
    private final Map<Api.AnyClientKey<?>, zabe> zaeh;
    private final Api.Client zaej;
    private Bundle zaek;
    private final Lock zaeo;
    private final Set<SignInConnectionListener> zaei = Collections.newSetFromMap(new WeakHashMap());
    private ConnectionResult zael = null;
    private ConnectionResult zaem = null;
    private boolean zaen = false;

    @GuardedBy("mLock")
    private int zaep = 0;

    public static zas zaa(Context context, zaaw zaawVar, Lock lock, Looper looper, GoogleApiAvailabilityLight googleApiAvailabilityLight, Map<Api.AnyClientKey<?>, Api.Client> map, ClientSettings clientSettings, Map<Api<?>, Boolean> map2, Api.AbstractClientBuilder<? extends com.google.android.gms.signin.zad, SignInOptions> abstractClientBuilder, ArrayList<zaq> arrayList) {
        ArrayMap arrayMap = new ArrayMap();
        ArrayMap arrayMap2 = new ArrayMap();
        Api.Client client = null;
        for (Map.Entry<Api.AnyClientKey<?>, Api.Client> entry : map.entrySet()) {
            Api.Client value = entry.getValue();
            if (value.providesSignIn()) {
                client = value;
            }
            if (value.requiresSignIn()) {
                arrayMap.put(entry.getKey(), value);
            } else {
                arrayMap2.put(entry.getKey(), value);
            }
        }
        Preconditions.checkState(!arrayMap.isEmpty(), "CompositeGoogleApiClient should not be used without any APIs that require sign-in.");
        ArrayMap arrayMap3 = new ArrayMap();
        ArrayMap arrayMap4 = new ArrayMap();
        for (Api<?> api : map2.keySet()) {
            Api.AnyClientKey<?> clientKey = api.getClientKey();
            if (arrayMap.containsKey(clientKey)) {
                arrayMap3.put(api, map2.get(api));
            } else {
                if (!arrayMap2.containsKey(clientKey)) {
                    throw new IllegalStateException("Each API in the isOptionalMap must have a corresponding client in the clients map.");
                }
                arrayMap4.put(api, map2.get(api));
            }
        }
        ArrayList arrayList2 = new ArrayList();
        ArrayList arrayList3 = new ArrayList();
        ArrayList<zaq> arrayList4 = arrayList;
        int size = arrayList4.size();
        int i = 0;
        while (i < size) {
            zaq zaqVar = arrayList4.get(i);
            i++;
            zaq zaqVar2 = zaqVar;
            if (arrayMap3.containsKey(zaqVar2.mApi)) {
                arrayList2.add(zaqVar2);
            } else {
                if (!arrayMap4.containsKey(zaqVar2.mApi)) {
                    throw new IllegalStateException("Each ClientCallbacks must have a corresponding API in the isOptionalMap");
                }
                arrayList3.add(zaqVar2);
            }
        }
        return new zas(context, zaawVar, lock, looper, googleApiAvailabilityLight, arrayMap, arrayMap2, clientSettings, abstractClientBuilder, client, arrayList2, arrayList3, arrayMap3, arrayMap4);
    }

    private zas(Context context, zaaw zaawVar, Lock lock, Looper looper, GoogleApiAvailabilityLight googleApiAvailabilityLight, Map<Api.AnyClientKey<?>, Api.Client> map, Map<Api.AnyClientKey<?>, Api.Client> map2, ClientSettings clientSettings, Api.AbstractClientBuilder<? extends com.google.android.gms.signin.zad, SignInOptions> abstractClientBuilder, Api.Client client, ArrayList<zaq> arrayList, ArrayList<zaq> arrayList2, Map<Api<?>, Boolean> map3, Map<Api<?>, Boolean> map4) {
        this.mContext = context;
        this.zaee = zaawVar;
        this.zaeo = lock;
        this.zabj = looper;
        this.zaej = client;
        this.zaef = new zabe(context, this.zaee, lock, looper, googleApiAvailabilityLight, map2, null, map4, null, arrayList2, new zau(this, null));
        this.zaeg = new zabe(context, this.zaee, lock, looper, googleApiAvailabilityLight, map, clientSettings, map3, abstractClientBuilder, arrayList, new zav(this, null));
        ArrayMap arrayMap = new ArrayMap();
        Iterator<Api.AnyClientKey<?>> it = map2.keySet().iterator();
        while (it.hasNext()) {
            arrayMap.put(it.next(), this.zaef);
        }
        Iterator<Api.AnyClientKey<?>> it2 = map.keySet().iterator();
        while (it2.hasNext()) {
            arrayMap.put(it2.next(), this.zaeg);
        }
        this.zaeh = Collections.unmodifiableMap(arrayMap);
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final <A extends Api.AnyClient, R extends Result, T extends BaseImplementation.ApiMethodImpl<R, A>> T enqueue(@NonNull T t) {
        if (zaa((BaseImplementation.ApiMethodImpl<? extends Result, ? extends Api.AnyClient>) t)) {
            if (zaz()) {
                t.setFailedResult(new Status(4, null, zaaa()));
                return t;
            }
            return (T) this.zaeg.enqueue(t);
        }
        return (T) this.zaef.enqueue(t);
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final <A extends Api.AnyClient, T extends BaseImplementation.ApiMethodImpl<? extends Result, A>> T execute(@NonNull T t) {
        if (zaa((BaseImplementation.ApiMethodImpl<? extends Result, ? extends Api.AnyClient>) t)) {
            if (zaz()) {
                t.setFailedResult(new Status(4, null, zaaa()));
                return t;
            }
            return (T) this.zaeg.execute(t);
        }
        return (T) this.zaef.execute(t);
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @Nullable
    @GuardedBy("mLock")
    public final ConnectionResult getConnectionResult(@NonNull Api<?> api) {
        if (this.zaeh.get(api.getClientKey()).equals(this.zaeg)) {
            if (zaz()) {
                return new ConnectionResult(4, zaaa());
            }
            return this.zaeg.getConnectionResult(api);
        }
        return this.zaef.getConnectionResult(api);
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final void connect() {
        this.zaep = 2;
        this.zaen = false;
        this.zaem = null;
        this.zael = null;
        this.zaef.connect();
        this.zaeg.connect();
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final ConnectionResult blockingConnect() {
        throw new UnsupportedOperationException();
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final ConnectionResult blockingConnect(long j, @NonNull TimeUnit timeUnit) {
        throw new UnsupportedOperationException();
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final void disconnect() {
        this.zaem = null;
        this.zael = null;
        this.zaep = 0;
        this.zaef.disconnect();
        this.zaeg.disconnect();
        zay();
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    public final boolean isConnected() {
        this.zaeo.lock();
        try {
            boolean z = true;
            if (!this.zaef.isConnected() || (!this.zaeg.isConnected() && !zaz() && this.zaep != 1)) {
                z = false;
            }
            return z;
        } finally {
            this.zaeo.unlock();
        }
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    public final boolean isConnecting() {
        this.zaeo.lock();
        try {
            return this.zaep == 2;
        } finally {
            this.zaeo.unlock();
        }
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    public final boolean maybeSignIn(SignInConnectionListener signInConnectionListener) {
        this.zaeo.lock();
        try {
            if ((isConnecting() || isConnected()) && !this.zaeg.isConnected()) {
                this.zaei.add(signInConnectionListener);
                if (this.zaep == 0) {
                    this.zaep = 1;
                }
                this.zaem = null;
                this.zaeg.connect();
                return true;
            }
            return false;
        } finally {
            this.zaeo.unlock();
        }
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    @GuardedBy("mLock")
    public final void zaw() {
        this.zaef.zaw();
        this.zaeg.zaw();
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    public final void maybeSignOut() {
        this.zaeo.lock();
        try {
            boolean zIsConnecting = isConnecting();
            this.zaeg.disconnect();
            this.zaem = new ConnectionResult(4);
            if (zIsConnecting) {
                new com.google.android.gms.internal.base.zap(this.zabj).post(new zat(this));
            } else {
                zay();
            }
        } finally {
            this.zaeo.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    @GuardedBy("mLock")
    public final void zax() {
        if (zab(this.zael)) {
            if (zab(this.zaem) || zaz()) {
                switch (this.zaep) {
                    case 2:
                        this.zaee.zab(this.zaek);
                    case 1:
                        zay();
                        break;
                    default:
                        Log.wtf("CompositeGAC", "Attempted to call success callbacks in CONNECTION_MODE_NONE. Callbacks should be disabled via GmsClientSupervisor", new AssertionError());
                        break;
                }
                this.zaep = 0;
                return;
            }
            if (this.zaem != null) {
                if (this.zaep == 1) {
                    zay();
                    return;
                } else {
                    zaa(this.zaem);
                    this.zaef.disconnect();
                    return;
                }
            }
            return;
        }
        if (this.zael != null && zab(this.zaem)) {
            this.zaeg.disconnect();
            zaa(this.zael);
        } else {
            if (this.zael == null || this.zaem == null) {
                return;
            }
            ConnectionResult connectionResult = this.zael;
            if (this.zaeg.zahs < this.zaef.zahs) {
                connectionResult = this.zaem;
            }
            zaa(connectionResult);
        }
    }

    @GuardedBy("mLock")
    private final void zaa(ConnectionResult connectionResult) {
        switch (this.zaep) {
            case 2:
                this.zaee.zac(connectionResult);
            case 1:
                zay();
                break;
            default:
                Log.wtf("CompositeGAC", "Attempted to call failure callbacks in CONNECTION_MODE_NONE. Callbacks should be disabled via GmsClientSupervisor", new Exception());
                break;
        }
        this.zaep = 0;
    }

    @GuardedBy("mLock")
    private final void zay() {
        Iterator<SignInConnectionListener> it = this.zaei.iterator();
        while (it.hasNext()) {
            it.next().onComplete();
        }
        this.zaei.clear();
    }

    /* JADX INFO: Access modifiers changed from: private */
    @GuardedBy("mLock")
    public final void zaa(int i, boolean z) {
        this.zaee.zab(i, z);
        this.zaem = null;
        this.zael = null;
    }

    @GuardedBy("mLock")
    private final boolean zaz() {
        return this.zaem != null && this.zaem.getErrorCode() == 4;
    }

    private final boolean zaa(BaseImplementation.ApiMethodImpl<? extends Result, ? extends Api.AnyClient> apiMethodImpl) {
        Object clientKey = apiMethodImpl.getClientKey();
        Preconditions.checkArgument(this.zaeh.containsKey(clientKey), "GoogleApiClient is not configured to use the API required for this call.");
        return this.zaeh.get(clientKey).equals(this.zaeg);
    }

    @Nullable
    private final PendingIntent zaaa() {
        if (this.zaej == null) {
            return null;
        }
        return PendingIntent.getActivity(this.mContext, System.identityHashCode(this.zaee), this.zaej.getSignInIntent(), 134217728);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zaa(Bundle bundle) {
        if (this.zaek == null) {
            this.zaek = bundle;
        } else if (bundle != null) {
            this.zaek.putAll(bundle);
        }
    }

    private static boolean zab(ConnectionResult connectionResult) {
        return connectionResult != null && connectionResult.isSuccess();
    }

    @Override // com.google.android.gms.common.api.internal.zabs
    public final void dump(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        printWriter.append((CharSequence) str).append("authClient").println(":");
        this.zaeg.dump(String.valueOf(str).concat("  "), fileDescriptor, printWriter, strArr);
        printWriter.append((CharSequence) str).append("anonClient").println(":");
        this.zaef.dump(String.valueOf(str).concat("  "), fileDescriptor, printWriter, strArr);
    }
}
