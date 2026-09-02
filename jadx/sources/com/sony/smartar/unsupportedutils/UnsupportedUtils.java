package com.sony.smartar.unsupportedutils;

import android.app.Activity;
import android.content.Context;
import android.hardware.Camera;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.widget.Toast;
import com.unity3d.player.UnityPlayer;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class UnsupportedUtils {
    private static final String SMART_CAPTURE_DIRECTORY = "/smartar/capture/";

    private static int defaultImageSensorRotation(boolean z) {
        return z ? 270 : 90;
    }

    private UnsupportedUtils() {
    }

    public static String moveToExternalDir(String str) {
        File file = new File(str);
        if (!file.exists()) {
            return null;
        }
        String str2 = String.valueOf(Environment.getExternalStorageDirectory().getAbsolutePath()) + SMART_CAPTURE_DIRECTORY;
        if (!new File(str2).exists()) {
            new File(str2).mkdirs();
        }
        File file2 = new File(str2, file.getName());
        if (file.renameTo(file2)) {
            return file2.getAbsolutePath();
        }
        return null;
    }

    public static void scanCaptureImage(String str) {
        final Context applicationContext = UnityPlayer.currentActivity.getApplicationContext();
        MediaScannerConnection.scanFile(applicationContext, new String[]{str}, new String[]{"image/*"}, new MediaScannerConnection.OnScanCompletedListener() { // from class: com.sony.smartar.unsupportedutils.UnsupportedUtils.1
            @Override // android.media.MediaScannerConnection.OnScanCompletedListener
            public void onScanCompleted(String str2, Uri uri) {
                Activity activity = UnityPlayer.currentActivity;
                final Context context = applicationContext;
                activity.runOnUiThread(new Runnable() { // from class: com.sony.smartar.unsupportedutils.UnsupportedUtils.1.1
                    @Override // java.lang.Runnable
                    public void run() {
                        Toast.makeText(context, "Completed capture image.", 1).show();
                    }
                });
            }
        });
    }

    public static float getFovY(boolean z) {
        Camera.Parameters cameraParams = getCameraParams(z);
        if (cameraParams == null) {
            return 0.0f;
        }
        return cameraParams.getVerticalViewAngle();
    }

    public static float getFocalLength(boolean z) {
        Camera.Parameters cameraParams = getCameraParams(z);
        if (cameraParams == null) {
            return 0.0f;
        }
        return cameraParams.getFocalLength();
    }

    public static int getImageSensorRotation(boolean z, Context context) {
        if (Build.VERSION.SDK_INT >= 21) {
            try {
                CameraManager cameraManager = (CameraManager) context.getSystemService("camera");
                String str = null;
                for (String str2 : cameraManager.getCameraIdList()) {
                    Integer num = (Integer) cameraManager.getCameraCharacteristics(str2).get(CameraCharacteristics.LENS_FACING);
                    if (num == null || num.intValue() != 0) {
                        if (num != null && num.intValue() == 1 && !z) {
                            str = str2;
                            break;
                        }
                    } else {
                        if (z) {
                            str = str2;
                            break;
                        }
                    }
                }
                if (str == null) {
                    return defaultImageSensorRotation(z);
                }
                return ((Integer) cameraManager.getCameraCharacteristics(str).get(CameraCharacteristics.SENSOR_ORIENTATION)).intValue();
            } catch (Exception unused) {
                return defaultImageSensorRotation(z);
            }
        }
        return defaultImageSensorRotation(z);
    }

    private static Camera.Parameters getCameraParams(boolean z) {
        Camera cameraOpen = Camera.open(z ? 1 : 0);
        if (cameraOpen == null) {
            return null;
        }
        Camera.CameraInfo cameraInfo = new Camera.CameraInfo();
        Camera.getCameraInfo(z ? 1 : 0, cameraInfo);
        if (cameraInfo.facing == 1 && !z) {
            cameraOpen.release();
            return null;
        }
        Camera.Parameters parameters = cameraOpen.getParameters();
        cameraOpen.release();
        return parameters;
    }
}
