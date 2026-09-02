package net.nbsi.notice;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import androidx.core.app.NotificationCompat;
import com.nbsi.nedev.webviewobject.WebviewObjectSettings;
import com.unity3d.player.UnityPlayerNativeActivity;

/* JADX INFO: loaded from: classes.dex */
public class NotificationSender {
    private static final int DEFAULT_NOTIFICATION_ID = 1;
    private static final String TAG = "NotificationBuilder";

    public static Drawable getDrawableResource(int i, Context context) {
        if (Build.VERSION.SDK_INT >= 21) {
            Log.i(TAG, "lollipop getDrawable");
            return context.getDrawable(i);
        }
        Log.i(TAG, "NOT lollipop getDrawable");
        return context.getResources().getDrawable(i);
    }

    /* JADX WARN: Code duplicated, block: B:39:0x00ec  */
    /* JADX WARN: Code duplicated, block: B:40:0x00f9  */
    /* JADX WARN: Code duplicated, block: B:43:0x0133  */
    /* JADX WARN: Code duplicated, block: B:44:0x0148  */
    /* JADX WARN: Code duplicated, block: B:49:0x0156  */
    /* JADX WARN: Code duplicated, block: B:60:0x017a  */
    public static void SendNotification(Context context, Intent intent) {
        String strGetString;
        String strGetString2;
        String strGetString3;
        String strGetString4;
        String strGetString5;
        String strGetString6;
        String strGetString7;
        String strGetString8;
        String strGetString9;
        String strGetString10;
        int i;
        Class<?> cls;
        PendingIntent activity;
        Resources resources;
        Bitmap bitmap;
        int i2;
        Bundle extras = intent.getExtras();
        if (extras.isEmpty()) {
            strGetString = null;
            strGetString2 = null;
            strGetString3 = null;
            strGetString4 = null;
            strGetString5 = null;
            strGetString6 = null;
            strGetString7 = null;
            strGetString8 = null;
            strGetString9 = null;
            strGetString10 = null;
        } else {
            Resources resources2 = context.getApplicationContext().getResources();
            strGetString2 = GetString(context, extras, resources2, "message");
            strGetString3 = GetString(context, extras, resources2, "title");
            strGetString4 = GetString(context, extras, resources2, "subtitle");
            strGetString5 = GetString(context, extras, resources2, "tickerText");
            strGetString6 = GetString(context, extras, resources2, "vibrate");
            strGetString7 = GetString(context, extras, resources2, "lights");
            strGetString8 = GetString(context, extras, resources2, "sound");
            strGetString9 = GetString(context, extras, resources2, "smallIcon");
            strGetString10 = GetString(context, extras, resources2, "largeIcon");
            strGetString = GetString(context, extras, resources2, "notificationid");
        }
        Log.i(TAG, "SendNotification() ");
        if (strGetString9 == null) {
            strGetString9 = "app_icon";
        }
        if (strGetString3 == null) {
            strGetString3 = "No Title";
        }
        if (strGetString2 == null) {
            strGetString2 = "No Message";
        }
        int i3 = strGetString != null ? Integer.parseInt(strGetString) : 1;
        NotificationManager notificationManager = (NotificationManager) context.getSystemService("notification");
        Context applicationContext = context.getApplicationContext();
        try {
            PackageInfo packageInfo = applicationContext.getPackageManager().getPackageInfo(applicationContext.getPackageName(), 1);
            StringBuilder sb = new StringBuilder();
            i = i3;
            try {
                sb.append("Start Activity Class: ");
                sb.append(packageInfo.activities[0].name);
                Log.i(TAG, sb.toString());
                try {
                    cls = Class.forName(packageInfo.activities[0].name);
                    try {
                        try {
                            Log.i(TAG, "Class = " + cls.toString());
                        } catch (ClassNotFoundException e) {
                            e = e;
                            e.printStackTrace();
                        }
                    } catch (PackageManager.NameNotFoundException e2) {
                        e = e2;
                        e.printStackTrace();
                    }
                } catch (ClassNotFoundException e3) {
                    e = e3;
                    cls = null;
                }
            } catch (PackageManager.NameNotFoundException e4) {
                e = e4;
                cls = null;
                e.printStackTrace();
                if (cls == null) {
                    activity = PendingIntent.getActivity(context, 0, new Intent(context, (Class<?>) UnityPlayerNativeActivity.class), 0);
                } else {
                    activity = PendingIntent.getActivity(context, 0, new Intent(context, cls), 0);
                }
                resources = context.getApplicationContext().getResources();
                int identifier = resources.getIdentifier(strGetString9, "drawable", context.getPackageName());
                StringBuilder sb2 = new StringBuilder();
                String str = strGetString5;
                sb2.append("packageName:");
                sb2.append(applicationContext.getPackageName());
                Log.i(TAG, sb2.toString());
                if (strGetString10 != null) {
                    bitmap = ((BitmapDrawable) getDrawableResource(resources.getIdentifier(strGetString10, "drawable", context.getPackageName()), applicationContext)).getBitmap();
                } else {
                    bitmap = null;
                }
                if (strGetString8 != null) {
                    i2 = 0;
                } else {
                    i2 = 0;
                }
                if (strGetString6 != null) {
                    i2 |= 2;
                }
                if (strGetString7 != null) {
                    i2 |= 4;
                }
                int i4 = i2;
                if (Build.VERSION.SDK_INT >= 26) {
                    notificationManager.createNotificationChannel(new NotificationChannel(WebviewObjectSettings.URLSCHEME_TYPE_PLUGUIN_DEFAULT, "ローカル通知", 3));
                    Log.i(TAG, "Create notificaion channel ");
                }
                notificationManager.notify(i, new NotificationCompat.Builder(context, WebviewObjectSettings.URLSCHEME_TYPE_PLUGUIN_DEFAULT).setContentIntent(activity).setSmallIcon(identifier).setLargeIcon(bitmap).setContentTitle(strGetString3).setSubText(strGetString4).setStyle(new NotificationCompat.BigTextStyle().bigText(strGetString2)).setContentText(strGetString2).setDefaults(i4).setTicker(str).setAutoCancel(true).build());
            }
        } catch (PackageManager.NameNotFoundException e5) {
            e = e5;
            i = i3;
        }
        if (cls == null) {
            activity = PendingIntent.getActivity(context, 0, new Intent(context, (Class<?>) UnityPlayerNativeActivity.class), 0);
        } else {
            activity = PendingIntent.getActivity(context, 0, new Intent(context, cls), 0);
        }
        resources = context.getApplicationContext().getResources();
        int identifier2 = resources.getIdentifier(strGetString9, "drawable", context.getPackageName());
        StringBuilder sb3 = new StringBuilder();
        String str2 = strGetString5;
        sb3.append("packageName:");
        sb3.append(applicationContext.getPackageName());
        Log.i(TAG, sb3.toString());
        if (strGetString10 != null) {
            bitmap = ((BitmapDrawable) getDrawableResource(resources.getIdentifier(strGetString10, "drawable", context.getPackageName()), applicationContext)).getBitmap();
        } else {
            bitmap = null;
        }
        if (strGetString8 != null || strGetString8.compareTo("0") == 0) {
            i2 = 0;
        } else {
            i2 = 1;
        }
        if (strGetString6 != null && strGetString6.compareTo("0") != 0) {
            i2 |= 2;
        }
        if (strGetString7 != null && strGetString7.compareTo("0") != 0) {
            i2 |= 4;
        }
        int i5 = i2;
        if (Build.VERSION.SDK_INT >= 26) {
            notificationManager.createNotificationChannel(new NotificationChannel(WebviewObjectSettings.URLSCHEME_TYPE_PLUGUIN_DEFAULT, "ローカル通知", 3));
            Log.i(TAG, "Create notificaion channel ");
        }
        notificationManager.notify(i, new NotificationCompat.Builder(context, WebviewObjectSettings.URLSCHEME_TYPE_PLUGUIN_DEFAULT).setContentIntent(activity).setSmallIcon(identifier2).setLargeIcon(bitmap).setContentTitle(strGetString3).setSubText(strGetString4).setStyle(new NotificationCompat.BigTextStyle().bigText(strGetString2)).setContentText(strGetString2).setDefaults(i5).setTicker(str2).setAutoCancel(true).build());
    }

    private static String GetString(Context context, Bundle bundle, Resources resources, String str) {
        String string = bundle.getString(str);
        if (string != null) {
            return string;
        }
        int identifier = resources.getIdentifier("bnsi_notification_" + str, "string", context.getPackageName());
        return identifier != 0 ? resources.getString(identifier) : string;
    }
}
