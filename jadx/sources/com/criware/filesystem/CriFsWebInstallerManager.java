package com.criware.filesystem;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedQueue;
import javax.net.ssl.X509TrustManager;

/* JADX INFO: loaded from: classes.dex */
public class CriFsWebInstallerManager {
    public boolean allow_insecure_ssl;
    public boolean crc_enabled;
    public int inactive_timeout_sec;
    public ConcurrentLinkedQueue<CriFsWebInstaller> installer_list;
    public boolean is_initialized;
    public int num_installers;
    private int num_installers_max;
    public String proxy_host = "";
    public short proxy_port = -1;
    public RequestHeaders request_headers;
    public String user_agent;

    public static class LooseTrustManager implements X509TrustManager {
        @Override // javax.net.ssl.X509TrustManager
        public void checkClientTrusted(X509Certificate[] x509CertificateArr, String str) throws CertificateException {
        }

        @Override // javax.net.ssl.X509TrustManager
        public void checkServerTrusted(X509Certificate[] x509CertificateArr, String str) throws CertificateException {
        }

        @Override // javax.net.ssl.X509TrustManager
        public X509Certificate[] getAcceptedIssuers() {
            return null;
        }
    }

    public void Manager_Initialize(CriFsWebInstaller.Config config) {
        if (this.is_initialized) {
            return;
        }
        this.num_installers = config.num_installers;
        this.allow_insecure_ssl = config.allow_insecure_ssl;
        this.inactive_timeout_sec = config.inactive_timeout_sec;
        this.proxy_host = config.proxy_host;
        this.proxy_port = config.proxy_port;
        this.user_agent = config.user_agent;
        this.crc_enabled = config.crc_enabled;
        this.num_installers_max = this.num_installers;
        this.num_installers = 0;
        this.installer_list = new ConcurrentLinkedQueue<>();
        this.request_headers = new RequestHeaders(config.max_request_fields);
        this.is_initialized = true;
    }

    public void Manager_Finalize() {
        if (this.is_initialized) {
            for (CriFsWebInstaller criFsWebInstaller : this.installer_list) {
                criFsWebInstaller.is_stop_required = true;
                this.installer_list.remove(criFsWebInstaller);
            }
            this.is_initialized = false;
        }
    }

    public CriFsWebInstaller CreateInstaller() {
        if (this.num_installers >= this.num_installers_max) {
            CriFsWebInstaller.ErrorEntry(3);
            return null;
        }
        CriFsWebInstaller criFsWebInstaller = new CriFsWebInstaller();
        if (this.installer_list.add(criFsWebInstaller)) {
            this.num_installers++;
        }
        return criFsWebInstaller;
    }

    public void ExecuteMain() {
        Iterator<CriFsWebInstaller> it = this.installer_list.iterator();
        while (it.hasNext()) {
            it.next().Update();
        }
    }

    public final class RequestHeaders {
        private List<String> fieldAndValues;

        public RequestHeaders(int i) {
            this.fieldAndValues = null;
            this.fieldAndValues = new ArrayList(i * 2);
        }

        public void set(String str, String str2) {
            removeAll(str);
            if (str2 != null) {
                add(str, str2);
            }
        }

        public int length() {
            return this.fieldAndValues.size() / 2;
        }

        public String getFieldName(int i) {
            int i2 = i * 2;
            if (i2 < 0 || i2 >= this.fieldAndValues.size()) {
                return null;
            }
            return this.fieldAndValues.get(i2);
        }

        public String getValue(int i) {
            int i2 = (i * 2) + 1;
            if (i2 < 0 || i2 >= this.fieldAndValues.size()) {
                return null;
            }
            return this.fieldAndValues.get(i2);
        }

        private void add(String str, String str2) {
            this.fieldAndValues.add(str);
            this.fieldAndValues.add(str2);
        }

        private void removeAll(String str) {
            for (int i = 0; i < this.fieldAndValues.size(); i += 2) {
                if (str.equalsIgnoreCase(this.fieldAndValues.get(i))) {
                    this.fieldAndValues.remove(i);
                    this.fieldAndValues.remove(i);
                }
            }
        }
    }
}
