package com.google.android.gms.dynamic;

import android.R;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.internal.ConnectionErrorMessages;
import com.google.android.gms.dynamic.LifecycleDelegate;
import java.util.LinkedList;

/* JADX INFO: loaded from: classes.dex */
@KeepForSdk
public abstract class DeferredLifecycleHelper<T extends LifecycleDelegate> {
    private T zarf;
    private Bundle zarg;
    private LinkedList<zaa> zarh;
    private final OnDelegateCreatedListener<T> zari = new com.google.android.gms.dynamic.zaa(this);

    /* JADX INFO: Access modifiers changed from: private */
    interface zaa {
        int getState();

        void zaa(LifecycleDelegate lifecycleDelegate);
    }

    @KeepForSdk
    public DeferredLifecycleHelper() {
    }

    @KeepForSdk
    protected abstract void createDelegate(OnDelegateCreatedListener<T> onDelegateCreatedListener);

    @KeepForSdk
    public T getDelegate() {
        return this.zarf;
    }

    private final void zal(int i) {
        while (!this.zarh.isEmpty() && this.zarh.getLast().getState() >= i) {
            this.zarh.removeLast();
        }
    }

    private final void zaa(Bundle bundle, zaa zaaVar) {
        if (this.zarf != null) {
            zaaVar.zaa(this.zarf);
            return;
        }
        if (this.zarh == null) {
            this.zarh = new LinkedList<>();
        }
        this.zarh.add(zaaVar);
        if (bundle != null) {
            if (this.zarg == null) {
                this.zarg = (Bundle) bundle.clone();
            } else {
                this.zarg.putAll(bundle);
            }
        }
        createDelegate(this.zari);
    }

    @KeepForSdk
    public void onInflate(Activity activity, Bundle bundle, Bundle bundle2) {
        zaa(bundle2, new zab(this, activity, bundle, bundle2));
    }

    @KeepForSdk
    public void onCreate(Bundle bundle) {
        zaa(bundle, new zac(this, bundle));
    }

    @KeepForSdk
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        FrameLayout frameLayout = new FrameLayout(layoutInflater.getContext());
        zaa(bundle, new zad(this, frameLayout, layoutInflater, viewGroup, bundle));
        if (this.zarf == null) {
            handleGooglePlayUnavailable(frameLayout);
        }
        return frameLayout;
    }

    @KeepForSdk
    protected void handleGooglePlayUnavailable(FrameLayout frameLayout) {
        showGooglePlayUnavailableMessage(frameLayout);
    }

    @KeepForSdk
    public static void showGooglePlayUnavailableMessage(FrameLayout frameLayout) {
        GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();
        Context context = frameLayout.getContext();
        int iIsGooglePlayServicesAvailable = googleApiAvailability.isGooglePlayServicesAvailable(context);
        String errorMessage = ConnectionErrorMessages.getErrorMessage(context, iIsGooglePlayServicesAvailable);
        String errorDialogButtonMessage = ConnectionErrorMessages.getErrorDialogButtonMessage(context, iIsGooglePlayServicesAvailable);
        LinearLayout linearLayout = new LinearLayout(frameLayout.getContext());
        linearLayout.setOrientation(1);
        linearLayout.setLayoutParams(new FrameLayout.LayoutParams(-2, -2));
        frameLayout.addView(linearLayout);
        TextView textView = new TextView(frameLayout.getContext());
        textView.setLayoutParams(new FrameLayout.LayoutParams(-2, -2));
        textView.setText(errorMessage);
        linearLayout.addView(textView);
        Intent errorResolutionIntent = googleApiAvailability.getErrorResolutionIntent(context, iIsGooglePlayServicesAvailable, null);
        if (errorResolutionIntent != null) {
            Button button = new Button(context);
            button.setId(R.id.button1);
            button.setLayoutParams(new FrameLayout.LayoutParams(-2, -2));
            button.setText(errorDialogButtonMessage);
            linearLayout.addView(button);
            button.setOnClickListener(new zae(context, errorResolutionIntent));
        }
    }

    @KeepForSdk
    public void onStart() {
        zaa((Bundle) null, new zaf(this));
    }

    @KeepForSdk
    public void onResume() {
        zaa((Bundle) null, new zag(this));
    }

    @KeepForSdk
    public void onPause() {
        if (this.zarf != null) {
            this.zarf.onPause();
        } else {
            zal(5);
        }
    }

    @KeepForSdk
    public void onStop() {
        if (this.zarf != null) {
            this.zarf.onStop();
        } else {
            zal(4);
        }
    }

    @KeepForSdk
    public void onDestroyView() {
        if (this.zarf != null) {
            this.zarf.onDestroyView();
        } else {
            zal(2);
        }
    }

    @KeepForSdk
    public void onDestroy() {
        if (this.zarf != null) {
            this.zarf.onDestroy();
        } else {
            zal(1);
        }
    }

    @KeepForSdk
    public void onSaveInstanceState(Bundle bundle) {
        if (this.zarf != null) {
            this.zarf.onSaveInstanceState(bundle);
        } else if (this.zarg != null) {
            bundle.putAll(this.zarg);
        }
    }

    @KeepForSdk
    public void onLowMemory() {
        if (this.zarf != null) {
            this.zarf.onLowMemory();
        }
    }

    static /* synthetic */ Bundle zaa(DeferredLifecycleHelper deferredLifecycleHelper, Bundle bundle) {
        deferredLifecycleHelper.zarg = null;
        return null;
    }
}
