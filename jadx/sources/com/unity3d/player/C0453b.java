package com.unity3d.player;

import android.os.Build;
import java.net.InetAddress;
import java.net.Socket;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import javax.net.ssl.HandshakeCompletedEvent;
import javax.net.ssl.HandshakeCompletedListener;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLPeerUnverifiedException;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

/* JADX INFO: renamed from: com.unity3d.player.b */
/* JADX INFO: loaded from: classes.dex */
public final class C0453b extends SSLSocketFactory {

    /* JADX INFO: renamed from: c */
    private static volatile SSLSocketFactory f634c;

    /* JADX INFO: renamed from: d */
    private static volatile X509TrustManager f635d;

    /* JADX INFO: renamed from: e */
    private static final Object f636e = new Object[0];

    /* JADX INFO: renamed from: f */
    private static final Object f637f = new Object[0];

    /* JADX INFO: renamed from: g */
    private static final boolean f638g;

    /* JADX INFO: renamed from: a */
    private final SSLSocketFactory f639a;

    /* JADX INFO: renamed from: b */
    private final a f640b;

    /* JADX INFO: renamed from: com.unity3d.player.b$a */
    class a implements HandshakeCompletedListener {
        @Override // javax.net.ssl.HandshakeCompletedListener
        public final void handshakeCompleted(HandshakeCompletedEvent handshakeCompletedEvent) {
            SSLSession session = handshakeCompletedEvent.getSession();
            session.getCipherSuite();
            session.getProtocol();
            try {
                session.getPeerPrincipal().getName();
            } catch (SSLPeerUnverifiedException unused) {
            }
        }
    }

    /* JADX INFO: renamed from: com.unity3d.player.b$b */
    public static abstract class b implements X509TrustManager {

        /* JADX INFO: renamed from: a */
        protected X509TrustManager f641a = C0453b.m503c();

        @Override // javax.net.ssl.X509TrustManager
        public final void checkClientTrusted(X509Certificate[] x509CertificateArr, String str) throws CertificateException {
            this.f641a.checkClientTrusted(x509CertificateArr, str);
        }

        @Override // javax.net.ssl.X509TrustManager
        public void checkServerTrusted(X509Certificate[] x509CertificateArr, String str) throws CertificateException {
            this.f641a.checkServerTrusted(x509CertificateArr, str);
        }

        @Override // javax.net.ssl.X509TrustManager
        public final X509Certificate[] getAcceptedIssuers() {
            return this.f641a.getAcceptedIssuers();
        }
    }

    static {
        boolean z = false;
        if (Build.VERSION.SDK_INT >= 16 && Build.VERSION.SDK_INT < 20) {
            z = true;
        }
        f638g = z;
    }

    private C0453b(b[] bVarArr) throws NoSuchAlgorithmException, KeyManagementException {
        SSLContext sSLContext = SSLContext.getInstance("TLS");
        sSLContext.init(null, bVarArr, null);
        this.f639a = sSLContext.getSocketFactory();
        this.f640b = null;
    }

    /* JADX INFO: renamed from: a */
    private Socket m499a(Socket socket) {
        if (socket != null && (socket instanceof SSLSocket)) {
            if (f638g) {
                SSLSocket sSLSocket = (SSLSocket) socket;
                sSLSocket.setEnabledProtocols(sSLSocket.getSupportedProtocols());
            }
            if (this.f640b != null) {
                ((SSLSocket) socket).addHandshakeCompletedListener(this.f640b);
            }
        }
        return socket;
    }

    /* JADX INFO: renamed from: a */
    public static SSLSocketFactory m500a(b bVar) {
        try {
            return bVar == null ? m502b() : new C0453b(new b[]{bVar});
        } catch (Exception e) {
            C0458g.Log(5, "CustomSSLSocketFactory: Failed to create SSLSocketFactory (" + e.getMessage() + ")");
            return null;
        }
    }

    /* JADX INFO: renamed from: b */
    private static SSLSocketFactory m502b() {
        synchronized (f636e) {
            if (f634c != null) {
                return f634c;
            }
            C0453b c0453b = new C0453b(null);
            f634c = c0453b;
            return c0453b;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: c */
    public static X509TrustManager m503c() {
        synchronized (f637f) {
            if (f635d != null) {
                return f635d;
            }
            try {
                TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
                trustManagerFactory.init((KeyStore) null);
                for (TrustManager trustManager : trustManagerFactory.getTrustManagers()) {
                    if (trustManager instanceof X509TrustManager) {
                        X509TrustManager x509TrustManager = (X509TrustManager) trustManager;
                        f635d = x509TrustManager;
                        return x509TrustManager;
                    }
                }
            } catch (Exception e) {
                C0458g.Log(5, "CustomSSLSocketFactory: Failed to find X509TrustManager (" + e.getMessage() + ")");
            }
            return null;
        }
    }

    @Override // javax.net.SocketFactory
    public final Socket createSocket() {
        return m499a(this.f639a.createSocket());
    }

    @Override // javax.net.SocketFactory
    public final Socket createSocket(String str, int i) {
        return m499a(this.f639a.createSocket(str, i));
    }

    @Override // javax.net.SocketFactory
    public final Socket createSocket(String str, int i, InetAddress inetAddress, int i2) {
        return m499a(this.f639a.createSocket(str, i, inetAddress, i2));
    }

    @Override // javax.net.SocketFactory
    public final Socket createSocket(InetAddress inetAddress, int i) {
        return m499a(this.f639a.createSocket(inetAddress, i));
    }

    @Override // javax.net.SocketFactory
    public final Socket createSocket(InetAddress inetAddress, int i, InetAddress inetAddress2, int i2) {
        return m499a(this.f639a.createSocket(inetAddress, i, inetAddress2, i2));
    }

    @Override // javax.net.ssl.SSLSocketFactory
    public final Socket createSocket(Socket socket, String str, int i, boolean z) {
        return m499a(this.f639a.createSocket(socket, str, i, z));
    }

    @Override // javax.net.ssl.SSLSocketFactory
    public final String[] getDefaultCipherSuites() {
        return this.f639a.getDefaultCipherSuites();
    }

    @Override // javax.net.ssl.SSLSocketFactory
    public final String[] getSupportedCipherSuites() {
        return this.f639a.getSupportedCipherSuites();
    }
}
