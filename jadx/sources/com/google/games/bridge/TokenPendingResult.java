package com.google.games.bridge;

import android.util.Log;
import androidx.annotation.NonNull;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.ResultCallback;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class TokenPendingResult extends PendingResult<TokenResult> {
    private static final String TAG = "TokenPendingResult";
    private CountDownLatch latch = new CountDownLatch(1);
    TokenResult result = new TokenResult();
    private ResultCallback<? super TokenResult> resultCallback;

    @Override // com.google.android.gms.common.api.PendingResult
    @NonNull
    public TokenResult await() {
        try {
            this.latch.await();
        } catch (InterruptedException unused) {
            setResult(null, null, null, 14);
        }
        return getResult();
    }

    @Override // com.google.android.gms.common.api.PendingResult
    @NonNull
    public TokenResult await(long j, @NonNull TimeUnit timeUnit) {
        try {
            if (!this.latch.await(j, timeUnit)) {
                setResult(null, null, null, 15);
            }
        } catch (InterruptedException unused) {
            setResult(null, null, null, 14);
        }
        return getResult();
    }

    @Override // com.google.android.gms.common.api.PendingResult
    public void cancel() {
        setResult(null, null, null, 16);
        this.latch.countDown();
    }

    @Override // com.google.android.gms.common.api.PendingResult
    public boolean isCanceled() {
        return getResult() != null && getResult().getStatus().isCanceled();
    }

    @Override // com.google.android.gms.common.api.PendingResult
    public void setResultCallback(@NonNull ResultCallback<? super TokenResult> resultCallback) {
        if (this.latch.getCount() == 0) {
            resultCallback.onResult(getResult());
        } else {
            setCallback(resultCallback);
        }
    }

    @Override // com.google.android.gms.common.api.PendingResult
    public void setResultCallback(@NonNull ResultCallback<? super TokenResult> resultCallback, long j, @NonNull TimeUnit timeUnit) {
        try {
            if (!this.latch.await(j, timeUnit)) {
                setResult(null, null, null, 15);
            }
        } catch (InterruptedException unused) {
            setResult(null, null, null, 14);
        }
        resultCallback.onResult(getResult());
    }

    private synchronized void setCallback(ResultCallback<? super TokenResult> resultCallback) {
        this.resultCallback = resultCallback;
    }

    private synchronized ResultCallback<? super TokenResult> getCallback() {
        return this.resultCallback;
    }

    private synchronized void setResult(String str, String str2, String str3, int i) {
        if (this.result != null && str == null) {
            str = this.result.getAuthCode();
        }
        if (this.result != null && str3 == null) {
            str3 = this.result.getIdToken();
        }
        if (this.result != null && str2 == null) {
            str2 = this.result.getEmail();
        }
        this.result = new TokenResult(str, str2, str3, i);
    }

    private synchronized TokenResult getResult() {
        return this.result;
    }

    public void setStatus(int i) {
        this.result.setStatus(i);
        this.latch.countDown();
        ResultCallback<? super TokenResult> callback = getCallback();
        TokenResult result = getResult();
        if (callback != null) {
            Log.d(TAG, "Calling onResult for result: " + result);
            getCallback().onResult(result);
        }
    }

    public void setEmail(String str) {
        this.result.setEmail(str);
    }

    public void setAuthCode(String str) {
        this.result.setAuthCode(str);
    }

    public void setIdToken(String str) {
        this.result.setIdToken(str);
    }
}
