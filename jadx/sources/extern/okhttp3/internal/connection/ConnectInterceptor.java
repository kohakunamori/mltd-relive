package extern.okhttp3.internal.connection;

import extern.okhttp3.Interceptor;
import extern.okhttp3.OkHttpClient;
import extern.okhttp3.Request;
import extern.okhttp3.Response;
import extern.okhttp3.internal.http.RealInterceptorChain;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public final class ConnectInterceptor implements Interceptor {
    public final OkHttpClient client;

    public ConnectInterceptor(OkHttpClient okHttpClient) {
        this.client = okHttpClient;
    }

    @Override // extern.okhttp3.Interceptor
    public Response intercept(Interceptor.Chain chain) throws IOException {
        RealInterceptorChain realInterceptorChain = (RealInterceptorChain) chain;
        Request request = realInterceptorChain.request();
        StreamAllocation streamAllocation = realInterceptorChain.streamAllocation();
        return realInterceptorChain.proceed(request, streamAllocation, streamAllocation.newStream(this.client, chain, !request.method().equals("GET")), streamAllocation.connection());
    }
}
