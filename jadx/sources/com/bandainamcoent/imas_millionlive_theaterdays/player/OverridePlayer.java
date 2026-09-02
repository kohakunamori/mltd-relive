package com.bandainamcoent.imas_millionlive_theaterdays.player;

import android.content.Context;
import android.view.SurfaceView;
import android.view.View;
import com.unity3d.player.UnityPlayer;

/* JADX INFO: loaded from: classes.dex */
public class OverridePlayer extends UnityPlayer {
    public OverridePlayer(Context context) {
        super(context);
    }

    @Override // android.view.ViewGroup
    public void addView(View view) {
        if (view instanceof SurfaceView) {
            ((SurfaceView) view).setZOrderOnTop(false);
        }
        super.addView(view);
    }
}
