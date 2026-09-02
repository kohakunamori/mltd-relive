package com.google.android.gms.auth.api.signin;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.NonNull;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.internal.zzh;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.api.GoogleApi;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.internal.ApiExceptionMapper;
import com.google.android.gms.common.api.internal.StatusExceptionMapper;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamite.DynamiteModule;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class GoogleSignInClient extends GoogleApi<GoogleSignInOptions> {
    private static final zzc zzar = new zzc(null);

    @VisibleForTesting
    private static int zzas = zzd.zzau;

    private static class zzc implements PendingResultUtil.ResultConverter<GoogleSignInResult, GoogleSignInAccount> {
        private zzc() {
        }

        @Override // com.google.android.gms.common.internal.PendingResultUtil.ResultConverter
        public final /* synthetic */ GoogleSignInAccount convert(Result result) {
            return ((GoogleSignInResult) result).getSignInAccount();
        }

        /* synthetic */ zzc(com.google.android.gms.auth.api.signin.zzc zzcVar) {
            this();
        }
    }

    @VisibleForTesting
    static final enum zzd {
        public static final int zzau = 1;
        public static final int zzav = 2;
        public static final int zzaw = 3;
        public static final int zzax = 4;
        private static final /* synthetic */ int[] zzay = {zzau, zzav, zzaw, zzax};

        /* JADX INFO: renamed from: values$50KLMJ33DTMIUPRFDTJMOP9FC5N68SJFD5I2UPRDECNM2TBKD0NM2S395TPMIPRED5N2UHRFDTJMOPAJD5JMSIBE8DM6IPBEEGI4IRBGDHIMQPBEEHGN8QBFDOTG____0 */
        public static int[] m10xd6228de2() {
            return (int[]) zzay.clone();
        }
    }

    GoogleSignInClient(@NonNull Context context, GoogleSignInOptions googleSignInOptions) {
        super(context, Auth.GOOGLE_SIGN_IN_API, googleSignInOptions, new ApiExceptionMapper());
    }

    GoogleSignInClient(@NonNull Activity activity, GoogleSignInOptions googleSignInOptions) {
        super(activity, Auth.GOOGLE_SIGN_IN_API, googleSignInOptions, (StatusExceptionMapper) new ApiExceptionMapper());
    }

    private final synchronized int zze() {
        if (zzas == zzd.zzau) {
            Context applicationContext = getApplicationContext();
            GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();
            int iIsGooglePlayServicesAvailable = googleApiAvailability.isGooglePlayServicesAvailable(applicationContext, 12451000);
            if (iIsGooglePlayServicesAvailable == 0) {
                zzas = zzd.zzax;
            } else if (googleApiAvailability.getErrorResolutionIntent(applicationContext, iIsGooglePlayServicesAvailable, null) == null && DynamiteModule.getLocalVersion(applicationContext, "com.google.android.gms.auth.api.fallback") != 0) {
                zzas = zzd.zzaw;
            } else {
                zzas = zzd.zzav;
            }
        }
        return zzas;
    }

    @NonNull
    public Intent getSignInIntent() {
        Context applicationContext = getApplicationContext();
        switch (com.google.android.gms.auth.api.signin.zzc.zzat[zze() - 1]) {
            case 1:
                return zzh.zzd(applicationContext, getApiOptions());
            case 2:
                return zzh.zzc(applicationContext, getApiOptions());
            default:
                return zzh.zze(applicationContext, getApiOptions());
        }
    }

    public Task<GoogleSignInAccount> silentSignIn() {
        return PendingResultUtil.toTask(zzh.zzc(asGoogleApiClient(), getApplicationContext(), getApiOptions(), zze() == zzd.zzaw), zzar);
    }

    public Task<Void> signOut() {
        return PendingResultUtil.toVoidTask(zzh.zzc(asGoogleApiClient(), getApplicationContext(), zze() == zzd.zzaw));
    }

    public Task<Void> revokeAccess() {
        return PendingResultUtil.toVoidTask(zzh.zzd(asGoogleApiClient(), getApplicationContext(), zze() == zzd.zzaw));
    }
}
