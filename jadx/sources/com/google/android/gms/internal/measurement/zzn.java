package com.google.android.gms.internal.measurement;

import android.os.Bundle;
import android.os.IBinder;
import android.os.IInterface;
import android.os.Parcel;
import android.os.RemoteException;
import androidx.core.view.MotionEventCompat;
import com.google.android.gms.dynamic.IObjectWrapper;
import org.apache.commons.net.ftp.FTPCommand;

/* JADX INFO: loaded from: classes.dex */
public abstract class zzn extends zza implements zzk {
    public zzn() {
        super("com.google.android.gms.measurement.api.internal.IAppMeasurementDynamiteService");
    }

    public static zzk asInterface(IBinder iBinder) {
        if (iBinder == null) {
            return null;
        }
        IInterface iInterfaceQueryLocalInterface = iBinder.queryLocalInterface("com.google.android.gms.measurement.api.internal.IAppMeasurementDynamiteService");
        if (iInterfaceQueryLocalInterface instanceof zzk) {
            return (zzk) iInterfaceQueryLocalInterface;
        }
        return new zzm(iBinder);
    }

    @Override // com.google.android.gms.internal.measurement.zza
    protected final boolean zza(int i, Parcel parcel, Parcel parcel2, int i2) throws RemoteException {
        zzp zzrVar = null;
        zzp zzrVar2 = null;
        zzp zzrVar3 = null;
        zzp zzrVar4 = null;
        zzq zzsVar = null;
        zzq zzsVar2 = null;
        zzq zzsVar3 = null;
        zzp zzrVar5 = null;
        zzp zzrVar6 = null;
        zzp zzrVar7 = null;
        zzp zzrVar8 = null;
        zzp zzrVar9 = null;
        zzp zzrVar10 = null;
        zzv zzuVar = null;
        zzp zzrVar11 = null;
        zzp zzrVar12 = null;
        zzp zzrVar13 = null;
        zzp zzrVar14 = null;
        zzp zzrVar15 = null;
        switch (i) {
            case 1:
                initialize(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), (zzx) zzd.zza(parcel, zzx.CREATOR), parcel.readLong());
                break;
            case 2:
                logEvent(parcel.readString(), parcel.readString(), (Bundle) zzd.zza(parcel, Bundle.CREATOR), zzd.zza(parcel), zzd.zza(parcel), parcel.readLong());
                break;
            case 3:
                String string = parcel.readString();
                String string2 = parcel.readString();
                Bundle bundle = (Bundle) zzd.zza(parcel, Bundle.CREATOR);
                IBinder strongBinder = parcel.readStrongBinder();
                if (strongBinder != null) {
                    IInterface iInterfaceQueryLocalInterface = strongBinder.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface instanceof zzp) {
                        zzrVar = (zzp) iInterfaceQueryLocalInterface;
                    } else {
                        zzrVar = new zzr(strongBinder);
                    }
                }
                logEventAndBundle(string, string2, bundle, zzrVar, parcel.readLong());
                break;
            case 4:
                setUserProperty(parcel.readString(), parcel.readString(), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), zzd.zza(parcel), parcel.readLong());
                break;
            case 5:
                String string3 = parcel.readString();
                String string4 = parcel.readString();
                boolean zZza = zzd.zza(parcel);
                IBinder strongBinder2 = parcel.readStrongBinder();
                if (strongBinder2 != null) {
                    IInterface iInterfaceQueryLocalInterface2 = strongBinder2.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface2 instanceof zzp) {
                        zzrVar15 = (zzp) iInterfaceQueryLocalInterface2;
                    } else {
                        zzrVar15 = new zzr(strongBinder2);
                    }
                }
                getUserProperties(string3, string4, zZza, zzrVar15);
                break;
            case 6:
                String string5 = parcel.readString();
                IBinder strongBinder3 = parcel.readStrongBinder();
                if (strongBinder3 != null) {
                    IInterface iInterfaceQueryLocalInterface3 = strongBinder3.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface3 instanceof zzp) {
                        zzrVar14 = (zzp) iInterfaceQueryLocalInterface3;
                    } else {
                        zzrVar14 = new zzr(strongBinder3);
                    }
                }
                getMaxUserProperties(string5, zzrVar14);
                break;
            case 7:
                setUserId(parcel.readString(), parcel.readLong());
                break;
            case 8:
                setConditionalUserProperty((Bundle) zzd.zza(parcel, Bundle.CREATOR), parcel.readLong());
                break;
            case 9:
                clearConditionalUserProperty(parcel.readString(), parcel.readString(), (Bundle) zzd.zza(parcel, Bundle.CREATOR));
                break;
            case 10:
                String string6 = parcel.readString();
                String string7 = parcel.readString();
                IBinder strongBinder4 = parcel.readStrongBinder();
                if (strongBinder4 != null) {
                    IInterface iInterfaceQueryLocalInterface4 = strongBinder4.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface4 instanceof zzp) {
                        zzrVar13 = (zzp) iInterfaceQueryLocalInterface4;
                    } else {
                        zzrVar13 = new zzr(strongBinder4);
                    }
                }
                getConditionalUserProperties(string6, string7, zzrVar13);
                break;
            case 11:
                setMeasurementEnabled(zzd.zza(parcel), parcel.readLong());
                break;
            case 12:
                resetAnalyticsData(parcel.readLong());
                break;
            case 13:
                setMinimumSessionDuration(parcel.readLong());
                break;
            case 14:
                setSessionTimeoutDuration(parcel.readLong());
                break;
            case 15:
                setCurrentScreen(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readString(), parcel.readString(), parcel.readLong());
                break;
            case 16:
                IBinder strongBinder5 = parcel.readStrongBinder();
                if (strongBinder5 != null) {
                    IInterface iInterfaceQueryLocalInterface5 = strongBinder5.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface5 instanceof zzp) {
                        zzrVar12 = (zzp) iInterfaceQueryLocalInterface5;
                    } else {
                        zzrVar12 = new zzr(strongBinder5);
                    }
                }
                getCurrentScreenName(zzrVar12);
                break;
            case 17:
                IBinder strongBinder6 = parcel.readStrongBinder();
                if (strongBinder6 != null) {
                    IInterface iInterfaceQueryLocalInterface6 = strongBinder6.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface6 instanceof zzp) {
                        zzrVar11 = (zzp) iInterfaceQueryLocalInterface6;
                    } else {
                        zzrVar11 = new zzr(strongBinder6);
                    }
                }
                getCurrentScreenClass(zzrVar11);
                break;
            case 18:
                IBinder strongBinder7 = parcel.readStrongBinder();
                if (strongBinder7 != null) {
                    IInterface iInterfaceQueryLocalInterface7 = strongBinder7.queryLocalInterface("com.google.android.gms.measurement.api.internal.IStringProvider");
                    if (iInterfaceQueryLocalInterface7 instanceof zzv) {
                        zzuVar = (zzv) iInterfaceQueryLocalInterface7;
                    } else {
                        zzuVar = new zzu(strongBinder7);
                    }
                }
                setInstanceIdProvider(zzuVar);
                break;
            case 19:
                IBinder strongBinder8 = parcel.readStrongBinder();
                if (strongBinder8 != null) {
                    IInterface iInterfaceQueryLocalInterface8 = strongBinder8.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface8 instanceof zzp) {
                        zzrVar10 = (zzp) iInterfaceQueryLocalInterface8;
                    } else {
                        zzrVar10 = new zzr(strongBinder8);
                    }
                }
                getCachedAppInstanceId(zzrVar10);
                break;
            case 20:
                IBinder strongBinder9 = parcel.readStrongBinder();
                if (strongBinder9 != null) {
                    IInterface iInterfaceQueryLocalInterface9 = strongBinder9.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface9 instanceof zzp) {
                        zzrVar9 = (zzp) iInterfaceQueryLocalInterface9;
                    } else {
                        zzrVar9 = new zzr(strongBinder9);
                    }
                }
                getAppInstanceId(zzrVar9);
                break;
            case 21:
                IBinder strongBinder10 = parcel.readStrongBinder();
                if (strongBinder10 != null) {
                    IInterface iInterfaceQueryLocalInterface10 = strongBinder10.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface10 instanceof zzp) {
                        zzrVar8 = (zzp) iInterfaceQueryLocalInterface10;
                    } else {
                        zzrVar8 = new zzr(strongBinder10);
                    }
                }
                getGmpAppId(zzrVar8);
                break;
            case 22:
                IBinder strongBinder11 = parcel.readStrongBinder();
                if (strongBinder11 != null) {
                    IInterface iInterfaceQueryLocalInterface11 = strongBinder11.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface11 instanceof zzp) {
                        zzrVar7 = (zzp) iInterfaceQueryLocalInterface11;
                    } else {
                        zzrVar7 = new zzr(strongBinder11);
                    }
                }
                generateEventId(zzrVar7);
                break;
            case 23:
                beginAdUnitExposure(parcel.readString(), parcel.readLong());
                break;
            case 24:
                endAdUnitExposure(parcel.readString(), parcel.readLong());
                break;
            case 25:
                onActivityStarted(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readLong());
                break;
            case 26:
                onActivityStopped(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readLong());
                break;
            case 27:
                onActivityCreated(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), (Bundle) zzd.zza(parcel, Bundle.CREATOR), parcel.readLong());
                break;
            case 28:
                onActivityDestroyed(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readLong());
                break;
            case 29:
                onActivityPaused(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readLong());
                break;
            case 30:
                onActivityResumed(IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), parcel.readLong());
                break;
            case FTPCommand.HELP /* 31 */:
                IObjectWrapper iObjectWrapperAsInterface = IObjectWrapper.Stub.asInterface(parcel.readStrongBinder());
                IBinder strongBinder12 = parcel.readStrongBinder();
                if (strongBinder12 != null) {
                    IInterface iInterfaceQueryLocalInterface12 = strongBinder12.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface12 instanceof zzp) {
                        zzrVar6 = (zzp) iInterfaceQueryLocalInterface12;
                    } else {
                        zzrVar6 = new zzr(strongBinder12);
                    }
                }
                onActivitySaveInstanceState(iObjectWrapperAsInterface, zzrVar6, parcel.readLong());
                break;
            case 32:
                Bundle bundle2 = (Bundle) zzd.zza(parcel, Bundle.CREATOR);
                IBinder strongBinder13 = parcel.readStrongBinder();
                if (strongBinder13 != null) {
                    IInterface iInterfaceQueryLocalInterface13 = strongBinder13.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface13 instanceof zzp) {
                        zzrVar5 = (zzp) iInterfaceQueryLocalInterface13;
                    } else {
                        zzrVar5 = new zzr(strongBinder13);
                    }
                }
                performAction(bundle2, zzrVar5, parcel.readLong());
                break;
            case 33:
                logHealthData(parcel.readInt(), parcel.readString(), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()), IObjectWrapper.Stub.asInterface(parcel.readStrongBinder()));
                break;
            case 34:
                IBinder strongBinder14 = parcel.readStrongBinder();
                if (strongBinder14 != null) {
                    IInterface iInterfaceQueryLocalInterface14 = strongBinder14.queryLocalInterface("com.google.android.gms.measurement.api.internal.IEventHandlerProxy");
                    if (iInterfaceQueryLocalInterface14 instanceof zzq) {
                        zzsVar3 = (zzq) iInterfaceQueryLocalInterface14;
                    } else {
                        zzsVar3 = new zzs(strongBinder14);
                    }
                }
                setEventInterceptor(zzsVar3);
                break;
            case 35:
                IBinder strongBinder15 = parcel.readStrongBinder();
                if (strongBinder15 != null) {
                    IInterface iInterfaceQueryLocalInterface15 = strongBinder15.queryLocalInterface("com.google.android.gms.measurement.api.internal.IEventHandlerProxy");
                    if (iInterfaceQueryLocalInterface15 instanceof zzq) {
                        zzsVar2 = (zzq) iInterfaceQueryLocalInterface15;
                    } else {
                        zzsVar2 = new zzs(strongBinder15);
                    }
                }
                registerOnMeasurementEventListener(zzsVar2);
                break;
            case 36:
                IBinder strongBinder16 = parcel.readStrongBinder();
                if (strongBinder16 != null) {
                    IInterface iInterfaceQueryLocalInterface16 = strongBinder16.queryLocalInterface("com.google.android.gms.measurement.api.internal.IEventHandlerProxy");
                    if (iInterfaceQueryLocalInterface16 instanceof zzq) {
                        zzsVar = (zzq) iInterfaceQueryLocalInterface16;
                    } else {
                        zzsVar = new zzs(strongBinder16);
                    }
                }
                unregisterOnMeasurementEventListener(zzsVar);
                break;
            case 37:
                initForTests(zzd.zzb(parcel));
                break;
            case 38:
                IBinder strongBinder17 = parcel.readStrongBinder();
                if (strongBinder17 != null) {
                    IInterface iInterfaceQueryLocalInterface17 = strongBinder17.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface17 instanceof zzp) {
                        zzrVar4 = (zzp) iInterfaceQueryLocalInterface17;
                    } else {
                        zzrVar4 = new zzr(strongBinder17);
                    }
                }
                getTestFlag(zzrVar4, parcel.readInt());
                break;
            case 39:
                setDataCollectionEnabled(zzd.zza(parcel));
                break;
            case MotionEventCompat.AXIS_GENERIC_9 /* 40 */:
                IBinder strongBinder18 = parcel.readStrongBinder();
                if (strongBinder18 != null) {
                    IInterface iInterfaceQueryLocalInterface18 = strongBinder18.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface18 instanceof zzp) {
                        zzrVar3 = (zzp) iInterfaceQueryLocalInterface18;
                    } else {
                        zzrVar3 = new zzr(strongBinder18);
                    }
                }
                isDataCollectionEnabled(zzrVar3);
                break;
            case MotionEventCompat.AXIS_GENERIC_10 /* 41 */:
                IBinder strongBinder19 = parcel.readStrongBinder();
                if (strongBinder19 != null) {
                    IInterface iInterfaceQueryLocalInterface19 = strongBinder19.queryLocalInterface("com.google.android.gms.measurement.api.internal.IBundleReceiver");
                    if (iInterfaceQueryLocalInterface19 instanceof zzp) {
                        zzrVar2 = (zzp) iInterfaceQueryLocalInterface19;
                    } else {
                        zzrVar2 = new zzr(strongBinder19);
                    }
                }
                getDeepLink(zzrVar2);
                break;
            default:
                return false;
        }
        parcel2.writeNoException();
        return true;
    }
}
