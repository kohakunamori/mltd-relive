package com.criware.filesystem;

import android.os.AsyncTask;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.Proxy;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.UnknownHostException;
import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.Locale;
import java.util.zip.CRC32;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLException;
import javax.net.ssl.SSLHandshakeException;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.X509TrustManager;

/* JADX INFO: loaded from: classes.dex */
public class CriFsWebInstaller {
    private static CriFsWebInstallerManager manager;
    private boolean can_access_asynctask;
    private CRC32 crc_num;
    private boolean is_timeouted;
    private boolean is_waiting_to_start;
    private long start_time;
    private WebInstallerTask task;
    private AsyncTaskParam task_params;
    private long timeout_start_time;
    private StatusInfo synced_statusinfo = new StatusInfo();
    public boolean is_stop_required = false;

    public static class Config {
        boolean allow_insecure_ssl;
        boolean crc_enabled;
        int inactive_timeout_sec;
        int max_request_fields;
        int num_installers;
        String proxy_host;
        short proxy_port;
        String user_agent;
    }

    public enum TaskStatus {
        BUSY,
        STOP,
        STOPPING
    }

    private static native boolean ErrorCallback(int i);

    public enum Status {
        CRIFSWEBINSTALLER_STATUS_STOP(0),
        CRIFSWEBINSTALLER_STATUS_BUSY(1),
        CRIFSWEBINSTALLER_STATUS_COMPLETE(2),
        CRIFSWEBINSTALLER_STATUS_ERROR(3);

        private int value;

        Status(int i) {
            this.value = i;
        }

        public int getValue() {
            return this.value;
        }
    }

    public enum Error {
        CRIFSWEBINSTALLER_ERROR_NONE(0),
        CRIFSWEBINSTALLER_ERROR_TIMEOUT(1),
        CRIFSWEBINSTALLER_ERROR_MEMORY(2),
        CRIFSWEBINSTALLER_ERROR_LOCALFS(3),
        CRIFSWEBINSTALLER_ERROR_DNS(4),
        CRIFSWEBINSTALLER_ERROR_CONNECTION(5),
        CRIFSWEBINSTALLER_ERROR_SSL(6),
        CRIFSWEBINSTALLER_ERROR_HTTP(7),
        CRIFSWEBINSTALLER_ERROR_INTERNAL(8);

        private int value;

        Error(int i) {
            this.value = i;
        }

        public int getValue() {
            return this.value;
        }
    }

    public class StatusInfo {
        long contents_size;
        Error error;
        int http_status_code;
        long received_size;
        Status status;

        public StatusInfo() {
        }
    }

    public class AsyncTaskParam {
        long param_contents_size;
        String param_dst_path;
        long param_received_size;
        String param_src_path;

        AsyncTaskParam(String str, String str2, long j, long j2) {
            this.param_src_path = str;
            this.param_dst_path = str2;
            this.param_contents_size = j;
            this.param_received_size = j2;
        }
    }

    CriFsWebInstaller() {
        if (manager.crc_enabled) {
            this.crc_num = new CRC32();
        }
        ClearMember();
    }

    public class TaskStatusInfo {
        TaskStatus status = TaskStatus.BUSY;
        Error error = Error.CRIFSWEBINSTALLER_ERROR_NONE;
        int http_status_code = -1;
        long contents_size = -1;
        long received_size = 0;

        TaskStatusInfo() {
        }
    }

    private class WebInstallerTask extends AsyncTask<AsyncTaskParam, Void, Boolean> {
        private HttpURLConnection http_connection = null;
        private boolean is_ssl;
        private String task_dst_path;
        private TaskStatusInfo task_internal_info;
        private String task_src_path;
        private File tmp_file;

        WebInstallerTask() {
            this.task_internal_info = CriFsWebInstaller.this.new TaskStatusInfo();
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public Boolean doInBackground(AsyncTaskParam... asyncTaskParamArr) {
            this.task_src_path = asyncTaskParamArr[0].param_src_path;
            this.task_dst_path = asyncTaskParamArr[0].param_dst_path;
            synchronized (this) {
                this.task_internal_info.contents_size = asyncTaskParamArr[0].param_contents_size;
                this.task_internal_info.received_size = asyncTaskParamArr[0].param_received_size;
            }
            if (!task_setup()) {
                if (this.http_connection != null) {
                    this.http_connection.disconnect();
                }
                return false;
            }
            if (isCancelled()) {
                this.tmp_file.delete();
                this.http_connection.disconnect();
                return false;
            }
            if (!task_connect()) {
                this.http_connection.disconnect();
                return false;
            }
            if (!task_copyfile()) {
                return false;
            }
            synchronized (this) {
                this.task_internal_info.status = TaskStatus.STOP;
            }
            return true;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        public void onPostExecute(Boolean bool) {
            synchronized (this) {
                this.task_internal_info.status = TaskStatus.STOP;
            }
        }

        @Override // android.os.AsyncTask
        protected void onCancelled() {
            synchronized (this) {
                this.task_internal_info.status = TaskStatus.STOP;
            }
        }

        public void Cancel() {
            cancel(true);
            synchronized (this) {
                this.task_internal_info.status = TaskStatus.STOPPING;
            }
        }

        public synchronized TaskStatusInfo GetTaskStatusInfo() {
            return this.task_internal_info;
        }

        private synchronized void SetError(Error error, int i) {
            if (!(error == Error.CRIFSWEBINSTALLER_ERROR_CONNECTION || error == Error.CRIFSWEBINSTALLER_ERROR_DNS) && this.tmp_file.exists()) {
                this.tmp_file.delete();
            }
            this.task_internal_info.status = TaskStatus.STOP;
            this.task_internal_info.error = error;
            this.task_internal_info.http_status_code = i;
        }

        private boolean task_setup() {
            try {
                if (this.task_src_path.toLowerCase(Locale.ENGLISH).startsWith("https://")) {
                    this.is_ssl = true;
                } else if (this.task_src_path.toLowerCase(Locale.ENGLISH).startsWith("http://")) {
                    this.is_ssl = false;
                } else {
                    SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, this.task_internal_info.http_status_code);
                    CriFsWebInstaller.ErrorEntry(7);
                    return false;
                }
                URL url = new URL(this.task_src_path);
                this.tmp_file = new File(this.task_dst_path + ".tmp");
                SSLSocketFactory tLSSocketFactory = null;
                X509TrustManager[] x509TrustManagerArr = (CriFsWebInstaller.manager.allow_insecure_ssl && this.is_ssl) ? new X509TrustManager[]{new CriFsWebInstallerManager.LooseTrustManager()} : null;
                boolean z = Build.VERSION.SDK_INT >= 16 && Build.VERSION.SDK_INT < 21;
                if (z || x509TrustManagerArr != null) {
                    SSLContext sSLContext = SSLContext.getInstance("TLS");
                    sSLContext.init(null, x509TrustManagerArr, null);
                    tLSSocketFactory = z ? new TLSSocketFactory(sSLContext.getSocketFactory()) : sSLContext.getSocketFactory();
                }
                try {
                    if (CriFsWebInstaller.manager.proxy_host == null || CriFsWebInstaller.manager.proxy_port == 0) {
                        CriFsWebInstallerManager criFsWebInstallerManager = CriFsWebInstaller.manager;
                        String property = System.getProperty("http.proxyHost");
                        criFsWebInstallerManager.proxy_host = property;
                        if (property != null) {
                            String property2 = System.getProperty("http.proxyPort");
                            CriFsWebInstallerManager criFsWebInstallerManager2 = CriFsWebInstaller.manager;
                            if (property2 == null) {
                                property2 = "-1";
                            }
                            criFsWebInstallerManager2.proxy_port = Short.parseShort(property2);
                            this.http_connection = (HttpURLConnection) url.openConnection(new Proxy(Proxy.Type.HTTP, new InetSocketAddress(CriFsWebInstaller.manager.proxy_host, CriFsWebInstaller.manager.proxy_port)));
                        } else {
                            this.http_connection = (HttpURLConnection) url.openConnection();
                        }
                    } else {
                        this.http_connection = (HttpURLConnection) url.openConnection(new Proxy(Proxy.Type.HTTP, new InetSocketAddress(CriFsWebInstaller.manager.proxy_host, CriFsWebInstaller.manager.proxy_port)));
                    }
                    this.http_connection.setRequestMethod("GET");
                    this.http_connection.setInstanceFollowRedirects(false);
                    this.http_connection.setDoInput(true);
                    this.http_connection.setConnectTimeout(5000);
                    this.http_connection.setReadTimeout(5000);
                    this.http_connection.setRequestProperty("User-Agent", CriFsWebInstaller.manager.user_agent);
                    this.http_connection.setRequestProperty("Accept-Encoding", "identity");
                    for (int i = 0; i < CriFsWebInstaller.manager.request_headers.length(); i++) {
                        try {
                            this.http_connection.setRequestProperty(CriFsWebInstaller.manager.request_headers.getFieldName(i), CriFsWebInstaller.manager.request_headers.getValue(i));
                        } catch (IllegalArgumentException unused) {
                            SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, this.task_internal_info.http_status_code);
                            CriFsWebInstaller.ErrorEntry(12);
                            return false;
                        }
                    }
                    if (tLSSocketFactory != null) {
                        ((HttpsURLConnection) this.http_connection).setSSLSocketFactory(tLSSocketFactory);
                    }
                    if (this.task_internal_info.contents_size != -1) {
                        if (!this.tmp_file.exists()) {
                            CriFsWebInstaller.ErrorEntry(8);
                            SetError(Error.CRIFSWEBINSTALLER_ERROR_LOCALFS, this.task_internal_info.http_status_code);
                            return false;
                        }
                        if (this.tmp_file.length() != this.task_internal_info.received_size) {
                            CriFsWebInstaller.ErrorEntry(9);
                            SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, this.task_internal_info.http_status_code);
                            return false;
                        }
                        this.http_connection.setRequestProperty("Range", "bytes=" + this.tmp_file.length() + "-");
                    } else if (this.tmp_file.exists()) {
                        this.tmp_file.delete();
                    }
                    return true;
                } catch (IllegalArgumentException unused2) {
                    SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, this.task_internal_info.http_status_code);
                    CriFsWebInstaller.ErrorEntry(11);
                    return false;
                }
            } catch (IOException e) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, this.task_internal_info.http_status_code);
                CriFsWebInstaller.ErrorEntry(4);
                e.printStackTrace();
                return false;
            } catch (NullPointerException e2) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_MEMORY, this.task_internal_info.http_status_code);
                e2.printStackTrace();
                return false;
            } catch (MalformedURLException e3) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_DNS, this.task_internal_info.http_status_code);
                e3.printStackTrace();
                return false;
            } catch (ProtocolException e4) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, this.task_internal_info.http_status_code);
                e4.printStackTrace();
                return false;
            } catch (GeneralSecurityException e5) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_SSL, this.task_internal_info.http_status_code);
                e5.printStackTrace();
                return false;
            }
        }

        private boolean task_connect() {
            long contentLength;
            try {
                this.http_connection.connect();
                int responseCode = this.http_connection.getResponseCode();
                if (responseCode == 200) {
                    contentLength = this.http_connection.getContentLength();
                } else {
                    if (responseCode != 206) {
                        if (responseCode >= 0) {
                            SetError(Error.CRIFSWEBINSTALLER_ERROR_HTTP, responseCode);
                            return false;
                        }
                        SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                        return false;
                    }
                    contentLength = ((long) this.http_connection.getContentLength()) + this.task_internal_info.received_size;
                }
                synchronized (this) {
                    this.task_internal_info.http_status_code = responseCode;
                    this.task_internal_info.contents_size = contentLength;
                }
                return true;
            } catch (FileNotFoundException unused) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_HTTP, -1);
                return false;
            } catch (SocketException unused2) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                return false;
            } catch (SocketTimeoutException unused3) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                return false;
            } catch (UnknownHostException unused4) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                return false;
            } catch (SSLHandshakeException unused5) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                return false;
            } catch (SSLException unused6) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_SSL, -1);
                return false;
            } catch (IOException e) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                CriFsWebInstaller.ErrorEntry(5);
                e.printStackTrace();
                return false;
            }
        }

        private boolean task_copyfile() {
            try {
                try {
                    try {
                        try {
                            InputStream inputStream = this.http_connection.getInputStream();
                            FileOutputStream fileOutputStream = new FileOutputStream(this.tmp_file, true);
                            byte[] bArr = new byte[65536];
                            while (!isCancelled()) {
                                try {
                                    int i = inputStream.read(bArr);
                                    if (i == -1) {
                                        break;
                                    }
                                    if (i != 0) {
                                        if (CriFsWebInstaller.manager.crc_enabled) {
                                            try {
                                                CriFsWebInstaller.this.crc_num.update(bArr, 0, i);
                                            } catch (ArrayIndexOutOfBoundsException unused) {
                                                SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, -1);
                                                CriFsWebInstaller.ErrorEntry(13);
                                                break;
                                            }
                                        }
                                        try {
                                            fileOutputStream.write(bArr, 0, i);
                                            synchronized (this) {
                                                this.task_internal_info.received_size += (long) i;
                                            }
                                        } catch (IOException unused2) {
                                            SetError(Error.CRIFSWEBINSTALLER_ERROR_LOCALFS, -1);
                                            break;
                                        }
                                    } else {
                                        try {
                                            Thread.sleep(10L);
                                        } catch (InterruptedException unused3) {
                                        }
                                    }
                                } catch (IOException unused4) {
                                    SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                                    break;
                                }
                            }
                            try {
                                inputStream.close();
                            } catch (IOException unused5) {
                            }
                            try {
                                fileOutputStream.close();
                            } catch (IOException unused6) {
                            }
                            this.http_connection.disconnect();
                            if (this.task_internal_info.error != Error.CRIFSWEBINSTALLER_ERROR_NONE) {
                                if (this.task_internal_info.error == Error.CRIFSWEBINSTALLER_ERROR_LOCALFS) {
                                    this.tmp_file.delete();
                                }
                                this.http_connection.disconnect();
                                return false;
                            }
                            if (isCancelled()) {
                                this.tmp_file.delete();
                                this.http_connection.disconnect();
                                return false;
                            }
                            if (this.task_internal_info.received_size != this.task_internal_info.contents_size) {
                                this.tmp_file.delete();
                                SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, -1);
                                CriFsWebInstaller.ErrorEntry(14);
                                this.http_connection.disconnect();
                                return false;
                            }
                            File file = new File(this.task_dst_path);
                            if (!file.exists()) {
                                this.tmp_file.renameTo(file);
                                this.http_connection.disconnect();
                                return true;
                            }
                            this.tmp_file.delete();
                            SetError(Error.CRIFSWEBINSTALLER_ERROR_LOCALFS, -1);
                            this.http_connection.disconnect();
                            return false;
                        } catch (Throwable th) {
                            this.http_connection.disconnect();
                            throw th;
                        }
                    } catch (IOException e) {
                        SetError(Error.CRIFSWEBINSTALLER_ERROR_INTERNAL, -1);
                        CriFsWebInstaller.ErrorEntry(6);
                        e.printStackTrace();
                        this.http_connection.disconnect();
                        return false;
                    }
                } catch (FileNotFoundException unused7) {
                    SetError(Error.CRIFSWEBINSTALLER_ERROR_LOCALFS, -1);
                    this.http_connection.disconnect();
                    return false;
                }
            } catch (NullPointerException unused8) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_MEMORY, -1);
                this.http_connection.disconnect();
                return false;
            } catch (SocketTimeoutException unused9) {
                SetError(Error.CRIFSWEBINSTALLER_ERROR_CONNECTION, -1);
                this.http_connection.disconnect();
                return false;
            }
        }
    }

    public void Update() {
        TaskStatusInfo taskStatusInfoGetTaskStatusInfo;
        if (this.synced_statusinfo.status == Status.CRIFSWEBINSTALLER_STATUS_BUSY && this.can_access_asynctask && (taskStatusInfoGetTaskStatusInfo = this.task.GetTaskStatusInfo()) != null) {
            switch (taskStatusInfoGetTaskStatusInfo.status) {
                case BUSY:
                    if (this.is_stop_required) {
                        this.task.Cancel();
                    } else {
                        this.synced_statusinfo.contents_size = taskStatusInfoGetTaskStatusInfo.contents_size;
                        if (taskStatusInfoGetTaskStatusInfo.received_size > this.synced_statusinfo.received_size) {
                            this.synced_statusinfo.received_size = taskStatusInfoGetTaskStatusInfo.received_size;
                            this.timeout_start_time = GetNow() / 1000;
                        } else if (this.timeout_start_time + ((long) manager.inactive_timeout_sec) < GetNow() / 1000) {
                            this.is_timeouted = true;
                            this.task.cancel(true);
                        }
                    }
                    break;
                case STOP:
                    if (this.is_stop_required) {
                        new File(this.task_params.param_dst_path + ".tmp").delete();
                        ClearMember();
                    } else if (this.is_timeouted) {
                        this.synced_statusinfo.contents_size = taskStatusInfoGetTaskStatusInfo.contents_size;
                        this.synced_statusinfo.received_size = taskStatusInfoGetTaskStatusInfo.received_size;
                        this.synced_statusinfo.status = Status.CRIFSWEBINSTALLER_STATUS_ERROR;
                        this.synced_statusinfo.error = Error.CRIFSWEBINSTALLER_ERROR_TIMEOUT;
                    } else {
                        this.synced_statusinfo.contents_size = taskStatusInfoGetTaskStatusInfo.contents_size;
                        this.synced_statusinfo.received_size = taskStatusInfoGetTaskStatusInfo.received_size;
                        if (this.timeout_start_time + ((long) manager.inactive_timeout_sec) < GetNow() / 1000) {
                            this.is_timeouted = true;
                        }
                        if (taskStatusInfoGetTaskStatusInfo.error == Error.CRIFSWEBINSTALLER_ERROR_NONE) {
                            this.synced_statusinfo.status = Status.CRIFSWEBINSTALLER_STATUS_COMPLETE;
                            this.synced_statusinfo.http_status_code = taskStatusInfoGetTaskStatusInfo.http_status_code;
                        } else if (IsRetryable(taskStatusInfoGetTaskStatusInfo.error, this.synced_statusinfo.contents_size)) {
                            if (!this.is_waiting_to_start) {
                                this.is_waiting_to_start = true;
                                this.start_time = GetNow();
                            } else if (GetNow() - this.start_time >= 5000) {
                                this.is_waiting_to_start = false;
                                this.task_params.param_contents_size = this.synced_statusinfo.contents_size;
                                this.task_params.param_received_size = this.synced_statusinfo.received_size;
                                this.can_access_asynctask = false;
                                StartTask(this.task_params);
                            }
                        } else {
                            this.synced_statusinfo.status = Status.CRIFSWEBINSTALLER_STATUS_ERROR;
                            this.synced_statusinfo.error = taskStatusInfoGetTaskStatusInfo.error;
                            this.synced_statusinfo.http_status_code = taskStatusInfoGetTaskStatusInfo.http_status_code;
                        }
                    }
                    break;
                case STOPPING:
                    this.synced_statusinfo.contents_size = taskStatusInfoGetTaskStatusInfo.contents_size;
                    this.synced_statusinfo.received_size = taskStatusInfoGetTaskStatusInfo.received_size;
                    break;
            }
        }
    }

    private long GetNow() {
        return new Date().getTime();
    }

    private static boolean IsRetryable(Error error, long j) {
        return (error == Error.CRIFSWEBINSTALLER_ERROR_CONNECTION || error == Error.CRIFSWEBINSTALLER_ERROR_DNS) && ((j > (-1L) ? 1 : (j == (-1L) ? 0 : -1)) != 0);
    }

    private void ClearMember() {
        this.synced_statusinfo.status = Status.CRIFSWEBINSTALLER_STATUS_STOP;
        this.synced_statusinfo.error = Error.CRIFSWEBINSTALLER_ERROR_NONE;
        this.synced_statusinfo.http_status_code = -1;
        this.synced_statusinfo.contents_size = -1L;
        this.synced_statusinfo.received_size = 0L;
        this.start_time = 0L;
        this.timeout_start_time = 0L;
        this.is_waiting_to_start = false;
        this.is_timeouted = false;
        this.can_access_asynctask = false;
        if (!manager.crc_enabled || this.crc_num == null) {
            return;
        }
        this.crc_num.reset();
    }

    private void StartTask(final AsyncTaskParam asyncTaskParam) {
        try {
            if (Build.VERSION.SDK_INT < 11) {
                new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: com.criware.filesystem.CriFsWebInstaller.1
                    @Override // java.lang.Runnable
                    public void run() {
                        CriFsWebInstaller.this.task = CriFsWebInstaller.this.new WebInstallerTask();
                        CriFsWebInstaller.this.task.execute(asyncTaskParam);
                        CriFsWebInstaller.this.can_access_asynctask = true;
                    }
                });
                return;
            }
            if (Build.VERSION.SDK_INT >= 11 && Build.VERSION.SDK_INT < 16) {
                new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: com.criware.filesystem.CriFsWebInstaller.2
                    @Override // java.lang.Runnable
                    public void run() {
                        CriFsWebInstaller.this.task = CriFsWebInstaller.this.new WebInstallerTask();
                        CriFsWebInstaller.this.task.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, asyncTaskParam);
                        CriFsWebInstaller.this.can_access_asynctask = true;
                    }
                });
                return;
            }
            this.task = new WebInstallerTask();
            this.task.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, asyncTaskParam);
            this.can_access_asynctask = true;
        } catch (NullPointerException unused) {
            ErrorEntry(10);
            this.synced_statusinfo.status = Status.CRIFSWEBINSTALLER_STATUS_ERROR;
            this.synced_statusinfo.error = Error.CRIFSWEBINSTALLER_ERROR_MEMORY;
        }
    }

    public static void Initialize(Config config) {
        if (manager == null) {
            manager = new CriFsWebInstallerManager();
            manager.Manager_Initialize(config);
        } else {
            ErrorEntry(1);
        }
    }

    public static void Finalize() {
        if (manager != null) {
            manager.Manager_Finalize();
            manager = null;
        } else {
            ErrorEntry(1);
        }
    }

    public static void SetRequestHeader(String str, String str2) {
        if (manager != null) {
            manager.request_headers.set(str, str2);
        }
    }

    public static void ExecuteMain() {
        if (manager != null) {
            manager.ExecuteMain();
        }
    }

    public static CriFsWebInstaller Create() {
        if (manager != null) {
            return manager.CreateInstaller();
        }
        ErrorEntry(1);
        return null;
    }

    public void Destroy() {
        if (this.synced_statusinfo.status != Status.CRIFSWEBINSTALLER_STATUS_STOP) {
            ErrorEntry(2);
        } else if (manager.installer_list.remove(this)) {
            manager.num_installers--;
        }
    }

    public void Copy(String str, String str2) {
        if (this.synced_statusinfo.status != Status.CRIFSWEBINSTALLER_STATUS_STOP) {
            ErrorEntry(2);
            return;
        }
        ClearMember();
        this.is_stop_required = false;
        this.synced_statusinfo.status = Status.CRIFSWEBINSTALLER_STATUS_BUSY;
        this.task_params = new AsyncTaskParam(str, str2, this.synced_statusinfo.contents_size, this.synced_statusinfo.received_size);
        this.timeout_start_time = GetNow() / 1000;
        StartTask(this.task_params);
    }

    public void Stop() {
        switch (this.synced_statusinfo.status) {
            case CRIFSWEBINSTALLER_STATUS_BUSY:
                this.is_stop_required = true;
                break;
            case CRIFSWEBINSTALLER_STATUS_COMPLETE:
            case CRIFSWEBINSTALLER_STATUS_ERROR:
                ClearMember();
                break;
        }
    }

    public int GetStatusInfo_status() {
        return this.synced_statusinfo.status.getValue();
    }

    public int GetStatusInfo_error() {
        return this.synced_statusinfo.error.getValue();
    }

    public int GetStatusInfo_http_status_code() {
        return this.synced_statusinfo.http_status_code;
    }

    public long GetStatusInfo_contents_size() {
        return this.synced_statusinfo.contents_size;
    }

    public long GetStatusInfo_received_size() {
        return this.synced_statusinfo.received_size;
    }

    public int IsCRCEnabled() {
        return manager.crc_enabled ? 1 : 0;
    }

    public long GetCRC32() {
        return this.crc_num.getValue();
    }

    public static boolean ErrorEntry(int i) {
        return ErrorCallback(i);
    }
}
