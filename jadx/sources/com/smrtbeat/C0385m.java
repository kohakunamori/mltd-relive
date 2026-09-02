package com.smrtbeat;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/* JADX INFO: renamed from: com.smrtbeat.m */
/* JADX INFO: loaded from: classes.dex */
class C0385m {
    C0385m() {
    }

    /* JADX INFO: renamed from: a */
    private static String m275a(int i) {
        String str;
        StringBuilder sb = new StringBuilder();
        sb.append("Failed");
        if (i != 1) {
            str = i != 2 ? ": NOT_DEFINED_OPEMODE" : " to decrypt";
        } else {
            str = " to encrypt";
        }
        sb.append(str);
        return sb.toString();
    }

    /* JADX INFO: renamed from: a */
    private static void m276a(Exception exc, int i) {
        C0377f0.m159a(C0377f0.e.ERROR, m275a(i));
    }

    /* JADX INFO: renamed from: a */
    private static byte[] m277a() {
        return ("ginga no ysakata").getBytes();
    }

    /* JADX INFO: renamed from: a */
    private static byte[] m278a(int i, byte[] bArr) {
        SecretKeySpec secretKeySpec = new SecretKeySpec(m280b(), "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(m277a());
        try {
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(i, secretKeySpec, ivParameterSpec);
            return cipher.doFinal(bArr);
        } catch (InvalidAlgorithmParameterException | InvalidKeyException | NoSuchAlgorithmException | BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException e) {
            m276a(e, i);
            return null;
        }
    }

    /* JADX INFO: renamed from: a */
    static byte[] m279a(byte[] bArr) {
        return m278a(2, bArr);
    }

    /* JADX INFO: renamed from: b */
    private static byte[] m280b() {
        return ("nayamagu megane!nayamagu megane!").getBytes();
    }

    /* JADX INFO: renamed from: b */
    static byte[] m281b(byte[] bArr) {
        return m278a(1, bArr);
    }
}
