package com.unity.purchasing.googleplay;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public class PurchaseActivity extends Activity {
    protected static final String TAG = "UnityIAP";
    private boolean receivedResult;

    @Override // android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Log.i(TAG, "Creating purchase activity");
        Bundle extras = getIntent().getExtras();
        if (extras != null && extras.getBoolean("vr", false)) {
            View decorView = getWindow().getDecorView();
            if (Build.VERSION.SDK_INT >= 11) {
                decorView.setSystemUiVisibility(6);
            }
        }
        if (GooglePlayPurchasing.ContinuePurchase(this, getIntent().getExtras().getString("productId"), getIntent().getExtras().getString("developerPayload"))) {
            return;
        }
        setResult(0);
        finish();
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        processActivityResult(i, i2, intent);
        this.receivedResult = true;
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        super.onDestroy();
        if (this.receivedResult) {
            return;
        }
        processActivityResult(GooglePlayPurchasing.ACTIVITY_REQUEST_CODE, 0, null);
    }

    public void processActivityResult(int i, int i2, Intent intent) {
        GooglePlayPurchasing.ProcessActivityResult(i, i2, intent);
        finish();
    }
}
