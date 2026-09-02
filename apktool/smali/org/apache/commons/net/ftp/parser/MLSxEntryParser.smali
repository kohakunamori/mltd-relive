.class public Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;
.super Lorg/apache/commons/net/ftp/FTPFileEntryParserImpl;
.source "MLSxEntryParser.java"


# static fields
.field private static final PARSER:Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;

.field private static final TYPE_TO_INT:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static UNIX_GROUPS:[I

.field private static UNIX_PERMS:[[I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 58
    new-instance v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;

    invoke-direct {v0}, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;-><init>()V

    sput-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->PARSER:Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;

    .line 60
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->TYPE_TO_INT:Ljava/util/HashMap;

    .line 62
    sget-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->TYPE_TO_INT:Ljava/util/HashMap;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "file"

    invoke-virtual {v0, v3, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    sget-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->TYPE_TO_INT:Ljava/util/HashMap;

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "cdir"

    invoke-virtual {v0, v4, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    sget-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->TYPE_TO_INT:Ljava/util/HashMap;

    const-string v4, "pdir"

    invoke-virtual {v0, v4, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    sget-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->TYPE_TO_INT:Ljava/util/HashMap;

    const-string v4, "dir"

    invoke-virtual {v0, v4, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v0, 0x3

    .line 68
    new-array v3, v0, [I

    fill-array-data v3, :array_0

    sput-object v3, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->UNIX_GROUPS:[I

    const/16 v3, 0x8

    .line 74
    new-array v3, v3, [[I

    new-array v4, v1, [I

    aput-object v4, v3, v1

    new-array v4, v2, [I

    const/4 v5, 0x2

    aput v5, v4, v1

    aput-object v4, v3, v2

    new-array v4, v2, [I

    aput v2, v4, v1

    aput-object v4, v3, v5

    new-array v4, v5, [I

    fill-array-data v4, :array_1

    aput-object v4, v3, v0

    new-array v2, v2, [I

    aput v1, v2, v1

    const/4 v1, 0x4

    aput-object v2, v3, v1

    new-array v1, v5, [I

    fill-array-data v1, :array_2

    const/4 v2, 0x5

    aput-object v1, v3, v2

    new-array v1, v5, [I

    fill-array-data v1, :array_3

    const/4 v2, 0x6

    aput-object v1, v3, v2

    new-array v0, v0, [I

    fill-array-data v0, :array_4

    const/4 v1, 0x7

    aput-object v0, v3, v1

    sput-object v3, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->UNIX_PERMS:[[I

    return-void

    :array_0
    .array-data 4
        0x0
        0x1
        0x2
    .end array-data

    :array_1
    .array-data 4
        0x2
        0x1
    .end array-data

    :array_2
    .array-data 4
        0x0
        0x2
    .end array-data

    :array_3
    .array-data 4
        0x0
        0x1
    .end array-data

    :array_4
    .array-data 4
        0x0
        0x1
        0x2
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .line 91
    invoke-direct {p0}, Lorg/apache/commons/net/ftp/FTPFileEntryParserImpl;-><init>()V

    return-void
.end method

.method private doUnixPerms(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)V
    .locals 6

    .line 179
    invoke-virtual {p2}, Ljava/lang/String;->toCharArray()[C

    move-result-object p2

    array-length v0, p2

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_6

    aget-char v3, p2, v2

    const/16 v4, 0x61

    const/4 v5, 0x1

    if-eq v3, v4, :cond_5

    const/16 v4, 0x70

    if-eq v3, v4, :cond_4

    const/16 v4, 0x72

    if-eq v3, v4, :cond_3

    const/16 v4, 0x77

    if-eq v3, v4, :cond_2

    const/16 v4, 0x6c

    if-eq v3, v4, :cond_1

    const/16 v4, 0x6d

    if-eq v3, v4, :cond_0

    packed-switch v3, :pswitch_data_0

    goto :goto_1

    .line 192
    :pswitch_0
    invoke-virtual {p1, v1, v1, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 189
    :pswitch_1
    invoke-virtual {p1, v1, v5, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 186
    :pswitch_2
    invoke-virtual {p1, v1, v5, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 201
    :cond_0
    invoke-virtual {p1, v1, v5, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    :cond_1
    const/4 v3, 0x2

    .line 198
    invoke-virtual {p1, v1, v3, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 210
    :cond_2
    invoke-virtual {p1, v1, v5, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 207
    :cond_3
    invoke-virtual {p1, v1, v1, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 204
    :cond_4
    invoke-virtual {p1, v1, v5, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    goto :goto_1

    .line 183
    :cond_5
    invoke-virtual {p1, v1, v5, v5}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    :goto_1
    :pswitch_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_6
    return-void

    :pswitch_data_0
    .packed-switch 0x63
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method public static getInstance()Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;
    .locals 1

    .line 224
    sget-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->PARSER:Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;

    return-object v0
.end method

.method public static parseEntry(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;
    .locals 1

    .line 220
    sget-object v0, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->PARSER:Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;

    invoke-virtual {v0, p0}, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->parseFTPEntry(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public parseFTPEntry(Ljava/lang/String;)Lorg/apache/commons/net/ftp/FTPFile;
    .locals 17

    move-object/from16 v0, p1

    const/4 v1, 0x2

    const-string v2, " "

    .line 96
    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v2

    .line 97
    array-length v3, v2

    if-eq v3, v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 100
    :cond_0
    new-instance v3, Lorg/apache/commons/net/ftp/FTPFile;

    invoke-direct {v3}, Lorg/apache/commons/net/ftp/FTPFile;-><init>()V

    .line 101
    invoke-virtual {v3, v0}, Lorg/apache/commons/net/ftp/FTPFile;->setRawListing(Ljava/lang/String;)V

    const/4 v0, 0x1

    .line 102
    aget-object v4, v2, v0

    invoke-virtual {v3, v4}, Lorg/apache/commons/net/ftp/FTPFile;->setName(Ljava/lang/String;)V

    const/4 v4, 0x0

    .line 103
    aget-object v5, v2, v4

    const-string v6, ";"

    invoke-virtual {v5, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 104
    aget-object v2, v2, v4

    sget-object v6, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v2, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    const-string v6, "unix.mode="

    invoke-virtual {v2, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    .line 105
    array-length v6, v5

    const/4 v7, 0x0

    :goto_0
    if-ge v7, v6, :cond_d

    aget-object v8, v5, v7

    const-string v9, "="

    .line 106
    invoke-virtual {v8, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v8

    .line 110
    array-length v9, v8

    if-eq v9, v1, :cond_2

    :cond_1
    :goto_1
    move-object/from16 v1, p0

    goto/16 :goto_5

    .line 113
    :cond_2
    aget-object v9, v8, v4

    sget-object v10, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v9, v10}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    .line 114
    aget-object v8, v8, v0

    .line 115
    sget-object v10, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v8, v10}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v10

    const-string v11, "size"

    .line 116
    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_3

    .line 117
    invoke-static {v8}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8

    invoke-virtual {v3, v8, v9}, Lorg/apache/commons/net/ftp/FTPFile;->setSize(J)V

    goto :goto_1

    :cond_3
    const-string v11, "sizd"

    .line 119
    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_4

    .line 120
    invoke-static {v8}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v8

    invoke-virtual {v3, v8, v9}, Lorg/apache/commons/net/ftp/FTPFile;->setSize(J)V

    goto :goto_1

    :cond_4
    const-string v11, "modify"

    .line 122
    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_6

    const-string v9, "."

    .line 125
    invoke-virtual {v8, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 126
    new-instance v9, Ljava/text/SimpleDateFormat;

    const-string v10, "yyyyMMddHHmmss.SSS"

    invoke-direct {v9, v10}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    goto :goto_2

    .line 128
    :cond_5
    new-instance v9, Ljava/text/SimpleDateFormat;

    const-string v10, "yyyyMMddHHmmss"

    invoke-direct {v9, v10}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    :goto_2
    const-string v10, "GMT"

    .line 130
    invoke-static {v10}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v10

    .line 131
    invoke-virtual {v9, v10}, Ljava/text/SimpleDateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    .line 132
    new-instance v11, Ljava/util/GregorianCalendar;

    invoke-direct {v11, v10}, Ljava/util/GregorianCalendar;-><init>(Ljava/util/TimeZone;)V

    .line 134
    :try_start_0
    invoke-virtual {v9, v8}, Ljava/text/SimpleDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v8

    invoke-virtual {v11, v8}, Ljava/util/GregorianCalendar;->setTime(Ljava/util/Date;)V
    :try_end_0
    .catch Ljava/text/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    .line 138
    :catch_0
    invoke-virtual {v3, v11}, Lorg/apache/commons/net/ftp/FTPFile;->setTimestamp(Ljava/util/Calendar;)V

    goto :goto_1

    :cond_6
    const-string v11, "type"

    .line 140
    invoke-virtual {v11, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    const/4 v12, 0x3

    if-eqz v11, :cond_8

    .line 141
    sget-object v8, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->TYPE_TO_INT:Ljava/util/HashMap;

    invoke-virtual {v8, v10}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Integer;

    if-nez v8, :cond_7

    .line 143
    invoke-virtual {v3, v12}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    goto/16 :goto_1

    .line 145
    :cond_7
    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    invoke-virtual {v3, v8}, Lorg/apache/commons/net/ftp/FTPFile;->setType(I)V

    goto/16 :goto_1

    :cond_8
    const-string v11, "unix."

    .line 148
    invoke-virtual {v9, v11}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-eqz v11, :cond_c

    const/4 v10, 0x5

    .line 149
    invoke-virtual {v9, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    sget-object v10, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v9, v10}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "group"

    .line 150
    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_9

    .line 151
    invoke-virtual {v3, v8}, Lorg/apache/commons/net/ftp/FTPFile;->setGroup(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_9
    const-string v10, "owner"

    .line 152
    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_a

    .line 153
    invoke-virtual {v3, v8}, Lorg/apache/commons/net/ftp/FTPFile;->setUser(Ljava/lang/String;)V

    goto/16 :goto_1

    :cond_a
    const-string v10, "mode"

    .line 154
    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 155
    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v9

    sub-int/2addr v9, v12

    const/4 v10, 0x0

    :goto_3
    if-ge v10, v12, :cond_1

    add-int v11, v9, v10

    .line 157
    invoke-virtual {v8, v11}, Ljava/lang/String;->charAt(I)C

    move-result v11

    add-int/lit8 v11, v11, -0x30

    if-ltz v11, :cond_b

    const/4 v13, 0x7

    if-gt v11, v13, :cond_b

    .line 159
    sget-object v13, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->UNIX_PERMS:[[I

    aget-object v11, v13, v11

    array-length v13, v11

    const/4 v14, 0x0

    :goto_4
    if-ge v14, v13, :cond_b

    aget v15, v11, v14

    .line 160
    sget-object v16, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->UNIX_GROUPS:[I

    aget v1, v16, v10

    invoke-virtual {v3, v1, v15, v0}, Lorg/apache/commons/net/ftp/FTPFile;->setPermission(IIZ)V

    add-int/lit8 v14, v14, 0x1

    const/4 v1, 0x2

    goto :goto_4

    :cond_b
    add-int/lit8 v10, v10, 0x1

    const/4 v1, 0x2

    goto :goto_3

    :cond_c
    if-nez v2, :cond_1

    const-string v1, "perm"

    .line 168
    invoke-virtual {v1, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    move-object/from16 v1, p0

    .line 169
    invoke-direct {v1, v3, v10}, Lorg/apache/commons/net/ftp/parser/MLSxEntryParser;->doUnixPerms(Lorg/apache/commons/net/ftp/FTPFile;Ljava/lang/String;)V

    :goto_5
    add-int/lit8 v7, v7, 0x1

    const/4 v1, 0x2

    goto/16 :goto_0

    :cond_d
    move-object/from16 v1, p0

    return-object v3
.end method
