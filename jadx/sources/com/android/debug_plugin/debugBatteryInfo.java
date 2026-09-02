package com.android.debug_plugin;

import android.content.Intent;
import android.content.IntentFilter;
import com.google.firebase.analytics.FirebaseAnalytics;
import com.unity3d.player.UnityPlayer;

/* JADX INFO: loaded from: classes.dex */
public class debugBatteryInfo {

    public static class myBatteryInfo {
        public int level;
        public int temperature;
        public int voltage;
    }

    public void GetBatteryInfo(String str, String str2) {
        Intent intentRegisterReceiver = UnityPlayer.currentActivity.getApplication().registerReceiver(null, new IntentFilter("android.intent.action.BATTERY_CHANGED"));
        int intExtra = intentRegisterReceiver.getIntExtra("temperature", 0);
        int intExtra2 = intentRegisterReceiver.getIntExtra(FirebaseAnalytics.Param.LEVEL, 0);
        int intExtra3 = intentRegisterReceiver.getIntExtra("voltage", 0);
        UnityPlayer.UnitySendMessage(str, str2, (((((("Temperature=" + String.valueOf(intExtra)) + ",") + "Level=" + String.valueOf(intExtra2)) + ",") + "Voltage=" + String.valueOf(intExtra3)) + ",") + "End");
    }

    public static String GetBatteryInfo() {
        Intent intentRegisterReceiver = UnityPlayer.currentActivity.getApplication().registerReceiver(null, new IntentFilter("android.intent.action.BATTERY_CHANGED"));
        myBatteryInfo mybatteryinfo = new myBatteryInfo();
        mybatteryinfo.level = intentRegisterReceiver.getIntExtra(FirebaseAnalytics.Param.LEVEL, 0);
        mybatteryinfo.temperature = intentRegisterReceiver.getIntExtra("temperature", 0);
        mybatteryinfo.voltage = intentRegisterReceiver.getIntExtra("voltage", 0);
        return ((((("Temperature=" + String.valueOf(mybatteryinfo.temperature)) + ",") + "Level=" + String.valueOf(mybatteryinfo.level)) + ",") + "Voltage=" + String.valueOf(mybatteryinfo.voltage)) + ",";
    }
}
