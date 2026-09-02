package com.google.android.gms.internal.measurement;

import android.os.Bundle;
import android.os.IInterface;
import android.os.RemoteException;

/* JADX INFO: loaded from: classes.dex */
public interface zzq extends IInterface {
    /* JADX INFO: renamed from: id */
    int mo42id() throws RemoteException;

    void onEvent(String str, String str2, Bundle bundle, long j) throws RemoteException;
}
