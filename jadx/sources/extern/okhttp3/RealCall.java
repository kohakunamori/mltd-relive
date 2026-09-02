package extern.okhttp3;

import androidx.core.app.NotificationCompat;
import extern.okhttp3.internal.NamedRunnable;
import extern.okhttp3.internal.Util;
import extern.okhttp3.internal.cache.CacheInterceptor;
import extern.okhttp3.internal.connection.ConnectInterceptor;
import extern.okhttp3.internal.connection.StreamAllocation;
import extern.okhttp3.internal.http.BridgeInterceptor;
import extern.okhttp3.internal.http.CallServerInterceptor;
import extern.okhttp3.internal.http.RealInterceptorChain;
import extern.okhttp3.internal.http.RetryAndFollowUpInterceptor;
import extern.okhttp3.internal.platform.Platform;
import extern.okio.AsyncTimeout;
import extern.okio.Timeout;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.TimeUnit;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
final class RealCall implements Call {
    final OkHttpClient client;

    @Nullable
    private EventListener eventListener;
    private boolean executed;
    final boolean forWebSocket;
    final Request originalRequest;
    final RetryAndFollowUpInterceptor retryAndFollowUpInterceptor;
    final AsyncTimeout timeout = new AsyncTimeout() { // from class: extern.okhttp3.RealCall.1
        @Override // extern.okio.AsyncTimeout
        protected void timedOut() {
            RealCall.this.cancel();
        }
    };

    private RealCall(OkHttpClient okHttpClient, Request request, boolean z) {
        this.client = okHttpClient;
        this.originalRequest = request;
        this.forWebSocket = z;
        this.retryAndFollowUpInterceptor = new RetryAndFollowUpInterceptor(okHttpClient, z);
        this.timeout.timeout(okHttpClient.callTimeoutMillis(), TimeUnit.MILLISECONDS);
    }

    static RealCall newRealCall(OkHttpClient okHttpClient, Request request, boolean z) {
        RealCall realCall = new RealCall(okHttpClient, request, z);
        realCall.eventListener = okHttpClient.eventListenerFactory().create(realCall);
        return realCall;
    }

    @Override // extern.okhttp3.Call
    public Request request() {
        return this.originalRequest;
    }

    @Override // extern.okhttp3.Call
    public Response execute() throws IOException {
        synchronized (this) {
            if (this.executed) {
                throw new IllegalStateException("Already Executed");
            }
            this.executed = true;
        }
        captureCallStackTrace();
        this.timeout.enter();
        this.eventListener.callStart(this);
        try {
            try {
                this.client.dispatcher().executed(this);
                Response responseWithInterceptorChain = getResponseWithInterceptorChain();
                if (responseWithInterceptorChain == null) {
                    throw new IOException("Canceled");
                }
                this.client.dispatcher().finished(this);
                return responseWithInterceptorChain;
            } catch (IOException e) {
                IOException iOExceptionTimeoutExit = timeoutExit(e);
                this.eventListener.callFailed(this, iOExceptionTimeoutExit);
                throw iOExceptionTimeoutExit;
            }
        } catch (Throwable th) {
            this.client.dispatcher().finished(this);
            throw th;
        }
        this.client.dispatcher().finished(this);
        throw th;
    }

    @Nullable
    IOException timeoutExit(@Nullable IOException iOException) {
        if (!this.timeout.exit()) {
            return iOException;
        }
        InterruptedIOException interruptedIOException = new InterruptedIOException("timeout");
        if (iOException != null) {
            interruptedIOException.initCause(iOException);
        }
        return interruptedIOException;
    }

    private void captureCallStackTrace() {
        this.retryAndFollowUpInterceptor.setCallStackTrace(Platform.get().getStackTraceForCloseable("response.body().close()"));
    }

    @Override // extern.okhttp3.Call
    public void enqueue(Callback callback) {
        synchronized (this) {
            if (this.executed) {
                throw new IllegalStateException("Already Executed");
            }
            this.executed = true;
        }
        captureCallStackTrace();
        this.eventListener.callStart(this);
        this.client.dispatcher().enqueue(new AsyncCall(callback));
    }

    @Override // extern.okhttp3.Call
    public void cancel() {
        this.retryAndFollowUpInterceptor.cancel();
    }

    @Override // extern.okhttp3.Call
    public Timeout timeout() {
        return this.timeout;
    }

    @Override // extern.okhttp3.Call
    public synchronized boolean isExecuted() {
        return this.executed;
    }

    @Override // extern.okhttp3.Call
    public boolean isCanceled() {
        return this.retryAndFollowUpInterceptor.isCanceled();
    }

    @Override // extern.okhttp3.Call
    /* JADX INFO: renamed from: clone, reason: merged with bridge method [inline-methods] */
    public RealCall m573clone() {
        return newRealCall(this.client, this.originalRequest, this.forWebSocket);
    }

    StreamAllocation streamAllocation() {
        return this.retryAndFollowUpInterceptor.streamAllocation();
    }

    final class AsyncCall extends NamedRunnable {
        static final /* synthetic */ boolean $assertionsDisabled = false;
        private final Callback responseCallback;

        AsyncCall(Callback callback) {
            super("OkHttp %s", RealCall.this.redactedUrl());
            this.responseCallback = callback;
        }

        String host() {
            return RealCall.this.originalRequest.url().host();
        }

        Request request() {
            return RealCall.this.originalRequest;
        }

        RealCall get() {
            return RealCall.this;
        }

        void executeOn(ExecutorService executorService) {
            try {
                try {
                    executorService.execute(this);
                } catch (RejectedExecutionException e) {
                    InterruptedIOException interruptedIOException = new InterruptedIOException("executor rejected");
                    interruptedIOException.initCause(e);
                    RealCall.this.eventListener.callFailed(RealCall.this, interruptedIOException);
                    this.responseCallback.onFailure(RealCall.this, interruptedIOException);
                    RealCall.this.client.dispatcher().finished(this);
                }
            } catch (Throwable th) {
                RealCall.this.client.dispatcher().finished(this);
                throw th;
            }
        }

        @Override // extern.okhttp3.internal.NamedRunnable
        protected void execute() {
            Throwable th;
            boolean z;
            IOException e;
            RealCall.this.timeout.enter();
            try {
                try {
                    z = true;
                    try {
                        this.responseCallback.onResponse(RealCall.this, RealCall.this.getResponseWithInterceptorChain());
                    } catch (IOException e2) {
                        e = e2;
                        IOException iOExceptionTimeoutExit = RealCall.this.timeoutExit(e);
                        if (!z) {
                            RealCall.this.eventListener.callFailed(RealCall.this, iOExceptionTimeoutExit);
                            this.responseCallback.onFailure(RealCall.this, iOExceptionTimeoutExit);
                        } else {
                            Platform.get().log(4, "Callback failure for " + RealCall.this.toLoggableString(), iOExceptionTimeoutExit);
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        RealCall.this.cancel();
                        if (!z) {
                            this.responseCallback.onFailure(RealCall.this, new IOException("canceled due to " + th));
                        }
                        throw th;
                    }
                } catch (Throwable th3) {
                    RealCall.this.client.dispatcher().finished(this);
                    throw th3;
                }
            } catch (IOException e3) {
                e = e3;
                z = false;
            } catch (Throwable th4) {
                th = th4;
                z = false;
            }
            RealCall.this.client.dispatcher().finished(this);
        }
    }

    String toLoggableString() {
        StringBuilder sb = new StringBuilder();
        sb.append(isCanceled() ? "canceled " : "");
        sb.append(this.forWebSocket ? "web socket" : NotificationCompat.CATEGORY_CALL);
        sb.append(" to ");
        sb.append(redactedUrl());
        return sb.toString();
    }

    String redactedUrl() {
        return this.originalRequest.url().redact();
    }

    Response getResponseWithInterceptorChain() throws IOException {
        ArrayList arrayList = new ArrayList();
        arrayList.addAll(this.client.interceptors());
        arrayList.add(this.retryAndFollowUpInterceptor);
        arrayList.add(new BridgeInterceptor(this.client.cookieJar()));
        arrayList.add(new CacheInterceptor(this.client.internalCache()));
        arrayList.add(new ConnectInterceptor(this.client));
        if (!this.forWebSocket) {
            arrayList.addAll(this.client.networkInterceptors());
        }
        arrayList.add(new CallServerInterceptor(this.forWebSocket));
        Response responseProceed = new RealInterceptorChain(arrayList, null, null, null, 0, this.originalRequest, this, this.eventListener, this.client.connectTimeoutMillis(), this.client.readTimeoutMillis(), this.client.writeTimeoutMillis()).proceed(this.originalRequest);
        if (!this.retryAndFollowUpInterceptor.isCanceled()) {
            return responseProceed;
        }
        Util.closeQuietly(responseProceed);
        throw new IOException("Canceled");
    }
}
