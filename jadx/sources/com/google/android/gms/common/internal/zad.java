package com.google.android.gms.common.internal;

import android.content.Intent;
import androidx.fragment.app.Fragment;

/* JADX INFO: loaded from: classes.dex */
final class zad extends DialogRedirect {
    private final /* synthetic */ Fragment val$fragment;
    private final /* synthetic */ int val$requestCode;
    private final /* synthetic */ Intent zaoh;

    zad(Intent intent, Fragment fragment, int i) {
        this.zaoh = intent;
        this.val$fragment = fragment;
        this.val$requestCode = i;
    }

    @Override // com.google.android.gms.common.internal.DialogRedirect
    public final void redirect() {
        if (this.zaoh != null) {
            this.val$fragment.startActivityForResult(this.zaoh, this.val$requestCode);
        }
    }
}
