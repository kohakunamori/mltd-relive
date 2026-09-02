package extern.okhttp3.internal.cache;

import extern.okio.Sink;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
public interface CacheRequest {
    void abort();

    Sink body() throws IOException;
}
