package com.google.firebase.iid;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Build;
import android.os.Looper;
import android.util.Log;
import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.WorkerThread;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.common.util.concurrent.NamedThreadFactory;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.SuccessContinuation;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.DataCollectionDefaultChange;
import com.google.firebase.FirebaseApp;
import com.google.firebase.events.Event;
import com.google.firebase.events.EventHandler;
import com.google.firebase.events.Subscriber;
import com.google.firebase.platforminfo.UserAgentPublisher;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executor;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public class FirebaseInstanceId {
    private static final long zza = TimeUnit.HOURS.toSeconds(8);
    private static zzaq zzb;

    @VisibleForTesting
    @GuardedBy("FirebaseInstanceId.class")
    private static ScheduledExecutorService zzc;
    private final Executor zzd;
    private final FirebaseApp zze;
    private final zzaf zzf;
    private final zzk zzg;
    private final zzak zzh;
    private final zzau zzi;

    @GuardedBy("this")
    private boolean zzj;
    private final zza zzk;

    public static FirebaseInstanceId getInstance() {
        return getInstance(FirebaseApp.getInstance());
    }

    @Keep
    public static FirebaseInstanceId getInstance(@NonNull FirebaseApp firebaseApp) {
        return (FirebaseInstanceId) firebaseApp.get(FirebaseInstanceId.class);
    }

    FirebaseInstanceId(FirebaseApp firebaseApp, Subscriber subscriber, UserAgentPublisher userAgentPublisher) {
        this(firebaseApp, new zzaf(firebaseApp.getApplicationContext()), zzc.zzb(), zzc.zzb(), subscriber, userAgentPublisher);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
    class zza {
        private final Subscriber zzc;

        @Nullable
        @GuardedBy("this")
        private EventHandler<DataCollectionDefaultChange> zzd;
        private final boolean zzb = zzc();

        @Nullable
        @GuardedBy("this")
        private Boolean zze = zzb();

        zza(Subscriber subscriber) {
            this.zzc = subscriber;
            if (this.zze == null && this.zzb) {
                this.zzd = new EventHandler(this) { // from class: com.google.firebase.iid.zzj
                    private final FirebaseInstanceId.zza zza;

                    {
                        this.zza = this;
                    }

                    @Override // com.google.firebase.events.EventHandler
                    public final void handle(Event event) {
                        FirebaseInstanceId.zza zzaVar = this.zza;
                        synchronized (zzaVar) {
                            if (zzaVar.zza()) {
                                FirebaseInstanceId.this.zzi();
                            }
                        }
                    }
                };
                subscriber.subscribe(DataCollectionDefaultChange.class, this.zzd);
            }
        }

        final synchronized boolean zza() {
            if (this.zze != null) {
                return this.zze.booleanValue();
            }
            return this.zzb && FirebaseInstanceId.this.zze.isDataCollectionDefaultEnabled();
        }

        final synchronized void zza(boolean z) {
            if (this.zzd != null) {
                this.zzc.unsubscribe(DataCollectionDefaultChange.class, this.zzd);
                this.zzd = null;
            }
            SharedPreferences.Editor editorEdit = FirebaseInstanceId.this.zze.getApplicationContext().getSharedPreferences("com.google.firebase.messaging", 0).edit();
            editorEdit.putBoolean("auto_init", z);
            editorEdit.apply();
            if (z) {
                FirebaseInstanceId.this.zzi();
            }
            this.zze = Boolean.valueOf(z);
        }

        @Nullable
        private final Boolean zzb() {
            ApplicationInfo applicationInfo;
            Context applicationContext = FirebaseInstanceId.this.zze.getApplicationContext();
            SharedPreferences sharedPreferences = applicationContext.getSharedPreferences("com.google.firebase.messaging", 0);
            if (sharedPreferences.contains("auto_init")) {
                return Boolean.valueOf(sharedPreferences.getBoolean("auto_init", false));
            }
            try {
                PackageManager packageManager = applicationContext.getPackageManager();
                if (packageManager == null || (applicationInfo = packageManager.getApplicationInfo(applicationContext.getPackageName(), 128)) == null || applicationInfo.metaData == null || !applicationInfo.metaData.containsKey("firebase_messaging_auto_init_enabled")) {
                    return null;
                }
                return Boolean.valueOf(applicationInfo.metaData.getBoolean("firebase_messaging_auto_init_enabled"));
            } catch (PackageManager.NameNotFoundException unused) {
                return null;
            }
        }

        private final boolean zzc() {
            try {
                Class.forName("com.google.firebase.messaging.FirebaseMessaging");
                return true;
            } catch (ClassNotFoundException unused) {
                Context applicationContext = FirebaseInstanceId.this.zze.getApplicationContext();
                Intent intent = new Intent("com.google.firebase.MESSAGING_EVENT");
                intent.setPackage(applicationContext.getPackageName());
                ResolveInfo resolveInfoResolveService = applicationContext.getPackageManager().resolveService(intent, 0);
                return (resolveInfoResolveService == null || resolveInfoResolveService.serviceInfo == null) ? false : true;
            }
        }
    }

    private FirebaseInstanceId(FirebaseApp firebaseApp, zzaf zzafVar, Executor executor, Executor executor2, Subscriber subscriber, UserAgentPublisher userAgentPublisher) {
        this.zzj = false;
        if (zzaf.zza(firebaseApp) == null) {
            throw new IllegalStateException("FirebaseInstanceId failed to initialize, FirebaseApp is missing project ID");
        }
        synchronized (FirebaseInstanceId.class) {
            if (zzb == null) {
                zzb = new zzaq(firebaseApp.getApplicationContext());
            }
        }
        this.zze = firebaseApp;
        this.zzf = zzafVar;
        this.zzg = new zzk(firebaseApp, zzafVar, executor, userAgentPublisher);
        this.zzd = executor2;
        this.zzi = new zzau(zzb);
        this.zzk = new zza(subscriber);
        this.zzh = new zzak(executor);
        if (this.zzk.zza()) {
            zzi();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzi() {
        if (zza(zzb()) || this.zzi.zza()) {
            zzj();
        }
    }

    final FirebaseApp zza() {
        return this.zze;
    }

    final synchronized void zza(boolean z) {
        this.zzj = z;
    }

    private final synchronized void zzj() {
        if (!this.zzj) {
            zza(0L);
        }
    }

    final synchronized void zza(long j) {
        zza(new zzas(this, this.zzf, this.zzi, Math.min(Math.max(30L, j << 1), zza)), j);
        this.zzj = true;
    }

    static void zza(Runnable runnable, long j) {
        synchronized (FirebaseInstanceId.class) {
            if (zzc == null) {
                zzc = new ScheduledThreadPoolExecutor(1, new NamedThreadFactory("FirebaseInstanceId"));
            }
            zzc.schedule(runnable, j, TimeUnit.SECONDS);
        }
    }

    @WorkerThread
    public String getId() {
        zzi();
        return zzk();
    }

    private static String zzk() {
        return zzb.zzb("").zza();
    }

    public long getCreationTime() {
        return zzb.zzb("").zzb();
    }

    @NonNull
    public Task<InstanceIdResult> getInstanceId() {
        return zza(zzaf.zza(this.zze), "*");
    }

    private final Task<InstanceIdResult> zza(final String str, String str2) {
        final String strZzd = zzd(str2);
        return Tasks.forResult(null).continueWithTask(this.zzd, new Continuation(this, str, strZzd) { // from class: com.google.firebase.iid.zzg
            private final FirebaseInstanceId zza;
            private final String zzb;
            private final String zzc;

            {
                this.zza = this;
                this.zzb = str;
                this.zzc = strZzd;
            }

            @Override // com.google.android.gms.tasks.Continuation
            public final Object then(Task task) {
                return this.zza.zza(this.zzb, this.zzc, task);
            }
        });
    }

    @WorkerThread
    public void deleteInstanceId() throws IOException {
        if (Looper.getMainLooper() == Looper.myLooper()) {
            throw new IOException("MAIN_THREAD");
        }
        zza(this.zzg.zza(zzk()));
        zze();
    }

    @Nullable
    @Deprecated
    public String getToken() {
        zzap zzapVarZzb = zzb();
        if (zza(zzapVarZzb)) {
            zzj();
        }
        return zzap.zza(zzapVarZzb);
    }

    @WorkerThread
    public String getToken(String str, String str2) throws IOException {
        if (Looper.getMainLooper() == Looper.myLooper()) {
            throw new IOException("MAIN_THREAD");
        }
        return ((InstanceIdResult) zza(zza(str, str2))).getToken();
    }

    @Nullable
    final zzap zzb() {
        return zzb(zzaf.zza(this.zze), "*");
    }

    @Nullable
    @VisibleForTesting
    private static zzap zzb(String str, String str2) {
        return zzb.zza("", str, str2);
    }

    final String zzc() throws IOException {
        return getToken(zzaf.zza(this.zze), "*");
    }

    private final <T> T zza(Task<T> task) throws IOException {
        try {
            return (T) Tasks.await(task, 30000L, TimeUnit.MILLISECONDS);
        } catch (InterruptedException | TimeoutException unused) {
            throw new IOException("SERVICE_NOT_AVAILABLE");
        } catch (ExecutionException e) {
            Throwable cause = e.getCause();
            if (cause instanceof IOException) {
                if ("INSTANCE_ID_RESET".equals(cause.getMessage())) {
                    zze();
                }
                throw ((IOException) cause);
            }
            if (cause instanceof RuntimeException) {
                throw ((RuntimeException) cause);
            }
            throw new IOException(e);
        }
    }

    @WorkerThread
    public void deleteToken(String str, String str2) throws IOException {
        if (Looper.getMainLooper() == Looper.myLooper()) {
            throw new IOException("MAIN_THREAD");
        }
        String strZzd = zzd(str2);
        zza(this.zzg.zzb(zzk(), str, strZzd));
        zzb.zzb("", str, strZzd);
    }

    public final synchronized Task<Void> zza(String str) {
        Task<Void> taskZza;
        taskZza = this.zzi.zza(str);
        zzj();
        return taskZza;
    }

    final void zzb(String str) throws IOException {
        zzap zzapVarZzb = zzb();
        if (zza(zzapVarZzb)) {
            throw new IOException("token not available");
        }
        zza(this.zzg.zzc(zzk(), zzapVarZzb.zza, str));
    }

    final void zzc(String str) throws IOException {
        zzap zzapVarZzb = zzb();
        if (zza(zzapVarZzb)) {
            throw new IOException("token not available");
        }
        zza(this.zzg.zzd(zzk(), zzapVarZzb.zza, str));
    }

    static boolean zzd() {
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            return true;
        }
        return Build.VERSION.SDK_INT == 23 && Log.isLoggable("FirebaseInstanceId", 3);
    }

    final synchronized void zze() {
        zzb.zzb();
        if (this.zzk.zza()) {
            zzj();
        }
    }

    final boolean zzf() {
        return this.zzf.zza() != 0;
    }

    final void zzg() {
        zzb.zzc("");
        zzj();
    }

    @VisibleForTesting
    public final boolean zzh() {
        return this.zzk.zza();
    }

    @VisibleForTesting
    public final void zzb(boolean z) {
        this.zzk.zza(z);
    }

    private static String zzd(String str) {
        return (str.isEmpty() || str.equalsIgnoreCase("fcm") || str.equalsIgnoreCase("gcm")) ? "*" : str;
    }

    final boolean zza(@Nullable zzap zzapVar) {
        return zzapVar == null || zzapVar.zzb(this.zzf.zzb());
    }

    final /* synthetic */ Task zza(final String str, final String str2, Task task) throws Exception {
        final String strZzk = zzk();
        zzap zzapVarZzb = zzb(str, str2);
        if (!zza(zzapVarZzb)) {
            return Tasks.forResult(new zzt(strZzk, zzapVarZzb.zza));
        }
        return this.zzh.zza(str, str2, new zzam(this, strZzk, str, str2) { // from class: com.google.firebase.iid.zzi
            private final FirebaseInstanceId zza;
            private final String zzb;
            private final String zzc;
            private final String zzd;

            {
                this.zza = this;
                this.zzb = strZzk;
                this.zzc = str;
                this.zzd = str2;
            }

            @Override // com.google.firebase.iid.zzam
            public final Task zza() {
                return this.zza.zza(this.zzb, this.zzc, this.zzd);
            }
        });
    }

    final /* synthetic */ Task zza(final String str, final String str2, final String str3) {
        return this.zzg.zza(str, str2, str3).onSuccessTask(this.zzd, new SuccessContinuation(this, str2, str3, str) { // from class: com.google.firebase.iid.zzh
            private final FirebaseInstanceId zza;
            private final String zzb;
            private final String zzc;
            private final String zzd;

            {
                this.zza = this;
                this.zzb = str2;
                this.zzc = str3;
                this.zzd = str;
            }

            @Override // com.google.android.gms.tasks.SuccessContinuation
            public final Task then(Object obj) {
                return this.zza.zza(this.zzb, this.zzc, this.zzd, (String) obj);
            }
        });
    }

    final /* synthetic */ Task zza(String str, String str2, String str3, String str4) throws Exception {
        zzb.zza("", str, str2, str4, this.zzf.zzb());
        return Tasks.forResult(new zzt(str3, str4));
    }
}
