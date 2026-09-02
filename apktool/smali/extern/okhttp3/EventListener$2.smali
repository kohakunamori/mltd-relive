.class Lextern/okhttp3/EventListener$2;
.super Ljava/lang/Object;
.source "EventListener.java"

# interfaces
.implements Lextern/okhttp3/EventListener$Factory;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lextern/okhttp3/EventListener;->factory(Lextern/okhttp3/EventListener;)Lextern/okhttp3/EventListener$Factory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$listener:Lextern/okhttp3/EventListener;


# direct methods
.method constructor <init>(Lextern/okhttp3/EventListener;)V
    .locals 0

    .line 57
    iput-object p1, p0, Lextern/okhttp3/EventListener$2;->val$listener:Lextern/okhttp3/EventListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public create(Lextern/okhttp3/Call;)Lextern/okhttp3/EventListener;
    .locals 0

    .line 59
    iget-object p1, p0, Lextern/okhttp3/EventListener$2;->val$listener:Lextern/okhttp3/EventListener;

    return-object p1
.end method
