package extern.okhttp3;

import extern.okio.ByteString;
import javax.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
public interface WebSocket {

    public interface Factory {
        WebSocket newWebSocket(Request request, WebSocketListener webSocketListener);
    }

    void cancel();

    boolean close(int i, @Nullable String str);

    long queueSize();

    Request request();

    boolean send(ByteString byteString);

    boolean send(String str);
}
