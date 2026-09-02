package com.bnsi.detectheadphonelib;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import com.unity3d.player.UnityPlayer;

/* JADX INFO: loaded from: classes.dex */
public class DetectHeadphone {
    private static BroadcastReceiver broadcastReceiver;

    public static void Deinitialize() {
        if (broadcastReceiver != null) {
            UnityPlayer.currentActivity.unregisterReceiver(broadcastReceiver);
            broadcastReceiver = null;
        }
    }

    public static void Initialize() {
        Activity activity = UnityPlayer.currentActivity;
        broadcastReceiver = new BroadcastReceiver() { // from class: com.bnsi.detectheadphonelib.DetectHeadphone.1
            @Override // android.content.BroadcastReceiver
            public void onReceive(Context context, Intent intent) {
                String action = intent.getAction();
                if (action == null) {
                    return;
                }
                boolean z = false;
                if (action.compareTo("android.intent.action.HEADSET_PLUG") != 0 ? action.compareTo("android.media.AUDIO_BECOMING_NOISY") == 0 : intent.getIntExtra("state", -1) >= 0) {
                    z = true;
                }
                if (z) {
                    UnityPlayer.UnitySendMessage("MainLoop", "OnAuxiliaryPause", "");
                }
            }
        };
        activity.registerReceiver(broadcastReceiver, new IntentFilter("android.intent.action.HEADSET_PLUG"));
        activity.registerReceiver(broadcastReceiver, new IntentFilter("android.media.AUDIO_BECOMING_NOISY"));
        activity.registerReceiver(broadcastReceiver, new IntentFilter("android.intent.action.DEVICE_STORAGE_LOW"));
    }
}
