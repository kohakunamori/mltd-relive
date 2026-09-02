package com.smrtbeat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.TimeZone;
import org.apache.commons.net.ftp.FTPReply;

/* JADX INFO: renamed from: com.smrtbeat.q */
/* JADX INFO: loaded from: classes.dex */
class C0389q {

    /* JADX INFO: renamed from: d */
    private static final String f389d = "yyyy-MM-dd HH:mm:ss.SSS Z";

    /* JADX INFO: renamed from: e */
    private static C0389q f390e = new C0389q();

    /* JADX INFO: renamed from: a */
    private List<a> f391a = new ArrayList();

    /* JADX INFO: renamed from: b */
    private int f392b = 0;

    /* JADX INFO: renamed from: c */
    private SimpleDateFormat f393c;

    /* JADX INFO: renamed from: com.smrtbeat.q$a */
    private static class a {

        /* JADX INFO: renamed from: a */
        final String f394a;

        /* JADX INFO: renamed from: b */
        final int f395b;

        a(String str) {
            this.f394a = str + "\n";
            this.f395b = str.getBytes().length;
        }
    }

    private C0389q() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(f389d);
        this.f393c = simpleDateFormat;
        simpleDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
    }

    /* JADX INFO: renamed from: a */
    static C0389q m312a() {
        return f390e;
    }

    /* JADX INFO: renamed from: a */
    private void m313a(int i, int i2) {
        int size = this.f391a.size();
        int i3 = 0;
        while (true) {
            if (size <= i && this.f392b <= i2) {
                break;
            }
            if (size <= 0) {
                C0377f0.m159a(C0377f0.e.WARN, "Count or size of log data is strange.");
                break;
            }
            this.f392b -= this.f391a.get(i3).f395b;
            size--;
            i3++;
        }
        if (this.f391a.size() > size) {
            List<a> list = this.f391a;
            list.subList(0, list.size() - size).clear();
        }
    }

    /* JADX INFO: renamed from: a */
    void m314a(String str) {
        synchronized (this) {
            a aVar = new a(this.f393c.format(new Date()) + ": " + str);
            this.f391a.add(aVar);
            this.f392b = this.f392b + aVar.f395b;
            m313a(FTPReply.UNRECOGNIZED_COMMAND, 65536);
        }
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        synchronized (this) {
            Iterator<a> it = this.f391a.iterator();
            while (it.hasNext()) {
                sb.append(it.next().f394a);
            }
        }
        return sb.toString();
    }
}
