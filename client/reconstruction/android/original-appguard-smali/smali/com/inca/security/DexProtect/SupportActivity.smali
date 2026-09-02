.class public Lcom/inca/security/DexProtect/SupportActivity;
.super Landroid/app/Activity;
.source "SupportActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 16
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 18
    new-instance p1, Landroid/app/AlertDialog$Builder;

    invoke-direct {p1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    .line 19
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    .line 25
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x18

    if-ge v1, v2, :cond_0

    .line 26
    invoke-virtual {p0}, Lcom/inca/security/DexProtect/SupportActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 28
    :cond_0
    invoke-virtual {p0}, Lcom/inca/security/DexProtect/SupportActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    .line 31
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 32
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    :cond_1
    const-string v1, "KR"

    .line 35
    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v1

    const-string v2, "AppGuard RunTime \u517c\u5bb9\u6027"

    if-nez v1, :cond_2

    const-string v2, "\uc571\uac00\ub4dc \ub7f0\ud0c0\uc784 \ud638\ud658\uc131"

    const-string v0, "\uc2e4\ud589\uc744 \uc704\ud574\uc11c\ub294 Dalvik \ub7f0\ud0c0\uc784\uc73c\ub85c\uc758 \ubcc0\uacbd\uc774 \ud544\uc694\ud569\ub2c8\ub2e4."

    goto :goto_1

    :cond_2
    const-string v1, "CN"

    .line 38
    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_3

    const-string v0, "\u4e3a\u6267\u884c\u9700\u8981\u53d8\u66f4\u5230Dalvik Runtime\u3002"

    goto :goto_1

    :cond_3
    const-string v1, "TW"

    .line 41
    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_4

    const-string v0, "\u70ba\u57f7\u884c\u9700\u8981\u8b8a\u66f4\u5230 Dalvik Runtime\u3002"

    goto :goto_1

    :cond_4
    const-string v1, "JP"

    .line 44
    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_5

    const-string v2, "GameGuard for Mobile\u306e\u30e9\u30f3\u30bf\u30a4\u30e0\u3068\u306e\u4e92\u63db\u6027"

    const-string v0, "\u5b9f\u884c\u3059\u308b\u305f\u3081\u306b\u306fDalvik\u30e9\u30f3\u30bf\u30a4\u30e0\u3078\u306e\u5909\u66f4\u304c\u5fc5\u8981\u3068\u306a\u308a\u307e\u3059\u3002"

    goto :goto_1

    :cond_5
    const-string v2, "AppGuard Runtime Compatibility"

    const-string v0, "A change to the Dalvik runtime is required for execution."

    .line 49
    :goto_1
    invoke-virtual {p1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 50
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 52
    new-instance v0, Lcom/inca/security/DexProtect/SupportActivity$1;

    invoke-direct {v0, p0}, Lcom/inca/security/DexProtect/SupportActivity$1;-><init>(Lcom/inca/security/DexProtect/SupportActivity;)V

    const-string v1, "OK"

    invoke-virtual {p1, v1, v0}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 69
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object p1

    .line 70
    invoke-virtual {p1}, Landroid/app/AlertDialog;->show()V

    return-void
.end method
