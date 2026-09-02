.class Lextern/okhttp3/internal/cache/DiskLruCache$2;
.super Lextern/okhttp3/internal/cache/FaultHidingSink;
.source "DiskLruCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/internal/cache/DiskLruCache;->newJournalWriter()Lextern/okio/BufferedSink;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field final synthetic this$0:Lextern/okhttp3/internal/cache/DiskLruCache;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method constructor <init>(Lextern/okhttp3/internal/cache/DiskLruCache;Lextern/okio/Sink;)V
    .locals 0

    .line 315
    iput-object p1, p0, Lextern/okhttp3/internal/cache/DiskLruCache$2;->this$0:Lextern/okhttp3/internal/cache/DiskLruCache;

    invoke-direct {p0, p2}, Lextern/okhttp3/internal/cache/FaultHidingSink;-><init>(Lextern/okio/Sink;)V

    return-void
.end method


# virtual methods
.method protected onException(Ljava/io/IOException;)V
    .locals 1

    .line 318
    iget-object p1, p0, Lextern/okhttp3/internal/cache/DiskLruCache$2;->this$0:Lextern/okhttp3/internal/cache/DiskLruCache;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lextern/okhttp3/internal/cache/DiskLruCache;->hasJournalErrors:Z

    return-void
.end method
