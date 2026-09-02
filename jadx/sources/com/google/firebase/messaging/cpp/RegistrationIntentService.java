package com.google.firebase.messaging.cpp;

import android.app.IntentService;
import android.content.Context;
import android.content.Intent;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.flatbuffers.FlatBufferBuilder;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

/* JADX INFO: loaded from: classes.dex */
public class RegistrationIntentService extends IntentService {
    private static final String TAG = "FirebaseRegService";

    public RegistrationIntentService() {
        super(TAG);
    }

    @Override // android.app.IntentService
    protected void onHandleIntent(Intent intent) throws Throwable {
        String token = FirebaseInstanceId.getInstance().getToken();
        DebugLogging.log(TAG, String.format("onHandleIntent token=%s", token));
        if (token != null) {
            writeTokenToInternalStorage(this, token);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r1v10 */
    /* JADX WARN: Type inference failed for: r1v11 */
    /* JADX WARN: Type inference failed for: r1v12 */
    /* JADX WARN: Type inference failed for: r1v13 */
    /* JADX WARN: Type inference failed for: r1v2 */
    /* JADX WARN: Type inference failed for: r1v3 */
    /* JADX WARN: Type inference failed for: r1v4 */
    /* JADX WARN: Type inference failed for: r1v5, types: [java.nio.channels.FileLock] */
    /* JADX WARN: Type inference failed for: r1v6 */
    /* JADX WARN: Type inference failed for: r1v7 */
    /* JADX WARN: Type inference failed for: r1v8 */
    /* JADX WARN: Type inference failed for: r1v9, types: [java.lang.String] */
    /* JADX WARN: Type inference failed for: r2v0 */
    /* JADX WARN: Type inference failed for: r2v1, types: [java.nio.channels.FileLock] */
    /* JADX WARN: Type inference failed for: r2v5, types: [java.nio.channels.FileLock] */
    public static void writeTokenToInternalStorage(Context context, String str) throws Throwable {
        ?? Lock;
        byte[] bArrGenerateTokenByteBuffer = generateTokenByteBuffer(str);
        ByteBuffer byteBufferAllocate = ByteBuffer.allocate(4);
        byteBufferAllocate.order(ByteOrder.LITTLE_ENDIAN);
        byteBufferAllocate.putInt(bArrGenerateTokenByteBuffer.length);
        ?? r1 = 0;
        r1 = 0;
        r1 = 0;
        try {
            try {
                try {
                    Lock = context.openFileOutput("FIREBASE_CLOUD_MESSAGING_LOCKFILE", 0).getChannel().lock();
                    try {
                        r1 = "FIREBASE_CLOUD_MESSAGING_LOCAL_STORAGE";
                        FileOutputStream fileOutputStreamOpenFileOutput = context.openFileOutput("FIREBASE_CLOUD_MESSAGING_LOCAL_STORAGE", 32768);
                        fileOutputStreamOpenFileOutput.write(byteBufferAllocate.array());
                        fileOutputStreamOpenFileOutput.write(bArrGenerateTokenByteBuffer);
                        fileOutputStreamOpenFileOutput.close();
                        if (Lock != 0) {
                            Lock.release();
                            r1 = r1;
                        }
                    } catch (Exception e) {
                        e = e;
                        r1 = Lock;
                        e.printStackTrace();
                        if (r1 != 0) {
                            r1.release();
                            r1 = r1;
                        }
                    } catch (Throwable th) {
                        th = th;
                        if (Lock != 0) {
                            try {
                                Lock.release();
                            } catch (Exception e2) {
                                e2.printStackTrace();
                            }
                        }
                        throw th;
                    }
                } catch (Exception e3) {
                    e3.printStackTrace();
                }
            } catch (Exception e4) {
                e = e4;
            }
        } catch (Throwable th2) {
            th = th2;
            Lock = r1;
        }
    }

    private static byte[] generateTokenByteBuffer(String str) {
        FlatBufferBuilder flatBufferBuilder = new FlatBufferBuilder(0);
        if (str == null) {
            str = "";
        }
        int iCreateString = flatBufferBuilder.createString(str);
        SerializedTokenReceived.startSerializedTokenReceived(flatBufferBuilder);
        SerializedTokenReceived.addToken(flatBufferBuilder, iCreateString);
        int iEndSerializedTokenReceived = SerializedTokenReceived.endSerializedTokenReceived(flatBufferBuilder);
        SerializedEvent.startSerializedEvent(flatBufferBuilder);
        SerializedEvent.addEventType(flatBufferBuilder, (byte) 2);
        SerializedEvent.addEvent(flatBufferBuilder, iEndSerializedTokenReceived);
        flatBufferBuilder.finish(SerializedEvent.endSerializedEvent(flatBufferBuilder));
        return flatBufferBuilder.sizedByteArray();
    }
}
