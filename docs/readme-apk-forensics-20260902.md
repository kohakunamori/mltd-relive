# README APK forensic comparison (2026-09-02)

This report compares all four Android APK links currently documented by `yuyueryuyu/mltd-relive`: Traditional Chinese and Korean, each with a Termux/same-device variant and a Desktop/LAN-DNS variant. The comparison was executed in GitHub Actions run `33604364193` on diagnostic branch `diagnose/login-regression-20260902`.

## APK identity

| Region | Mode | Size (bytes) | SHA-256 |
|---|---|---:|---|
| zh | Termux | 96,352,378 | `d1d33e93e44f4ecdc986512b71ab41e47b9638bc55065e7d34f5e4f7bf840e4b` |
| zh | Desktop | 96,249,978 | `a423f1b09b6d9022cf255aff9a43716d6beadf32d42641da3c7b92d2e663e918` |
| ko | Termux | 91,814,010 | `7712fbf8b1c9effdb99f95b76451460b85ab44badf7483936ada4f38d7970064` |
| ko | Desktop | 91,707,514 | `a0dbd66681f59d4ac5ca9d4bd1cf7aea24e7cd728356342158ded6b871f47e93` |

The current `kohakunamori/mltd-relive` release configuration points at the same Desktop APK URLs and the same Desktop SHA-256 values.

## Package/runtime metadata

All four APKs report:

- `versionCode=21000`
- `versionName=2.1.000`
- `minSdkVersion=19`
- `targetSdkVersion=29`
- `compileSdkVersion=23`
- ABI: `arm64-v8a`
- install location: `preferExternal`

Package IDs are deliberately different by deployment topology:

| Region | Termux | Desktop |
|---|---|---|
| zh | `com.bandainamcoent.imas_millionlive_theaterdays_ch.termux` | `com.bandainamcoent.imas_millionlive_theaterdays_ch.local` |
| ko | `com.bandainamcoent.imas_millionlive_theaterdays_kr.termux` | `com.bandainamcoent.imas_millionlive_theaterdays_kr.local` |

The corresponding `FirebaseInitProvider` and `FileProvider` authorities change only to follow that package ID. Permissions, features, Activity configuration and other manifest behavior are the same. No same-region difference adds `android:usesCleartextTraffic`, `android:networkSecurityConfig`, a trust manager, or an extra network permission.

Application labels are intentionally mode-distinguished:

- zh Desktop: `劇場時光L`
- zh Termux: `劇場時光T`
- ko Desktop: `밀리언 라이브!L`
- ko Termux: `밀리언 라이브!T`

The decoded `res/values/strings.xml` same-region diff contains only this `app_name` L/T change.

## Exact same-region APK payload differences

Each APK contains 205 ZIP entries. Within either region, Termux vs Desktop has:

- 0 added entries
- 0 removed entries
- 25 entries with changed CRC/size
- 3 of those are JAR signature metadata under `META-INF`
- 22 are actual payload differences

The 22 payload differences are exactly:

1. `AndroidManifest.xml`
2. `assets/bin/Data/Managed/Metadata/global-metadata.dat`
3. `resources.arsc`
4. `res/drawable-xxxhdpi/icon_notification_l.png`
5. 18 launcher images: `app_icon.png`, `app_icon_round.png`, and `ic_launcher_foreground.png` across hdpi/ldpi/mdpi/xhdpi/xxhdpi/xxxhdpi.

No other APK payload entry differs within the same region.

In particular, the actual executable/runtime code is byte-identical within each region:

### Traditional Chinese hashes, identical between Termux and Desktop

- `classes.dex`: `2660a104b9d5746d920be6651aff2ed7d2a0834a8dc94b8f0166760e1a90d6df`
- `lib/arm64-v8a/libil2cpp.so`: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- `lib/arm64-v8a/libunity.so`: `af8b49e0ed592fcec99e0f6ebc33e86dfa7647abe9d476c70a199fd53ea03051`

### Korean hashes, identical between Termux and Desktop

- `classes.dex`: `4cd2a18669511ac5b42bcf8c1f23659334ae08e948844725b1d1ab49a4e9165f`
- `lib/arm64-v8a/libil2cpp.so`: `94266a83cc0e33d6ff0956ad35e1676389f0f9494eb9755965004be49a2199b8`
- `lib/arm64-v8a/libunity.so`: `7ae30464782ab7155819f64179505203e1cd6f42b6e51276ea4f6735da54e7d6`

Thus the Termux/Desktop distinction is not implemented by different Java bytecode, different IL2CPP machine code, or a different Unity runtime.

## Network routing difference

The deployment-specific API base is stored in IL2CPP `global-metadata.dat`. Network-string comparison found the same topology substitution in both regions:

| Region | Termux metadata | Desktop metadata |
|---|---|---|
| zh | `http://127.0.0.1:7650/` | `https://theaterdays-zh.appspot.com/` |
| ko | `http://127.0.0.1:7650/` | `https://theaterdays-ko.appspot.com/` |

The same-region network-string scan found no other deployment-specific network endpoint change. `libil2cpp.so` itself is identical, so this is a metadata/string-constant redirection rather than a native-code networking rewrite.

This maps exactly to the two server topologies:

- Termux console mode starts only the plain HTTP API server on port 7650 and marks the server local. No DNS-53 + TLS-443 proxy is required for the game API.
- Desktop GUI mode starts the API server, DNS server and TLS proxy. The client keeps the original Appspot hostname, local DNS redirects it to the PC/LAN server, and the TLS proxy serves the API on port 443.

Important: the upstream yuyu `AssetService.GetAssetVersion` still returns `https://assets.rainbowunicorn7297.com/{language}-{os}/` for both modes. The Termux APK therefore proves that the API can be redirected to localhost HTTP; it does **not** prove that this client variant uses or accepts a localhost HTTP Asset server. The current fork's `http://127.0.0.1:7651/...` local-asset behavior is a later fork-specific addition.

## Resources and icons

The resource table (`resources.arsc`) is the same size within each region and differs by only 7 bytes. Apktool decoding reduces the textual resource difference to the single `app_name` character (`L` versus `T`).

The 19 PNG resources are genuinely different image payloads, not merely metadata changes. The highest-resolution launcher foregrounds are completely different artwork between Termux and Desktop. For a given mode, the icon files are byte-identical between the zh and ko APKs, showing that these images distinguish deployment mode, not language/region.

## Signing

All four APKs successfully verify using APK signing schemes v1, v2 and v3, with one signer. All four expose the same signer certificate/public key:

- DN: `CN=NAMCO BANDAI Games Inc., OU=NAMCO BANDAI Games Inc., O=NAMCO BANDAI Games Inc., L=Shinagawa-ku, ST=Tokyo, C=jp`
- certificate SHA-256: `97a2df3b955591658932ef98db1bb412223b6efcda58c4ada79901036e93d91f`
- public-key SHA-256: `15b8a227d7a52f2432608f2602f96f24be2ffc0aa4d14248c9814007bf312bba`
- RSA 1024-bit

The `META-INF` signature payloads differ because the APK content differs, but signer identity does not.

## Consequences

1. The two same-region APKs are deployment variants of the same 2.1.000 client core, not an old/new client pair.
2. Termux-specific behavior is primarily the API-base substitution to `http://127.0.0.1:7650/`, plus a separate package ID/label/icon so it is distinguishable/installable separately.
3. Desktop-specific behavior preserves the Appspot HTTPS API hostname and therefore relies on LAN DNS interception + local TLS proxy.
4. There is no evidence of a Termux-only Java/native TLS bypass: Java DEX, IL2CPP machine code and Unity runtime are identical within a region, and there is no Termux-only network-security manifest setting.
5. The README's Android-12L-corrected Desktop APK is not carrying a Desktop-only native/runtime correction relative to the Termux APK: both modes share the same executable runtime files. To identify exactly what was changed from the original EoS APK for Android 12L compatibility, the untouched original 2.1.000 APK must be added as a third baseline.
6. Because package IDs differ (`.termux` vs `.local`), Android treats the variants as separate applications with separate app sandboxes/caches even though their signer identity is the same.
