package com.smrtbeat;

import java.util.ArrayList;
import java.util.Collection;

/* JADX INFO: loaded from: classes.dex */
public class SmartBeatConfig {

    /* JADX INFO: renamed from: a */
    private String f32a;

    /* JADX INFO: renamed from: b */
    private boolean f33b = true;

    /* JADX INFO: renamed from: c */
    private boolean f34c = true;

    /* JADX INFO: renamed from: d */
    private boolean f35d = false;

    /* JADX INFO: renamed from: e */
    private Collection<Integer> f36e = new ArrayList();

    /* JADX INFO: renamed from: a */
    String m53a() {
        return this.f32a;
    }

    public SmartBeatConfig addIgnoredSignal(int i) {
        this.f36e.add(Integer.valueOf(i));
        return this;
    }

    public SmartBeatConfig addIgnoredSignals(Collection<Integer> collection) {
        this.f36e.addAll(collection);
        return this;
    }

    /* JADX INFO: renamed from: b */
    boolean m54b() {
        return this.f33b;
    }

    /* JADX INFO: renamed from: c */
    Collection<Integer> m55c() {
        return this.f36e;
    }

    public boolean getAutoBreadcrumb() {
        return this.f34c;
    }

    public boolean getCallOtherSignalHandlers() {
        return this.f35d;
    }

    public SmartBeatConfig setApiKey(String str) {
        this.f32a = str;
        return this;
    }

    public SmartBeatConfig setAutoBreadcrumb(boolean z) {
        this.f34c = z;
        return this;
    }

    public SmartBeatConfig setCallOtherSignalHandlers(boolean z) {
        this.f35d = z;
        return this;
    }

    public SmartBeatConfig setEnabled(boolean z) {
        this.f33b = z;
        return this;
    }
}
