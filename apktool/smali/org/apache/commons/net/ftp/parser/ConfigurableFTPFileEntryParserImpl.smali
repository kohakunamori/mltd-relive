.class public abstract Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;
.super Lorg/apache/commons/net/ftp/parser/RegexFTPFileEntryParserImpl;
.source "ConfigurableFTPFileEntryParserImpl.java"

# interfaces
.implements Lorg/apache/commons/net/ftp/Configurable;


# instance fields
.field private final timestampParser:Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    .line 59
    invoke-direct {p0, p1}, Lorg/apache/commons/net/ftp/parser/RegexFTPFileEntryParserImpl;-><init>(Ljava/lang/String;)V

    .line 60
    new-instance p1, Lorg/apache/commons/net/ftp/parser/FTPTimestampParserImpl;

    invoke-direct {p1}, Lorg/apache/commons/net/ftp/parser/FTPTimestampParserImpl;-><init>()V

    iput-object p1, p0, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->timestampParser:Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;

    return-void
.end method


# virtual methods
.method public configure(Lorg/apache/commons/net/ftp/FTPClientConfig;)V
    .locals 2

    .line 93
    iget-object v0, p0, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->timestampParser:Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;

    instance-of v0, v0, Lorg/apache/commons/net/ftp/Configurable;

    if-eqz v0, :cond_3

    .line 94
    invoke-virtual {p0}, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->getDefaultConfiguration()Lorg/apache/commons/net/ftp/FTPClientConfig;

    move-result-object v0

    if-eqz p1, :cond_2

    .line 96
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPClientConfig;->getDefaultDateFormatStr()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    .line 97
    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPClientConfig;->getDefaultDateFormatStr()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Lorg/apache/commons/net/ftp/FTPClientConfig;->setDefaultDateFormatStr(Ljava/lang/String;)V

    .line 99
    :cond_0
    invoke-virtual {p1}, Lorg/apache/commons/net/ftp/FTPClientConfig;->getRecentDateFormatStr()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    .line 100
    invoke-virtual {v0}, Lorg/apache/commons/net/ftp/FTPClientConfig;->getRecentDateFormatStr()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lorg/apache/commons/net/ftp/FTPClientConfig;->setRecentDateFormatStr(Ljava/lang/String;)V

    .line 102
    :cond_1
    iget-object v0, p0, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->timestampParser:Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;

    check-cast v0, Lorg/apache/commons/net/ftp/Configurable;

    invoke-interface {v0, p1}, Lorg/apache/commons/net/ftp/Configurable;->configure(Lorg/apache/commons/net/ftp/FTPClientConfig;)V

    goto :goto_0

    .line 104
    :cond_2
    iget-object p1, p0, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->timestampParser:Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;

    check-cast p1, Lorg/apache/commons/net/ftp/Configurable;

    invoke-interface {p1, v0}, Lorg/apache/commons/net/ftp/Configurable;->configure(Lorg/apache/commons/net/ftp/FTPClientConfig;)V

    :cond_3
    :goto_0
    return-void
.end method

.method protected abstract getDefaultConfiguration()Lorg/apache/commons/net/ftp/FTPClientConfig;
.end method

.method public parseTimestamp(Ljava/lang/String;)Ljava/util/Calendar;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/text/ParseException;
        }
    .end annotation

    .line 74
    iget-object v0, p0, Lorg/apache/commons/net/ftp/parser/ConfigurableFTPFileEntryParserImpl;->timestampParser:Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;

    invoke-interface {v0, p1}, Lorg/apache/commons/net/ftp/parser/FTPTimestampParser;->parseTimestamp(Ljava/lang/String;)Ljava/util/Calendar;

    move-result-object p1

    return-object p1
.end method
