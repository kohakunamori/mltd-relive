package com.unity.purchasing.common;

/* JADX INFO: loaded from: classes.dex */
public class ProductDefinition {

    /* JADX INFO: renamed from: id */
    public String f445id;
    public String storeSpecificId;
    public ProductType type;

    public ProductDefinition(String str, String str2, ProductType productType) {
        this.f445id = str;
        this.storeSpecificId = str2;
        this.type = productType;
    }

    public ProductDefinition(String str, ProductType productType) {
        this(str, str, productType);
    }
}
