package com.google.firebase.iid;

import androidx.annotation.Keep;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.firebase.FirebaseApp;
import com.google.firebase.components.Component;
import com.google.firebase.components.ComponentRegistrar;
import com.google.firebase.components.Dependency;
import com.google.firebase.events.Subscriber;
import com.google.firebase.iid.internal.FirebaseInstanceIdInternal;
import com.google.firebase.platforminfo.LibraryVersionComponent;
import com.google.firebase.platforminfo.UserAgentPublisher;
import java.util.Arrays;
import java.util.List;

/* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
/* JADX INFO: loaded from: classes.dex */
@Keep
@KeepForSdk
public final class Registrar implements ComponentRegistrar {
    @Override // com.google.firebase.components.ComponentRegistrar
    @Keep
    public final List<Component<?>> getComponents() {
        return Arrays.asList(Component.builder(FirebaseInstanceId.class).add(Dependency.required(FirebaseApp.class)).add(Dependency.required(Subscriber.class)).add(Dependency.required(UserAgentPublisher.class)).factory(zzah.zza).alwaysEager().build(), Component.builder(FirebaseInstanceIdInternal.class).add(Dependency.required(FirebaseInstanceId.class)).factory(zzai.zza).build(), LibraryVersionComponent.create("fire-iid", "19.0.1"));
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: compiled from: com.google.firebase:firebase-iid@@19.0.1 */
    static class zza implements FirebaseInstanceIdInternal {
        private final FirebaseInstanceId zza;

        public zza(FirebaseInstanceId firebaseInstanceId) {
            this.zza = firebaseInstanceId;
        }

        @Override // com.google.firebase.iid.internal.FirebaseInstanceIdInternal
        public final String getId() {
            return this.zza.getId();
        }

        @Override // com.google.firebase.iid.internal.FirebaseInstanceIdInternal
        public final String getToken() {
            return this.zza.getToken();
        }
    }
}
