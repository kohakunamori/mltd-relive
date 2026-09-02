package com.google.firebase.messaging.cpp;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

/* JADX INFO: loaded from: classes.dex */
public class ListenerService extends FirebaseMessagingService {
    public static final String MESSAGE_TYPE_DELETED = "deleted_messages";
    public static final String MESSAGE_TYPE_SEND_ERROR = "send_error";
    public static final String MESSAGE_TYPE_SEND_EVENT = "send_event";
    private static final String TAG = "FIREBASE_LISTENER";
    private final MessageWriter messageWriter;

    public ListenerService() {
        this(MessageWriter.defaultInstance());
    }

    public ListenerService(MessageWriter messageWriter) {
        this.messageWriter = messageWriter;
    }

    @Override // com.google.firebase.messaging.FirebaseMessagingService
    public void onDeletedMessages() throws Throwable {
        DebugLogging.log(TAG, "onDeletedMessages");
        this.messageWriter.writeMessageEventToInternalStorage(this, null, MESSAGE_TYPE_DELETED, null);
    }

    @Override // com.google.firebase.messaging.FirebaseMessagingService
    public void onMessageReceived(RemoteMessage remoteMessage) throws Throwable {
        this.messageWriter.writeMessage(this, remoteMessage, false, null);
    }

    @Override // com.google.firebase.messaging.FirebaseMessagingService
    public void onMessageSent(String str) throws Throwable {
        DebugLogging.log(TAG, String.format("onMessageSent messageId=%s", str));
        this.messageWriter.writeMessageEventToInternalStorage(this, str, MESSAGE_TYPE_SEND_EVENT, null);
    }

    @Override // com.google.firebase.messaging.FirebaseMessagingService
    public void onSendError(String str, Exception exc) throws Throwable {
        DebugLogging.log(TAG, String.format("onSendError messageId=%s exception=%s", str, exc.toString()));
        this.messageWriter.writeMessageEventToInternalStorage(this, str, MESSAGE_TYPE_SEND_ERROR, exc.toString());
    }

    @Override // com.google.firebase.messaging.FirebaseMessagingService
    public void onNewToken(String str) throws Throwable {
        DebugLogging.log(TAG, String.format("onNewToken token=%s", str));
        RegistrationIntentService.writeTokenToInternalStorage(this, str);
    }
}
