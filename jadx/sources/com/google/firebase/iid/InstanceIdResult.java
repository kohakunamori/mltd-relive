package com.google.firebase.iid;

import androidx.annotation.NonNull;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
public interface InstanceIdResult {
    @NonNull
    String getId();

    @NonNull
    String getToken();
}
