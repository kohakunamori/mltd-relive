package org.apache.commons.net;

import java.util.EventListener;

/* JADX INFO: loaded from: classes.dex */
public interface ProtocolCommandListener extends EventListener {
    void protocolCommandSent(ProtocolCommandEvent protocolCommandEvent);

    void protocolReplyReceived(ProtocolCommandEvent protocolCommandEvent);
}
