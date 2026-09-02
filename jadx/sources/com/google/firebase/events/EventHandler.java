package com.google.firebase.events;

import com.google.android.gms.common.annotation.KeepForSdk;

/* JADX INFO: compiled from: com.google.firebase:firebase-common@@17.1.0 */
/* JADX INFO: loaded from: classes.dex */
@KeepForSdk
public interface EventHandler<T> {
    @KeepForSdk
    void handle(Event<T> event);
}
