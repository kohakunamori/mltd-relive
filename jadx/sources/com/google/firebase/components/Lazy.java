package com.google.firebase.components;

import androidx.annotation.RestrictTo;
import androidx.annotation.VisibleForTesting;
import com.google.firebase.inject.Provider;

/* JADX INFO: compiled from: com.google.firebase:firebase-common@@17.1.0 */
/* JADX INFO: loaded from: classes.dex */
@RestrictTo({RestrictTo.Scope.LIBRARY})
public class Lazy<T> implements Provider<T> {
    private static final Object UNINITIALIZED = new Object();
    private volatile Object instance;
    private volatile Provider<T> provider;

    Lazy(T t) {
        this.instance = UNINITIALIZED;
        this.instance = t;
    }

    public Lazy(Provider<T> provider) {
        this.instance = UNINITIALIZED;
        this.provider = provider;
    }

    @Override // com.google.firebase.inject.Provider
    public T get() {
        T t = (T) this.instance;
        if (t == UNINITIALIZED) {
            synchronized (this) {
                t = (T) this.instance;
                if (t == UNINITIALIZED) {
                    t = this.provider.get();
                    this.instance = t;
                    this.provider = null;
                }
            }
        }
        return t;
    }

    @VisibleForTesting
    boolean isInitialized() {
        return this.instance != UNINITIALIZED;
    }
}
