package com.google.games.bridge;

import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;

/* JADX INFO: loaded from: classes.dex */
public class TokenResult implements Result {
    private String authCode;
    private String email;
    private String idToken;
    private Status status;

    public TokenResult() {
    }

    TokenResult(String str, String str2, String str3, int i) {
        this.status = new Status(i);
        this.authCode = str;
        this.idToken = str3;
        this.email = str2;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Status: ");
        sb.append(this.status);
        sb.append(" email: ");
        sb.append(this.email == null ? "<null>" : this.email);
        sb.append(" id:");
        sb.append(this.idToken == null ? "<null>" : this.idToken);
        sb.append(" access: ");
        sb.append(this.authCode == null ? "<null>" : this.authCode);
        return sb.toString();
    }

    @Override // com.google.android.gms.common.api.Result
    public Status getStatus() {
        return this.status;
    }

    public int getStatusCode() {
        return this.status.getStatusCode();
    }

    public String getAuthCode() {
        return this.authCode == null ? "" : this.authCode;
    }

    public String getIdToken() {
        return this.idToken == null ? "" : this.idToken;
    }

    public String getEmail() {
        return this.email == null ? "" : this.email;
    }

    public void setStatus(int i) {
        this.status = new Status(i);
    }

    public void setEmail(String str) {
        this.email = str;
    }

    public void setAuthCode(String str) {
        this.authCode = str;
    }

    public void setIdToken(String str) {
        this.idToken = str;
    }
}
