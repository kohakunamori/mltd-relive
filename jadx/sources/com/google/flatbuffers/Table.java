package com.google.flatbuffers;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.Comparator;

/* JADX INFO: loaded from: classes.dex */
public class Table {
    public static final ThreadLocal<Charset> UTF8_CHARSET = new ThreadLocal<Charset>() { // from class: com.google.flatbuffers.Table.1
        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        public Charset initialValue() {
            return Charset.forName(com.adjust.sdk.Constants.ENCODING);
        }
    };

    /* JADX INFO: renamed from: bb */
    protected ByteBuffer f19bb;
    protected int bb_pos;
    Utf8 utf8 = Utf8.getDefault();
    protected int vtable_size;
    protected int vtable_start;

    protected int keysCompare(Integer num, Integer num2, ByteBuffer byteBuffer) {
        return 0;
    }

    public ByteBuffer getByteBuffer() {
        return this.f19bb;
    }

    protected int __offset(int i) {
        if (i < this.vtable_size) {
            return this.f19bb.getShort(this.vtable_start + i);
        }
        return 0;
    }

    protected static int __offset(int i, int i2, ByteBuffer byteBuffer) {
        int iCapacity = byteBuffer.capacity() - i2;
        return byteBuffer.getShort((i + iCapacity) - byteBuffer.getInt(iCapacity)) + iCapacity;
    }

    protected int __indirect(int i) {
        return i + this.f19bb.getInt(i);
    }

    protected static int __indirect(int i, ByteBuffer byteBuffer) {
        return i + byteBuffer.getInt(i);
    }

    protected String __string(int i) {
        int i2 = i + this.f19bb.getInt(i);
        return this.utf8.decodeUtf8(this.f19bb, i2 + 4, this.f19bb.getInt(i2));
    }

    protected int __vector_len(int i) {
        int i2 = i + this.bb_pos;
        return this.f19bb.getInt(i2 + this.f19bb.getInt(i2));
    }

    protected int __vector(int i) {
        int i2 = i + this.bb_pos;
        return i2 + this.f19bb.getInt(i2) + 4;
    }

    protected ByteBuffer __vector_as_bytebuffer(int i, int i2) {
        int i__offset = __offset(i);
        if (i__offset == 0) {
            return null;
        }
        ByteBuffer byteBufferOrder = this.f19bb.duplicate().order(ByteOrder.LITTLE_ENDIAN);
        int i__vector = __vector(i__offset);
        byteBufferOrder.position(i__vector);
        byteBufferOrder.limit(i__vector + (__vector_len(i__offset) * i2));
        return byteBufferOrder;
    }

    protected ByteBuffer __vector_in_bytebuffer(ByteBuffer byteBuffer, int i, int i2) {
        int i__offset = __offset(i);
        if (i__offset == 0) {
            return null;
        }
        int i__vector = __vector(i__offset);
        byteBuffer.rewind();
        byteBuffer.limit((__vector_len(i__offset) * i2) + i__vector);
        byteBuffer.position(i__vector);
        return byteBuffer;
    }

    protected Table __union(Table table, int i) {
        int i2 = i + this.bb_pos;
        table.bb_pos = i2 + this.f19bb.getInt(i2);
        table.f19bb = this.f19bb;
        table.vtable_start = table.bb_pos - this.f19bb.getInt(table.bb_pos);
        table.vtable_size = this.f19bb.getShort(table.vtable_start);
        return table;
    }

    protected static boolean __has_identifier(ByteBuffer byteBuffer, String str) {
        if (str.length() != 4) {
            throw new AssertionError("FlatBuffers: file identifier must be length 4");
        }
        for (int i = 0; i < 4; i++) {
            if (str.charAt(i) != ((char) byteBuffer.get(byteBuffer.position() + 4 + i))) {
                return false;
            }
        }
        return true;
    }

    protected void sortTables(int[] iArr, final ByteBuffer byteBuffer) {
        Integer[] numArr = new Integer[iArr.length];
        for (int i = 0; i < iArr.length; i++) {
            numArr[i] = Integer.valueOf(iArr[i]);
        }
        Arrays.sort(numArr, new Comparator<Integer>() { // from class: com.google.flatbuffers.Table.2
            @Override // java.util.Comparator
            public int compare(Integer num, Integer num2) {
                return Table.this.keysCompare(num, num2, byteBuffer);
            }
        });
        for (int i2 = 0; i2 < iArr.length; i2++) {
            iArr[i2] = numArr[i2].intValue();
        }
    }

    protected static int compareStrings(int i, int i2, ByteBuffer byteBuffer) {
        int i3 = i + byteBuffer.getInt(i);
        int i4 = i2 + byteBuffer.getInt(i2);
        int i5 = byteBuffer.getInt(i3);
        int i6 = byteBuffer.getInt(i4);
        int i7 = i3 + 4;
        int i8 = i4 + 4;
        int iMin = Math.min(i5, i6);
        for (int i9 = 0; i9 < iMin; i9++) {
            int i10 = i9 + i7;
            int i11 = i9 + i8;
            if (byteBuffer.get(i10) != byteBuffer.get(i11)) {
                return byteBuffer.get(i10) - byteBuffer.get(i11);
            }
        }
        return i5 - i6;
    }

    protected static int compareStrings(int i, byte[] bArr, ByteBuffer byteBuffer) {
        int i2 = i + byteBuffer.getInt(i);
        int i3 = byteBuffer.getInt(i2);
        int length = bArr.length;
        int i4 = i2 + 4;
        int iMin = Math.min(i3, length);
        for (int i5 = 0; i5 < iMin; i5++) {
            int i6 = i5 + i4;
            if (byteBuffer.get(i6) != bArr[i5]) {
                return byteBuffer.get(i6) - bArr[i5];
            }
        }
        return i3 - length;
    }

    public void __reset() {
        this.f19bb = null;
        this.bb_pos = 0;
        this.vtable_start = 0;
        this.vtable_size = 0;
    }
}
