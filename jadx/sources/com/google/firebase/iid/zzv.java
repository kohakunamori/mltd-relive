package com.google.firebase.iid;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.util.Log;
import android.util.SparseArray;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.stats.ConnectionTracker;
import java.util.ArrayDeque;
import java.util.Iterator;
import java.util.Queue;
import java.util.concurrent.TimeUnit;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final class zzv implements ServiceConnection {

    @GuardedBy("this")
    int zza;
    final Messenger zzb;
    zzac zzc;

    @GuardedBy("this")
    final Queue<zzae<?>> zzd;

    @GuardedBy("this")
    final SparseArray<zzae<?>> zze;
    final /* synthetic */ zzu zzf;

    private zzv(zzu zzuVar) {
        this.zzf = zzuVar;
        this.zza = 0;
        this.zzb = new Messenger(new com.google.android.gms.internal.firebase_messaging.zze(Looper.getMainLooper(), new Handler.Callback(this) { // from class: com.google.firebase.iid.zzy
            private final zzv zza;

            {
                this.zza = this;
            }

            @Override // android.os.Handler.Callback
            public final boolean handleMessage(Message message) {
                return this.zza.zza(message);
            }
        }));
        this.zzd = new ArrayDeque();
        this.zze = new SparseArray<>();
    }

    final synchronized boolean zza(zzae<?> zzaeVar) {
        switch (this.zza) {
            case 0:
                this.zzd.add(zzaeVar);
                Preconditions.checkState(this.zza == 0);
                if (Log.isLoggable("MessengerIpcClient", 2)) {
                    Log.v("MessengerIpcClient", "Starting bind to GmsCore");
                }
                this.zza = 1;
                Intent intent = new Intent("com.google.android.c2dm.intent.REGISTER");
                intent.setPackage("com.google.android.gms");
                if (!ConnectionTracker.getInstance().bindService(this.zzf.zzb, intent, this, 1)) {
                    zza(0, "Unable to bind to service");
                } else {
                    this.zzf.zzc.schedule(new Runnable(this) { // from class: com.google.firebase.iid.zzx
                        private final zzv zza;

                        {
                            this.zza = this;
                        }

                        @Override // java.lang.Runnable
                        public final void run() {
                            this.zza.zzb();
                        }
                    }, 30L, TimeUnit.SECONDS);
                }
                return true;
            case 1:
                this.zzd.add(zzaeVar);
                return true;
            case 2:
                this.zzd.add(zzaeVar);
                zzc();
                return true;
            case 3:
            case 4:
                return false;
            default:
                int i = this.zza;
                StringBuilder sb = new StringBuilder(26);
                sb.append("Unknown state: ");
                sb.append(i);
                throw new IllegalStateException(sb.toString());
        }
    }

    final boolean zza(Message message) {
        int i = message.arg1;
        if (Log.isLoggable("MessengerIpcClient", 3)) {
            StringBuilder sb = new StringBuilder(41);
            sb.append("Received response to request: ");
            sb.append(i);
            Log.d("MessengerIpcClient", sb.toString());
        }
        synchronized (this) {
            zzae<?> zzaeVar = this.zze.get(i);
            if (zzaeVar == null) {
                StringBuilder sb2 = new StringBuilder(50);
                sb2.append("Received response for unknown request: ");
                sb2.append(i);
                Log.w("MessengerIpcClient", sb2.toString());
                return true;
            }
            this.zze.remove(i);
            zza();
            Bundle data = message.getData();
            if (data.getBoolean("unsupported", false)) {
                zzaeVar.zza(new zzad(4, "Not supported by GmsCore"));
            } else {
                zzaeVar.zza(data);
            }
            return true;
        }
    }

    @Override // android.content.ServiceConnection
    public final synchronized void onServiceConnected(ComponentName componentName, IBinder iBinder) {
        if (Log.isLoggable("MessengerIpcClient", 2)) {
            Log.v("MessengerIpcClient", "Service connected");
        }
        if (iBinder == null) {
            zza(0, "Null service connection");
            return;
        }
        try {
            this.zzc = new zzac(iBinder);
            this.zza = 2;
            zzc();
        } catch (RemoteException e) {
            zza(0, e.getMessage());
        }
    }

    private final void zzc() {
        this.zzf.zzc.execute(new Runnable(this) { // from class: com.google.firebase.iid.zzaa
            private final zzv zza;

            {
                this.zza = this;
            }

            @Override // java.lang.Runnable
            public final void run() {
                final zzae<?> zzaeVarPoll;
                final zzv zzvVar = this.zza;
                while (true) {
                    synchronized (zzvVar) {
                        if (zzvVar.zza != 2) {
                            return;
                        }
                        if (zzvVar.zzd.isEmpty()) {
                            zzvVar.zza();
                            return;
                        } else {
                            zzaeVarPoll = zzvVar.zzd.poll();
                            zzvVar.zze.put(zzaeVarPoll.zza, zzaeVarPoll);
                            zzvVar.zzf.zzc.schedule(new Runnable(zzvVar, zzaeVarPoll) { // from class: com.google.firebase.iid.zzz
                                private final zzv zza;
                                private final zzae zzb;

                                {
                                    this.zza = zzvVar;
                                    this.zzb = zzaeVarPoll;
                                }

                                @Override // java.lang.Runnable
                                public final void run() {
                                    this.zza.zza(this.zzb.zza);
                                }
                            }, 30L, TimeUnit.SECONDS);
                        }
                    }
                    if (Log.isLoggable("MessengerIpcClient", 3)) {
                        String strValueOf = String.valueOf(zzaeVarPoll);
                        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 8);
                        sb.append("Sending ");
                        sb.append(strValueOf);
                        Log.d("MessengerIpcClient", sb.toString());
                    }
                    Context context = zzvVar.zzf.zzb;
                    Messenger messenger = zzvVar.zzb;
                    Message messageObtain = Message.obtain();
                    messageObtain.what = zzaeVarPoll.zzc;
                    messageObtain.arg1 = zzaeVarPoll.zza;
                    messageObtain.replyTo = messenger;
                    Bundle bundle = new Bundle();
                    bundle.putBoolean("oneWay", zzaeVarPoll.zza());
                    bundle.putString("pkg", context.getPackageName());
                    bundle.putBundle("data", zzaeVarPoll.zzd);
                    messageObtain.setData(bundle);
                    try {
                        zzvVar.zzc.zza(messageObtain);
                    } catch (RemoteException e) {
                        zzvVar.zza(2, e.getMessage());
                    }
                }
            }
        });
    }

    @Override // android.content.ServiceConnection
    public final synchronized void onServiceDisconnected(ComponentName componentName) {
        if (Log.isLoggable("MessengerIpcClient", 2)) {
            Log.v("MessengerIpcClient", "Service disconnected");
        }
        zza(2, "Service disconnected");
    }

    final synchronized void zza(int i, String str) {
        if (Log.isLoggable("MessengerIpcClient", 3)) {
            String strValueOf = String.valueOf(str);
            Log.d("MessengerIpcClient", strValueOf.length() != 0 ? "Disconnected: ".concat(strValueOf) : new String("Disconnected: "));
        }
        switch (this.zza) {
            case 0:
                throw new IllegalStateException();
            case 1:
            case 2:
                if (Log.isLoggable("MessengerIpcClient", 2)) {
                    Log.v("MessengerIpcClient", "Unbinding service");
                }
                this.zza = 4;
                ConnectionTracker.getInstance().unbindService(this.zzf.zzb, this);
                zzad zzadVar = new zzad(i, str);
                Iterator<zzae<?>> it = this.zzd.iterator();
                while (it.hasNext()) {
                    it.next().zza(zzadVar);
                }
                this.zzd.clear();
                for (int i2 = 0; i2 < this.zze.size(); i2++) {
                    this.zze.valueAt(i2).zza(zzadVar);
                }
                this.zze.clear();
                return;
            case 3:
                this.zza = 4;
                return;
            case 4:
                return;
            default:
                int i3 = this.zza;
                StringBuilder sb = new StringBuilder(26);
                sb.append("Unknown state: ");
                sb.append(i3);
                throw new IllegalStateException(sb.toString());
        }
    }

    final synchronized void zza() {
        if (this.zza == 2 && this.zzd.isEmpty() && this.zze.size() == 0) {
            if (Log.isLoggable("MessengerIpcClient", 2)) {
                Log.v("MessengerIpcClient", "Finished handling requests, unbinding");
            }
            this.zza = 3;
            ConnectionTracker.getInstance().unbindService(this.zzf.zzb, this);
        }
    }

    final synchronized void zzb() {
        if (this.zza == 1) {
            zza(1, "Timed out while binding");
        }
    }

    final synchronized void zza(int i) {
        zzae<?> zzaeVar = this.zze.get(i);
        if (zzaeVar != null) {
            StringBuilder sb = new StringBuilder(31);
            sb.append("Timing out request: ");
            sb.append(i);
            Log.w("MessengerIpcClient", sb.toString());
            this.zze.remove(i);
            zzaeVar.zza(new zzad(3, "Timed out waiting for response"));
            zza();
        }
    }
}
