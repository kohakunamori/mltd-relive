package com.google.android.gms.internal.firebase_messaging;

import java.io.PrintStream;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public final class zzn {
    private static final zzm zza;
    private static final int zzb;

    /* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
    static final class zza extends zzm {
        zza() {
        }

        @Override // com.google.android.gms.internal.firebase_messaging.zzm
        public final void zza(Throwable th, Throwable th2) {
        }
    }

    public static void zza(Throwable th, Throwable th2) {
        zza.zza(th, th2);
    }

    private static Integer zza() {
        try {
            return (Integer) Class.forName("android.os.Build$VERSION").getField("SDK_INT").get(null);
        } catch (Exception e) {
            System.err.println("Failed to retrieve value from android.os.Build$VERSION.SDK_INT due to the following exception.");
            e.printStackTrace(System.err);
            return null;
        }
    }

    /* JADX WARN: Code duplicated, block: B:10:0x0017 A[Catch: Throwable -> 0x0015, TryCatch #1 {Throwable -> 0x0015, blocks: (B:5:0x0007, B:7:0x000f, B:10:0x0017, B:12:0x0020, B:13:0x0026), top: B:27:0x0007 }] */
    /* JADX WARN: Code duplicated, block: B:12:0x0020 A[Catch: Throwable -> 0x0015, TryCatch #1 {Throwable -> 0x0015, blocks: (B:5:0x0007, B:7:0x000f, B:10:0x0017, B:12:0x0020, B:13:0x0026), top: B:27:0x0007 }] */
    /* JADX WARN: Code duplicated, block: B:13:0x0026 A[Catch: Throwable -> 0x0015, TRY_LEAVE, TryCatch #1 {Throwable -> 0x0015, blocks: (B:5:0x0007, B:7:0x000f, B:10:0x0017, B:12:0x0020, B:13:0x0026), top: B:27:0x0007 }] */
    static {
        Integer numZza;
        zzm zzaVar;
        try {
            numZza = zza();
            if (numZza != null) {
                try {
                    if (numZza.intValue() >= 19) {
                        zzaVar = new zzr();
                    } else if (!Boolean.getBoolean("com.google.devtools.build.android.desugar.runtime.twr_disable_mimic")) {
                        zzaVar = new zzq();
                    } else {
                        zzaVar = new zza();
                    }
                } catch (Throwable th) {
                    th = th;
                    PrintStream printStream = System.err;
                    String name = zza.class.getName();
                    StringBuilder sb = new StringBuilder(String.valueOf(name).length() + 133);
                    sb.append("An error has occurred when initializing the try-with-resources desuguring strategy. The default strategy ");
                    sb.append(name);
                    sb.append("will be used. The error is: ");
                    printStream.println(sb.toString());
                    th.printStackTrace(System.err);
                    zzaVar = new zza();
                }
            } else if (!Boolean.getBoolean("com.google.devtools.build.android.desugar.runtime.twr_disable_mimic")) {
                zzaVar = new zzq();
            } else {
                zzaVar = new zza();
            }
        } catch (Throwable th2) {
            th = th2;
            numZza = null;
        }
        zza = zzaVar;
        zzb = numZza != null ? numZza.intValue() : 1;
    }
}
