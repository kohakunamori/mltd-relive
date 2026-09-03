# Reverse-engineered Android client acceptance

Recorded: 2026-09-03

This document records the client-side acceptance layer used together with the standalone server compatibility gate.

## Acceptance source

Use `client-decompiled-zh-fixed-v1` as the executable acceptance-client source. It is the complete generated Apktool/JADX/IL2CPP tree of the known historical working `zh-fixed` client.

Do not substitute `client-zh-fixed-reconstruction` for this purpose yet. That branch is the independent reconstruction from the official 2.1.000/AppGuard-protected client and remains a separate, incomplete reverse-engineering effort.

## Automated gate

Workflow: `.github/workflows/reverse-client-acceptance.yml`.

The workflow:

1. sparse-checks out the authoritative `apktool/` tree, IL2CPP `dump.cs`, and recorded rebuild metadata from `client-decompiled-zh-fixed-v1`;
2. verifies the historical rebuild baseline uses Apktool `2.12.1` and records rebuild exit code `0`;
3. rebuilds the Android package from the Apktool tree;
4. zipaligns it and signs it with an ephemeral CI-only test key;
5. verifies the resulting APK signature;
6. verifies package `com.bandainamcoent.imas_millionlive_theaterdays_ch.local` and version `2.1.000`;
7. verifies the rebuilt APK still contains the exact historical fixed payloads:
   - `lib/arm64-v8a/libil2cpp.so` SHA-256 `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`;
   - `assets/bin/Data/Managed/Metadata/global-metadata.dat` SHA-256 `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`;
8. verifies reverse-client markers for `AuthService.TransferPassword`, `AuthService.Login`, `UserService.RecoverVitalityByItemMulti`, Birthday, FavoriteCostume, SalesCostume and PresentHistory against the server handlers;
9. fails if `ItemService.UseItem` becomes registered, preserving the prior audited conclusion that this constant has no proven active UI/business callsite.

## First successful rebuild

Workflow run: `33727172810`  
Server HEAD: `6ac273f1ab258e215957ebd0df099126c9443b39`  
Client source branch HEAD used by checkout: `214b8c7d6c3db2b99087931ea4db88c2f9d21d04`  
Artifact ID: `9882417625`

The rebuilt signed APK passed all checks with:

- package: `com.bandainamcoent.imas_millionlive_theaterdays_ch.local`
- version: `2.1.000`
- rebuilt signed APK SHA-256: `284f678fba67879cb5a0c27b91f4ebdec5fe83e2b4c3b47b97a14cbe6442649c`
- fixed `libil2cpp.so` SHA-256: `52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b`
- fixed `global-metadata.dat` SHA-256: `0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0`

The whole rebuilt APK is not expected to reproduce the historical APK hash because Apktool repackaging and the CI test signature are new. The preserved native/metadata hashes are the important invariant.

## Hosted ARM64 runtime probe

The workflow also probes `ubuntu-24.04-arm` rather than assuming an ARM64 runner can execute Android faithfully.

Observed:

- architecture: native `aarch64`;
- Docker: available;
- `/dev/kvm`: absent.

Therefore the GitHub-hosted ARM64 runner is not accepted as a trustworthy Android-emulator runtime gate. Do not claim the game client has been dynamically launched in CI merely because the runner itself is ARM64.

## Same-HEAD final acceptance

`reverse-client-acceptance.yml` is coupled to `.github/workflows/final-standalone-acceptance.yml`. The final pre-device checkpoint must therefore produce both:

- the Ubuntu standalone server GUI artifact; and
- the rebuilt installable reverse-client APK

from the exact same `feature/multi-user-accounts` commit.

## Remaining real-device gate

Use the CI-rebuilt reverse-client APK for the final ARM64 Android smoke, not a separately sourced historical APK.

Minimum checks:

1. APK installs and launches on ARM64 Android.
2. Password transfer with `MLTD0000 / relive2026` reaches the original full-save Home state.
3. A separately registered account transfers/logs in and has an independent save.
4. Correct username plus wrong password is rejected.
5. Login/title, Live, Story finish/replay, Profile, vitality recovery, Friend flows, normal/interrupted Job recovery and Costume/Unit/SongUnit remain usable.
6. Explicitly exercise the real-client `RecoverVitalityByItemMulti` path that previously exposed the `mst_item_id` wire-contract bug.
7. Exercise Birthday/FavoriteCostume surfaces when reachable from the UI.

PR/merge/release remains blocked until this real Android execution passes.
