package com.google.firebase.messaging.cpp;

import android.content.Context;
import android.net.Uri;
import com.adjust.sdk.Constants;
import com.google.firebase.messaging.RemoteMessage;
import com.google.flatbuffers.FlatBufferBuilder;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileLock;
import java.util.Iterator;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class MessageWriter {
    private static final MessageWriter DEFAULT_INSTANCE = new MessageWriter();
    static final String LOCK_FILE = "FIREBASE_CLOUD_MESSAGING_LOCKFILE";
    static final String STORAGE_FILE = "FIREBASE_CLOUD_MESSAGING_LOCAL_STORAGE";
    private static final String TAG = "FIREBASE_MESSAGE_WRITER";

    private static String emptyIfNull(String str) {
        return str != null ? str : "";
    }

    private static String priorityToString(int i) {
        switch (i) {
            case 1:
                return Constants.HIGH;
            case 2:
                return Constants.NORMAL;
            default:
                return "";
        }
    }

    public static MessageWriter defaultInstance() {
        return DEFAULT_INSTANCE;
    }

    public void writeMessage(Context context, RemoteMessage remoteMessage, boolean z, Uri uri) throws Throwable {
        String from = remoteMessage.getFrom();
        String to = remoteMessage.getTo();
        String messageId = remoteMessage.getMessageId();
        String messageType = remoteMessage.getMessageType();
        Map<String, String> data = remoteMessage.getData();
        RemoteMessage.Notification notification = remoteMessage.getNotification();
        String collapseKey = remoteMessage.getCollapseKey();
        int priority = remoteMessage.getPriority();
        int originalPriority = remoteMessage.getOriginalPriority();
        long sentTime = remoteMessage.getSentTime();
        int ttl = remoteMessage.getTtl();
        Uri link = (uri != null || notification == null) ? uri : notification.getLink();
        String string = link != null ? link.toString() : null;
        Object[] objArr = new Object[4];
        objArr[0] = from;
        objArr[1] = messageId;
        objArr[2] = data == null ? "(null)" : data.toString();
        objArr[3] = notification == null ? "(null)" : notification.toString();
        DebugLogging.log(TAG, String.format("onMessageReceived from=%s message_id=%s, data=%s, notification=%s", objArr));
        writeMessageToInternalStorage(context, from, to, messageId, messageType, null, data, notification, z, string, collapseKey, priority, originalPriority, sentTime, ttl);
    }

    void writeMessageEventToInternalStorage(Context context, String str, String str2, String str3) throws Throwable {
        writeMessageToInternalStorage(context, null, null, str, str2, null, null, null, false, null, null, 0, 0, 0L, 0);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:20:0x0054 -> B:30:0x0058). Please report as a decompilation issue!!! */
    void writeMessageToInternalStorage(Context context, String str, String str2, String str3, String str4, String str5, Map<String, String> map, RemoteMessage.Notification notification, boolean z, String str6, String str7, int i, int i2, long j, int i3) throws Throwable {
        Throwable th;
        FileLock fileLock;
        byte[] bArrGenerateMessageByteBuffer = generateMessageByteBuffer(str, str2, str3, str4, str5, map, notification, z, str6, str7, i, i2, j, i3);
        ByteBuffer byteBufferAllocate = ByteBuffer.allocate(4);
        byteBufferAllocate.order(ByteOrder.LITTLE_ENDIAN);
        byteBufferAllocate.putInt(bArrGenerateMessageByteBuffer.length);
        Object obj = null;
        FileLock fileLock2 = null;
        obj = null;
        try {
            try {
                try {
                    FileLock fileLockLock = context.openFileOutput(LOCK_FILE, 0).getChannel().lock();
                    try {
                        String str8 = STORAGE_FILE;
                        FileOutputStream fileOutputStreamOpenFileOutput = context.openFileOutput(STORAGE_FILE, 32768);
                        fileOutputStreamOpenFileOutput.write(byteBufferAllocate.array());
                        fileOutputStreamOpenFileOutput.write(bArrGenerateMessageByteBuffer);
                        fileOutputStreamOpenFileOutput.close();
                        obj = str8;
                        if (fileLockLock != null) {
                            fileLockLock.release();
                            obj = str8;
                        }
                    } catch (Exception e) {
                        e = e;
                        fileLock2 = fileLockLock;
                        e.printStackTrace();
                        obj = fileLock2;
                        if (fileLock2 != null) {
                            fileLock2.release();
                            obj = fileLock2;
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        fileLock = fileLockLock;
                        if (fileLock != 0) {
                            try {
                                fileLock.release();
                                throw th;
                            } catch (Exception e2) {
                                e2.printStackTrace();
                                throw th;
                            }
                        }
                        throw th;
                    }
                } catch (Throwable th3) {
                    th = th3;
                    fileLock = obj;
                }
            } catch (Exception e3) {
                e = e3;
            }
        } catch (Exception e4) {
            e4.printStackTrace();
            obj = obj;
        }
    }

    private static byte[] generateMessageByteBuffer(String str, String str2, String str3, String str4, String str5, Map<String, String> map, RemoteMessage.Notification notification, boolean z, String str6, String str7, int i, int i2, long j, int i3) {
        int iCreateDataVector;
        int iEndSerializedNotification;
        int iCreateBodyLocArgsVector;
        int iCreateTitleLocArgsVector;
        FlatBufferBuilder flatBufferBuilder = new FlatBufferBuilder(0);
        int iCreateString = flatBufferBuilder.createString(emptyIfNull(str));
        int iCreateString2 = flatBufferBuilder.createString(emptyIfNull(str2));
        int iCreateString3 = flatBufferBuilder.createString(emptyIfNull(str3));
        int iCreateString4 = flatBufferBuilder.createString(emptyIfNull(str4));
        int iCreateString5 = flatBufferBuilder.createString(emptyIfNull(str5));
        int iCreateString6 = flatBufferBuilder.createString(emptyIfNull(str6));
        int iCreateString7 = flatBufferBuilder.createString(emptyIfNull(str7));
        int iCreateString8 = flatBufferBuilder.createString(priorityToString(i));
        int iCreateString9 = flatBufferBuilder.createString(priorityToString(i2));
        if (map != null) {
            int[] iArr = new int[map.size()];
            Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
            int i4 = 0;
            while (it.hasNext()) {
                Map.Entry<String, String> next = it.next();
                Iterator<Map.Entry<String, String>> it2 = it;
                iArr[i4] = DataPair.createDataPair(flatBufferBuilder, flatBufferBuilder.createString(next.getKey()), flatBufferBuilder.createString(next.getValue()));
                i4++;
                it = it2;
            }
            iCreateDataVector = SerializedMessage.createDataVector(flatBufferBuilder, iArr);
        } else {
            iCreateDataVector = 0;
        }
        if (notification != null) {
            int iCreateString10 = flatBufferBuilder.createString(emptyIfNull(notification.getTitle()));
            int iCreateString11 = flatBufferBuilder.createString(emptyIfNull(notification.getBody()));
            int iCreateString12 = flatBufferBuilder.createString(emptyIfNull(notification.getIcon()));
            int iCreateString13 = flatBufferBuilder.createString(emptyIfNull(notification.getSound()));
            int iCreateString14 = flatBufferBuilder.createString("");
            int iCreateString15 = flatBufferBuilder.createString(emptyIfNull(notification.getTag()));
            int iCreateString16 = flatBufferBuilder.createString(emptyIfNull(notification.getColor()));
            int iCreateString17 = flatBufferBuilder.createString(emptyIfNull(notification.getClickAction()));
            int iCreateString18 = flatBufferBuilder.createString(emptyIfNull(notification.getChannelId()));
            int iCreateString19 = flatBufferBuilder.createString(emptyIfNull(notification.getBodyLocalizationKey()));
            String[] bodyLocalizationArgs = notification.getBodyLocalizationArgs();
            if (bodyLocalizationArgs != null) {
                int[] iArr2 = new int[bodyLocalizationArgs.length];
                int i5 = 0;
                int i6 = 0;
                for (int length = bodyLocalizationArgs.length; i5 < length; length = length) {
                    iArr2[i6] = flatBufferBuilder.createString(bodyLocalizationArgs[i5]);
                    i5++;
                    i6++;
                }
                iCreateBodyLocArgsVector = SerializedNotification.createBodyLocArgsVector(flatBufferBuilder, iArr2);
            } else {
                iCreateBodyLocArgsVector = 0;
            }
            int iCreateString20 = flatBufferBuilder.createString(emptyIfNull(notification.getTitleLocalizationKey()));
            String[] titleLocalizationArgs = notification.getTitleLocalizationArgs();
            if (titleLocalizationArgs != null) {
                int[] iArr3 = new int[titleLocalizationArgs.length];
                int i7 = 0;
                int i8 = 0;
                for (int length2 = titleLocalizationArgs.length; i7 < length2; length2 = length2) {
                    iArr3[i8] = flatBufferBuilder.createString(titleLocalizationArgs[i7]);
                    i7++;
                    i8++;
                }
                iCreateTitleLocArgsVector = SerializedNotification.createTitleLocArgsVector(flatBufferBuilder, iArr3);
            } else {
                iCreateTitleLocArgsVector = 0;
            }
            SerializedNotification.startSerializedNotification(flatBufferBuilder);
            SerializedNotification.addTitle(flatBufferBuilder, iCreateString10);
            SerializedNotification.addBody(flatBufferBuilder, iCreateString11);
            SerializedNotification.addIcon(flatBufferBuilder, iCreateString12);
            SerializedNotification.addSound(flatBufferBuilder, iCreateString13);
            SerializedNotification.addBadge(flatBufferBuilder, iCreateString14);
            SerializedNotification.addTag(flatBufferBuilder, iCreateString15);
            SerializedNotification.addColor(flatBufferBuilder, iCreateString16);
            SerializedNotification.addClickAction(flatBufferBuilder, iCreateString17);
            SerializedNotification.addAndroidChannelId(flatBufferBuilder, iCreateString18);
            SerializedNotification.addBodyLocKey(flatBufferBuilder, iCreateString19);
            SerializedNotification.addBodyLocArgs(flatBufferBuilder, iCreateBodyLocArgsVector);
            SerializedNotification.addTitleLocKey(flatBufferBuilder, iCreateString20);
            SerializedNotification.addTitleLocArgs(flatBufferBuilder, iCreateTitleLocArgsVector);
            iEndSerializedNotification = SerializedNotification.endSerializedNotification(flatBufferBuilder);
        } else {
            iCreateString = iCreateString;
            iCreateString2 = iCreateString2;
            iCreateString3 = iCreateString3;
            iCreateString4 = iCreateString4;
            iEndSerializedNotification = 0;
        }
        SerializedMessage.startSerializedMessage(flatBufferBuilder);
        SerializedMessage.addFrom(flatBufferBuilder, iCreateString);
        SerializedMessage.addTo(flatBufferBuilder, iCreateString2);
        SerializedMessage.addMessageId(flatBufferBuilder, iCreateString3);
        SerializedMessage.addMessageType(flatBufferBuilder, iCreateString4);
        SerializedMessage.addPriority(flatBufferBuilder, iCreateString8);
        SerializedMessage.addOriginalPriority(flatBufferBuilder, iCreateString9);
        SerializedMessage.addSentTime(flatBufferBuilder, j);
        SerializedMessage.addTimeToLive(flatBufferBuilder, i3);
        SerializedMessage.addError(flatBufferBuilder, iCreateString5);
        SerializedMessage.addCollapseKey(flatBufferBuilder, iCreateString7);
        if (map != null) {
            SerializedMessage.addData(flatBufferBuilder, iCreateDataVector);
        }
        if (notification != null) {
            SerializedMessage.addNotification(flatBufferBuilder, iEndSerializedNotification);
        }
        SerializedMessage.addNotificationOpened(flatBufferBuilder, z);
        SerializedMessage.addLink(flatBufferBuilder, iCreateString6);
        int iEndSerializedMessage = SerializedMessage.endSerializedMessage(flatBufferBuilder);
        SerializedEvent.startSerializedEvent(flatBufferBuilder);
        SerializedEvent.addEventType(flatBufferBuilder, (byte) 1);
        SerializedEvent.addEvent(flatBufferBuilder, iEndSerializedMessage);
        flatBufferBuilder.finish(SerializedEvent.endSerializedEvent(flatBufferBuilder));
        return flatBufferBuilder.sizedByteArray();
    }
}
