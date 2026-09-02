package extern.okhttp3.internal.cache;

import extern.okio.Buffer;
import extern.okio.ForwardingSink;
import extern.okio.Sink;
import java.io.IOException;

/* JADX INFO: loaded from: classes.dex */
class FaultHidingSink extends ForwardingSink {
    private boolean hasErrors;

    protected void onException(IOException iOException) {
    }

    FaultHidingSink(Sink sink) {
        super(sink);
    }

    @Override // extern.okio.ForwardingSink, extern.okio.Sink
    public void write(Buffer buffer, long j) throws IOException {
        if (this.hasErrors) {
            buffer.skip(j);
            return;
        }
        try {
            super.write(buffer, j);
        } catch (IOException e) {
            this.hasErrors = true;
            onException(e);
        }
    }

    @Override // extern.okio.ForwardingSink, extern.okio.Sink, java.io.Flushable
    public void flush() throws IOException {
        if (this.hasErrors) {
            return;
        }
        try {
            super.flush();
        } catch (IOException e) {
            this.hasErrors = true;
            onException(e);
        }
    }

    @Override // extern.okio.ForwardingSink, extern.okio.Sink, java.io.Closeable, java.lang.AutoCloseable
    public void close() throws IOException {
        if (this.hasErrors) {
            return;
        }
        try {
            super.close();
        } catch (IOException e) {
            this.hasErrors = true;
            onException(e);
        }
    }
}
