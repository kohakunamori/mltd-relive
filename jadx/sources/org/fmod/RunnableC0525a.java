package org.fmod;

import android.media.AudioRecord;
import android.util.Log;
import java.nio.ByteBuffer;

/* JADX INFO: renamed from: org.fmod.a */
/* JADX INFO: loaded from: classes.dex */
final class RunnableC0525a implements Runnable {

    /* JADX INFO: renamed from: a */
    private final FMODAudioDevice f753a;

    /* JADX INFO: renamed from: b */
    private final ByteBuffer f754b;

    /* JADX INFO: renamed from: c */
    private final int f755c;

    /* JADX INFO: renamed from: d */
    private final int f756d;

    /* JADX INFO: renamed from: e */
    private final int f757e = 2;

    /* JADX INFO: renamed from: f */
    private volatile Thread f758f;

    /* JADX INFO: renamed from: g */
    private volatile boolean f759g;

    /* JADX INFO: renamed from: h */
    private AudioRecord f760h;

    /* JADX INFO: renamed from: i */
    private boolean f761i;

    RunnableC0525a(FMODAudioDevice fMODAudioDevice, int i, int i2) {
        this.f753a = fMODAudioDevice;
        this.f755c = i;
        this.f756d = i2;
        this.f754b = ByteBuffer.allocateDirect(AudioRecord.getMinBufferSize(i, i2, 2));
    }

    /* JADX INFO: renamed from: d */
    private void m565d() {
        if (this.f760h != null) {
            if (this.f760h.getState() == 1) {
                this.f760h.stop();
            }
            this.f760h.release();
            this.f760h = null;
        }
        this.f754b.position(0);
        this.f761i = false;
    }

    /* JADX INFO: renamed from: a */
    public final int m566a() {
        return this.f754b.capacity();
    }

    /* JADX INFO: renamed from: b */
    public final void m567b() {
        if (this.f758f != null) {
            m568c();
        }
        this.f759g = true;
        this.f758f = new Thread(this);
        this.f758f.start();
    }

    /* JADX INFO: renamed from: c */
    public final void m568c() {
        while (this.f758f != null) {
            this.f759g = false;
            try {
                this.f758f.join();
                this.f758f = null;
            } catch (InterruptedException unused) {
            }
        }
    }

    @Override // java.lang.Runnable
    public final void run() {
        int i = 3;
        while (this.f759g) {
            if (!this.f761i && i > 0) {
                m565d();
                this.f760h = new AudioRecord(1, this.f755c, this.f756d, this.f757e, this.f754b.capacity());
                this.f761i = this.f760h.getState() == 1;
                if (this.f761i) {
                    this.f754b.position(0);
                    this.f760h.startRecording();
                    i = 3;
                } else {
                    Log.e("FMOD", "AudioRecord failed to initialize (status " + this.f760h.getState() + ")");
                    i += -1;
                    m565d();
                }
            }
            if (this.f761i && this.f760h.getRecordingState() == 3) {
                this.f753a.fmodProcessMicData(this.f754b, this.f760h.read(this.f754b, this.f754b.capacity()));
                this.f754b.position(0);
            }
        }
        m565d();
    }
}
