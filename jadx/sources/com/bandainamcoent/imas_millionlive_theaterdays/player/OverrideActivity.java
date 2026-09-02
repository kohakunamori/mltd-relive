package com.bandainamcoent.imas_millionlive_theaterdays.player;

import android.app.Activity;
import android.os.Bundle;
import com.unity3d.player.UnityPlayer;
import com.unity3d.player.UnityPlayerActivity;

/* JADX INFO: loaded from: classes.dex */
public class OverrideActivity extends UnityPlayerActivity {
    public static Activity getCurrentActivity() {
        return UnityPlayer.currentActivity;
    }

    @Override // com.unity3d.player.UnityPlayerActivity, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        getWindow().setFormat(2);
        this.mUnityPlayer = new OverridePlayer(this);
        setContentView(this.mUnityPlayer);
        this.mUnityPlayer.requestFocus();
    }
}
