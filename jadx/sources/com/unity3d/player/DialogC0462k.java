package com.unity3d.player;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.text.Editable;
import android.text.InputFilter;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;

/* JADX INFO: renamed from: com.unity3d.player.k */
/* JADX INFO: loaded from: classes.dex */
public final class DialogC0462k extends Dialog implements TextWatcher, View.OnClickListener {

    /* JADX INFO: renamed from: c */
    private static int f655c = 1627389952;

    /* JADX INFO: renamed from: d */
    private static int f656d = -1;

    /* JADX INFO: renamed from: e */
    private static int f657e = 134217728;

    /* JADX INFO: renamed from: f */
    private static int f658f = 67108864;

    /* JADX INFO: renamed from: a */
    private Context f659a;

    /* JADX INFO: renamed from: b */
    private UnityPlayer f660b;

    /* JADX INFO: renamed from: g */
    private int f661g;

    public DialogC0462k(Context context, UnityPlayer unityPlayer, String str, int i, boolean z, boolean z2, boolean z3, String str2, int i2, boolean z4) {
        super(context);
        this.f659a = null;
        this.f660b = null;
        this.f659a = context;
        this.f660b = unityPlayer;
        Window window = getWindow();
        window.requestFeature(1);
        WindowManager.LayoutParams attributes = window.getAttributes();
        attributes.gravity = 80;
        attributes.x = 0;
        attributes.y = 0;
        window.setAttributes(attributes);
        window.setBackgroundDrawable(new ColorDrawable(0));
        setContentView(createSoftInputView());
        window.setLayout(-1, -2);
        window.clearFlags(2);
        if (C0461j.f651a) {
            window.clearFlags(f657e);
            window.clearFlags(f658f);
        }
        EditText editText = (EditText) findViewById(1057292289);
        Button button = (Button) findViewById(1057292290);
        m510a(editText, str, i, z, z2, z3, str2, i2);
        button.setOnClickListener(this);
        this.f661g = editText.getCurrentTextColor();
        m518a(z4);
        editText.setOnFocusChangeListener(new View.OnFocusChangeListener() { // from class: com.unity3d.player.k.1
            @Override // android.view.View.OnFocusChangeListener
            public final void onFocusChange(View view, boolean z5) {
                if (z5) {
                    DialogC0462k.this.getWindow().setSoftInputMode(5);
                }
            }
        });
        editText.requestFocus();
    }

    /* JADX INFO: renamed from: a */
    private static int m507a(int i, boolean z, boolean z2, boolean z3) {
        int i2 = (z ? 32768 : 524288) | (z2 ? 131072 : 0) | (z3 ? 128 : 0);
        if (i < 0 || i > 11) {
            return i2;
        }
        int[] iArr = {1, 16385, 12290, 17, 2, 3, 8289, 33, 1, 16417, 17, 8194};
        return (iArr[i] & 2) != 0 ? iArr[i] : iArr[i] | i2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public String m508a() {
        EditText editText = (EditText) findViewById(1057292289);
        if (editText == null) {
            return null;
        }
        return editText.getText().toString().trim();
    }

    /* JADX INFO: renamed from: a */
    private void m510a(EditText editText, String str, int i, boolean z, boolean z2, boolean z3, String str2, int i2) {
        editText.setImeOptions(6);
        editText.setText(str);
        editText.setHint(str2);
        editText.setHintTextColor(f655c);
        editText.setInputType(m507a(i, z, z2, z3));
        editText.setImeOptions(33554432);
        if (i2 > 0) {
            editText.setFilters(new InputFilter[]{new InputFilter.LengthFilter(i2)});
        }
        editText.addTextChangedListener(this);
        editText.setSelection(editText.getText().length());
        editText.setClickable(true);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX INFO: renamed from: a */
    public void m512a(String str, boolean z) {
        ((EditText) findViewById(1057292289)).setSelection(0, 0);
        this.f660b.reportSoftInputStr(str, 1, z);
    }

    /* JADX INFO: renamed from: a */
    public final void m515a(int i) {
        EditText editText = (EditText) findViewById(1057292289);
        if (editText != null) {
            if (i > 0) {
                editText.setFilters(new InputFilter[]{new InputFilter.LengthFilter(i)});
            } else {
                editText.setFilters(new InputFilter[0]);
            }
        }
    }

    /* JADX INFO: renamed from: a */
    public final void m516a(int i, int i2) {
        int i3;
        EditText editText = (EditText) findViewById(1057292289);
        if (editText == null || editText.getText().length() < (i3 = i2 + i)) {
            return;
        }
        editText.setSelection(i, i3);
    }

    /* JADX INFO: renamed from: a */
    public final void m517a(String str) {
        EditText editText = (EditText) findViewById(1057292289);
        if (editText != null) {
            editText.setText(str);
            editText.setSelection(str.length());
        }
    }

    /* JADX INFO: renamed from: a */
    public final void m518a(boolean z) {
        int i;
        EditText editText = (EditText) findViewById(1057292289);
        Button button = (Button) findViewById(1057292290);
        View viewFindViewById = findViewById(1057292291);
        if (z) {
            i = 0;
            editText.setBackgroundColor(0);
            editText.setTextColor(0);
            editText.setCursorVisible(false);
            button.setClickable(false);
            button.setTextColor(0);
        } else {
            editText.setBackgroundColor(f656d);
            editText.setTextColor(this.f661g);
            editText.setCursorVisible(true);
            button.setClickable(true);
            button.setTextColor(this.f661g);
            i = f656d;
        }
        viewFindViewById.setBackgroundColor(i);
    }

    @Override // android.text.TextWatcher
    public final void afterTextChanged(Editable editable) {
        this.f660b.reportSoftInputStr(editable.toString(), 0, false);
    }

    @Override // android.text.TextWatcher
    public final void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }

    protected final View createSoftInputView() {
        RelativeLayout relativeLayout = new RelativeLayout(this.f659a);
        relativeLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
        relativeLayout.setBackgroundColor(f656d);
        relativeLayout.setId(1057292291);
        EditText editText = new EditText(this.f659a) { // from class: com.unity3d.player.k.2
            @Override // android.widget.TextView, android.view.View
            public final boolean onKeyPreIme(int i, KeyEvent keyEvent) {
                if (i == 4) {
                    DialogC0462k.this.m512a(DialogC0462k.this.m508a(), true);
                    return true;
                }
                if (i == 84) {
                    return true;
                }
                return super.onKeyPreIme(i, keyEvent);
            }

            @Override // android.widget.TextView
            protected final void onSelectionChanged(int i, int i2) {
                DialogC0462k.this.f660b.reportSoftInputSelection(i, i2 - i);
            }

            @Override // android.widget.TextView, android.view.View
            public final void onWindowFocusChanged(boolean z) {
                super.onWindowFocusChanged(z);
                if (z) {
                    ((InputMethodManager) DialogC0462k.this.f659a.getSystemService("input_method")).showSoftInput(this, 0);
                }
            }
        };
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(-1, -2);
        layoutParams.addRule(15);
        layoutParams.addRule(0, 1057292290);
        editText.setLayoutParams(layoutParams);
        editText.setId(1057292289);
        relativeLayout.addView(editText);
        Button button = new Button(this.f659a);
        button.setText(this.f659a.getResources().getIdentifier("ok", "string", "android"));
        RelativeLayout.LayoutParams layoutParams2 = new RelativeLayout.LayoutParams(-2, -2);
        layoutParams2.addRule(15);
        layoutParams2.addRule(11);
        button.setLayoutParams(layoutParams2);
        button.setId(1057292290);
        button.setBackgroundColor(0);
        relativeLayout.addView(button);
        ((EditText) relativeLayout.findViewById(1057292289)).setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: com.unity3d.player.k.3
            @Override // android.widget.TextView.OnEditorActionListener
            public final boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (i == 6) {
                    DialogC0462k.this.m512a(DialogC0462k.this.m508a(), false);
                }
                return false;
            }
        });
        relativeLayout.setPadding(16, 16, 16, 16);
        return relativeLayout;
    }

    @Override // android.app.Dialog
    public final void onBackPressed() {
        m512a(m508a(), true);
    }

    @Override // android.view.View.OnClickListener
    public final void onClick(View view) {
        m512a(m508a(), false);
    }

    @Override // android.text.TextWatcher
    public final void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
    }
}
