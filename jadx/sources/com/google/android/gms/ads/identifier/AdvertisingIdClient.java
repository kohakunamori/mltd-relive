package com.google.android.gms.ads.identifier;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.RemoteException;
import android.os.SystemClock;
import android.util.Log;
import androidx.annotation.Nullable;
import androidx.annotation.RecentlyNonNull;
import androidx.annotation.RecentlyNullable;
import com.google.android.gms.common.BlockingServiceConnection;
import com.google.android.gms.common.GoogleApiAvailabilityLight;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.annotation.KeepForSdkWithMembers;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.internal.ShowFirstParty;
import com.google.android.gms.common.stats.ConnectionTracker;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.ads_identifier.zze;
import com.google.android.gms.internal.ads_identifier.zzf;
import java.io.IOException;
import java.util.HashMap;
import java.util.concurrent.TimeUnit;
import javax.annotation.ParametersAreNonnullByDefault;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: compiled from: com.google.android.gms:play-services-ads-identifier@@17.0.1 */
/* JADX INFO: loaded from: classes.dex */
@KeepForSdk
@ParametersAreNonnullByDefault
public class AdvertisingIdClient {

    @Nullable
    @GuardedBy("this")
    BlockingServiceConnection zza;

    @Nullable
    @GuardedBy("this")
    zzf zzb;

    @GuardedBy("this")
    boolean zzc;
    final Object zzd;

    @Nullable
    @GuardedBy("mAutoDisconnectTaskLock")
    zzb zze;
    final long zzf;

    @GuardedBy("this")
    private final Context zzg;

    /* JADX INFO: compiled from: com.google.android.gms:play-services-ads-identifier@@17.0.1 */
    @KeepForSdkWithMembers
    public static final class Info {

        @Nullable
        private final String zza;
        private final boolean zzb;

        public Info(@Nullable String str, boolean z) {
            this.zza = str;
            this.zzb = z;
        }

        @RecentlyNullable
        public String getId() {
            return this.zza;
        }

        public boolean isLimitAdTrackingEnabled() {
            return this.zzb;
        }

        @RecentlyNonNull
        public String toString() {
            String str = this.zza;
            boolean z = this.zzb;
            StringBuilder sb = new StringBuilder(String.valueOf(str).length() + 7);
            sb.append("{");
            sb.append(str);
            sb.append("}");
            sb.append(z);
            return sb.toString();
        }
    }

    @KeepForSdk
    public AdvertisingIdClient(@RecentlyNonNull Context context) {
        this(context, 30000L, false, false);
    }

    @RecentlyNonNull
    @KeepForSdk
    public static Info getAdvertisingIdInfo(@RecentlyNonNull Context context) throws GooglePlayServicesRepairableException, IllegalStateException, GooglePlayServicesNotAvailableException, IOException {
        AdvertisingIdClient advertisingIdClient = new AdvertisingIdClient(context, -1L, true, false);
        try {
            long jElapsedRealtime = SystemClock.elapsedRealtime();
            advertisingIdClient.zzb(false);
            Info info = advertisingIdClient.getInfo();
            advertisingIdClient.zzc(info, true, 0.0f, SystemClock.elapsedRealtime() - jElapsedRealtime, "", null);
            advertisingIdClient.zza();
            return info;
        } catch (Throwable th) {
            try {
                advertisingIdClient.zzc(null, true, 0.0f, -1L, "", th);
                throw th;
            } catch (Throwable th2) {
                advertisingIdClient.zza();
                throw th2;
            }
        }
    }

    @KeepForSdk
    public static boolean getIsAdIdFakeForDebugLogging(@RecentlyNonNull Context context) throws GooglePlayServicesRepairableException, GooglePlayServicesNotAvailableException, IOException {
        boolean zZzd;
        AdvertisingIdClient advertisingIdClient = new AdvertisingIdClient(context, -1L, false, false);
        try {
            advertisingIdClient.zzb(false);
            Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
            synchronized (advertisingIdClient) {
                if (advertisingIdClient.zzc) {
                    Preconditions.checkNotNull(advertisingIdClient.zza);
                    Preconditions.checkNotNull(advertisingIdClient.zzb);
                    zZzd = advertisingIdClient.zzb.zzd();
                } else {
                    synchronized (advertisingIdClient.zzd) {
                        zzb zzbVar = advertisingIdClient.zze;
                        if (zzbVar == null || !zzbVar.zzb) {
                            throw new IOException("AdvertisingIdClient is not connected.");
                        }
                    }
                    try {
                        advertisingIdClient.zzb(false);
                        if (!advertisingIdClient.zzc) {
                            throw new IOException("AdvertisingIdClient cannot reconnect.");
                        }
                        Preconditions.checkNotNull(advertisingIdClient.zza);
                        Preconditions.checkNotNull(advertisingIdClient.zzb);
                        try {
                            zZzd = advertisingIdClient.zzb.zzd();
                        } catch (RemoteException e) {
                            Log.i("AdvertisingIdClient", "GMS remote exception ", e);
                            throw new IOException("Remote exception");
                        }
                    } catch (Exception e2) {
                        throw new IOException("AdvertisingIdClient cannot reconnect.", e2);
                    }
                }
                throw th;
            }
            advertisingIdClient.zzd();
            advertisingIdClient.zza();
            return zZzd;
        } catch (Throwable th) {
            advertisingIdClient.zza();
            throw th;
        }
    }

    @ShowFirstParty
    @KeepForSdk
    public static void setShouldSkipGmsCoreVersionCheck(boolean z) {
    }

    private final void zzd() {
        synchronized (this.zzd) {
            zzb zzbVar = this.zze;
            if (zzbVar != null) {
                zzbVar.zza.countDown();
                try {
                    this.zze.join();
                } catch (InterruptedException unused) {
                }
            }
            long j = this.zzf;
            if (j > 0) {
                this.zze = new zzb(this, j);
            }
        }
    }

    protected final void finalize() throws Throwable {
        zza();
        super.finalize();
    }

    @RecentlyNonNull
    @KeepForSdk
    public Info getInfo() throws IOException {
        Info info;
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        synchronized (this) {
            if (this.zzc) {
                Preconditions.checkNotNull(this.zza);
                Preconditions.checkNotNull(this.zzb);
                info = new Info(this.zzb.zzc(), this.zzb.zze(true));
            } else {
                synchronized (this.zzd) {
                    zzb zzbVar = this.zze;
                    if (zzbVar == null || !zzbVar.zzb) {
                        throw new IOException("AdvertisingIdClient is not connected.");
                    }
                }
                try {
                    zzb(false);
                    if (!this.zzc) {
                        throw new IOException("AdvertisingIdClient cannot reconnect.");
                    }
                    Preconditions.checkNotNull(this.zza);
                    Preconditions.checkNotNull(this.zzb);
                    try {
                        info = new Info(this.zzb.zzc(), this.zzb.zze(true));
                    } catch (RemoteException e) {
                        Log.i("AdvertisingIdClient", "GMS remote exception ", e);
                        throw new IOException("Remote exception");
                    }
                } catch (Exception e2) {
                    throw new IOException("AdvertisingIdClient cannot reconnect.", e2);
                }
            }
            throw th;
        }
        zzd();
        return info;
    }

    @KeepForSdk
    public void start() throws GooglePlayServicesRepairableException, IllegalStateException, GooglePlayServicesNotAvailableException, IOException {
        zzb(true);
    }

    public final void zza() {
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        synchronized (this) {
            if (this.zzg == null || this.zza == null) {
                return;
            }
            try {
                if (this.zzc) {
                    ConnectionTracker.getInstance().unbindService(this.zzg, this.zza);
                }
            } catch (Throwable th) {
                Log.i("AdvertisingIdClient", "AdvertisingIdClient unbindService failed.", th);
            }
            this.zzc = false;
            this.zzb = null;
            this.zza = null;
        }
    }

    @VisibleForTesting
    protected final void zzb(boolean z) throws GooglePlayServicesRepairableException, IllegalStateException, GooglePlayServicesNotAvailableException, IOException {
        Preconditions.checkNotMainThread("Calling this from your main thread can lead to deadlock");
        synchronized (this) {
            if (this.zzc) {
                zza();
            }
            Context context = this.zzg;
            try {
                context.getPackageManager().getPackageInfo("com.android.vending", 0);
                int iIsGooglePlayServicesAvailable = GoogleApiAvailabilityLight.getInstance().isGooglePlayServicesAvailable(context, 12451000);
                if (iIsGooglePlayServicesAvailable != 0 && iIsGooglePlayServicesAvailable != 2) {
                    throw new IOException("Google Play services not available");
                }
                BlockingServiceConnection blockingServiceConnection = new BlockingServiceConnection();
                Intent intent = new Intent("com.google.android.gms.ads.identifier.service.START");
                intent.setPackage("com.google.android.gms");
                try {
                    if (!ConnectionTracker.getInstance().bindService(context, intent, blockingServiceConnection, 1)) {
                        throw new IOException("Connection failure");
                    }
                    this.zza = blockingServiceConnection;
                    try {
                        this.zzb = zze.zza(this.zza.getServiceWithTimeout(10000L, TimeUnit.MILLISECONDS));
                        this.zzc = true;
                        if (z) {
                            zzd();
                        }
                    } catch (InterruptedException unused) {
                        throw new IOException("Interrupted exception");
                    } catch (Throwable th) {
                        throw new IOException(th);
                    }
                } catch (Throwable th2) {
                    throw new IOException(th2);
                }
            } catch (PackageManager.NameNotFoundException unused2) {
                throw new GooglePlayServicesNotAvailableException(9);
            }
        }
    }

    @VisibleForTesting
    final boolean zzc(@Nullable Info info, boolean z, float f, long j, String str, @Nullable Throwable th) {
        if (Math.random() > 0.0d) {
            return false;
        }
        HashMap map = new HashMap();
        map.put("app_context", "1");
        if (info != null) {
            map.put("limit_ad_tracking", true != info.isLimitAdTrackingEnabled() ? "0" : "1");
            String id = info.getId();
            if (id != null) {
                map.put("ad_id_size", Integer.toString(id.length()));
            }
        }
        if (th != null) {
            map.put("error", th.getClass().getName());
        }
        map.put("tag", "AdvertisingIdClient");
        map.put("time_spent", Long.toString(j));
        new zza(this, map).start();
        return true;
    }

    @VisibleForTesting
    public AdvertisingIdClient(@RecentlyNonNull Context context, long j, boolean z, boolean z2) {
        Context applicationContext;
        this.zzd = new Object();
        Preconditions.checkNotNull(context);
        if (z && (applicationContext = context.getApplicationContext()) != null) {
            context = applicationContext;
        }
        this.zzg = context;
        this.zzc = false;
        this.zzf = j;
    }
}
