.class public final Lextern/okhttp3/ConnectionSpec$Builder;
.super Ljava/lang/Object;
.source "ConnectionSpec.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lextern/okhttp3/ConnectionSpec;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field cipherSuites:[Ljava/lang/String;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field supportsTlsExtensions:Z

.field tls:Z

.field tlsVersions:[Ljava/lang/String;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lextern/okhttp3/ConnectionSpec;)V
    .locals 1

    .line 265
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 266
    iget-boolean v0, p1, Lextern/okhttp3/ConnectionSpec;->tls:Z

    iput-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    .line 267
    iget-object v0, p1, Lextern/okhttp3/ConnectionSpec;->cipherSuites:[Ljava/lang/String;

    iput-object v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->cipherSuites:[Ljava/lang/String;

    .line 268
    iget-object v0, p1, Lextern/okhttp3/ConnectionSpec;->tlsVersions:[Ljava/lang/String;

    iput-object v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tlsVersions:[Ljava/lang/String;

    .line 269
    iget-boolean p1, p1, Lextern/okhttp3/ConnectionSpec;->supportsTlsExtensions:Z

    iput-boolean p1, p0, Lextern/okhttp3/ConnectionSpec$Builder;->supportsTlsExtensions:Z

    return-void
.end method

.method constructor <init>(Z)V
    .locals 0

    .line 261
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 262
    iput-boolean p1, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    return-void
.end method


# virtual methods
.method public allEnabledCipherSuites()Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 2

    .line 273
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 274
    iput-object v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->cipherSuites:[Ljava/lang/String;

    return-object p0

    .line 273
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "no cipher suites for cleartext connections"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public allEnabledTlsVersions()Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 2

    .line 300
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 301
    iput-object v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tlsVersions:[Ljava/lang/String;

    return-object p0

    .line 300
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "no TLS versions for cleartext connections"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public build()Lextern/okhttp3/ConnectionSpec;
    .locals 1

    .line 334
    new-instance v0, Lextern/okhttp3/ConnectionSpec;

    invoke-direct {v0, p0}, Lextern/okhttp3/ConnectionSpec;-><init>(Lextern/okhttp3/ConnectionSpec$Builder;)V

    return-object v0
.end method

.method public varargs cipherSuites([Lextern/okhttp3/CipherSuite;)Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 3

    .line 279
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_1

    .line 281
    array-length v0, p1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    .line 282
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_0

    .line 283
    aget-object v2, p1, v1

    iget-object v2, v2, Lextern/okhttp3/CipherSuite;->javaName:Ljava/lang/String;

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 285
    :cond_0
    invoke-virtual {p0, v0}, Lextern/okhttp3/ConnectionSpec$Builder;->cipherSuites([Ljava/lang/String;)Lextern/okhttp3/ConnectionSpec$Builder;

    move-result-object p1

    return-object p1

    .line 279
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "no cipher suites for cleartext connections"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw p1

    :goto_2
    goto :goto_1
.end method

.method public varargs cipherSuites([Ljava/lang/String;)Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 1

    .line 289
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_1

    .line 291
    array-length v0, p1

    if-eqz v0, :cond_0

    .line 295
    invoke-virtual {p1}, [Ljava/lang/String;->clone()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    iput-object p1, p0, Lextern/okhttp3/ConnectionSpec$Builder;->cipherSuites:[Ljava/lang/String;

    return-object p0

    .line 292
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "At least one cipher suite is required"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 289
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "no cipher suites for cleartext connections"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public supportsTlsExtensions(Z)Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 1

    .line 328
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_0

    .line 329
    iput-boolean p1, p0, Lextern/okhttp3/ConnectionSpec$Builder;->supportsTlsExtensions:Z

    return-object p0

    .line 328
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "no TLS extensions for cleartext connections"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public varargs tlsVersions([Lextern/okhttp3/TlsVersion;)Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 3

    .line 306
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_1

    .line 308
    array-length v0, p1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    .line 309
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_0

    .line 310
    aget-object v2, p1, v1

    iget-object v2, v2, Lextern/okhttp3/TlsVersion;->javaName:Ljava/lang/String;

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 313
    :cond_0
    invoke-virtual {p0, v0}, Lextern/okhttp3/ConnectionSpec$Builder;->tlsVersions([Ljava/lang/String;)Lextern/okhttp3/ConnectionSpec$Builder;

    move-result-object p1

    return-object p1

    .line 306
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "no TLS versions for cleartext connections"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw p1

    :goto_2
    goto :goto_1
.end method

.method public varargs tlsVersions([Ljava/lang/String;)Lextern/okhttp3/ConnectionSpec$Builder;
    .locals 1

    .line 317
    iget-boolean v0, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tls:Z

    if-eqz v0, :cond_1

    .line 319
    array-length v0, p1

    if-eqz v0, :cond_0

    .line 323
    invoke-virtual {p1}, [Ljava/lang/String;->clone()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    iput-object p1, p0, Lextern/okhttp3/ConnectionSpec$Builder;->tlsVersions:[Ljava/lang/String;

    return-object p0

    .line 320
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "At least one TLS version is required"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 317
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "no TLS versions for cleartext connections"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
