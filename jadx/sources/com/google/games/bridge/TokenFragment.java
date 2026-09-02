package com.google.games.bridge;

import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import androidx.annotation.NonNull;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.auth.api.signin.GoogleSignInStatusCodes;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.common.api.PendingResult;
import com.google.android.gms.common.api.Scope;
import com.google.android.gms.games.Games;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

/* JADX INFO: loaded from: classes.dex */
public class TokenFragment extends Fragment {
    private static final String FRAGMENT_TAG = "gpg.AuthTokenSupport";
    private static final int RC_ACCT = 9002;
    private static final String TAG = "TokenFragment";
    private static TokenFragment helperFragment;
    private static final Object lock = new Object();
    private static boolean mStartUpSignInCheckPerformed = false;
    private static TokenRequest pendingTokenRequest;
    private GoogleSignInClient mGoogleSignInClient;

    public static PendingResult fetchToken(Activity activity, boolean z, boolean z2, boolean z3, boolean z4, String str, boolean z5, String[] strArr, boolean z6, String str2) {
        boolean z7;
        TokenRequest tokenRequest = new TokenRequest(z, z2, z3, z4, str, z5, strArr, z6, str2);
        synchronized (lock) {
            if (pendingTokenRequest == null) {
                pendingTokenRequest = tokenRequest;
                z7 = true;
            } else {
                z7 = false;
            }
        }
        if (!z7) {
            Log.e(TAG, "Already a pending token request (requested == ): " + tokenRequest);
            Log.e(TAG, "Already a pending token request: " + pendingTokenRequest);
            tokenRequest.setResult(10);
            return tokenRequest.getPendingResponse();
        }
        TokenFragment tokenFragment = (TokenFragment) activity.getFragmentManager().findFragmentByTag(FRAGMENT_TAG);
        if (tokenFragment == null) {
            try {
                Log.d(TAG, "Creating fragment");
                TokenFragment tokenFragment2 = new TokenFragment();
                FragmentTransaction fragmentTransactionBeginTransaction = activity.getFragmentManager().beginTransaction();
                fragmentTransactionBeginTransaction.add(tokenFragment2, FRAGMENT_TAG);
                fragmentTransactionBeginTransaction.commit();
            } catch (Throwable th) {
                Log.e(TAG, "Cannot launch token fragment:" + th.getMessage(), th);
                tokenRequest.setResult(13);
                synchronized (lock) {
                    pendingTokenRequest = null;
                }
            }
        } else {
            Log.d(TAG, "Fragment exists.. calling processRequests");
            tokenFragment.processRequest();
        }
        return tokenRequest.getPendingResponse();
    }

    public static void signOut(Activity activity) {
        TokenFragment tokenFragment = (TokenFragment) activity.getFragmentManager().findFragmentByTag(FRAGMENT_TAG);
        if (tokenFragment != null) {
            tokenFragment.reset();
        }
        synchronized (lock) {
            pendingTokenRequest = null;
        }
    }

    private void reset() {
        if (this.mGoogleSignInClient != null) {
            this.mGoogleSignInClient.signOut();
            this.mGoogleSignInClient = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void signIn() {
        final TokenRequest tokenRequest;
        Log.d(TAG, "signIn");
        synchronized (lock) {
            tokenRequest = pendingTokenRequest;
        }
        final GoogleSignInClient googleSignInClient = this.mGoogleSignInClient;
        if (googleSignInClient == null || tokenRequest == null) {
            return;
        }
        if (tokenRequest.canReuseAccount()) {
            final GoogleSignInAccount lastSignedInAccount = GoogleSignIn.getLastSignedInAccount(getActivity());
            if (GoogleSignIn.hasPermissions(lastSignedInAccount, tokenRequest.scopes)) {
                Log.d(TAG, "Checking the last signed-in account if it can be used.");
                Games.getGamesClient(getActivity(), lastSignedInAccount).getAppId().addOnCompleteListener(new OnCompleteListener<String>() { // from class: com.google.games.bridge.TokenFragment.1
                    @Override // com.google.android.gms.tasks.OnCompleteListener
                    public void onComplete(@NonNull Task<String> task) {
                        if (task.isSuccessful()) {
                            Log.d(TokenFragment.TAG, "Signed-in with the last signed-in account.");
                            TokenFragment.this.onSignedIn(0, lastSignedInAccount);
                        } else {
                            googleSignInClient.signOut().addOnCompleteListener(new OnCompleteListener<Void>() { // from class: com.google.games.bridge.TokenFragment.1.1
                                @Override // com.google.android.gms.tasks.OnCompleteListener
                                public void onComplete(@NonNull Task<Void> task2) {
                                    if (task2.isSuccessful()) {
                                        Log.d(TokenFragment.TAG, "Can't reuse the last signed-in account. Second attempt after sign out.");
                                        TokenFragment.this.signIn();
                                    } else {
                                        Log.e(TokenFragment.TAG, "Can't reuse the last signed-in account and sign out failed.");
                                        TokenFragment.this.onSignedIn(4, null);
                                    }
                                }
                            });
                        }
                    }
                });
                return;
            }
        }
        Log.d(TAG, "signInClient.silentSignIn");
        googleSignInClient.silentSignIn().addOnSuccessListener(getActivity(), new OnSuccessListener<GoogleSignInAccount>() { // from class: com.google.games.bridge.TokenFragment.3
            @Override // com.google.android.gms.tasks.OnSuccessListener
            public void onSuccess(GoogleSignInAccount googleSignInAccount) {
                Log.d(TokenFragment.TAG, "silentSignIn.onSuccess");
                TokenFragment.this.onSignedIn(0, googleSignInAccount);
            }
        }).addOnFailureListener(getActivity(), new OnFailureListener() { // from class: com.google.games.bridge.TokenFragment.2
            @Override // com.google.android.gms.tasks.OnFailureListener
            public void onFailure(Exception exc) {
                Log.d(TokenFragment.TAG, "silentSignIn.onFailure");
                int statusCode = exc instanceof ApiException ? ((ApiException) exc).getStatusCode() : 8;
                if (statusCode == 4 || statusCode == 8 || statusCode == 6) {
                    if (!tokenRequest.getSilent()) {
                        TokenFragment.this.startActivityForResult(googleSignInClient.getSignInIntent(), 9002);
                        return;
                    } else {
                        Log.i(TokenFragment.TAG, "Sign-in failed. Run in silent mode and UI sign-in required.");
                        TokenFragment.this.onSignedIn(4, null);
                        return;
                    }
                }
                Log.e(TokenFragment.TAG, "Sign-in failed with status code: " + statusCode);
                TokenFragment.this.onSignedIn(statusCode, null);
            }
        });
    }

    private void processRequest() {
        TokenRequest tokenRequest;
        synchronized (lock) {
            tokenRequest = pendingTokenRequest;
        }
        if (tokenRequest == null) {
            return;
        }
        if (buildClient(getActivity(), tokenRequest)) {
            signIn();
        } else {
            synchronized (lock) {
                pendingTokenRequest = null;
            }
        }
        Log.d(TAG, "Done with processRequest, result is pending.");
    }

    private boolean buildClient(Activity activity, TokenRequest tokenRequest) {
        Log.d(TAG, "Building client for: " + tokenRequest);
        GoogleSignInOptions.Builder builder = new GoogleSignInOptions.Builder();
        if (tokenRequest.doAuthCode) {
            if (!tokenRequest.getWebClientId().isEmpty() && !tokenRequest.getWebClientId().equals("__WEB_CLIENTID__")) {
                builder.requestServerAuthCode(tokenRequest.getWebClientId(), tokenRequest.getForceRefresh());
            } else {
                Log.e(TAG, "Web client ID is needed for Auth Code");
                tokenRequest.setResult(10);
                return false;
            }
        }
        if (tokenRequest.doEmail) {
            builder.requestEmail();
        }
        if (tokenRequest.doIdToken) {
            if (!tokenRequest.getWebClientId().isEmpty() && !tokenRequest.getWebClientId().equals("__WEB_CLIENTID__")) {
                builder.requestIdToken(tokenRequest.getWebClientId());
            } else {
                Log.e(TAG, "Web client ID is needed for ID Token");
                tokenRequest.setResult(10);
                return false;
            }
        }
        if (tokenRequest.scopes != null) {
            for (Scope scope : tokenRequest.scopes) {
                builder.requestScopes(scope, new Scope[0]);
            }
        }
        if (tokenRequest.hidePopups) {
            Log.d(TAG, "hiding popup views for games API");
            builder.addExtension(Games.GamesOptions.builder().setShowConnectingPopup(false).build());
        }
        if (tokenRequest.accountName != null && !tokenRequest.accountName.isEmpty()) {
            builder.setAccountName(tokenRequest.accountName);
        }
        this.mGoogleSignInClient = GoogleSignIn.getClient(activity, builder.build());
        return true;
    }

    @Override // android.app.Fragment
    public void onActivityResult(int i, int i2, Intent intent) {
        if (i == 9002) {
            GoogleSignInResult signInResultFromIntent = Auth.GoogleSignInApi.getSignInResultFromIntent(intent);
            if (signInResultFromIntent != null && signInResultFromIntent.isSuccess()) {
                onSignedIn(signInResultFromIntent.getStatus().getStatusCode(), signInResultFromIntent.getSignInAccount());
                return;
            }
            if (i2 == 0) {
                onSignedIn(16, null);
                return;
            }
            if (signInResultFromIntent != null) {
                Log.e(TAG, "GoogleSignInResult error status code: " + signInResultFromIntent.getStatus());
                onSignedIn(signInResultFromIntent.getStatus().getStatusCode(), null);
                return;
            }
            Log.e(TAG, "Google SignIn Result is null, resultCode is " + i2 + "(" + GoogleSignInStatusCodes.getStatusCodeString(i2) + ")");
            onSignedIn(13, null);
            return;
        }
        super.onActivityResult(i, i2, intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void onSignedIn(int i, GoogleSignInAccount googleSignInAccount) {
        TokenRequest tokenRequest;
        synchronized (lock) {
            tokenRequest = pendingTokenRequest;
            pendingTokenRequest = null;
        }
        if (tokenRequest != null) {
            if (googleSignInAccount != null) {
                tokenRequest.setAuthCode(googleSignInAccount.getServerAuthCode());
                tokenRequest.setEmail(googleSignInAccount.getEmail());
                tokenRequest.setIdToken(googleSignInAccount.getIdToken());
            }
            if (i != 0) {
                Log.e(TAG, "Setting result error status code to: " + i);
            }
            tokenRequest.setResult(i);
        }
    }

    @Override // android.app.Fragment
    public void onResume() {
        Log.d(TAG, "onResume called");
        super.onResume();
        if (helperFragment == null) {
            helperFragment = this;
        }
        processRequest();
    }

    private static class TokenRequest {
        private String accountName;
        private boolean doAuthCode;
        private boolean doEmail;
        private boolean doIdToken;
        private boolean forceRefresh;
        private boolean hidePopups;
        private TokenPendingResult pendingResponse = new TokenPendingResult();
        private Scope[] scopes;
        private boolean silent;
        private String webClientId;

        public TokenRequest(boolean z, boolean z2, boolean z3, boolean z4, String str, boolean z5, String[] strArr, boolean z6, String str2) {
            this.silent = z;
            this.doAuthCode = z2;
            this.doEmail = z3;
            this.doIdToken = z4;
            this.webClientId = str;
            this.forceRefresh = z5;
            if (strArr != null && strArr.length > 0) {
                this.scopes = new Scope[strArr.length];
                for (int i = 0; i < strArr.length; i++) {
                    this.scopes[i] = new Scope(strArr[i]);
                }
            } else {
                this.scopes = null;
            }
            this.hidePopups = z6;
            this.accountName = str2;
        }

        public boolean canReuseAccount() {
            return (this.doAuthCode || this.doIdToken) ? false : true;
        }

        public PendingResult<TokenResult> getPendingResponse() {
            return this.pendingResponse;
        }

        public boolean getSilent() {
            return this.silent;
        }

        public void setResult(int i) {
            this.pendingResponse.setStatus(i);
        }

        public void setEmail(String str) {
            this.pendingResponse.setEmail(str);
        }

        public void cancel() {
            this.pendingResponse.cancel();
        }

        public void setAuthCode(String str) {
            this.pendingResponse.setAuthCode(str);
        }

        public void setIdToken(String str) {
            this.pendingResponse.setIdToken(str);
        }

        public String getEmail() {
            return this.pendingResponse.result.getEmail();
        }

        public String getIdToken() {
            return this.pendingResponse.result.getIdToken();
        }

        public String getAuthCode() {
            return this.pendingResponse.result.getAuthCode();
        }

        public String toString() {
            return Integer.toHexString(hashCode()) + " (a:" + this.doAuthCode + " e:" + this.doEmail + " i:" + this.doIdToken + " wc: " + this.webClientId + " f: " + this.forceRefresh + ")";
        }

        public String getWebClientId() {
            return this.webClientId == null ? "" : this.webClientId;
        }

        public boolean getForceRefresh() {
            return this.forceRefresh;
        }
    }

    public static boolean checkGooglePlayServicesAvailable() {
        GooglePlayServicesUtil.isGooglePlayServicesAvailable(null);
        return false;
    }

    public static View createInvisibleView(Activity activity) {
        View view = new View(activity);
        view.setVisibility(4);
        view.setClickable(false);
        return view;
    }
}
