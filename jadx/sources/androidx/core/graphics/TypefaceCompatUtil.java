package androidx.core.graphics;

import android.content.Context;
import android.content.res.Resources;
import android.net.Uri;
import android.os.CancellationSignal;
import android.os.ParcelFileDescriptor;
import android.os.Process;
import android.os.StrictMode;
import android.util.Log;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.annotation.RestrictTo;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;

/* JADX INFO: loaded from: classes.dex */
@RestrictTo({RestrictTo.Scope.LIBRARY_GROUP})
public class TypefaceCompatUtil {
    private static final String CACHE_FILE_PREFIX = ".font";
    private static final String TAG = "TypefaceCompatUtil";

    private TypefaceCompatUtil() {
    }

    @Nullable
    public static File getTempFile(Context context) {
        String str = CACHE_FILE_PREFIX + Process.myPid() + "-" + Process.myTid() + "-";
        for (int i = 0; i < 100; i++) {
            File file = new File(context.getCacheDir(), str + i);
            try {
                if (file.createNewFile()) {
                    return file;
                }
            } catch (IOException unused) {
            }
        }
        return null;
    }

    /* JADX WARN: Code duplicated, block: B:18:0x002e A[Catch: IOException -> 0x0032, TryCatch #1 {IOException -> 0x0032, blocks: (B:3:0x0001, B:5:0x0016, B:14:0x0025, B:19:0x0031, B:18:0x002e, B:17:0x002a), top: B:21:0x0001, inners: #3 }] */
    /* JADX WARN: Code duplicated, block: B:22:0x0025 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    @Nullable
    @RequiresApi(19)
    private static ByteBuffer mmap(File file) throws Throwable {
        Throwable th;
        try {
            FileInputStream fileInputStream = new FileInputStream(file);
            try {
                FileChannel channel = fileInputStream.getChannel();
                MappedByteBuffer map = channel.map(FileChannel.MapMode.READ_ONLY, 0L, channel.size());
                fileInputStream.close();
                return map;
            } catch (Throwable th2) {
                th = th2;
                th = null;
                if (th == null) {
                    fileInputStream.close();
                    throw th;
                }
                fileInputStream.close();
                throw th;
            }
        } catch (IOException unused) {
            return null;
        }
    }

    /* JADX WARN: Code duplicated, block: B:25:0x0049 A[Catch: all -> 0x004d, Throwable -> 0x0050, TryCatch #4 {Throwable -> 0x0050, blocks: (B:8:0x0013, B:10:0x002c, B:26:0x004c, B:25:0x0049, B:24:0x0045), top: B:47:0x0013 }] */
    /* JADX WARN: Code duplicated, block: B:34:0x0058 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:39:0x0063 A[Catch: IOException -> 0x0067, TryCatch #1 {IOException -> 0x0067, blocks: (B:3:0x0005, B:6:0x000f, B:12:0x0031, B:35:0x005a, B:39:0x0063, B:38:0x005f, B:40:0x0066), top: B:44:0x0005, inners: #2 }] */
    /* JADX WARN: Code duplicated, block: B:45:0x005a A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:50:0x0040 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:56:? A[Catch: IOException -> 0x0067, SYNTHETIC, TRY_LEAVE, TryCatch #1 {IOException -> 0x0067, blocks: (B:3:0x0005, B:6:0x000f, B:12:0x0031, B:35:0x005a, B:39:0x0063, B:38:0x005f, B:40:0x0066), top: B:44:0x0005, inners: #2 }] */
    @Nullable
    @RequiresApi(19)
    public static ByteBuffer mmap(Context context, CancellationSignal cancellationSignal, Uri uri) throws Throwable {
        Throwable th;
        Throwable th2;
        Throwable th3;
        try {
            ParcelFileDescriptor parcelFileDescriptorOpenFileDescriptor = context.getContentResolver().openFileDescriptor(uri, "r", cancellationSignal);
            if (parcelFileDescriptorOpenFileDescriptor == null) {
                if (parcelFileDescriptorOpenFileDescriptor != null) {
                    parcelFileDescriptorOpenFileDescriptor.close();
                }
                return null;
            }
            try {
                try {
                    FileInputStream fileInputStream = new FileInputStream(parcelFileDescriptorOpenFileDescriptor.getFileDescriptor());
                    try {
                        FileChannel channel = fileInputStream.getChannel();
                        MappedByteBuffer map = channel.map(FileChannel.MapMode.READ_ONLY, 0L, channel.size());
                        fileInputStream.close();
                        if (parcelFileDescriptorOpenFileDescriptor != null) {
                            parcelFileDescriptorOpenFileDescriptor.close();
                        }
                        return map;
                    } catch (Throwable th4) {
                        try {
                            throw th4;
                        } catch (Throwable th5) {
                            th2 = th4;
                            th3 = th5;
                            if (th2 == null) {
                                fileInputStream.close();
                                throw th3;
                            }
                            fileInputStream.close();
                            throw th3;
                        }
                    }
                } catch (Throwable th6) {
                    try {
                        throw th6;
                    } catch (Throwable th7) {
                        th = th6;
                        th = th7;
                        if (parcelFileDescriptorOpenFileDescriptor != null) {
                            throw th;
                        }
                        if (th == null) {
                            parcelFileDescriptorOpenFileDescriptor.close();
                            throw th;
                        }
                        try {
                            parcelFileDescriptorOpenFileDescriptor.close();
                            throw th;
                        } catch (Throwable th8) {
                            th.addSuppressed(th8);
                            throw th;
                        }
                    }
                }
            } catch (Throwable th9) {
                th = th9;
                th = null;
                if (parcelFileDescriptorOpenFileDescriptor != null) {
                    throw th;
                }
                if (th == null) {
                    parcelFileDescriptorOpenFileDescriptor.close();
                    throw th;
                }
                parcelFileDescriptorOpenFileDescriptor.close();
                throw th;
            }
        } catch (IOException unused) {
            return null;
        }
    }

    @Nullable
    @RequiresApi(19)
    public static ByteBuffer copyToDirectBuffer(Context context, Resources resources, int i) {
        File tempFile = getTempFile(context);
        if (tempFile == null) {
            return null;
        }
        try {
            if (copyToFile(tempFile, resources, i)) {
                return mmap(tempFile);
            }
            return null;
        } finally {
            tempFile.delete();
        }
    }

    public static boolean copyToFile(File file, InputStream inputStream) throws Throwable {
        StrictMode.ThreadPolicy threadPolicyAllowThreadDiskWrites = StrictMode.allowThreadDiskWrites();
        FileOutputStream fileOutputStream = null;
        try {
            try {
                FileOutputStream fileOutputStream2 = new FileOutputStream(file, false);
                try {
                    byte[] bArr = new byte[1024];
                    while (true) {
                        int i = inputStream.read(bArr);
                        if (i != -1) {
                            fileOutputStream2.write(bArr, 0, i);
                        } else {
                            closeQuietly(fileOutputStream2);
                            StrictMode.setThreadPolicy(threadPolicyAllowThreadDiskWrites);
                            return true;
                        }
                    }
                } catch (IOException e) {
                    e = e;
                    fileOutputStream = fileOutputStream2;
                    Log.e(TAG, "Error copying resource contents to temp file: " + e.getMessage());
                    closeQuietly(fileOutputStream);
                    StrictMode.setThreadPolicy(threadPolicyAllowThreadDiskWrites);
                    return false;
                } catch (Throwable th) {
                    th = th;
                    fileOutputStream = fileOutputStream2;
                    closeQuietly(fileOutputStream);
                    StrictMode.setThreadPolicy(threadPolicyAllowThreadDiskWrites);
                    throw th;
                }
            } catch (IOException e2) {
                e = e2;
            }
        } catch (Throwable th2) {
            th = th2;
        }
    }

    public static boolean copyToFile(File file, Resources resources, int i) throws Throwable {
        InputStream inputStreamOpenRawResource;
        try {
            inputStreamOpenRawResource = resources.openRawResource(i);
            try {
                boolean zCopyToFile = copyToFile(file, inputStreamOpenRawResource);
                closeQuietly(inputStreamOpenRawResource);
                return zCopyToFile;
            } catch (Throwable th) {
                th = th;
                closeQuietly(inputStreamOpenRawResource);
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
            inputStreamOpenRawResource = null;
        }
    }

    public static void closeQuietly(Closeable closeable) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (IOException unused) {
            }
        }
    }
}
