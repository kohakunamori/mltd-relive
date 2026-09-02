package extern.okhttp3.internal.http;

import extern.okhttp3.MediaType;
import extern.okhttp3.ResponseBody;
import extern.okio.BufferedSource;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
public final class RealResponseBody extends ResponseBody {
    private final long contentLength;

    @Nullable
    private final String contentTypeString;
    private final BufferedSource source;

    public RealResponseBody(@Nullable String str, long j, BufferedSource bufferedSource) {
        this.contentTypeString = str;
        this.contentLength = j;
        this.source = bufferedSource;
    }

    @Override // extern.okhttp3.ResponseBody
    public MediaType contentType() {
        String str = this.contentTypeString;
        if (str != null) {
            return MediaType.parse(str);
        }
        return null;
    }

    @Override // extern.okhttp3.ResponseBody
    public long contentLength() {
        return this.contentLength;
    }

    @Override // extern.okhttp3.ResponseBody
    public BufferedSource source() {
        return this.source;
    }
}
