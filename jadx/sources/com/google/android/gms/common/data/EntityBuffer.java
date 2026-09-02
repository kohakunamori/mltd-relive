package com.google.android.gms.common.data;

import com.google.android.gms.common.annotation.KeepForSdk;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@KeepForSdk
public abstract class EntityBuffer<T> extends AbstractDataBuffer<T> {
    private boolean zame;
    private ArrayList<Integer> zamf;

    @KeepForSdk
    protected EntityBuffer(DataHolder dataHolder) {
        super(dataHolder);
        this.zame = false;
    }

    @KeepForSdk
    protected String getChildDataMarkerColumn() {
        return null;
    }

    @KeepForSdk
    protected abstract T getEntry(int i, int i2);

    @KeepForSdk
    protected abstract String getPrimaryDataMarkerColumn();

    /* JADX WARN: Code duplicated, block: B:17:0x0067  */
    @Override // com.google.android.gms.common.data.AbstractDataBuffer, com.google.android.gms.common.data.DataBuffer
    @KeepForSdk
    public final T get(int i) {
        int iIntValue;
        zacb();
        int iZah = zah(i);
        int i2 = 0;
        if (i >= 0 && i != this.zamf.size()) {
            if (i == this.zamf.size() - 1) {
                iIntValue = this.mDataHolder.getCount() - this.zamf.get(i).intValue();
            } else {
                iIntValue = this.zamf.get(i + 1).intValue() - this.zamf.get(i).intValue();
            }
            if (iIntValue == 1) {
                int iZah2 = zah(i);
                int windowIndex = this.mDataHolder.getWindowIndex(iZah2);
                String childDataMarkerColumn = getChildDataMarkerColumn();
                if (childDataMarkerColumn == null || this.mDataHolder.getString(childDataMarkerColumn, iZah2, windowIndex) != null) {
                    i2 = iIntValue;
                }
            } else {
                i2 = iIntValue;
            }
        }
        return getEntry(iZah, i2);
    }

    @Override // com.google.android.gms.common.data.AbstractDataBuffer, com.google.android.gms.common.data.DataBuffer
    @KeepForSdk
    public int getCount() {
        zacb();
        return this.zamf.size();
    }

    private final void zacb() {
        synchronized (this) {
            if (!this.zame) {
                int count = this.mDataHolder.getCount();
                this.zamf = new ArrayList<>();
                if (count > 0) {
                    this.zamf.add(0);
                    String primaryDataMarkerColumn = getPrimaryDataMarkerColumn();
                    String string = this.mDataHolder.getString(primaryDataMarkerColumn, 0, this.mDataHolder.getWindowIndex(0));
                    for (int i = 1; i < count; i++) {
                        int windowIndex = this.mDataHolder.getWindowIndex(i);
                        String string2 = this.mDataHolder.getString(primaryDataMarkerColumn, i, windowIndex);
                        if (string2 == null) {
                            StringBuilder sb = new StringBuilder(String.valueOf(primaryDataMarkerColumn).length() + 78);
                            sb.append("Missing value for markerColumn: ");
                            sb.append(primaryDataMarkerColumn);
                            sb.append(", at row: ");
                            sb.append(i);
                            sb.append(", for window: ");
                            sb.append(windowIndex);
                            throw new NullPointerException(sb.toString());
                        }
                        if (!string2.equals(string)) {
                            this.zamf.add(Integer.valueOf(i));
                            string = string2;
                        }
                    }
                }
                this.zame = true;
            }
        }
    }

    private final int zah(int i) {
        if (i < 0 || i >= this.zamf.size()) {
            StringBuilder sb = new StringBuilder(53);
            sb.append("Position ");
            sb.append(i);
            sb.append(" is out of bounds for this buffer");
            throw new IllegalArgumentException(sb.toString());
        }
        return this.zamf.get(i).intValue();
    }
}
