package org.apache.commons.net.p004io;

import java.util.EventListener;

/* JADX INFO: loaded from: classes.dex */
public interface CopyStreamListener extends EventListener {
    void bytesTransferred(long j, int i, long j2);

    void bytesTransferred(CopyStreamEvent copyStreamEvent);
}
