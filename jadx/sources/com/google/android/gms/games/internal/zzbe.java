package com.google.android.gms.games.internal;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.Releasable;
import com.google.android.gms.common.api.Result;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.ApiExceptionUtil;
import com.google.android.gms.common.internal.PendingResultUtil;
import com.google.android.gms.games.AnnotatedData;
import com.google.android.gms.games.GamesClientStatusCodes;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public final class zzbe {
    private static final zzbn zzjf = zzbk.zzjs;

    @NonNull
    public static <R, PendingR extends Result, ExceptionData> Task<R> zza(@NonNull final PendingResult<PendingR> pendingResult, @NonNull final zzbn zzbnVar, @NonNull final PendingResultUtil.ResultConverter<PendingR, R> resultConverter, @NonNull final PendingResultUtil.ResultConverter<PendingR, ExceptionData> resultConverter2, @NonNull final zzbl<ExceptionData> zzblVar) {
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        pendingResult.addStatusListener(new PendingResult.StatusListener(pendingResult, zzbnVar, taskCompletionSource, resultConverter, resultConverter2, zzblVar) { // from class: com.google.android.gms.games.internal.zzbf
            private final PendingResult zzjg;
            private final zzbn zzjh;
            private final TaskCompletionSource zzji;
            private final PendingResultUtil.ResultConverter zzjj;
            private final PendingResultUtil.ResultConverter zzjk;
            private final zzbl zzjl;

            {
                this.zzjg = pendingResult;
                this.zzjh = zzbnVar;
                this.zzji = taskCompletionSource;
                this.zzjj = resultConverter;
                this.zzjk = resultConverter2;
                this.zzjl = zzblVar;
            }

            @Override // com.google.android.gms.common.api.PendingResult.StatusListener
            public final void onComplete(Status status) {
                zzbe.zza(this.zzjg, this.zzjh, this.zzji, this.zzjj, this.zzjk, this.zzjl, status);
            }
        });
        return taskCompletionSource.getTask();
    }

    @NonNull
    public static <R, PendingR extends Result> Task<R> toTask(@NonNull final PendingResult<PendingR> pendingResult, @NonNull final PendingResultUtil.ResultConverter<PendingR, R> resultConverter) {
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        pendingResult.addStatusListener(new PendingResult.StatusListener(pendingResult, taskCompletionSource, resultConverter) { // from class: com.google.android.gms.games.internal.zzbg
            private final PendingResult zzjg;
            private final TaskCompletionSource zzjm;
            private final PendingResultUtil.ResultConverter zzjn;

            {
                this.zzjg = pendingResult;
                this.zzjm = taskCompletionSource;
                this.zzjn = resultConverter;
            }

            @Override // com.google.android.gms.common.api.PendingResult.StatusListener
            public final void onComplete(Status status) {
                zzbe.zza(this.zzjg, this.zzjm, this.zzjn, status);
            }
        });
        return taskCompletionSource.getTask();
    }

    @NonNull
    public static <R, PendingR extends Result> Task<AnnotatedData<R>> zza(@NonNull final PendingResult<PendingR> pendingResult, @NonNull final PendingResultUtil.ResultConverter<PendingR, R> resultConverter, @Nullable final zzbm<PendingR> zzbmVar) {
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        pendingResult.addStatusListener(new PendingResult.StatusListener(pendingResult, taskCompletionSource, resultConverter, zzbmVar) { // from class: com.google.android.gms.games.internal.zzbh
            private final PendingResult zzjg;
            private final TaskCompletionSource zzjm;
            private final PendingResultUtil.ResultConverter zzjn;
            private final zzbm zzjo;

            {
                this.zzjg = pendingResult;
                this.zzjm = taskCompletionSource;
                this.zzjn = resultConverter;
                this.zzjo = zzbmVar;
            }

            @Override // com.google.android.gms.common.api.PendingResult.StatusListener
            public final void onComplete(Status status) {
                zzbe.zza(this.zzjg, this.zzjm, this.zzjn, this.zzjo, status);
            }
        });
        return taskCompletionSource.getTask();
    }

    @NonNull
    public static <R, PendingR extends Result> Task<AnnotatedData<R>> zza(@NonNull PendingResult<PendingR> pendingResult, @NonNull PendingResultUtil.ResultConverter<PendingR, R> resultConverter) {
        return zza(pendingResult, resultConverter, (zzbm) null);
    }

    @NonNull
    public static <R extends Releasable, PendingR extends Result> Task<AnnotatedData<R>> zzb(@NonNull final PendingResult<PendingR> pendingResult, @NonNull final PendingResultUtil.ResultConverter<PendingR, R> resultConverter) {
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        pendingResult.addStatusListener(new PendingResult.StatusListener(resultConverter, pendingResult, taskCompletionSource) { // from class: com.google.android.gms.games.internal.zzbi
            private final TaskCompletionSource zzji;
            private final PendingResultUtil.ResultConverter zzjp;
            private final PendingResult zzjq;

            {
                this.zzjp = resultConverter;
                this.zzjq = pendingResult;
                this.zzji = taskCompletionSource;
            }

            @Override // com.google.android.gms.common.api.PendingResult.StatusListener
            public final void onComplete(Status status) {
                zzbe.zza(this.zzjp, this.zzjq, this.zzji, status);
            }
        });
        return taskCompletionSource.getTask();
    }

    @NonNull
    public static <R, PendingR extends Result> Task<R> zza(@NonNull final PendingResult<PendingR> pendingResult, @NonNull final zzbn zzbnVar, @NonNull final PendingResultUtil.ResultConverter<PendingR, R> resultConverter) {
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        pendingResult.addStatusListener(new PendingResult.StatusListener(zzbnVar, pendingResult, taskCompletionSource, resultConverter) { // from class: com.google.android.gms.games.internal.zzbj
            private final TaskCompletionSource zzji;
            private final PendingResultUtil.ResultConverter zzjj;
            private final PendingResult zzjq;
            private final zzbn zzjr;

            {
                this.zzjr = zzbnVar;
                this.zzjq = pendingResult;
                this.zzji = taskCompletionSource;
                this.zzjj = resultConverter;
            }

            @Override // com.google.android.gms.common.api.PendingResult.StatusListener
            public final void onComplete(Status status) {
                zzbe.zza(this.zzjr, this.zzjq, this.zzji, this.zzjj, status);
            }
        });
        return taskCompletionSource.getTask();
    }

    static final /* synthetic */ void zza(zzbn zzbnVar, PendingResult pendingResult, TaskCompletionSource taskCompletionSource, PendingResultUtil.ResultConverter resultConverter, Status status) {
        if (zzbnVar.zza(status)) {
            taskCompletionSource.setResult(resultConverter.convert(pendingResult.await(0L, TimeUnit.MILLISECONDS)));
        } else {
            taskCompletionSource.setException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zzb(status)));
        }
    }

    static final /* synthetic */ void zza(PendingResultUtil.ResultConverter resultConverter, PendingResult pendingResult, TaskCompletionSource taskCompletionSource, Status status) {
        boolean z = status.getStatusCode() == 3;
        Releasable releasable = (Releasable) resultConverter.convert(pendingResult.await(0L, TimeUnit.MILLISECONDS));
        if (status.isSuccess() || z) {
            taskCompletionSource.setResult(new AnnotatedData(releasable, z));
            return;
        }
        if (releasable != null) {
            releasable.release();
        }
        taskCompletionSource.setException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zzb(status)));
    }

    static final /* synthetic */ void zza(PendingResult pendingResult, TaskCompletionSource taskCompletionSource, PendingResultUtil.ResultConverter resultConverter, zzbm zzbmVar, Status status) {
        boolean z = status.getStatusCode() == 3;
        Result resultAwait = pendingResult.await(0L, TimeUnit.MILLISECONDS);
        if (status.isSuccess() || z) {
            taskCompletionSource.setResult(new AnnotatedData(resultConverter.convert(resultAwait), z));
            return;
        }
        if (resultAwait != null && zzbmVar != null) {
            zzbmVar.release(resultAwait);
        }
        taskCompletionSource.setException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zzb(status)));
    }

    static final /* synthetic */ void zza(PendingResult pendingResult, TaskCompletionSource taskCompletionSource, PendingResultUtil.ResultConverter resultConverter, Status status) {
        Result resultAwait = pendingResult.await(0L, TimeUnit.MILLISECONDS);
        if (status.isSuccess()) {
            taskCompletionSource.setResult(resultConverter.convert(resultAwait));
        } else {
            taskCompletionSource.setException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zzb(status)));
        }
    }

    static final /* synthetic */ void zza(PendingResult pendingResult, zzbn zzbnVar, TaskCompletionSource taskCompletionSource, PendingResultUtil.ResultConverter resultConverter, PendingResultUtil.ResultConverter resultConverter2, zzbl zzblVar, Status status) {
        Result resultAwait = pendingResult.await(0L, TimeUnit.MILLISECONDS);
        if (zzbnVar.zza(status)) {
            taskCompletionSource.setResult(resultConverter.convert(resultAwait));
            return;
        }
        Object objConvert = resultConverter2.convert(resultAwait);
        if (objConvert != null) {
            taskCompletionSource.setException(zzblVar.zza(GamesClientStatusCodes.zzb(status), objConvert));
        } else {
            taskCompletionSource.setException(ApiExceptionUtil.fromStatus(GamesClientStatusCodes.zzb(status)));
        }
    }
}
