package net.nbsi.notice;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;
import androidx.core.app.NotificationCompat;
import com.unity3d.player.UnityPlayer;
import java.util.Calendar;

/* JADX INFO: loaded from: classes.dex */
public class LocalNotification {

    /* JADX INFO: renamed from: c */
    public Context f739c;

    public Context getC() {
        return this.f739c;
    }

    public void setC(Context context) {
        this.f739c = context;
    }

    public void cancelNotification(int i) {
        Context applicationContext = UnityPlayer.currentActivity.getApplicationContext();
        ((AlarmManager) applicationContext.getSystemService(NotificationCompat.CATEGORY_ALARM)).cancel(PendingIntent.getBroadcast(applicationContext, i, new Intent(applicationContext, (Class<?>) NotificationReceiver.class), 134217728));
        ((NotificationManager) applicationContext.getSystemService("notification")).cancel(i);
    }

    public void sendNotification(String str, int i, int i2, String str2, String str3, String str4, String str5, String str6, String str7, String str8, String str9) {
        Log.i("Unity", "SendNotificationStart id:" + i2 + " remainSec:" + i);
        Activity activity = UnityPlayer.currentActivity;
        Context applicationContext = activity.getApplicationContext();
        Log.i("Unity", "Activity = " + activity.toString() + " contest = " + applicationContext.toString());
        Intent intent = new Intent(applicationContext, (Class<?>) NotificationReceiver.class);
        intent.putExtra("message", str);
        intent.putExtra("notificationid", Integer.toString(i2));
        intent.putExtra("title", str2);
        intent.putExtra("subtitle", str3);
        intent.putExtra("tickerText", str4);
        intent.putExtra("smallIcon", str5);
        intent.putExtra("largeIcon", str6);
        intent.putExtra("sound", str7);
        intent.putExtra("vibrate", str8);
        intent.putExtra("lights", str9);
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        calendar.add(13, i);
        PendingIntent broadcast = PendingIntent.getBroadcast(applicationContext, i2, intent, 134217728);
        AlarmManager alarmManager = (AlarmManager) applicationContext.getSystemService(NotificationCompat.CATEGORY_ALARM);
        if (Build.VERSION.SDK_INT >= 23) {
            alarmManager.setExact(0, calendar.getTimeInMillis(), broadcast);
        } else {
            alarmManager.set(0, calendar.getTimeInMillis(), broadcast);
        }
        Log.i("Unity", "Set Alarm: " + i);
    }
}
