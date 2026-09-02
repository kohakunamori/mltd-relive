package com.google.android.gms.measurement.internal;

import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Pair;
import androidx.annotation.NonNull;
import androidx.annotation.WorkerThread;
import com.adjust.sdk.Constants;
import com.google.android.gms.common.api.internal.GoogleServices;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.DefaultClock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.Wrappers;
import java.net.URL;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class zzfj implements zzgh {
    private static volatile zzfj zzoa;
    private final Clock zzac;
    private final long zzdr;
    private final zzr zzfv;
    private final Context zzob;
    private final String zzoc;
    private final String zzod;
    private final zzs zzoe;
    private final zzeo zzof;
    private final zzef zzog;
    private final zzfc zzoh;
    private final zziw zzoi;
    private final zzjs zzoj;
    private final zzed zzok;
    private final zzhq zzol;
    private final zzgp zzom;
    private final zza zzon;
    private final zzhl zzoo;
    private zzeb zzop;
    private zzhv zzoq;
    private zzac zzor;
    private zzdy zzos;
    private zzeu zzot;
    private Boolean zzou;
    private long zzov;
    private volatile Boolean zzow;

    @VisibleForTesting
    private Boolean zzox;

    @VisibleForTesting
    private Boolean zzoy;
    private int zzoz;
    private final boolean zzt;
    private final String zzv;
    private boolean zzdh = false;
    private AtomicInteger zzpa = new AtomicInteger(0);

    private zzfj(zzgm zzgmVar) {
        boolean z = false;
        Preconditions.checkNotNull(zzgmVar);
        this.zzfv = new zzr(zzgmVar.zzob);
        zzak.zza(this.zzfv);
        this.zzob = zzgmVar.zzob;
        this.zzv = zzgmVar.zzv;
        this.zzoc = zzgmVar.zzoc;
        this.zzod = zzgmVar.zzod;
        this.zzt = zzgmVar.zzt;
        this.zzow = zzgmVar.zzow;
        com.google.android.gms.internal.measurement.zzx zzxVar = zzgmVar.zzpr;
        if (zzxVar != null && zzxVar.zzw != null) {
            Object obj = zzxVar.zzw.get("measurementEnabled");
            if (obj instanceof Boolean) {
                this.zzox = (Boolean) obj;
            }
            Object obj2 = zzxVar.zzw.get("measurementDeactivated");
            if (obj2 instanceof Boolean) {
                this.zzoy = (Boolean) obj2;
            }
        }
        com.google.android.gms.internal.measurement.zzcm.zzr(this.zzob);
        this.zzac = DefaultClock.getInstance();
        this.zzdr = this.zzac.currentTimeMillis();
        this.zzoe = new zzs(this);
        zzeo zzeoVar = new zzeo(this);
        zzeoVar.initialize();
        this.zzof = zzeoVar;
        zzef zzefVar = new zzef(this);
        zzefVar.initialize();
        this.zzog = zzefVar;
        zzjs zzjsVar = new zzjs(this);
        zzjsVar.initialize();
        this.zzoj = zzjsVar;
        zzed zzedVar = new zzed(this);
        zzedVar.initialize();
        this.zzok = zzedVar;
        this.zzon = new zza(this);
        zzhq zzhqVar = new zzhq(this);
        zzhqVar.initialize();
        this.zzol = zzhqVar;
        zzgp zzgpVar = new zzgp(this);
        zzgpVar.initialize();
        this.zzom = zzgpVar;
        zziw zziwVar = new zziw(this);
        zziwVar.initialize();
        this.zzoi = zziwVar;
        zzhl zzhlVar = new zzhl(this);
        zzhlVar.initialize();
        this.zzoo = zzhlVar;
        zzfc zzfcVar = new zzfc(this);
        zzfcVar.initialize();
        this.zzoh = zzfcVar;
        if (zzgmVar.zzpr != null && zzgmVar.zzpr.zzs != 0) {
            z = true;
        }
        boolean z2 = !z;
        zzr zzrVar = this.zzfv;
        if (this.zzob.getApplicationContext() instanceof Application) {
            zzgp zzgpVarZzq = zzq();
            if (zzgpVarZzq.getContext().getApplicationContext() instanceof Application) {
                Application application = (Application) zzgpVarZzq.getContext().getApplicationContext();
                if (zzgpVarZzq.zzpu == null) {
                    zzgpVarZzq.zzpu = new zzhj(zzgpVarZzq, null);
                }
                if (z2) {
                    application.unregisterActivityLifecycleCallbacks(zzgpVarZzq.zzpu);
                    application.registerActivityLifecycleCallbacks(zzgpVarZzq.zzpu);
                    zzgpVarZzq.zzab().zzgs().zzao("Registered activity lifecycle callback");
                }
            }
        } else {
            zzab().zzgn().zzao("Application context is not an Application");
        }
        this.zzoh.zza(new zzfl(this, zzgmVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    @WorkerThread
    public final void zza(zzgm zzgmVar) {
        zzeh zzehVarZzgq;
        String strConcat;
        zzaa().zzo();
        zzs.zzbm();
        zzac zzacVar = new zzac(this);
        zzacVar.initialize();
        this.zzor = zzacVar;
        zzdy zzdyVar = new zzdy(this, zzgmVar.zzs);
        zzdyVar.initialize();
        this.zzos = zzdyVar;
        zzeb zzebVar = new zzeb(this);
        zzebVar.initialize();
        this.zzop = zzebVar;
        zzhv zzhvVar = new zzhv(this);
        zzhvVar.initialize();
        this.zzoq = zzhvVar;
        this.zzoj.zzbj();
        this.zzof.zzbj();
        this.zzot = new zzeu(this);
        this.zzos.zzbj();
        zzab().zzgq().zza("App measurement is starting up, version", Long.valueOf(this.zzoe.zzao()));
        zzr zzrVar = this.zzfv;
        zzab().zzgq().zzao("To enable debug logging run: adb shell setprop log.tag.FA VERBOSE");
        zzr zzrVar2 = this.zzfv;
        String strZzag = zzdyVar.zzag();
        if (TextUtils.isEmpty(this.zzv)) {
            if (zzz().zzbr(strZzag)) {
                zzehVarZzgq = zzab().zzgq();
                strConcat = "Faster debug mode event logging enabled. To disable, run:\n  adb shell setprop debug.firebase.analytics.app .none.";
            } else {
                zzehVarZzgq = zzab().zzgq();
                String strValueOf = String.valueOf(strZzag);
                strConcat = strValueOf.length() != 0 ? "To enable faster debug mode event logging run:\n  adb shell setprop debug.firebase.analytics.app ".concat(strValueOf) : new String("To enable faster debug mode event logging run:\n  adb shell setprop debug.firebase.analytics.app ");
            }
            zzehVarZzgq.zzao(strConcat);
        }
        zzab().zzgr().zzao("Debug-level message logging enabled");
        if (this.zzoz != this.zzpa.get()) {
            zzab().zzgk().zza("Not all components initialized", Integer.valueOf(this.zzoz), Integer.valueOf(this.zzpa.get()));
        }
        this.zzdh = true;
    }

    @WorkerThread
    protected final void start() {
        zzaa().zzo();
        if (zzac().zzlj.get() == 0) {
            zzac().zzlj.set(this.zzac.currentTimeMillis());
        }
        if (Long.valueOf(zzac().zzlo.get()).longValue() == 0) {
            zzab().zzgs().zza("Persisting first open", Long.valueOf(this.zzdr));
            zzac().zzlo.set(this.zzdr);
        }
        if (!zzie()) {
            if (isEnabled()) {
                if (!zzz().zzbp("android.permission.INTERNET")) {
                    zzab().zzgk().zzao("App is missing INTERNET permission");
                }
                if (!zzz().zzbp("android.permission.ACCESS_NETWORK_STATE")) {
                    zzab().zzgk().zzao("App is missing ACCESS_NETWORK_STATE permission");
                }
                zzr zzrVar = this.zzfv;
                if (!Wrappers.packageManager(this.zzob).isCallerInstantApp() && !this.zzoe.zzbw()) {
                    if (!zzez.zzl(this.zzob)) {
                        zzab().zzgk().zzao("AppMeasurementReceiver not registered/enabled");
                    }
                    if (!zzjs.zzb(this.zzob, false)) {
                        zzab().zzgk().zzao("AppMeasurementService not registered/enabled");
                    }
                }
                zzab().zzgk().zzao("Uploading is not possible. App measurement disabled");
            }
        } else {
            zzr zzrVar2 = this.zzfv;
            if (!TextUtils.isEmpty(zzr().getGmpAppId()) || !TextUtils.isEmpty(zzr().zzah())) {
                zzz();
                if (zzjs.zza(zzr().getGmpAppId(), zzac().zzhc(), zzr().zzah(), zzac().zzhd())) {
                    zzab().zzgq().zzao("Rechecking which service to use due to a GMP App Id change");
                    zzac().zzhf();
                    zzu().resetAnalyticsData();
                    this.zzoq.disconnect();
                    this.zzoq.zzis();
                    zzac().zzlo.set(this.zzdr);
                    zzac().zzlq.zzau(null);
                }
                zzac().zzar(zzr().getGmpAppId());
                zzac().zzas(zzr().zzah());
            }
            zzq().zzbg(zzac().zzlq.zzho());
            zzr zzrVar3 = this.zzfv;
            if (!TextUtils.isEmpty(zzr().getGmpAppId()) || !TextUtils.isEmpty(zzr().zzah())) {
                boolean zIsEnabled = isEnabled();
                if (!zzac().zzhj() && !this.zzoe.zzbp()) {
                    zzac().zzf(!zIsEnabled);
                }
                if (zIsEnabled) {
                    zzq().zzim();
                }
                zzs().zza(new AtomicReference<>());
            }
        }
        zzac().zzly.set(this.zzoe.zza(zzak.zziu));
        zzac().zzlz.set(this.zzoe.zza(zzak.zziv));
    }

    @Override // com.google.android.gms.measurement.internal.zzgh
    public final zzr zzae() {
        return this.zzfv;
    }

    public final zzs zzad() {
        return this.zzoe;
    }

    public final zzeo zzac() {
        zza((zzgf) this.zzof);
        return this.zzof;
    }

    @Override // com.google.android.gms.measurement.internal.zzgh
    public final zzef zzab() {
        zza((zzge) this.zzog);
        return this.zzog;
    }

    public final zzef zzhs() {
        if (this.zzog == null || !this.zzog.isInitialized()) {
            return null;
        }
        return this.zzog;
    }

    @Override // com.google.android.gms.measurement.internal.zzgh
    public final zzfc zzaa() {
        zza((zzge) this.zzoh);
        return this.zzoh;
    }

    public final zziw zzv() {
        zza((zzg) this.zzoi);
        return this.zzoi;
    }

    public final zzeu zzht() {
        return this.zzot;
    }

    final zzfc zzhu() {
        return this.zzoh;
    }

    public final zzgp zzq() {
        zza((zzg) this.zzom);
        return this.zzom;
    }

    public final zzjs zzz() {
        zza((zzgf) this.zzoj);
        return this.zzoj;
    }

    public final zzed zzy() {
        zza((zzgf) this.zzok);
        return this.zzok;
    }

    public final zzeb zzu() {
        zza((zzg) this.zzop);
        return this.zzop;
    }

    private final zzhl zzhv() {
        zza((zzge) this.zzoo);
        return this.zzoo;
    }

    @Override // com.google.android.gms.measurement.internal.zzgh
    public final Context getContext() {
        return this.zzob;
    }

    public final boolean zzhw() {
        return TextUtils.isEmpty(this.zzv);
    }

    public final String zzhx() {
        return this.zzv;
    }

    public final String zzhy() {
        return this.zzoc;
    }

    public final String zzhz() {
        return this.zzod;
    }

    public final boolean zzia() {
        return this.zzt;
    }

    @Override // com.google.android.gms.measurement.internal.zzgh
    public final Clock zzx() {
        return this.zzac;
    }

    public final zzhq zzt() {
        zza((zzg) this.zzol);
        return this.zzol;
    }

    public final zzhv zzs() {
        zza((zzg) this.zzoq);
        return this.zzoq;
    }

    public final zzac zzw() {
        zza((zzge) this.zzor);
        return this.zzor;
    }

    public final zzdy zzr() {
        zza((zzg) this.zzos);
        return this.zzos;
    }

    public final zza zzp() {
        if (this.zzon == null) {
            throw new IllegalStateException("Component not created");
        }
        return this.zzon;
    }

    @VisibleForTesting
    public static zzfj zza(Context context, String str, String str2, Bundle bundle) {
        return zza(context, new com.google.android.gms.internal.measurement.zzx(0L, 0L, true, null, null, null, bundle));
    }

    public static zzfj zza(Context context, com.google.android.gms.internal.measurement.zzx zzxVar) {
        if (zzxVar != null && (zzxVar.origin == null || zzxVar.zzv == null)) {
            zzxVar = new com.google.android.gms.internal.measurement.zzx(zzxVar.zzr, zzxVar.zzs, zzxVar.zzt, zzxVar.zzu, null, null, zzxVar.zzw);
        }
        Preconditions.checkNotNull(context);
        Preconditions.checkNotNull(context.getApplicationContext());
        if (zzoa == null) {
            synchronized (zzfj.class) {
                if (zzoa == null) {
                    zzoa = new zzfj(new zzgm(context, zzxVar));
                }
            }
        } else if (zzxVar != null && zzxVar.zzw != null && zzxVar.zzw.containsKey("dataCollectionDefaultEnabled")) {
            zzoa.zza(zzxVar.zzw.getBoolean("dataCollectionDefaultEnabled"));
        }
        return zzoa;
    }

    private final void zzbi() {
        if (!this.zzdh) {
            throw new IllegalStateException("AppMeasurement is not initialized");
        }
    }

    private static void zza(zzge zzgeVar) {
        if (zzgeVar == null) {
            throw new IllegalStateException("Component not created");
        }
        if (zzgeVar.isInitialized()) {
            return;
        }
        String strValueOf = String.valueOf(zzgeVar.getClass());
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 27);
        sb.append("Component not initialized: ");
        sb.append(strValueOf);
        throw new IllegalStateException(sb.toString());
    }

    private static void zza(zzg zzgVar) {
        if (zzgVar == null) {
            throw new IllegalStateException("Component not created");
        }
        if (zzgVar.isInitialized()) {
            return;
        }
        String strValueOf = String.valueOf(zzgVar.getClass());
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 27);
        sb.append("Component not initialized: ");
        sb.append(strValueOf);
        throw new IllegalStateException(sb.toString());
    }

    private static void zza(zzgf zzgfVar) {
        if (zzgfVar == null) {
            throw new IllegalStateException("Component not created");
        }
    }

    @WorkerThread
    final void zza(boolean z) {
        this.zzow = Boolean.valueOf(z);
    }

    @WorkerThread
    public final boolean zzib() {
        return this.zzow != null && this.zzow.booleanValue();
    }

    @WorkerThread
    public final boolean isEnabled() {
        boolean zBooleanValue;
        zzaa().zzo();
        zzbi();
        if (this.zzoe.zza(zzak.zzil)) {
            if (this.zzoe.zzbp()) {
                return false;
            }
            if (this.zzoy != null && this.zzoy.booleanValue()) {
                return false;
            }
            Boolean boolZzhg = zzac().zzhg();
            if (boolZzhg != null) {
                return boolZzhg.booleanValue();
            }
            Boolean boolZzbq = this.zzoe.zzbq();
            if (boolZzbq != null) {
                return boolZzbq.booleanValue();
            }
            if (this.zzox != null) {
                return this.zzox.booleanValue();
            }
            if (GoogleServices.isMeasurementExplicitlyDisabled()) {
                return false;
            }
            if (!this.zzoe.zza(zzak.zzig) || this.zzow == null) {
                return true;
            }
            return this.zzow.booleanValue();
        }
        if (this.zzoe.zzbp()) {
            return false;
        }
        Boolean boolZzbq2 = this.zzoe.zzbq();
        if (boolZzbq2 != null) {
            zBooleanValue = boolZzbq2.booleanValue();
        } else {
            zBooleanValue = !GoogleServices.isMeasurementExplicitlyDisabled();
            if (zBooleanValue && this.zzow != null && zzak.zzig.get(null).booleanValue()) {
                zBooleanValue = this.zzow.booleanValue();
            }
        }
        return zzac().zze(zBooleanValue);
    }

    final long zzic() {
        Long lValueOf = Long.valueOf(zzac().zzlo.get());
        if (lValueOf.longValue() == 0) {
            return this.zzdr;
        }
        return Math.min(this.zzdr, lValueOf.longValue());
    }

    final void zzm() {
        zzr zzrVar = this.zzfv;
    }

    final void zzl() {
        zzr zzrVar = this.zzfv;
        throw new IllegalStateException("Unexpected call on client side");
    }

    final void zzb(zzge zzgeVar) {
        this.zzoz++;
    }

    final void zzb(zzg zzgVar) {
        this.zzoz++;
    }

    final void zzid() {
        this.zzpa.incrementAndGet();
    }

    @WorkerThread
    protected final boolean zzie() {
        zzbi();
        zzaa().zzo();
        if (this.zzou == null || this.zzov == 0 || (this.zzou != null && !this.zzou.booleanValue() && Math.abs(this.zzac.elapsedRealtime() - this.zzov) > 1000)) {
            this.zzov = this.zzac.elapsedRealtime();
            zzr zzrVar = this.zzfv;
            boolean z = true;
            this.zzou = Boolean.valueOf(zzz().zzbp("android.permission.INTERNET") && zzz().zzbp("android.permission.ACCESS_NETWORK_STATE") && (Wrappers.packageManager(this.zzob).isCallerInstantApp() || this.zzoe.zzbw() || (zzez.zzl(this.zzob) && zzjs.zzb(this.zzob, false))));
            if (this.zzou.booleanValue()) {
                if (!zzz().zzr(zzr().getGmpAppId(), zzr().zzah()) && TextUtils.isEmpty(zzr().zzah())) {
                    z = false;
                }
                this.zzou = Boolean.valueOf(z);
            }
        }
        return this.zzou.booleanValue();
    }

    @WorkerThread
    public final void zza(@NonNull final com.google.android.gms.internal.measurement.zzp zzpVar) {
        zzaa().zzo();
        zza((zzge) zzhv());
        String strZzag = zzr().zzag();
        Pair<String, Boolean> pairZzap = zzac().zzap(strZzag);
        if (!this.zzoe.zzbr().booleanValue() || ((Boolean) pairZzap.second).booleanValue()) {
            zzab().zzgr().zzao("ADID unavailable to retrieve Deferred Deep Link. Skipping");
            zzz().zzb(zzpVar, "");
            return;
        }
        if (!zzhv().zzgv()) {
            zzab().zzgn().zzao("Network is not available for Deferred Deep Link request. Skipping");
            zzz().zzb(zzpVar, "");
            return;
        }
        URL urlZza = zzz().zza(zzr().zzad().zzao(), strZzag, (String) pairZzap.first);
        zzhl zzhlVarZzhv = zzhv();
        zzhk zzhkVar = new zzhk(this, zzpVar) { // from class: com.google.android.gms.measurement.internal.zzfi
            private final zzfj zzny;
            private final com.google.android.gms.internal.measurement.zzp zznz;

            {
                this.zzny = this;
                this.zznz = zzpVar;
            }

            @Override // com.google.android.gms.measurement.internal.zzhk
            public final void zza(String str, int i, Throwable th, byte[] bArr, Map map) {
                this.zzny.zza(this.zznz, str, i, th, bArr, map);
            }
        };
        zzhlVarZzhv.zzo();
        zzhlVarZzhv.zzbi();
        Preconditions.checkNotNull(urlZza);
        Preconditions.checkNotNull(zzhkVar);
        zzhlVarZzhv.zzaa().zzb(new zzhn(zzhlVarZzhv, strZzag, urlZza, null, null, zzhkVar));
    }

    final /* synthetic */ void zza(com.google.android.gms.internal.measurement.zzp zzpVar, String str, int i, Throwable th, byte[] bArr, Map map) {
        List<ResolveInfo> listQueryIntentActivities;
        boolean z = true;
        if (!((i == 200 || i == 204 || i == 304) && th == null)) {
            zzab().zzgn().zza("Network Request for Deferred Deep Link failed. response, exception", Integer.valueOf(i), th);
            zzz().zzb(zzpVar, "");
            return;
        }
        if (bArr.length == 0) {
            zzz().zzb(zzpVar, "");
            return;
        }
        try {
            JSONObject jSONObject = new JSONObject(new String(bArr));
            String strOptString = jSONObject.optString(Constants.DEEPLINK, "");
            String strOptString2 = jSONObject.optString("gclid", "");
            zzjs zzjsVarZzz = zzz();
            zzjsVarZzz.zzm();
            if (TextUtils.isEmpty(strOptString) || (listQueryIntentActivities = zzjsVarZzz.getContext().getPackageManager().queryIntentActivities(new Intent("android.intent.action.VIEW", Uri.parse(strOptString)), 0)) == null || listQueryIntentActivities.isEmpty()) {
                z = false;
            }
            if (!z) {
                zzab().zzgn().zza("Deferred Deep Link validation failed. gclid, deep link", strOptString2, strOptString);
                zzz().zzb(zzpVar, "");
                return;
            }
            Bundle bundle = new Bundle();
            bundle.putString(Constants.DEEPLINK, strOptString);
            bundle.putString("gclid", strOptString2);
            this.zzom.logEvent("auto", "_cmp", bundle);
            zzz().zzb(zzpVar, strOptString);
        } catch (JSONException e) {
            zzab().zzgk().zza("Failed to parse the Deferred Deep Link response. exception", e);
            zzz().zzb(zzpVar, "");
        }
    }
}
