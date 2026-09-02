package com.unity3d.player;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.SurfaceTexture;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureFailure;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.TotalCaptureResult;
import android.hardware.camera2.params.MeteringRectangle;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.media.Image;
import android.media.ImageReader;
import android.os.Handler;
import android.os.HandlerThread;
import android.util.Range;
import android.util.Size;
import android.view.Surface;
import com.unity.purchasing.googleplay.GooglePlayPurchasing;
import java.util.Arrays;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

/* JADX INFO: renamed from: com.unity3d.player.a */
/* JADX INFO: loaded from: classes.dex */
public final class C0452a {

    /* JADX INFO: renamed from: b */
    private static CameraManager f595b;

    /* JADX INFO: renamed from: c */
    private static String[] f596c;

    /* JADX INFO: renamed from: e */
    private static Semaphore f597e = new Semaphore(1);

    /* JADX INFO: renamed from: a */
    private InterfaceC0455d f602a;

    /* JADX INFO: renamed from: d */
    private CameraDevice f603d;

    /* JADX INFO: renamed from: f */
    private HandlerThread f604f;

    /* JADX INFO: renamed from: g */
    private Handler f605g;

    /* JADX INFO: renamed from: h */
    private Rect f606h;

    /* JADX INFO: renamed from: i */
    private Rect f607i;

    /* JADX INFO: renamed from: j */
    private int f608j;

    /* JADX INFO: renamed from: k */
    private int f609k;

    /* JADX INFO: renamed from: n */
    private int f612n;

    /* JADX INFO: renamed from: o */
    private int f613o;

    /* JADX INFO: renamed from: q */
    private Range f615q;

    /* JADX INFO: renamed from: s */
    private Image f617s;

    /* JADX INFO: renamed from: t */
    private CaptureRequest.Builder f618t;

    /* JADX INFO: renamed from: w */
    private int f621w;

    /* JADX INFO: renamed from: x */
    private SurfaceTexture f622x;

    /* JADX INFO: renamed from: l */
    private float f610l = -1.0f;

    /* JADX INFO: renamed from: m */
    private float f611m = -1.0f;

    /* JADX INFO: renamed from: p */
    private boolean f614p = false;

    /* JADX INFO: renamed from: r */
    private ImageReader f616r = null;

    /* JADX INFO: renamed from: u */
    private CameraCaptureSession f619u = null;

    /* JADX INFO: renamed from: v */
    private Object f620v = new Object();

    /* JADX INFO: renamed from: y */
    private Surface f623y = null;

    /* JADX INFO: renamed from: z */
    private int f624z = a.f632c;

    /* JADX INFO: renamed from: A */
    private CameraCaptureSession.CaptureCallback f598A = new CameraCaptureSession.CaptureCallback() { // from class: com.unity3d.player.a.1
        @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
        public final void onCaptureCompleted(CameraCaptureSession cameraCaptureSession, CaptureRequest captureRequest, TotalCaptureResult totalCaptureResult) {
            C0452a.this.m469a(captureRequest.getTag());
        }

        @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
        public final void onCaptureFailed(CameraCaptureSession cameraCaptureSession, CaptureRequest captureRequest, CaptureFailure captureFailure) {
            C0458g.Log(5, "Camera2: Capture session failed " + captureRequest.getTag() + " reason " + captureFailure.getReason());
            C0452a.this.m469a(captureRequest.getTag());
        }

        @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
        public final void onCaptureSequenceAborted(CameraCaptureSession cameraCaptureSession, int i) {
        }

        @Override // android.hardware.camera2.CameraCaptureSession.CaptureCallback
        public final void onCaptureSequenceCompleted(CameraCaptureSession cameraCaptureSession, int i, long j) {
        }
    };

    /* JADX INFO: renamed from: B */
    private final CameraDevice.StateCallback f599B = new CameraDevice.StateCallback() { // from class: com.unity3d.player.a.3
        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public final void onClosed(CameraDevice cameraDevice) {
            C0452a.f597e.release();
        }

        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public final void onDisconnected(CameraDevice cameraDevice) {
            C0458g.Log(5, "Camera2: CameraDevice disconnected.");
            C0452a.this.m467a(cameraDevice);
            C0452a.f597e.release();
        }

        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public final void onError(CameraDevice cameraDevice, int i) {
            C0458g.Log(6, "Camera2: Error opeining CameraDevice " + i);
            C0452a.this.m467a(cameraDevice);
            C0452a.f597e.release();
        }

        @Override // android.hardware.camera2.CameraDevice.StateCallback
        public final void onOpened(CameraDevice cameraDevice) {
            C0452a.this.f603d = cameraDevice;
            C0452a.f597e.release();
        }
    };

    /* JADX INFO: renamed from: C */
    private final ImageReader.OnImageAvailableListener f600C = new ImageReader.OnImageAvailableListener() { // from class: com.unity3d.player.a.4
        @Override // android.media.ImageReader.OnImageAvailableListener
        public final void onImageAvailable(ImageReader imageReader) {
            if (C0452a.f597e.tryAcquire()) {
                Image imageAcquireNextImage = imageReader.acquireNextImage();
                if (imageAcquireNextImage != null) {
                    Image.Plane[] planes = imageAcquireNextImage.getPlanes();
                    if (imageAcquireNextImage.getFormat() == 35 && planes != null && planes.length == 3) {
                        C0452a.this.f602a.mo361a(planes[0].getBuffer(), planes[1].getBuffer(), planes[2].getBuffer(), planes[0].getRowStride(), planes[1].getRowStride(), planes[1].getPixelStride());
                    } else {
                        C0458g.Log(6, "Camera2: Wrong image format.");
                    }
                    if (C0452a.this.f617s != null) {
                        C0452a.this.f617s.close();
                    }
                    C0452a.this.f617s = imageAcquireNextImage;
                }
                C0452a.f597e.release();
            }
        }
    };

    /* JADX INFO: renamed from: D */
    private final SurfaceTexture.OnFrameAvailableListener f601D = new SurfaceTexture.OnFrameAvailableListener() { // from class: com.unity3d.player.a.5
        @Override // android.graphics.SurfaceTexture.OnFrameAvailableListener
        public final void onFrameAvailable(SurfaceTexture surfaceTexture) {
            C0452a.this.f602a.mo360a(surfaceTexture);
        }
    };

    /* JADX WARN: $VALUES field not found */
    /* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
    /* JADX INFO: renamed from: com.unity3d.player.a$a */
    private static final class a {

        /* JADX INFO: renamed from: a */
        public static final int f630a = 1;

        /* JADX INFO: renamed from: b */
        public static final int f631b = 2;

        /* JADX INFO: renamed from: c */
        public static final int f632c = 3;

        /* JADX INFO: renamed from: d */
        private static final /* synthetic */ int[] f633d = {f630a, f631b, f632c};
    }

    protected C0452a(InterfaceC0455d interfaceC0455d) {
        this.f602a = null;
        this.f602a = interfaceC0455d;
        m484g();
    }

    /* JADX INFO: renamed from: a */
    public static int m458a(Context context) {
        return m478c(context).length;
    }

    /* JADX INFO: renamed from: a */
    public static int m459a(Context context, int i) {
        try {
            return ((Integer) m471b(context).getCameraCharacteristics(m478c(context)[i]).get(CameraCharacteristics.SENSOR_ORIENTATION)).intValue();
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
            return 0;
        }
    }

    /* JADX INFO: renamed from: a */
    private static int m460a(Range[] rangeArr, int i) {
        int i2 = -1;
        double d = Double.MAX_VALUE;
        for (int i3 = 0; i3 < rangeArr.length; i3++) {
            int iIntValue = ((Integer) rangeArr[i3].getLower()).intValue();
            int iIntValue2 = ((Integer) rangeArr[i3].getUpper()).intValue();
            float f = i;
            if (f + 0.1f > iIntValue && f - 0.1f < iIntValue2) {
                return i;
            }
            double dMin = Math.min(Math.abs(i - iIntValue), Math.abs(i - iIntValue2));
            if (dMin < d) {
                i2 = i3;
                d = dMin;
            }
        }
        return ((Integer) (i > ((Integer) rangeArr[i2].getUpper()).intValue() ? rangeArr[i2].getUpper() : rangeArr[i2].getLower())).intValue();
    }

    /* JADX INFO: renamed from: a */
    private static Rect m461a(Size[] sizeArr, double d, double d2) {
        double d3 = Double.MAX_VALUE;
        int i = 0;
        int i2 = 0;
        for (int i3 = 0; i3 < sizeArr.length; i3++) {
            int width = sizeArr[i3].getWidth();
            int height = sizeArr[i3].getHeight();
            double d4 = width;
            Double.isNaN(d4);
            double dAbs = Math.abs(Math.log(d / d4));
            double d5 = height;
            Double.isNaN(d5);
            double dAbs2 = dAbs + Math.abs(Math.log(d2 / d5));
            if (dAbs2 < d3) {
                i = width;
                i2 = height;
                d3 = dAbs2;
            }
        }
        return new Rect(0, 0, i, i2);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public void m467a(CameraDevice cameraDevice) {
        synchronized (this.f620v) {
            this.f619u = null;
        }
        cameraDevice.close();
        this.f603d = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public void m469a(Object obj) {
        if (obj != "Focus") {
            if (obj == "Cancel focus") {
                synchronized (this.f620v) {
                    if (this.f619u != null) {
                        m490j();
                    }
                }
                return;
            }
            return;
        }
        this.f614p = false;
        synchronized (this.f620v) {
            if (this.f619u != null) {
                try {
                    this.f618t.set(CaptureRequest.CONTROL_AF_TRIGGER, 0);
                    this.f618t.setTag("Regular");
                    this.f619u.setRepeatingRequest(this.f618t.build(), this.f598A, this.f605g);
                } catch (CameraAccessException e) {
                    C0458g.Log(6, "Camera2: CameraAccessException " + e);
                }
            }
        }
    }

    /* JADX INFO: renamed from: a */
    private static Size[] m470a(CameraCharacteristics cameraCharacteristics) {
        String str;
        StreamConfigurationMap streamConfigurationMap = (StreamConfigurationMap) cameraCharacteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
        if (streamConfigurationMap == null) {
            str = "Camera2: configuration map is not available.";
        } else {
            Size[] outputSizes = streamConfigurationMap.getOutputSizes(35);
            if (outputSizes != null && outputSizes.length != 0) {
                return outputSizes;
            }
            str = "Camera2: output sizes for YUV_420_888 format are not avialable.";
        }
        C0458g.Log(6, str);
        return null;
    }

    /* JADX INFO: renamed from: b */
    private static CameraManager m471b(Context context) {
        if (f595b == null) {
            f595b = (CameraManager) context.getSystemService("camera");
        }
        return f595b;
    }

    /* JADX INFO: renamed from: b */
    private void m473b(CameraCharacteristics cameraCharacteristics) {
        this.f609k = ((Integer) cameraCharacteristics.get(CameraCharacteristics.CONTROL_MAX_REGIONS_AF)).intValue();
        if (this.f609k > 0) {
            this.f607i = (Rect) cameraCharacteristics.get(CameraCharacteristics.SENSOR_INFO_ACTIVE_ARRAY_SIZE);
            float fWidth = this.f607i.width() / this.f607i.height();
            float fWidth2 = this.f606h.width() / this.f606h.height();
            if (fWidth2 > fWidth) {
                this.f612n = 0;
                this.f613o = (int) ((this.f607i.height() - (this.f607i.width() / fWidth2)) / 2.0f);
            } else {
                this.f613o = 0;
                this.f612n = (int) ((this.f607i.width() - (this.f607i.height() * fWidth2)) / 2.0f);
            }
            this.f608j = Math.min(this.f607i.width(), this.f607i.height()) / 20;
        }
    }

    /* JADX INFO: renamed from: b */
    public static boolean m475b(Context context, int i) {
        try {
            return ((Integer) m471b(context).getCameraCharacteristics(m478c(context)[i]).get(CameraCharacteristics.LENS_FACING)).intValue() == 0;
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
            return false;
        }
    }

    /* JADX INFO: renamed from: c */
    public static boolean m477c(Context context, int i) {
        try {
            return ((Integer) m471b(context).getCameraCharacteristics(m478c(context)[i]).get(CameraCharacteristics.CONTROL_MAX_REGIONS_AF)).intValue() > 0;
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
            return false;
        }
    }

    /* JADX INFO: renamed from: c */
    private static String[] m478c(Context context) {
        if (f596c == null) {
            try {
                f596c = m471b(context).getCameraIdList();
            } catch (CameraAccessException e) {
                C0458g.Log(6, "Camera2: CameraAccessException " + e);
                f596c = new String[0];
            }
        }
        return f596c;
    }

    /* JADX INFO: renamed from: d */
    public static int[] m480d(Context context, int i) {
        try {
            Size[] sizeArrM470a = m470a(m471b(context).getCameraCharacteristics(m478c(context)[i]));
            if (sizeArrM470a == null) {
                return null;
            }
            int[] iArr = new int[sizeArrM470a.length * 2];
            for (int i2 = 0; i2 < sizeArrM470a.length; i2++) {
                int i3 = i2 * 2;
                iArr[i3] = sizeArrM470a[i2].getWidth();
                iArr[i3 + 1] = sizeArrM470a[i2].getHeight();
            }
            return iArr;
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
            return null;
        }
    }

    /* JADX INFO: renamed from: g */
    private void m484g() {
        this.f604f = new HandlerThread("CameraBackground");
        this.f604f.start();
        this.f605g = new Handler(this.f604f.getLooper());
    }

    /* JADX INFO: renamed from: h */
    private void m487h() {
        this.f604f.quit();
        try {
            this.f604f.join(4000L);
            this.f604f = null;
            this.f605g = null;
        } catch (InterruptedException e) {
            this.f604f.interrupt();
            C0458g.Log(6, "Camera2: Interrupted while waiting for the background thread to finish " + e);
        }
    }

    /* JADX INFO: renamed from: i */
    private void m489i() {
        try {
            if (!f597e.tryAcquire(4L, TimeUnit.SECONDS)) {
                C0458g.Log(5, "Camera2: Timeout waiting to lock camera for closing.");
                return;
            }
            this.f603d.close();
            try {
                if (!f597e.tryAcquire(4L, TimeUnit.SECONDS)) {
                    C0458g.Log(5, "Camera2: Timeout waiting to close camera.");
                }
            } catch (InterruptedException e) {
                C0458g.Log(6, "Camera2: Interrupted while waiting to close camera " + e);
            }
            this.f603d = null;
            f597e.release();
        } catch (InterruptedException e2) {
            C0458g.Log(6, "Camera2: Interrupted while trying to lock camera for closing " + e2);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: j */
    public void m490j() {
        try {
            if (this.f609k != 0 && this.f610l >= 0.0f && this.f610l <= 1.0f && this.f611m >= 0.0f && this.f611m <= 1.0f) {
                this.f614p = true;
                int iWidth = (int) (((this.f607i.width() - (this.f612n * 2)) * this.f610l) + this.f612n);
                double dHeight = this.f607i.height() - (this.f613o * 2);
                double d = this.f611m;
                Double.isNaN(d);
                Double.isNaN(dHeight);
                double d2 = dHeight * (1.0d - d);
                double d3 = this.f613o;
                Double.isNaN(d3);
                this.f618t.set(CaptureRequest.CONTROL_AF_REGIONS, new MeteringRectangle[]{new MeteringRectangle(Math.max(this.f608j + 1, Math.min(iWidth, (this.f607i.width() - this.f608j) - 1)) - this.f608j, Math.max(this.f608j + 1, Math.min((int) (d2 + d3), (this.f607i.height() - this.f608j) - 1)) - this.f608j, this.f608j * 2, this.f608j * 2, GooglePlayPurchasing.ACTIVITY_REQUEST_CODE)});
                this.f618t.set(CaptureRequest.CONTROL_AF_MODE, 1);
                this.f618t.set(CaptureRequest.CONTROL_AF_TRIGGER, 1);
                this.f618t.setTag("Focus");
                this.f619u.capture(this.f618t.build(), this.f598A, this.f605g);
                return;
            }
            this.f618t.set(CaptureRequest.CONTROL_AF_MODE, 4);
            this.f618t.setTag("Regular");
            if (this.f619u != null) {
                this.f619u.setRepeatingRequest(this.f618t.build(), this.f598A, this.f605g);
            }
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
        }
    }

    /* JADX INFO: renamed from: k */
    private void m491k() {
        try {
            if (this.f619u != null) {
                this.f619u.stopRepeating();
                this.f618t.set(CaptureRequest.CONTROL_AF_TRIGGER, 2);
                this.f618t.set(CaptureRequest.CONTROL_AF_MODE, 0);
                this.f618t.setTag("Cancel focus");
                this.f619u.capture(this.f618t.build(), this.f598A, this.f605g);
            }
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
        }
    }

    /* JADX INFO: renamed from: a */
    public final Rect m492a() {
        return this.f606h;
    }

    /* JADX INFO: renamed from: a */
    public final boolean m493a(float f, float f2) {
        if (this.f609k <= 0) {
            return false;
        }
        if (this.f614p) {
            C0458g.Log(5, "Camera2: Setting manual focus point already started.");
            return false;
        }
        this.f610l = f;
        this.f611m = f2;
        synchronized (this.f620v) {
            if (this.f619u != null && this.f624z != a.f631b) {
                m491k();
            }
        }
        return true;
    }

    /* JADX INFO: renamed from: a */
    public final boolean m494a(Context context, int i, int i2, int i3, int i4, int i5) {
        try {
            CameraCharacteristics cameraCharacteristics = f595b.getCameraCharacteristics(m478c(context)[i]);
            if (((Integer) cameraCharacteristics.get(CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL)).intValue() == 2) {
                C0458g.Log(5, "Camera2: only LEGACY hardware level is supported.");
                return false;
            }
            Size[] sizeArrM470a = m470a(cameraCharacteristics);
            if (sizeArrM470a != null && sizeArrM470a.length != 0) {
                this.f606h = m461a(sizeArrM470a, i2, i3);
                Range[] rangeArr = (Range[]) cameraCharacteristics.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES);
                if (rangeArr == null || rangeArr.length == 0) {
                    C0458g.Log(6, "Camera2: target FPS ranges are not avialable.");
                } else {
                    int iM460a = m460a(rangeArr, i4);
                    this.f615q = new Range(Integer.valueOf(iM460a), Integer.valueOf(iM460a));
                    try {
                        if (!f597e.tryAcquire(4L, TimeUnit.SECONDS)) {
                            C0458g.Log(5, "Camera2: Timeout waiting to lock camera for opening.");
                            return false;
                        }
                        try {
                            f595b.openCamera(m478c(context)[i], this.f599B, this.f605g);
                            try {
                                if (!f597e.tryAcquire(4L, TimeUnit.SECONDS)) {
                                    C0458g.Log(5, "Camera2: Timeout waiting to open camera.");
                                    return false;
                                }
                                f597e.release();
                                this.f621w = i5;
                                m473b(cameraCharacteristics);
                                return this.f603d != null;
                            } catch (InterruptedException e) {
                                C0458g.Log(6, "Camera2: Interrupted while waiting to open camera " + e);
                            }
                        } catch (CameraAccessException e2) {
                            C0458g.Log(6, "Camera2: CameraAccessException " + e2);
                            f597e.release();
                            return false;
                        }
                    } catch (InterruptedException e3) {
                        C0458g.Log(6, "Camera2: Interrupted while trying to lock camera for opening " + e3);
                        return false;
                    }
                }
            }
            return false;
        } catch (CameraAccessException e4) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e4);
            return false;
        }
    }

    /* JADX INFO: renamed from: b */
    public final void m495b() {
        if (this.f603d != null) {
            m498e();
            m489i();
            this.f598A = null;
            this.f623y = null;
            this.f622x = null;
            if (this.f617s != null) {
                this.f617s.close();
                this.f617s = null;
            }
            if (this.f616r != null) {
                this.f616r.close();
                this.f616r = null;
            }
        }
        m487h();
    }

    /* JADX INFO: renamed from: c */
    public final void m496c() {
        if (this.f616r == null) {
            this.f616r = ImageReader.newInstance(this.f606h.width(), this.f606h.height(), 35, 2);
            this.f616r.setOnImageAvailableListener(this.f600C, this.f605g);
            this.f617s = null;
            if (this.f621w != 0) {
                this.f622x = new SurfaceTexture(this.f621w);
                this.f622x.setDefaultBufferSize(this.f606h.width(), this.f606h.height());
                this.f622x.setOnFrameAvailableListener(this.f601D, this.f605g);
                this.f623y = new Surface(this.f622x);
            }
        }
        try {
            if (this.f619u == null) {
                this.f603d.createCaptureSession(Arrays.asList(this.f623y != null ? new Surface[]{this.f623y, this.f616r.getSurface()} : new Surface[]{this.f616r.getSurface()}), new CameraCaptureSession.StateCallback() { // from class: com.unity3d.player.a.2
                    @Override // android.hardware.camera2.CameraCaptureSession.StateCallback
                    public final void onConfigureFailed(CameraCaptureSession cameraCaptureSession) {
                        C0458g.Log(6, "Camera2: CaptureSession configuration failed.");
                    }

                    @Override // android.hardware.camera2.CameraCaptureSession.StateCallback
                    public final void onConfigured(CameraCaptureSession cameraCaptureSession) {
                        if (C0452a.this.f603d == null) {
                            return;
                        }
                        synchronized (C0452a.this.f620v) {
                            C0452a.this.f619u = cameraCaptureSession;
                            try {
                                C0452a.this.f618t = C0452a.this.f603d.createCaptureRequest(1);
                                if (C0452a.this.f623y != null) {
                                    C0452a.this.f618t.addTarget(C0452a.this.f623y);
                                }
                                C0452a.this.f618t.addTarget(C0452a.this.f616r.getSurface());
                                C0452a.this.f618t.set(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, C0452a.this.f615q);
                                C0452a.this.m490j();
                            } catch (CameraAccessException e) {
                                C0458g.Log(6, "Camera2: CameraAccessException " + e);
                            }
                        }
                    }
                }, this.f605g);
            } else if (this.f624z == a.f631b) {
                this.f619u.setRepeatingRequest(this.f618t.build(), this.f598A, this.f605g);
            }
            this.f624z = a.f630a;
        } catch (CameraAccessException e) {
            C0458g.Log(6, "Camera2: CameraAccessException " + e);
        }
    }

    /* JADX INFO: renamed from: d */
    public final void m497d() {
        synchronized (this.f620v) {
            if (this.f619u != null) {
                try {
                    this.f619u.stopRepeating();
                    this.f624z = a.f631b;
                } catch (CameraAccessException e) {
                    C0458g.Log(6, "Camera2: CameraAccessException " + e);
                }
            }
        }
    }

    /* JADX INFO: renamed from: e */
    public final void m498e() {
        synchronized (this.f620v) {
            if (this.f619u != null) {
                try {
                    this.f619u.abortCaptures();
                } catch (CameraAccessException e) {
                    C0458g.Log(6, "Camera2: CameraAccessException " + e);
                }
                this.f619u.close();
                this.f619u = null;
                this.f624z = a.f632c;
            }
        }
    }
}
