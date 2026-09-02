package com.google.android.gms.common.api.internal;

import android.app.PendingIntent;
import android.content.Context;
import android.os.Bundle;
import android.os.DeadObjectException;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.WorkerThread;
import androidx.collection.ArrayMap;
import androidx.collection.ArraySet;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.Feature;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApi;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Scope;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.UnsupportedApiCallException;
import com.google.android.gms.common.internal.BaseGmsClient;
import com.google.android.gms.common.internal.GoogleApiAvailabilityCache;
import com.google.android.gms.common.internal.IAccountAccessor;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.SimpleClientAdapter;
import com.google.android.gms.common.util.ArrayUtils;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
@KeepForSdk
public class GoogleApiManager implements Handler.Callback {

    @GuardedBy("lock")
    private static GoogleApiManager zaic;
    private final Handler handler;
    private final Context zaid;
    private final GoogleApiAvailability zaie;
    private final GoogleApiAvailabilityCache zaif;
    public static final Status zahx = new Status(4, "Sign-out occurred while this API call was in progress.");
    private static final Status zahy = new Status(4, "The user must be signed in to make this API call.");
    private static final Object lock = new Object();
    private long zahz = 5000;
    private long zaia = 120000;
    private long zaib = 10000;
    private final AtomicInteger zaig = new AtomicInteger(1);
    private final AtomicInteger zaih = new AtomicInteger(0);
    private final Map<zai<?>, zaa<?>> zaii = new ConcurrentHashMap(5, 0.75f, 1);

    @GuardedBy("lock")
    private zaae zaij = null;

    @GuardedBy("lock")
    private final Set<zai<?>> zaik = new ArraySet();
    private final Set<zai<?>> zail = new ArraySet();

    public static GoogleApiManager zab(Context context) {
        GoogleApiManager googleApiManager;
        synchronized (lock) {
            if (zaic == null) {
                HandlerThread handlerThread = new HandlerThread("GoogleApiHandler", 9);
                handlerThread.start();
                zaic = new GoogleApiManager(context.getApplicationContext(), handlerThread.getLooper(), GoogleApiAvailability.getInstance());
            }
            googleApiManager = zaic;
        }
        return googleApiManager;
    }

    private static class zab {
        private final zai<?> zajb;
        private final Feature zajc;

        private zab(zai<?> zaiVar, Feature feature) {
            this.zajb = zaiVar;
            this.zajc = feature;
        }

        public final boolean equals(Object obj) {
            if (obj == null || !(obj instanceof zab)) {
                return false;
            }
            zab zabVar = (zab) obj;
            return Objects.equal(this.zajb, zabVar.zajb) && Objects.equal(this.zajc, zabVar.zajc);
        }

        public final int hashCode() {
            return Objects.hashCode(this.zajb, this.zajc);
        }

        public final String toString() {
            return Objects.toStringHelper(this).add("key", this.zajb).add("feature", this.zajc).toString();
        }

        /* synthetic */ zab(zai zaiVar, Feature feature, zabi zabiVar) {
            this(zaiVar, feature);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    class zac implements zach, BaseGmsClient.ConnectionProgressReportCallbacks {
        private final zai<?> zafq;
        private final Api.Client zaio;
        private IAccountAccessor zajd = null;
        private Set<Scope> zaje = null;
        private boolean zajf = false;

        public zac(Api.Client client, zai<?> zaiVar) {
            this.zaio = client;
            this.zafq = zaiVar;
        }

        @Override // com.google.android.gms.common.internal.BaseGmsClient.ConnectionProgressReportCallbacks
        public final void onReportServiceBinding(@NonNull ConnectionResult connectionResult) {
            GoogleApiManager.this.handler.post(new zabo(this, connectionResult));
        }

        @Override // com.google.android.gms.common.api.internal.zach
        @WorkerThread
        public final void zag(ConnectionResult connectionResult) {
            ((zaa) GoogleApiManager.this.zaii.get(this.zafq)).zag(connectionResult);
        }

        @Override // com.google.android.gms.common.api.internal.zach
        @WorkerThread
        public final void zaa(IAccountAccessor iAccountAccessor, Set<Scope> set) {
            if (iAccountAccessor == null || set == null) {
                Log.wtf("GoogleApiManager", "Received null response from onSignInSuccess", new Exception());
                zag(new ConnectionResult(4));
            } else {
                this.zajd = iAccountAccessor;
                this.zaje = set;
                zabr();
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        @WorkerThread
        public final void zabr() {
            if (!this.zajf || this.zajd == null) {
                return;
            }
            this.zaio.getRemoteService(this.zajd, this.zaje);
        }

        static /* synthetic */ boolean zaa(zac zacVar, boolean z) {
            zacVar.zajf = true;
            return true;
        }
    }

    public static GoogleApiManager zabc() {
        GoogleApiManager googleApiManager;
        synchronized (lock) {
            Preconditions.checkNotNull(zaic, "Must guarantee manager is non-null before using getInstance");
            googleApiManager = zaic;
        }
        return googleApiManager;
    }

    @KeepForSdk
    public static void reportSignOut() {
        synchronized (lock) {
            if (zaic != null) {
                GoogleApiManager googleApiManager = zaic;
                googleApiManager.zaih.incrementAndGet();
                googleApiManager.handler.sendMessageAtFrontOfQueue(googleApiManager.handler.obtainMessage(10));
            }
        }
    }

    public class zaa<O extends Api.ApiOptions> implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener, zar {
        private final zai<O> zafq;
        private final Api.Client zaio;
        private final Api.AnyClient zaip;
        private final zaab zaiq;
        private final int zait;
        private final zace zaiu;
        private boolean zaiv;
        private final Queue<com.google.android.gms.common.api.internal.zab> zain = new LinkedList();
        private final Set<zak> zair = new HashSet();
        private final Map<ListenerHolder.ListenerKey<?>, zabw> zais = new HashMap();
        private final List<zab> zaiw = new ArrayList();
        private ConnectionResult zaix = null;

        @WorkerThread
        public zaa(GoogleApi<O> googleApi) {
            this.zaio = googleApi.zaa(GoogleApiManager.this.handler.getLooper(), this);
            if (this.zaio instanceof SimpleClientAdapter) {
                this.zaip = ((SimpleClientAdapter) this.zaio).getClient();
            } else {
                this.zaip = this.zaio;
            }
            this.zafq = googleApi.zak();
            this.zaiq = new zaab();
            this.zait = googleApi.getInstanceId();
            if (this.zaio.requiresSignIn()) {
                this.zaiu = googleApi.zaa(GoogleApiManager.this.zaid, GoogleApiManager.this.handler);
            } else {
                this.zaiu = null;
            }
        }

        @Override // com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks
        public final void onConnected(@Nullable Bundle bundle) {
            if (Looper.myLooper() == GoogleApiManager.this.handler.getLooper()) {
                zabg();
            } else {
                GoogleApiManager.this.handler.post(new zabj(this));
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        @WorkerThread
        public final void zabg() {
            zabl();
            zai(ConnectionResult.RESULT_SUCCESS);
            zabn();
            Iterator<zabw> it = this.zais.values().iterator();
            while (it.hasNext()) {
                zabw next = it.next();
                if (zaa(next.zajx.getRequiredFeatures()) != null) {
                    it.remove();
                } else {
                    try {
                        next.zajx.registerListener(this.zaip, new TaskCompletionSource<>());
                    } catch (DeadObjectException unused) {
                        onConnectionSuspended(1);
                        this.zaio.disconnect();
                    } catch (RemoteException unused2) {
                        it.remove();
                    }
                }
            }
            zabi();
            zabo();
        }

        @Override // com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks
        public final void onConnectionSuspended(int i) {
            if (Looper.myLooper() == GoogleApiManager.this.handler.getLooper()) {
                zabh();
            } else {
                GoogleApiManager.this.handler.post(new zabk(this));
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        @WorkerThread
        public final void zabh() {
            zabl();
            this.zaiv = true;
            this.zaiq.zaai();
            GoogleApiManager.this.handler.sendMessageDelayed(Message.obtain(GoogleApiManager.this.handler, 9, this.zafq), GoogleApiManager.this.zahz);
            GoogleApiManager.this.handler.sendMessageDelayed(Message.obtain(GoogleApiManager.this.handler, 11, this.zafq), GoogleApiManager.this.zaia);
            GoogleApiManager.this.zaif.flush();
        }

        @WorkerThread
        public final void zag(@NonNull ConnectionResult connectionResult) {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            this.zaio.disconnect();
            onConnectionFailed(connectionResult);
        }

        @WorkerThread
        private final boolean zah(@NonNull ConnectionResult connectionResult) {
            synchronized (GoogleApiManager.lock) {
                if (GoogleApiManager.this.zaij == null || !GoogleApiManager.this.zaik.contains(this.zafq)) {
                    return false;
                }
                GoogleApiManager.this.zaij.zab(connectionResult, this.zait);
                return true;
            }
        }

        @Override // com.google.android.gms.common.api.internal.zar
        public final void zaa(ConnectionResult connectionResult, Api<?> api, boolean z) {
            if (Looper.myLooper() == GoogleApiManager.this.handler.getLooper()) {
                onConnectionFailed(connectionResult);
            } else {
                GoogleApiManager.this.handler.post(new zabl(this, connectionResult));
            }
        }

        @Override // com.google.android.gms.common.api.GoogleApiClient.OnConnectionFailedListener
        @WorkerThread
        public final void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            if (this.zaiu != null) {
                this.zaiu.zabs();
            }
            zabl();
            GoogleApiManager.this.zaif.flush();
            zai(connectionResult);
            if (connectionResult.getErrorCode() != 4) {
                if (this.zain.isEmpty()) {
                    this.zaix = connectionResult;
                    return;
                }
                if (zah(connectionResult) || GoogleApiManager.this.zac(connectionResult, this.zait)) {
                    return;
                }
                if (connectionResult.getErrorCode() == 18) {
                    this.zaiv = true;
                }
                if (this.zaiv) {
                    GoogleApiManager.this.handler.sendMessageDelayed(Message.obtain(GoogleApiManager.this.handler, 9, this.zafq), GoogleApiManager.this.zahz);
                    return;
                }
                String strZan = this.zafq.zan();
                StringBuilder sb = new StringBuilder(String.valueOf(strZan).length() + 38);
                sb.append("API: ");
                sb.append(strZan);
                sb.append(" is not available on this device.");
                zac(new Status(17, sb.toString()));
                return;
            }
            zac(GoogleApiManager.zahy);
        }

        @WorkerThread
        private final void zabi() {
            ArrayList arrayList = new ArrayList(this.zain);
            int size = arrayList.size();
            int i = 0;
            while (i < size) {
                Object obj = arrayList.get(i);
                i++;
                com.google.android.gms.common.api.internal.zab zabVar = (com.google.android.gms.common.api.internal.zab) obj;
                if (!this.zaio.isConnected()) {
                    return;
                }
                if (zab(zabVar)) {
                    this.zain.remove(zabVar);
                }
            }
        }

        @WorkerThread
        public final void zaa(com.google.android.gms.common.api.internal.zab zabVar) {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            if (this.zaio.isConnected()) {
                if (zab(zabVar)) {
                    zabo();
                    return;
                } else {
                    this.zain.add(zabVar);
                    return;
                }
            }
            this.zain.add(zabVar);
            if (this.zaix != null && this.zaix.hasResolution()) {
                onConnectionFailed(this.zaix);
            } else {
                connect();
            }
        }

        @WorkerThread
        public final void zabj() {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            zac(GoogleApiManager.zahx);
            this.zaiq.zaah();
            for (ListenerHolder.ListenerKey listenerKey : (ListenerHolder.ListenerKey[]) this.zais.keySet().toArray(new ListenerHolder.ListenerKey[this.zais.size()])) {
                zaa(new zah(listenerKey, new TaskCompletionSource()));
            }
            zai(new ConnectionResult(4));
            if (this.zaio.isConnected()) {
                this.zaio.onUserSignOut(new zabm(this));
            }
        }

        public final Api.Client zaab() {
            return this.zaio;
        }

        public final Map<ListenerHolder.ListenerKey<?>, zabw> zabk() {
            return this.zais;
        }

        @WorkerThread
        public final void zabl() {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            this.zaix = null;
        }

        @WorkerThread
        public final ConnectionResult zabm() {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            return this.zaix;
        }

        @WorkerThread
        private final boolean zab(com.google.android.gms.common.api.internal.zab zabVar) {
            if (!(zabVar instanceof com.google.android.gms.common.api.internal.zac)) {
                zac(zabVar);
                return true;
            }
            com.google.android.gms.common.api.internal.zac zacVar = (com.google.android.gms.common.api.internal.zac) zabVar;
            Feature featureZaa = zaa(zacVar.zab((zaa<?>) this));
            if (featureZaa == null) {
                zac(zabVar);
                return true;
            }
            if (zacVar.zac(this)) {
                zab zabVar2 = new zab(this.zafq, featureZaa, null);
                int iIndexOf = this.zaiw.indexOf(zabVar2);
                if (iIndexOf >= 0) {
                    zab zabVar3 = this.zaiw.get(iIndexOf);
                    GoogleApiManager.this.handler.removeMessages(15, zabVar3);
                    GoogleApiManager.this.handler.sendMessageDelayed(Message.obtain(GoogleApiManager.this.handler, 15, zabVar3), GoogleApiManager.this.zahz);
                    return false;
                }
                this.zaiw.add(zabVar2);
                GoogleApiManager.this.handler.sendMessageDelayed(Message.obtain(GoogleApiManager.this.handler, 15, zabVar2), GoogleApiManager.this.zahz);
                GoogleApiManager.this.handler.sendMessageDelayed(Message.obtain(GoogleApiManager.this.handler, 16, zabVar2), GoogleApiManager.this.zaia);
                ConnectionResult connectionResult = new ConnectionResult(2, null);
                if (zah(connectionResult)) {
                    return false;
                }
                GoogleApiManager.this.zac(connectionResult, this.zait);
                return false;
            }
            zacVar.zaa(new UnsupportedApiCallException(featureZaa));
            return false;
        }

        @WorkerThread
        private final void zac(com.google.android.gms.common.api.internal.zab zabVar) {
            zabVar.zaa(this.zaiq, requiresSignIn());
            try {
                zabVar.zaa((zaa<?>) this);
            } catch (DeadObjectException unused) {
                onConnectionSuspended(1);
                this.zaio.disconnect();
            }
        }

        @WorkerThread
        public final void zac(Status status) {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            Iterator<com.google.android.gms.common.api.internal.zab> it = this.zain.iterator();
            while (it.hasNext()) {
                it.next().zaa(status);
            }
            this.zain.clear();
        }

        @WorkerThread
        public final void resume() {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            if (this.zaiv) {
                connect();
            }
        }

        @WorkerThread
        private final void zabn() {
            if (this.zaiv) {
                GoogleApiManager.this.handler.removeMessages(11, this.zafq);
                GoogleApiManager.this.handler.removeMessages(9, this.zafq);
                this.zaiv = false;
            }
        }

        @WorkerThread
        public final void zaav() {
            Status status;
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            if (this.zaiv) {
                zabn();
                if (GoogleApiManager.this.zaie.isGooglePlayServicesAvailable(GoogleApiManager.this.zaid) == 18) {
                    status = new Status(8, "Connection timed out while waiting for Google Play services update to complete.");
                } else {
                    status = new Status(8, "API failed to connect while resuming due to an unknown error.");
                }
                zac(status);
                this.zaio.disconnect();
            }
        }

        private final void zabo() {
            GoogleApiManager.this.handler.removeMessages(12, this.zafq);
            GoogleApiManager.this.handler.sendMessageDelayed(GoogleApiManager.this.handler.obtainMessage(12, this.zafq), GoogleApiManager.this.zaib);
        }

        @WorkerThread
        public final boolean zabp() {
            return zac(true);
        }

        @WorkerThread
        private final boolean zac(boolean z) {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            if (!this.zaio.isConnected() || this.zais.size() != 0) {
                return false;
            }
            if (!this.zaiq.zaag()) {
                this.zaio.disconnect();
                return true;
            }
            if (z) {
                zabo();
            }
            return false;
        }

        @WorkerThread
        public final void connect() {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            if (this.zaio.isConnected() || this.zaio.isConnecting()) {
                return;
            }
            int clientAvailability = GoogleApiManager.this.zaif.getClientAvailability(GoogleApiManager.this.zaid, this.zaio);
            if (clientAvailability != 0) {
                onConnectionFailed(new ConnectionResult(clientAvailability, null));
                return;
            }
            zac zacVar = GoogleApiManager.this.new zac(this.zaio, this.zafq);
            if (this.zaio.requiresSignIn()) {
                this.zaiu.zaa(zacVar);
            }
            this.zaio.connect(zacVar);
        }

        @WorkerThread
        public final void zaa(zak zakVar) {
            Preconditions.checkHandlerThread(GoogleApiManager.this.handler);
            this.zair.add(zakVar);
        }

        @WorkerThread
        private final void zai(ConnectionResult connectionResult) {
            for (zak zakVar : this.zair) {
                String endpointPackageName = null;
                if (Objects.equal(connectionResult, ConnectionResult.RESULT_SUCCESS)) {
                    endpointPackageName = this.zaio.getEndpointPackageName();
                }
                zakVar.zaa(this.zafq, connectionResult, endpointPackageName);
            }
            this.zair.clear();
        }

        final boolean isConnected() {
            return this.zaio.isConnected();
        }

        public final boolean requiresSignIn() {
            return this.zaio.requiresSignIn();
        }

        public final int getInstanceId() {
            return this.zait;
        }

        final com.google.android.gms.signin.zad zabq() {
            if (this.zaiu == null) {
                return null;
            }
            return this.zaiu.zabq();
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Nullable
        @WorkerThread
        private final Feature zaa(@Nullable Feature[] featureArr) {
            if (featureArr == null || featureArr.length == 0) {
                return null;
            }
            Feature[] availableFeatures = this.zaio.getAvailableFeatures();
            if (availableFeatures == null) {
                availableFeatures = new Feature[0];
            }
            ArrayMap arrayMap = new ArrayMap(availableFeatures.length);
            for (Feature feature : availableFeatures) {
                arrayMap.put(feature.getName(), Long.valueOf(feature.getVersion()));
            }
            for (Feature feature2 : featureArr) {
                if (!arrayMap.containsKey(feature2.getName()) || ((Long) arrayMap.get(feature2.getName())).longValue() < feature2.getVersion()) {
                    return feature2;
                }
            }
            return null;
        }

        /* JADX INFO: Access modifiers changed from: private */
        @WorkerThread
        public final void zaa(zab zabVar) {
            if (this.zaiw.contains(zabVar) && !this.zaiv) {
                if (!this.zaio.isConnected()) {
                    connect();
                } else {
                    zabi();
                }
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        @WorkerThread
        public final void zab(zab zabVar) {
            Feature[] featureArrZab;
            if (this.zaiw.remove(zabVar)) {
                GoogleApiManager.this.handler.removeMessages(15, zabVar);
                GoogleApiManager.this.handler.removeMessages(16, zabVar);
                Feature feature = zabVar.zajc;
                ArrayList arrayList = new ArrayList(this.zain.size());
                for (com.google.android.gms.common.api.internal.zab zabVar2 : this.zain) {
                    if ((zabVar2 instanceof com.google.android.gms.common.api.internal.zac) && (featureArrZab = ((com.google.android.gms.common.api.internal.zac) zabVar2).zab((zaa<?>) this)) != null && ArrayUtils.contains(featureArrZab, feature)) {
                        arrayList.add(zabVar2);
                    }
                }
                ArrayList arrayList2 = arrayList;
                int size = arrayList2.size();
                int i = 0;
                while (i < size) {
                    Object obj = arrayList2.get(i);
                    i++;
                    com.google.android.gms.common.api.internal.zab zabVar3 = (com.google.android.gms.common.api.internal.zab) obj;
                    this.zain.remove(zabVar3);
                    zabVar3.zaa(new UnsupportedApiCallException(feature));
                }
            }
        }

        static /* synthetic */ boolean zaa(zaa zaaVar, boolean z) {
            return zaaVar.zac(false);
        }
    }

    @KeepForSdk
    private GoogleApiManager(Context context, Looper looper, GoogleApiAvailability googleApiAvailability) {
        this.zaid = context;
        this.handler = new com.google.android.gms.internal.base.zap(looper, this);
        this.zaie = googleApiAvailability;
        this.zaif = new GoogleApiAvailabilityCache(googleApiAvailability);
        this.handler.sendMessage(this.handler.obtainMessage(6));
    }

    public final int zabd() {
        return this.zaig.getAndIncrement();
    }

    public final void zaa(GoogleApi<?> googleApi) {
        this.handler.sendMessage(this.handler.obtainMessage(7, googleApi));
    }

    @WorkerThread
    private final void zab(GoogleApi<?> googleApi) {
        Object objZak = googleApi.zak();
        zaa<?> zaaVar = this.zaii.get(objZak);
        if (zaaVar == null) {
            zaaVar = new zaa<>(googleApi);
            this.zaii.put((zai<?>) objZak, zaaVar);
        }
        if (zaaVar.requiresSignIn()) {
            this.zail.add((zai<?>) objZak);
        }
        zaaVar.connect();
    }

    public final void zaa(@NonNull zaae zaaeVar) {
        synchronized (lock) {
            if (this.zaij != zaaeVar) {
                this.zaij = zaaeVar;
                this.zaik.clear();
            }
            this.zaik.addAll(zaaeVar.zaaj());
        }
    }

    final void zab(@NonNull zaae zaaeVar) {
        synchronized (lock) {
            if (this.zaij == zaaeVar) {
                this.zaij = null;
                this.zaik.clear();
            }
        }
    }

    public final Task<Map<zai<?>, String>> zaa(Iterable<? extends GoogleApi<?>> iterable) {
        zak zakVar = new zak(iterable);
        this.handler.sendMessage(this.handler.obtainMessage(2, zakVar));
        return zakVar.getTask();
    }

    public final void zao() {
        this.handler.sendMessage(this.handler.obtainMessage(3));
    }

    final void maybeSignOut() {
        this.zaih.incrementAndGet();
        this.handler.sendMessage(this.handler.obtainMessage(10));
    }

    public final Task<Boolean> zac(GoogleApi<?> googleApi) {
        zaaf zaafVar = new zaaf(googleApi.zak());
        this.handler.sendMessage(this.handler.obtainMessage(14, zaafVar));
        return zaafVar.zaal().getTask();
    }

    public final <O extends Api.ApiOptions> void zaa(GoogleApi<O> googleApi, int i, BaseImplementation.ApiMethodImpl<? extends Result, Api.AnyClient> apiMethodImpl) {
        this.handler.sendMessage(this.handler.obtainMessage(4, new zabv(new zae(i, apiMethodImpl), this.zaih.get(), googleApi)));
    }

    public final <O extends Api.ApiOptions, ResultT> void zaa(GoogleApi<O> googleApi, int i, TaskApiCall<Api.AnyClient, ResultT> taskApiCall, TaskCompletionSource<ResultT> taskCompletionSource, StatusExceptionMapper statusExceptionMapper) {
        this.handler.sendMessage(this.handler.obtainMessage(4, new zabv(new zag(i, taskApiCall, taskCompletionSource, statusExceptionMapper), this.zaih.get(), googleApi)));
    }

    public final <O extends Api.ApiOptions> Task<Void> zaa(@NonNull GoogleApi<O> googleApi, @NonNull RegisterListenerMethod<Api.AnyClient, ?> registerListenerMethod, @NonNull UnregisterListenerMethod<Api.AnyClient, ?> unregisterListenerMethod) {
        TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        this.handler.sendMessage(this.handler.obtainMessage(8, new zabv(new zaf(new zabw(registerListenerMethod, unregisterListenerMethod), taskCompletionSource), this.zaih.get(), googleApi)));
        return taskCompletionSource.getTask();
    }

    public final <O extends Api.ApiOptions> Task<Boolean> zaa(@NonNull GoogleApi<O> googleApi, @NonNull ListenerHolder.ListenerKey<?> listenerKey) {
        TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        this.handler.sendMessage(this.handler.obtainMessage(13, new zabv(new zah(listenerKey, taskCompletionSource), this.zaih.get(), googleApi)));
        return taskCompletionSource.getTask();
    }

    /* JADX WARN: Code duplicated, block: B:46:0x0172  */
    /* JADX WARN: Code duplicated, block: B:47:0x01b8  */
    /*  JADX ERROR: JadxRuntimeException in pass: IfRegionVisitor
        jadx.core.utils.exceptions.JadxRuntimeException: Can't remove SSA var: r3v14 com.google.android.gms.common.api.internal.GoogleApiManager$zaa<?>, still in use, count: 2, list:
          (r3v14 com.google.android.gms.common.api.internal.GoogleApiManager$zaa<?>) from 0x0168: INVOKE (r3v14 com.google.android.gms.common.api.internal.GoogleApiManager$zaa<?>) VIRTUAL call: com.google.android.gms.common.api.internal.GoogleApiManager.zaa.getInstanceId():int A[MD:():int (m), WRAPPED] (LINE:150)
          (r3v14 com.google.android.gms.common.api.internal.GoogleApiManager$zaa<?>) from 0x0170: PHI (r3 I:??) = 
          (r3v10 com.google.android.gms.common.api.internal.GoogleApiManager$zaa<?>)
          (r3v14 com.google.android.gms.common.api.internal.GoogleApiManager$zaa<?>)
         binds: [B:44:0x016f, B:84:0x0170] A[DONT_GENERATE, DONT_INLINE]
        	at jadx.core.utils.InsnRemover.removeSsaVar(InsnRemover.java:164)
        	at jadx.core.utils.InsnRemover.unbindResult(InsnRemover.java:129)
        	at jadx.core.utils.InsnRemover.unbindInsn(InsnRemover.java:93)
        	at jadx.core.dex.visitors.regions.TernaryMod.makeTernaryInsn(TernaryMod.java:132)
        	at jadx.core.dex.visitors.regions.TernaryMod.processRegion(TernaryMod.java:67)
        	at jadx.core.dex.visitors.regions.TernaryMod.enterRegion(TernaryMod.java:50)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverseInternal(DepthRegionTraversal.java:96)
        	at jadx.core.dex.visitors.regions.DepthRegionTraversal.traverse(DepthRegionTraversal.java:27)
        	at jadx.core.dex.visitors.regions.TernaryMod.process(TernaryMod.java:36)
        	at jadx.core.dex.visitors.regions.IfRegionVisitor.process(IfRegionVisitor.java:44)
        	at jadx.core.dex.visitors.regions.IfRegionVisitor.visit(IfRegionVisitor.java:30)
        */
    @Override // android.os.Handler.Callback
    @androidx.annotation.WorkerThread
    public boolean handleMessage(android.os.Message r8) {
        /*
            Method dump skipped, instruction units count: 760
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.common.api.internal.GoogleApiManager.handleMessage(android.os.Message):boolean");
    }

    final PendingIntent zaa(zai<?> zaiVar, int i) {
        com.google.android.gms.signin.zad zadVarZabq;
        zaa<?> zaaVar = this.zaii.get(zaiVar);
        if (zaaVar == null || (zadVarZabq = zaaVar.zabq()) == null) {
            return null;
        }
        return PendingIntent.getActivity(this.zaid, i, zadVarZabq.getSignInIntent(), 134217728);
    }

    final boolean zac(ConnectionResult connectionResult, int i) {
        return this.zaie.zaa(this.zaid, connectionResult, i);
    }

    public final void zaa(ConnectionResult connectionResult, int i) {
        if (zac(connectionResult, i)) {
            return;
        }
        this.handler.sendMessage(this.handler.obtainMessage(5, i, 0, connectionResult));
    }
}
