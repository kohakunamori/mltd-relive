package com.adjust.sdk.scheduler;

import com.adjust.sdk.AdjustFactory;
import com.adjust.sdk.ILogger;
import com.adjust.sdk.Util;
import java.text.DecimalFormat;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public class TimerOnce {
    private Runnable command;
    private ILogger logger = AdjustFactory.getLogger();
    private String name;
    private FutureScheduler scheduler;
    private ScheduledFuture waitingTask;

    public TimerOnce(Runnable runnable, String str) {
        this.name = str;
        this.scheduler = new SingleThreadFutureScheduler(str, true);
        this.command = runnable;
    }

    public void startIn(long j) {
        cancel(false);
        DecimalFormat decimalFormat = Util.SecondsDisplayFormat;
        double d = j;
        Double.isNaN(d);
        this.logger.verbose("%s starting. Launching in %s seconds", this.name, decimalFormat.format(d / 1000.0d));
        this.waitingTask = this.scheduler.scheduleFuture(new Runnable() { // from class: com.adjust.sdk.scheduler.TimerOnce.1
            @Override // java.lang.Runnable
            public void run() {
                TimerOnce.this.logger.verbose("%s fired", TimerOnce.this.name);
                TimerOnce.this.command.run();
                TimerOnce.this.waitingTask = null;
            }
        }, j);
    }

    public long getFireIn() {
        if (this.waitingTask == null) {
            return 0L;
        }
        return this.waitingTask.getDelay(TimeUnit.MILLISECONDS);
    }

    private void cancel(boolean z) {
        if (this.waitingTask != null) {
            this.waitingTask.cancel(z);
        }
        this.waitingTask = null;
        this.logger.verbose("%s canceled", this.name);
    }

    public void cancel() {
        cancel(false);
    }

    public void teardown() {
        cancel(true);
        if (this.scheduler != null) {
            this.scheduler.teardown();
        }
        this.scheduler = null;
    }
}
