package org.fmod;

import android.media.AudioTrack;
import android.util.Log;
import java.nio.ByteBuffer;

/* JADX INFO: loaded from: classes.dex */
public class FMODAudioDevice implements Runnable {

    /* JADX INFO: renamed from: h */
    private static int f742h = 0;

    /* JADX INFO: renamed from: i */
    private static int f743i = 1;

    /* JADX INFO: renamed from: j */
    private static int f744j = 2;

    /* JADX INFO: renamed from: k */
    private static int f745k = 3;

    /* JADX INFO: renamed from: a */
    private volatile Thread f746a = null;

    /* JADX INFO: renamed from: b */
    private volatile boolean f747b = false;

    /* JADX INFO: renamed from: c */
    private AudioTrack f748c = null;

    /* JADX INFO: renamed from: d */
    private boolean f749d = false;

    /* JADX INFO: renamed from: e */
    private ByteBuffer f750e = null;

    /* JADX INFO: renamed from: f */
    private byte[] f751f = null;

    /* JADX INFO: renamed from: g */
    private volatile RunnableC0525a f752g;

    private native int fmodGetInfo(int i);

    private native int fmodProcess(ByteBuffer byteBuffer);

    private void releaseAudioTrack() {
        if (this.f748c != null) {
            if (this.f748c.getState() == 1) {
                this.f748c.stop();
            }
            this.f748c.release();
            this.f748c = null;
        }
        this.f750e = null;
        this.f751f = null;
        this.f749d = false;
    }

    public synchronized void close() {
        stop();
    }

    native int fmodProcessMicData(ByteBuffer byteBuffer, int i);

    public boolean isRunning() {
        return this.f746a != null && this.f746a.isAlive();
    }

    @Override // java.lang.Runnable
    public void run() {
        int i = 3;
        while (this.f747b) {
            if (!this.f749d && i > 0) {
                releaseAudioTrack();
                int iFmodGetInfo = fmodGetInfo(f742h);
                int iRound = Math.round(AudioTrack.getMinBufferSize(iFmodGetInfo, 3, 2) * 1.1f) & (-4);
                int iFmodGetInfo2 = fmodGetInfo(f743i);
                int iFmodGetInfo3 = fmodGetInfo(f744j) * iFmodGetInfo2 * 4;
                this.f748c = new AudioTrack(3, iFmodGetInfo, 3, 2, iFmodGetInfo3 > iRound ? iFmodGetInfo3 : iRound, 1);
                this.f749d = this.f748c.getState() == 1;
                if (this.f749d) {
                    this.f750e = ByteBuffer.allocateDirect(iFmodGetInfo2 * 2 * 2);
                    this.f751f = new byte[this.f750e.capacity()];
                    this.f748c.play();
                    i = 3;
                } else {
                    Log.e("FMOD", "AudioTrack failed to initialize (status " + this.f748c.getState() + ")");
                    releaseAudioTrack();
                    i += -1;
                }
            }
            if (this.f749d) {
                if (fmodGetInfo(f745k) == 1) {
                    fmodProcess(this.f750e);
                    this.f750e.get(this.f751f, 0, this.f750e.capacity());
                    this.f748c.write(this.f751f, 0, this.f750e.capacity());
                    this.f750e.position(0);
                } else {
                    releaseAudioTrack();
                }
            }
        }
        releaseAudioTrack();
    }

    public synchronized void start() {
        if (this.f746a != null) {
            stop();
        }
        this.f746a = new Thread(this, "FMODAudioDevice");
        this.f746a.setPriority(10);
        this.f747b = true;
        this.f746a.start();
        if (this.f752g != null) {
            this.f752g.m567b();
        }
    }

    public synchronized int startAudioRecord(int i, int i2, int i3) {
        if (this.f752g == null) {
            this.f752g = new RunnableC0525a(this, i, i2);
            this.f752g.m567b();
        }
        return this.f752g.m566a();
    }

    public synchronized void stop() {
        while (this.f746a != null) {
            this.f747b = false;
            try {
                this.f746a.join();
                this.f746a = null;
            } catch (InterruptedException unused) {
            }
        }
        if (this.f752g != null) {
            this.f752g.m568c();
        }
    }

    public synchronized void stopAudioRecord() {
        if (this.f752g != null) {
            this.f752g.m568c();
            this.f752g = null;
        }
    }
}
