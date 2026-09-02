package extern.okhttp3.internal.http;

import extern.okhttp3.Request;
import extern.okhttp3.Response;
import extern.okhttp3.ResponseBody;
import extern.okio.Sink;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public interface HttpCodec {
    public static final int DISCARD_STREAM_TIMEOUT_MILLIS = 100;

    void cancel();

    Sink createRequestBody(Request request, long j);

    void finishRequest() throws IOException;

    void flushRequest() throws IOException;

    ResponseBody openResponseBody(Response response) throws IOException;

    Response.Builder readResponseHeaders(boolean z) throws IOException;

    void writeRequestHeaders(Request request) throws IOException;
}
