package com.smrtbeat;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import java.util.Collections;

/* JADX INFO: renamed from: com.smrtbeat.u */
/* JADX INFO: loaded from: classes.dex */
@TargetApi(14)
class C0392u {

    /* JADX INFO: renamed from: a */
    private static final String f443a = "ActivityLifecycle";

    /* JADX INFO: renamed from: com.smrtbeat.u$a */
    static class a implements Application.ActivityLifecycleCallbacks {

        /* JADX INFO: renamed from: a */
        final /* synthetic */ boolean f444a;

        a(boolean z) {
            this.f444a = z;
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivityCreated(Activity activity, Bundle bundle) {
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivityCreated()")));
            }
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivityDestroyed(Activity activity) {
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivityDestroyed()")));
            }
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivityPaused(Activity activity) {
            C0377f0.m152a(activity);
            C0368b.m82a().m86a(activity);
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivityPaused()")));
            }
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivityResumed(Activity activity) {
            C0377f0.m172b(activity);
            C0368b.m82a().m89b(activity);
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivityResumed()")));
            }
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivitySaveInstanceState(Activity activity, Bundle bundle) {
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivitySaveInstanceState()")));
            }
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivityStarted(Activity activity) {
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivityStarted()")));
            }
        }

        @Override // android.app.Application.ActivityLifecycleCallbacks
        public void onActivityStopped(Activity activity) {
            C0368b.m82a().m90c(activity);
            if (this.f444a) {
                C0377f0.m158a(new C0372d(EnumC0374e.BC2_TYPE_AUTO_BREADCRUMB, activity.getClass().getSimpleName(), Collections.singletonMap(C0392u.f443a, "onActivityStopped()")));
            }
        }
    }

    C0392u() {
    }

    /* JADX INFO: renamed from: a */
    private static Application.ActivityLifecycleCallbacks m346a(boolean z) {
        return new a(z);
    }

    /* JADX INFO: renamed from: a */
    static void m347a(Application application, boolean z) {
        if (application != null) {
            application.registerActivityLifecycleCallbacks(m346a(z));
        } else {
            C0377f0.m159a(C0377f0.e.ERROR, "Failed to register activity lifecycle callback");
        }
    }
}
