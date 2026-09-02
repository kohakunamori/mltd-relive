package com.google.android.gms.common.api.internal;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import androidx.annotation.BinderThread;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.WorkerThread;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.Api;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.Scope;
import com.google.android.gms.common.internal.ClientSettings;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ResolveAccountResponse;
import com.google.android.gms.signin.SignInOptions;
import java.util.Set;

/* JADX INFO: loaded from: classes.dex */
public final class zace extends com.google.android.gms.signin.internal.zac implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener {
    private static Api.AbstractClientBuilder<? extends com.google.android.gms.signin.zad, SignInOptions> zaki = com.google.android.gms.signin.zaa.zaph;
    private final Context mContext;
    private final Handler mHandler;
    private Set<Scope> mScopes;
    private final Api.AbstractClientBuilder<? extends com.google.android.gms.signin.zad, SignInOptions> zaau;
    private ClientSettings zaet;
    private com.google.android.gms.signin.zad zagb;
    private zach zakj;

    @WorkerThread
    public zace(Context context, Handler handler, @NonNull ClientSettings clientSettings) {
        this(context, handler, clientSettings, zaki);
    }

    @WorkerThread
    public zace(Context context, Handler handler, @NonNull ClientSettings clientSettings, Api.AbstractClientBuilder<? extends com.google.android.gms.signin.zad, SignInOptions> abstractClientBuilder) {
        this.mContext = context;
        this.mHandler = handler;
        this.zaet = (ClientSettings) Preconditions.checkNotNull(clientSettings, "ClientSettings must not be null");
        this.mScopes = clientSettings.getRequiredScopes();
        this.zaau = abstractClientBuilder;
    }

    @WorkerThread
    public final void zaa(zach zachVar) {
        if (this.zagb != null) {
            this.zagb.disconnect();
        }
        this.zaet.setClientSessionId(Integer.valueOf(System.identityHashCode(this)));
        this.zagb = (com.google.android.gms.signin.zad) this.zaau.buildClient(this.mContext, this.mHandler.getLooper(), this.zaet, this.zaet.getSignInOptions(), this, this);
        this.zakj = zachVar;
        if (this.mScopes == null || this.mScopes.isEmpty()) {
            this.mHandler.post(new zacf(this));
        } else {
            this.zagb.connect();
        }
    }

    public final com.google.android.gms.signin.zad zabq() {
        return this.zagb;
    }

    public final void zabs() {
        if (this.zagb != null) {
            this.zagb.disconnect();
        }
    }

    @Override // com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks
    @WorkerThread
    public final void onConnected(@Nullable Bundle bundle) {
        this.zagb.zaa(this);
    }

    @Override // com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks
    @WorkerThread
    public final void onConnectionSuspended(int i) {
        this.zagb.disconnect();
    }

    @Override // com.google.android.gms.common.api.GoogleApiClient.OnConnectionFailedListener
    @WorkerThread
    public final void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        this.zakj.zag(connectionResult);
    }

    @Override // com.google.android.gms.signin.internal.zac, com.google.android.gms.signin.internal.zad
    @BinderThread
    public final void zab(com.google.android.gms.signin.internal.zaj zajVar) {
        this.mHandler.post(new zacg(this, zajVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zac(com.google.android.gms.signin.internal.zaj zajVar) {
        ConnectionResult connectionResult = zajVar.getConnectionResult();
        if (connectionResult.isSuccess()) {
            ResolveAccountResponse resolveAccountResponseZacx = zajVar.zacx();
            ConnectionResult connectionResult2 = resolveAccountResponseZacx.getConnectionResult();
            if (!connectionResult2.isSuccess()) {
                String strValueOf = String.valueOf(connectionResult2);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 48);
                sb.append("Sign-in succeeded with resolve account failure: ");
                sb.append(strValueOf);
                Log.wtf("SignInCoordinator", sb.toString(), new Exception());
                this.zakj.zag(connectionResult2);
                this.zagb.disconnect();
                return;
            }
            this.zakj.zaa(resolveAccountResponseZacx.getAccountAccessor(), this.mScopes);
        } else {
            this.zakj.zag(connectionResult);
        }
        this.zagb.disconnect();
    }
}
