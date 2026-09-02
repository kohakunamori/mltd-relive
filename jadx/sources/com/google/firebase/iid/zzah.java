package com.google.firebase.iid;

import com.google.firebase.FirebaseApp;
import com.google.firebase.components.ComponentContainer;
import com.google.firebase.components.ComponentFactory;
import com.google.firebase.events.Subscriber;
import com.google.firebase.platforminfo.UserAgentPublisher;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzah implements ComponentFactory {
    static final ComponentFactory zza = new zzah();

    private zzah() {
    }

    @Override // com.google.firebase.components.ComponentFactory
    public final Object create(ComponentContainer componentContainer) {
        return new FirebaseInstanceId((FirebaseApp) componentContainer.get(FirebaseApp.class), (Subscriber) componentContainer.get(Subscriber.class), (UserAgentPublisher) componentContainer.get(UserAgentPublisher.class));
    }
}
