package com.google.android.gms.measurement.internal;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;
import androidx.annotation.Nullable;
import androidx.annotation.WorkerThread;
import androidx.core.os.EnvironmentCompat;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.GoogleServices;
import com.google.android.gms.common.internal.StringResourceValueReader;
import com.google.android.gms.common.util.Clock;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.wrappers.InstantApps;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zzdy extends zzg {
    private String zzce;
    private String zzcg;
    private String zzcm;
    private String zzco;
    private long zzcr;
    private String zzcu;
    private List<String> zzcw;
    private int zzds;
    private int zzjr;
    private String zzjs;
    private long zzjt;
    private long zzs;

    zzdy(zzfj zzfjVar, long j) {
        super(zzfjVar);
        this.zzs = j;
    }

    @Override // com.google.android.gms.measurement.internal.zzg
    protected final boolean zzbk() {
        return true;
    }

    @Override // com.google.android.gms.measurement.internal.zzg
    protected final void zzbl() {
        boolean z;
        String installerPackageName = EnvironmentCompat.MEDIA_UNKNOWN;
        String str = "Unknown";
        String string = "Unknown";
        String packageName = getContext().getPackageName();
        PackageManager packageManager = getContext().getPackageManager();
        int i = Integer.MIN_VALUE;
        if (packageManager == null) {
            zzab().zzgk().zza("PackageManager is null, app identity information might be inaccurate. appId", zzef.zzam(packageName));
        } else {
            try {
                installerPackageName = packageManager.getInstallerPackageName(packageName);
            } catch (IllegalArgumentException unused) {
                zzab().zzgk().zza("Error retrieving app installer package name. appId", zzef.zzam(packageName));
            }
            if (installerPackageName == null) {
                installerPackageName = "manual_install";
            } else if ("com.android.vending".equals(installerPackageName)) {
                installerPackageName = "";
            }
            try {
                PackageInfo packageInfo = packageManager.getPackageInfo(getContext().getPackageName(), 0);
                if (packageInfo != null) {
                    CharSequence applicationLabel = packageManager.getApplicationLabel(packageInfo.applicationInfo);
                    string = TextUtils.isEmpty(applicationLabel) ? "Unknown" : applicationLabel.toString();
                    String str2 = packageInfo.versionName;
                    try {
                        i = packageInfo.versionCode;
                        str = str2;
                    } catch (PackageManager.NameNotFoundException unused2) {
                        str = str2;
                        zzab().zzgk().zza("Error retrieving package info. appId, appName", zzef.zzam(packageName), string);
                    }
                }
            } catch (PackageManager.NameNotFoundException unused3) {
            }
        }
        this.zzce = packageName;
        this.zzco = installerPackageName;
        this.zzcm = str;
        this.zzjr = i;
        this.zzjs = string;
        this.zzjt = 0L;
        zzae();
        Status statusInitialize = GoogleServices.initialize(getContext());
        boolean z2 = true;
        boolean z3 = (statusInitialize != null && statusInitialize.isSuccess()) | (!TextUtils.isEmpty(this.zzj.zzhx()) && "am".equals(this.zzj.zzhy()));
        if (!z3) {
            if (statusInitialize == null) {
                zzab().zzgk().zzao("GoogleService failed to initialize (no status)");
            } else {
                zzab().zzgk().zza("GoogleService failed to initialize, status", Integer.valueOf(statusInitialize.getStatusCode()), statusInitialize.getStatusMessage());
            }
        }
        if (z3) {
            Boolean boolZzbq = zzad().zzbq();
            if (zzad().zzbp()) {
                if (this.zzj.zzhw()) {
                    zzab().zzgq().zzao("Collection disabled with firebase_analytics_collection_deactivated=1");
                }
            } else if (boolZzbq != null && !boolZzbq.booleanValue()) {
                if (this.zzj.zzhw()) {
                    zzab().zzgq().zzao("Collection disabled with firebase_analytics_collection_enabled=0");
                }
            } else if (boolZzbq == null && GoogleServices.isMeasurementExplicitlyDisabled()) {
                zzab().zzgq().zzao("Collection disabled with google_app_measurement_enable=0");
            } else {
                zzab().zzgs().zzao("Collection enabled");
                z = true;
            }
            z = false;
        } else {
            z = false;
        }
        this.zzcg = "";
        this.zzcu = "";
        this.zzcr = 0L;
        zzae();
        if (!TextUtils.isEmpty(this.zzj.zzhx()) && "am".equals(this.zzj.zzhy())) {
            this.zzcu = this.zzj.zzhx();
        }
        try {
            String googleAppId = GoogleServices.getGoogleAppId();
            this.zzcg = TextUtils.isEmpty(googleAppId) ? "" : googleAppId;
            if (!TextUtils.isEmpty(googleAppId)) {
                this.zzcu = new StringResourceValueReader(getContext()).getString("admob_app_id");
            }
            if (z) {
                zzab().zzgs().zza("App package, google app id", this.zzce, this.zzcg);
            }
        } catch (IllegalStateException e) {
            zzab().zzgk().zza("getGoogleAppId or isMeasurementEnabled failed with exception. appId", zzef.zzam(packageName), e);
        }
        this.zzcw = null;
        if (zzad().zze(this.zzce, zzak.zzix)) {
            zzae();
            List<String> listZzk = zzad().zzk("analytics.safelisted_events");
            if (listZzk != null) {
                if (listZzk.size() == 0) {
                    zzab().zzgn().zzao("Safelisted event list cannot be empty. Ignoring");
                } else {
                    Iterator<String> it = listZzk.iterator();
                    while (it.hasNext()) {
                        if (!zzz().zzq("safelisted event", it.next())) {
                        }
                    }
                }
                z2 = false;
                break;
            }
            if (z2) {
                this.zzcw = listZzk;
            }
        }
        if (Build.VERSION.SDK_INT < 16) {
            this.zzds = 0;
        } else if (packageManager != null) {
            this.zzds = InstantApps.isInstantApp(getContext()) ? 1 : 0;
        } else {
            this.zzds = 0;
        }
    }

    @WorkerThread
    final zzn zzai(String str) {
        Boolean boolZzj;
        zzo();
        zzm();
        String strZzag = zzag();
        String gmpAppId = getGmpAppId();
        zzbi();
        String str2 = this.zzcm;
        long jZzgf = zzgf();
        zzbi();
        String str3 = this.zzco;
        long jZzao = zzad().zzao();
        zzbi();
        zzo();
        if (this.zzjt == 0) {
            this.zzjt = this.zzj.zzz().zzc(getContext(), getContext().getPackageName());
        }
        long j = this.zzjt;
        boolean zIsEnabled = this.zzj.isEnabled();
        boolean z = !zzac().zzmc;
        zzo();
        zzm();
        String strZzge = !this.zzj.isEnabled() ? null : zzge();
        zzbi();
        long j2 = this.zzcr;
        long jZzic = this.zzj.zzic();
        int iZzgg = zzgg();
        boolean zBooleanValue = zzad().zzbr().booleanValue();
        zzs zzsVarZzad = zzad();
        zzsVarZzad.zzm();
        Boolean boolZzj2 = zzsVarZzad.zzj("google_analytics_ssaid_collection_enabled");
        return new zzn(strZzag, gmpAppId, str2, jZzgf, str3, jZzao, j, str, zIsEnabled, z, strZzge, j2, jZzic, iZzgg, zBooleanValue, Boolean.valueOf(boolZzj2 == null || boolZzj2.booleanValue()).booleanValue(), zzac().zzhi(), zzah(), (!zzad().zze(zzag(), zzak.zzij) || (boolZzj = zzad().zzj("google_analytics_default_allow_ad_personalization_signals")) == null) ? null : Boolean.valueOf(!boolZzj.booleanValue()), this.zzs, zzad().zze(zzag(), zzak.zzix) ? this.zzcw : null);
    }

    @VisibleForTesting
    @WorkerThread
    private final String zzge() {
        try {
            Class<?> clsLoadClass = getContext().getClassLoader().loadClass("com.google.firebase.analytics.FirebaseAnalytics");
            if (clsLoadClass == null) {
                return null;
            }
            try {
                Object objInvoke = clsLoadClass.getDeclaredMethod("getInstance", Context.class).invoke(null, getContext());
                if (objInvoke == null) {
                    return null;
                }
                try {
                    return (String) clsLoadClass.getDeclaredMethod("getFirebaseInstanceId", new Class[0]).invoke(objInvoke, new Object[0]);
                } catch (Exception unused) {
                    zzab().zzgp().zzao("Failed to retrieve Firebase Instance Id");
                    return null;
                }
            } catch (Exception unused2) {
                zzab().zzgo().zzao("Failed to obtain Firebase Analytics instance");
                return null;
            }
        } catch (ClassNotFoundException unused3) {
            return null;
        }
    }

    final String zzag() {
        zzbi();
        return this.zzce;
    }

    final String getGmpAppId() {
        zzbi();
        return this.zzcg;
    }

    final String zzah() {
        zzbi();
        return this.zzcu;
    }

    final int zzgf() {
        zzbi();
        return this.zzjr;
    }

    final int zzgg() {
        zzbi();
        return this.zzds;
    }

    @Nullable
    final List<String> zzbh() {
        return this.zzcw;
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzl() {
        super.zzl();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzm() {
        super.zzm();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzn() {
        super.zzn();
    }

    @Override // com.google.android.gms.measurement.internal.zzd, com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ void zzo() {
        super.zzo();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zza zzp() {
        return super.zzp();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzgp zzq() {
        return super.zzq();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzdy zzr() {
        return super.zzr();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzhv zzs() {
        return super.zzs();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzhq zzt() {
        return super.zzt();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zzeb zzu() {
        return super.zzu();
    }

    @Override // com.google.android.gms.measurement.internal.zzd
    public final /* bridge */ /* synthetic */ zziw zzv() {
        return super.zzv();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzac zzw() {
        return super.zzw();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ Clock zzx() {
        return super.zzx();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ Context getContext() {
        return super.getContext();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzed zzy() {
        return super.zzy();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzjs zzz() {
        return super.zzz();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ zzfc zzaa() {
        return super.zzaa();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ zzef zzab() {
        return super.zzab();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzeo zzac() {
        return super.zzac();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf
    public final /* bridge */ /* synthetic */ zzs zzad() {
        return super.zzad();
    }

    @Override // com.google.android.gms.measurement.internal.zzgf, com.google.android.gms.measurement.internal.zzgh
    public final /* bridge */ /* synthetic */ zzr zzae() {
        return super.zzae();
    }
}
