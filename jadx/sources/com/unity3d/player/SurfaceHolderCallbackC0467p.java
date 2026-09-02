package com.unity3d.player;

import android.app.Activity;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.media.MediaPlayer;
import android.net.Uri;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.MediaController;
import java.io.FileInputStream;
import java.io.IOException;

/* JADX INFO: renamed from: com.unity3d.player.p */
/* JADX INFO: loaded from: classes.dex */
public final class SurfaceHolderCallbackC0467p extends FrameLayout implements MediaPlayer.OnBufferingUpdateListener, MediaPlayer.OnCompletionListener, MediaPlayer.OnPreparedListener, MediaPlayer.OnVideoSizeChangedListener, SurfaceHolder.Callback, MediaController.MediaPlayerControl {

    /* JADX INFO: renamed from: a */
    private static boolean f686a;

    /* JADX INFO: renamed from: b */
    private final Context f687b;

    /* JADX INFO: renamed from: c */
    private final SurfaceView f688c;

    /* JADX INFO: renamed from: d */
    private final SurfaceHolder f689d;

    /* JADX INFO: renamed from: e */
    private final String f690e;

    /* JADX INFO: renamed from: f */
    private final int f691f;

    /* JADX INFO: renamed from: g */
    private final int f692g;

    /* JADX INFO: renamed from: h */
    private final boolean f693h;

    /* JADX INFO: renamed from: i */
    private final long f694i;

    /* JADX INFO: renamed from: j */
    private final long f695j;

    /* JADX INFO: renamed from: k */
    private final FrameLayout f696k;

    /* JADX INFO: renamed from: l */
    private final Display f697l;

    /* JADX INFO: renamed from: m */
    private int f698m;

    /* JADX INFO: renamed from: n */
    private int f699n;

    /* JADX INFO: renamed from: o */
    private int f700o;

    /* JADX INFO: renamed from: p */
    private int f701p;

    /* JADX INFO: renamed from: q */
    private MediaPlayer f702q;

    /* JADX INFO: renamed from: r */
    private MediaController f703r;

    /* JADX INFO: renamed from: s */
    private boolean f704s;

    /* JADX INFO: renamed from: t */
    private boolean f705t;

    /* JADX INFO: renamed from: u */
    private int f706u;

    /* JADX INFO: renamed from: v */
    private boolean f707v;

    /* JADX INFO: renamed from: w */
    private boolean f708w;

    /* JADX INFO: renamed from: x */
    private a f709x;

    /* JADX INFO: renamed from: y */
    private b f710y;

    /* JADX INFO: renamed from: z */
    private volatile int f711z;

    /* JADX INFO: renamed from: com.unity3d.player.p$a */
    public interface a {
        /* JADX INFO: renamed from: a */
        void mo542a(int i);
    }

    /* JADX INFO: renamed from: com.unity3d.player.p$b */
    public class b implements Runnable {

        /* JADX INFO: renamed from: b */
        private SurfaceHolderCallbackC0467p f713b;

        /* JADX INFO: renamed from: c */
        private boolean f714c = false;

        public b(SurfaceHolderCallbackC0467p surfaceHolderCallbackC0467p) {
            this.f713b = surfaceHolderCallbackC0467p;
        }

        /* JADX INFO: renamed from: a */
        public final void m543a() {
            this.f714c = true;
        }

        @Override // java.lang.Runnable
        public final void run() {
            try {
                Thread.sleep(5000L);
            } catch (InterruptedException unused) {
                Thread.currentThread().interrupt();
            }
            if (this.f714c) {
                return;
            }
            if (SurfaceHolderCallbackC0467p.f686a) {
                SurfaceHolderCallbackC0467p.m537b("Stopping the video player due to timeout.");
            }
            this.f713b.CancelOnPrepare();
        }
    }

    protected SurfaceHolderCallbackC0467p(Context context, String str, int i, int i2, int i3, boolean z, long j, long j2, a aVar) {
        super(context);
        this.f704s = false;
        this.f705t = false;
        this.f706u = 0;
        this.f707v = false;
        this.f708w = false;
        this.f711z = 0;
        this.f709x = aVar;
        this.f687b = context;
        this.f696k = this;
        this.f688c = new SurfaceView(context);
        this.f689d = this.f688c.getHolder();
        this.f689d.addCallback(this);
        this.f696k.setBackgroundColor(i);
        this.f696k.addView(this.f688c);
        this.f697l = ((WindowManager) this.f687b.getSystemService("window")).getDefaultDisplay();
        this.f690e = str;
        this.f691f = i2;
        this.f692g = i3;
        this.f693h = z;
        this.f694i = j;
        this.f695j = j2;
        if (f686a) {
            m537b("fileName: " + this.f690e);
        }
        if (f686a) {
            m537b("backgroundColor: " + i);
        }
        if (f686a) {
            m537b("controlMode: " + this.f691f);
        }
        if (f686a) {
            m537b("scalingMode: " + this.f692g);
        }
        if (f686a) {
            m537b("isURL: " + this.f693h);
        }
        if (f686a) {
            m537b("videoOffset: " + this.f694i);
        }
        if (f686a) {
            m537b("videoLength: " + this.f695j);
        }
        setFocusable(true);
        setFocusableInTouchMode(true);
    }

    /* JADX INFO: renamed from: a */
    private void m535a(int i) {
        this.f711z = i;
        if (this.f709x != null) {
            this.f709x.mo542a(this.f711z);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: b */
    public static void m537b(String str) {
        Log.i("Video", "VideoPlayer: " + str);
    }

    /* JADX INFO: renamed from: c */
    private void m539c() {
        FileInputStream fileInputStream;
        if (this.f702q != null) {
            this.f702q.setDisplay(this.f689d);
            if (this.f707v) {
                return;
            }
            if (f686a) {
                m537b("Resuming playback");
            }
            this.f702q.start();
            return;
        }
        m535a(0);
        doCleanUp();
        try {
            this.f702q = new MediaPlayer();
            if (this.f693h) {
                this.f702q.setDataSource(this.f687b, Uri.parse(this.f690e));
            } else {
                if (this.f695j != 0) {
                    fileInputStream = new FileInputStream(this.f690e);
                    this.f702q.setDataSource(fileInputStream.getFD(), this.f694i, this.f695j);
                } else {
                    try {
                        AssetFileDescriptor assetFileDescriptorOpenFd = getResources().getAssets().openFd(this.f690e);
                        this.f702q.setDataSource(assetFileDescriptorOpenFd.getFileDescriptor(), assetFileDescriptorOpenFd.getStartOffset(), assetFileDescriptorOpenFd.getLength());
                        assetFileDescriptorOpenFd.close();
                    } catch (IOException unused) {
                        fileInputStream = new FileInputStream(this.f690e);
                        this.f702q.setDataSource(fileInputStream.getFD());
                        fileInputStream.close();
                    }
                }
                fileInputStream.close();
            }
            this.f702q.setDisplay(this.f689d);
            this.f702q.setScreenOnWhilePlaying(true);
            this.f702q.setOnBufferingUpdateListener(this);
            this.f702q.setOnCompletionListener(this);
            this.f702q.setOnPreparedListener(this);
            this.f702q.setOnVideoSizeChangedListener(this);
            this.f702q.setAudioStreamType(3);
            this.f702q.prepareAsync();
            this.f710y = new b(this);
            new Thread(this.f710y).start();
        } catch (Exception e) {
            if (f686a) {
                m537b("error: " + e.getMessage() + e);
            }
            m535a(2);
        }
    }

    /* JADX INFO: renamed from: d */
    private void m540d() {
        if (isPlaying()) {
            return;
        }
        m535a(1);
        if (f686a) {
            m537b("startVideoPlayback");
        }
        updateVideoLayout();
        if (this.f707v) {
            return;
        }
        start();
    }

    public final void CancelOnPrepare() {
        m535a(2);
    }

    /* JADX INFO: renamed from: a */
    final boolean m541a() {
        return this.f707v;
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final boolean canPause() {
        return true;
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final boolean canSeekBackward() {
        return true;
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final boolean canSeekForward() {
        return true;
    }

    protected final void destroyPlayer() {
        if (f686a) {
            m537b("destroyPlayer");
        }
        if (!this.f707v) {
            pause();
        }
        doCleanUp();
    }

    protected final void doCleanUp() {
        if (this.f710y != null) {
            this.f710y.m543a();
            this.f710y = null;
        }
        if (this.f702q != null) {
            this.f702q.release();
            this.f702q = null;
        }
        this.f700o = 0;
        this.f701p = 0;
        this.f705t = false;
        this.f704s = false;
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final int getBufferPercentage() {
        if (this.f693h) {
            return this.f706u;
        }
        return 100;
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final int getCurrentPosition() {
        if (this.f702q == null) {
            return 0;
        }
        return this.f702q.getCurrentPosition();
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final int getDuration() {
        if (this.f702q == null) {
            return 0;
        }
        return this.f702q.getDuration();
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final boolean isPlaying() {
        boolean z = this.f705t && this.f704s;
        if (this.f702q == null) {
            return !z;
        }
        return this.f702q.isPlaying() || !z;
    }

    @Override // android.media.MediaPlayer.OnBufferingUpdateListener
    public final void onBufferingUpdate(MediaPlayer mediaPlayer, int i) {
        if (f686a) {
            m537b("onBufferingUpdate percent:" + i);
        }
        this.f706u = i;
    }

    @Override // android.media.MediaPlayer.OnCompletionListener
    public final void onCompletion(MediaPlayer mediaPlayer) {
        if (f686a) {
            m537b("onCompletion called");
        }
        destroyPlayer();
        m535a(3);
    }

    @Override // android.view.View, android.view.KeyEvent.Callback
    public final boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (i != 4 && (this.f691f != 2 || i == 0 || keyEvent.isSystem())) {
            return this.f703r != null ? this.f703r.onKeyDown(i, keyEvent) : super.onKeyDown(i, keyEvent);
        }
        destroyPlayer();
        m535a(3);
        return true;
    }

    @Override // android.media.MediaPlayer.OnPreparedListener
    public final void onPrepared(MediaPlayer mediaPlayer) {
        if (f686a) {
            m537b("onPrepared called");
        }
        if (this.f710y != null) {
            this.f710y.m543a();
            this.f710y = null;
        }
        if (this.f691f == 0 || this.f691f == 1) {
            this.f703r = new MediaController(this.f687b);
            this.f703r.setMediaPlayer(this);
            this.f703r.setAnchorView(this);
            this.f703r.setEnabled(true);
            if (this.f687b instanceof Activity) {
                this.f703r.setSystemUiVisibility(((Activity) this.f687b).getWindow().getDecorView().getSystemUiVisibility());
            }
            this.f703r.show();
        }
        this.f705t = true;
        if (this.f705t && this.f704s) {
            m540d();
        }
    }

    @Override // android.view.View
    public final boolean onTouchEvent(MotionEvent motionEvent) {
        int action = motionEvent.getAction() & 255;
        if (this.f691f != 2 || action != 0) {
            return this.f703r != null ? this.f703r.onTouchEvent(motionEvent) : super.onTouchEvent(motionEvent);
        }
        destroyPlayer();
        m535a(3);
        return true;
    }

    @Override // android.media.MediaPlayer.OnVideoSizeChangedListener
    public final void onVideoSizeChanged(MediaPlayer mediaPlayer, int i, int i2) {
        if (f686a) {
            m537b("onVideoSizeChanged called " + i + "x" + i2);
        }
        if (i != 0 && i2 != 0) {
            this.f704s = true;
            this.f700o = i;
            this.f701p = i2;
            if (this.f705t && this.f704s) {
                m540d();
                return;
            }
            return;
        }
        if (f686a) {
            m537b("invalid video width(" + i + ") or height(" + i2 + ")");
        }
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final void pause() {
        if (this.f702q == null) {
            return;
        }
        if (this.f708w) {
            this.f702q.pause();
        }
        this.f707v = true;
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final void seekTo(int i) {
        if (this.f702q == null) {
            return;
        }
        this.f702q.seekTo(i);
    }

    @Override // android.widget.MediaController.MediaPlayerControl
    public final void start() {
        if (f686a) {
            m537b("Start");
        }
        if (this.f702q == null) {
            return;
        }
        if (this.f708w) {
            this.f702q.start();
        }
        this.f707v = false;
    }

    @Override // android.view.SurfaceHolder.Callback
    public final void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
        if (f686a) {
            m537b("surfaceChanged called " + i + " " + i2 + "x" + i3);
        }
        if (this.f698m == i2 && this.f699n == i3) {
            return;
        }
        this.f698m = i2;
        this.f699n = i3;
        if (this.f708w) {
            updateVideoLayout();
        }
    }

    @Override // android.view.SurfaceHolder.Callback
    public final void surfaceCreated(SurfaceHolder surfaceHolder) {
        if (f686a) {
            m537b("surfaceCreated called");
        }
        this.f708w = true;
        m539c();
    }

    @Override // android.view.SurfaceHolder.Callback
    public final void surfaceDestroyed(SurfaceHolder surfaceHolder) {
        if (f686a) {
            m537b("surfaceDestroyed called");
        }
        this.f708w = false;
    }

    /* JADX WARN: Code duplicated, block: B:19:0x0053  */
    /* JADX WARN: Code duplicated, block: B:20:0x0059  */
    protected final void updateVideoLayout() {
        if (f686a) {
            m537b("updateVideoLayout");
        }
        if (this.f702q == null) {
            return;
        }
        if (this.f698m == 0 || this.f699n == 0) {
            WindowManager windowManager = (WindowManager) this.f687b.getSystemService("window");
            DisplayMetrics displayMetrics = new DisplayMetrics();
            windowManager.getDefaultDisplay().getMetrics(displayMetrics);
            this.f698m = displayMetrics.widthPixels;
            this.f699n = displayMetrics.heightPixels;
        }
        int i = this.f698m;
        int i2 = this.f699n;
        if (this.f704s) {
            float f = this.f700o / this.f701p;
            float f2 = this.f698m / this.f699n;
            if (this.f692g == 1) {
                if (f2 <= f) {
                    i2 = (int) (this.f698m / f);
                } else {
                    i = (int) (this.f699n * f);
                }
            } else if (this.f692g == 2) {
                if (f2 >= f) {
                    i2 = (int) (this.f698m / f);
                } else {
                    i = (int) (this.f699n * f);
                }
            } else if (this.f692g == 0) {
                i = this.f700o;
                i2 = this.f701p;
            }
        } else if (f686a) {
            m537b("updateVideoLayout: Video size is not known yet");
        }
        if (this.f698m == i && this.f699n == i2) {
            return;
        }
        if (f686a) {
            m537b("frameWidth = " + i + "; frameHeight = " + i2);
        }
        this.f696k.updateViewLayout(this.f688c, new FrameLayout.LayoutParams(i, i2, 17));
    }
}
