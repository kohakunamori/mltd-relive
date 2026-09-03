# Server Compatibility Agent Handoff

> Repository: `kohakunamori/mltd-relive`  
> Working branch: `fix/story-service-compat`  
> Base branch: `main`  
> Base `main` SHA at this handoff: `c47e1035eb0dfc2acf8ff1e32054cbc550bbae59`  
> Pre-handoff working HEAD: `74471ad405a8d2c0eccbe1eb2c2f48307abf3aae` (`ci: resolve gift item mechanics`)  
> Recorded: 2026-09-03

This file is the authoritative handoff for the current standalone-server compatibility pass. Read it before doing new reverse-engineering or implementation work.

## 1. Goal and working rules

The current task is to make the standalone server behave correctly for the preserved/fixed Traditional Chinese MLTD client, prioritizing real playable offline flows rather than maximizing a raw RPC-count metric.

Use evidence in this order:

1. Reverse-engineered client contracts and call sites from `client-decompiled-zh-fixed-v1`.
2. Existing standalone master data, SQLAlchemy models, schemas, and preserved save state.
3. Existing working server implementations and runtime behavior.
4. Only then infer missing semantics, and mark any intentional compatibility fallback explicitly.

Do **not** invent DTO fields, persistence semantics, rewards, or fake handlers just to remove `-32601` errors. If the client contains a constant but no active call site, that is not sufficient evidence to implement it.

Before asking the user for information, inspect the repository, reverse artifacts, CI logs, existing database models, and current workflows. Only involve the user when device/runtime observations or permissions are genuinely required.

## 2. Stable baseline before this compatibility branch

The last stable user-device-tested release is:

- Tag: `standalone-v0.1.10`
- Release: `mltd-relive-standalone-v0.1.10`
- Release ID: `381069337`
- Merge SHA: `e27b99e5852bf1532d4dfc1514d304dd45404dc0`
- Release-trigger commit: `58a7f8fb7353ecfad99cfadf1599348e59273239`

The user already verified login, Live, API operation, and HTTP/1.1 keep-alive behavior on a real client/device against that baseline.

Relevant v0.1.10 architecture:

```text
API:
client
  -> local listener-wrapped TLS
  -> threaded direct WSGI
  -> HTTP/1.1 keep-alive

Asset:
client
  -> remote HTTPS Asset URL
  -> Rainbow R2 default / configurable Asset Remote URL
```

There is no runtime local/hybrid Asset relay in that released architecture.

## 3. Reverse-engineered client source of truth

The full IL2CPP reverse snapshot for the fixed zh client is on orphan branch:

`client-decompiled-zh-fixed-v1`

Important files:

- `il2cpp-dump/dump.cs`
- `il2cpp-dump/script.json`
- `report/server-contract-diff.md`
- `report/client-rpc-surface.json`
- `report/il2cpp-dump-relevant-hits.txt`

Use these to establish exact argument/reply DTOs and, where possible, actual call sites. Do not substitute assumptions based on current Japanese-client behavior unless the preserved zh client does not contain enough evidence.

## 4. Current branch scope

At the pre-handoff snapshot this branch is 101 commits ahead of `main` and 0 behind. Major compatibility modules added or expanded include:

- `standalone/mltd/services/story.py`
- `standalone/mltd/services/story_legacy.py`
- `standalone/mltd/services/client_compat.py`
- `standalone/mltd/services/mission_client.py`
- `standalone/mltd/services/theater_compat.py`
- `standalone/mltd/services/user_profile.py`
- `standalone/mltd/services/user_rank.py`
- `standalone/mltd/services/user_vitality.py`
- `standalone/mltd/services/system_setting.py`
- `standalone/mltd/services/friend.py`
- `standalone/mltd/services/friend_core.py`
- `standalone/mltd/services/friend_recommend.py`
- `standalone/mltd/services/job_compat.py`
- `standalone/mltd/services/offline_content_compat.py`
- `standalone/mltd/services/__init__.py`

Runtime/contract tests were added under `tests/`, and targeted GitHub Actions workflows were added under `.github/workflows/`.

## 5. Completed or substantially completed areas

### StoryService

Reverse-engineered missing active RPCs have been implemented:

- `StoryService.PlayStoryMV`
- `StoryService.FinishCostumeAdv`
- `StoryService.FinishEpisode`
- `StoryService.FinishMainStory`
- `StoryService.FinishMemorial`
- `StoryService.FinishOfferStory`
- `StoryService.FinishSpecialStory`

Existing Story GET handlers remain supported.

Important semantics:

- Story completion is idempotent. Existing/default saves initialize many stories as already read; replay must still return a valid reply and must not duplicate rewards.
- Rewards are granted from existing `MstRewardItem` relationships where preserved data exists.
- Main-story completion can unlock the next story state, unlock a reward song, and update relevant missions.
- Episode completion can update the matching client mission.
- `FinishOfferStory` is intentionally a compatibility no-op returning an empty reward list because this standalone database has no preserved offer-story master/state model.
- `PlayStoryMV` legitimately returns `{}`.

Tests:

- `tests/test_story_service_compat.py`
- `tests/test_story_service_runtime.py`
- `.github/workflows/test-story-service.yml`

### Client mission compatibility

Important client-side mission flows have been implemented in `mission_client.py`, including previously missing/unsafe Training/anniversary mission handling. Reward behavior was fixed where the old server could crash while processing client mission rewards.

Tests/workflows:

- `tests/test_client_mission_runtime.py`
- `.github/workflows/test-client-mission-rpc.yml`
- `.github/workflows/audit-client-mission-mapping.yml`

### Theater compatibility

`FinishTheaterOpening` has an explicit compatibility path and returns a client-safe no-opening state when preserved data cannot provide a richer result.

Tests:

- `tests/test_theater_opening_compat.py`

### User profile

Implemented/persisted profile-facing flows including:

- `GetProfile`
- `SetSelfProfile`
- `SetAchievementList`
- helper/favorite/achievement state required by the client
- relevant profile mission progression, including mission class 27 handling

Tests/workflow:

- `tests/test_user_profile_runtime.py`
- `.github/workflows/test-user-profile-rpc.yml`

### Producer rank

`GetProducerRankList` is implemented against existing fan thresholds and preserved reward/master data.

Tests/workflow:

- `tests/test_user_rank_runtime.py`
- `.github/workflows/test-user-rank-rpc.yml`

### Vitality recovery

Implemented in `user_vitality.py`:

- `UserService.RecoverVitalityByItem`
- `UserService.RecoverVitalityByItemMulti`
- `UserService.RecoverVitalityByJewel`

Important semantics already resolved:

- Recovery-item amount derives from master `value1` plus percentage `value2` semantics.
- Recovery items must be the vitality-recovery item type.
- Multi-item consumption is validated before mutation and applied atomically.
- Vitality overflow is capped at `2 * max_vitality`.
- Natural recovery timing is adjusted/stopped correctly when crossing the normal vitality cap.
- Jewel recovery uses the configured `MstGameSetting` availability window/cost.
- General jewel consumption uses free jewels first, then paid jewels.
- Surplus vitality is not converted into live tickets in this preserved-era behavior.

Tests/workflow:

- `tests/test_user_vitality_runtime.py`
- `.github/workflows/test-user-vitality-rpc.yml`

### System settings

`SetSystemSetting` has a real persistent implementation, including LessonWear-related configuration needed by the client.

Tests/workflow:

- `tests/test_system_setting_runtime.py`
- `.github/workflows/test-system-setting-rpc.yml`

### Friend system

Core friend state transitions now have persistent implementations rather than shallow compatibility stubs:

- recommendation/list paths
- friend requests
- received requests
- accept
- delete

Flower-stand handling was also corrected where the pre-existing reply shape did not match the client DTO. Comment-list access is client-safe.

Do **not** implement `SendComment` as an ephemeral success response. There is currently no suitable persistent comment table in the preserved database. A correct implementation requires a model/schema/database-upgrade path so that a sent comment remains present after refresh/restart.

Tests/workflows:

- `tests/test_friend_core_runtime.py`
- `tests/test_friend_recommend_runtime.py`
- `.github/workflows/test-friend-core-rpc.yml`
- `.github/workflows/test-friend-recommend-rpc.yml`

### Offline/no-data content paths

Several content screens that legitimately have no preserved standalone data now return exact client-safe empty DTO structures instead of failing with `-32601` or malformed shapes. This includes Navi/Drama/Blog/Mail/PresentHistory-related compatibility surfaces where applicable.

Files/tests:

- `standalone/mltd/services/offline_content_compat.py`
- `tests/test_offline_content_compat.py`
- `.github/workflows/test-offline-content-compat.yml`

### Client logging

`LiveService.PostLog` is accepted so the client can post log data without breaking an otherwise valid flow.

### Interrupted Job recovery

Implemented in `standalone/mltd/services/job_compat.py`:

- `JobService.BreakJob`
- `JobService.CancelJob`

Resolved behavior:

- `StartJob` already consumes vitality.
- If the client is killed/interrupted before normal `FinishJob`, restart recovery uses `BreakJob` to discard the pending job.
- `BreakJob` deletes `PendingJob` and its orphan child answer rows atomically.
- `CancelJob` performs the same cleanup for the supported non-event-tour path.
- **Do not refund vitality and do not rewind `full_recover_date`.** Refunding would make it possible to duplicate vitality by repeatedly killing the client after `StartJob`.
- Repeated cleanup is intentionally idempotent.
- `BreakJob` returns `{}`.
- `CancelJob` returns `{'is_event_tour': False}` because standalone event-tour jobs are unsupported.

Verified GitHub Actions run:

- Workflow: `Test interrupted job RPC compatibility`
- Run ID: `33636865667`
- Result: `success`

## 6. CostumeService conclusion — do not undo without new evidence

The client contains string constants for:

- `CostumeService.GetCostumeList`
- `CostumeService.SetCostume`

However, the currently traced active clothing flow uses:

```text
IdolService.GetIdolList
  -> having_costume_list / costume_list

UnitService.SetUnit
  -> UnitIdol.mst_costume_id

UnitService.SetSongUnit
  -> SongUnitIdol.mst_costume_id
```

No convincing active `HTTPRequest` call path for the two standalone `CostumeService` constants was established. Treat them as likely legacy/unused unless new reverse evidence shows otherwise. Do not add fake handlers merely to improve RPC coverage statistics.

## 7. Current active audit / next targets

The most recent audit commit before this document was:

`74471ad405a8d2c0eccbe1eb2c2f48307abf3aae` — `ci: resolve gift item mechanics`

Latest known audit workflow:

- Workflow: `Audit next active RPC contracts`
- Run ID: `33637743268`
- Result: `success`

The next compatibility cluster to finish is:

1. `ItemService.UseItem`
2. `BirthdayService.ExecuteBirthdayPresent`
3. `IdolService.SetFavoriteCostume`
4. `IdolService.GetSalesCostumeList`
5. `PresentService.GetPresentHistory`

For each target, first correlate exact client DTO + call site + existing server model/master support.

### ItemService.UseItem

Determine which item classes actually route through `UseItem`. Vitality recovery already has dedicated `RecoverVitalityByItem` and `RecoverVitalityByItemMulti` paths; do not create a second consumption path that double-spends or produces contradictory semantics. Verify reply fields and effects from the reversed client and master data before implementation.

### BirthdayService.ExecuteBirthdayPresent

A `Birthday.is_executed`-style persistent state exists, but the exact gift/reward/result-idol behavior still needs to be closed from client contracts and master data. Do not invent reward amounts or fabricate `ResultIdol` data.

### IdolService.SetFavoriteCostume / GetSalesCostumeList

These are more plausible active costume-facing surfaces than the legacy-looking `CostumeService.*` constants. Trace the UI/call sites and map them to existing idol/costume ownership models before implementing.

### PresentService.GetPresentHistory

An empty compatibility reply may be correct if there is no preserved present ledger, but verify the exact client contract/call site first. Do not add persistent history data unless there is a real source/model for it.

## 8. Known intentional gaps / risks

- `FriendService.SendComment`: no persistent comment model yet. Correct implementation requires DB schema plus upgrade/migration support for existing v0.1.10 saves.
- Offer-story completion: no preserved offer-story model; currently an intentional empty-reward compatibility path.
- Event-tour Job behavior: unsupported; `CancelJob.is_event_tour` remains false.
- Legacy-looking `CostumeService.*`: intentionally not implemented without active call evidence.
- Many event, shop/payment, Lounge, historical-event, and other EoS-era RPCs remain outside the current core-playable compatibility pass.
- Old RPC coverage numbers quoted during earlier work are stale. Re-run the current coverage audit from the final branch HEAD before making any coverage claim.

## 9. CI and verification policy

Do not treat import tests or AST-only contract tests as sufficient for persistent RPCs. Prefer runtime SQLAlchemy/SQLite tests that exercise actual state transitions, replay/idempotence, invalid input, and reply shapes.

Before handing a build to the user:

1. Re-run the targeted runtime workflows for every touched module.
2. Run the current RPC coverage/audit workflows from the final HEAD.
3. Resolve failures rather than disabling checks.
4. Build a **new** Ubuntu standalone GUI test artifact from the final branch HEAD. Older StoryService test packages are stale and should not be used for final smoke testing.

## 10. Required real-device smoke before merge/release

The next useful user-device smoke should cover at least:

1. Login/title flow.
2. Live flow.
3. Story completion and repeated/replayed completion.
4. Profile modification/persistence.
5. Vitality recovery by recovery item and jewel.
6. Friend request -> accept -> delete.
7. Flower-stand and friend-comment screens.
8. Normal Job completion.
9. Start Job -> kill/interruption -> restart -> recovery cleanup.
10. Costume/Unit/SongUnit save and reload behavior.
11. Any newly implemented Item/Birthday/FavoriteCostume/SalesCostume flow reachable from the UI.

Only after runtime CI and this device smoke give confidence should this branch be proposed for final merge to `main` and a new standalone release.

## 11. Guardrails for the next agent

- Continue on `fix/story-service-compat`; do not restart the work on a fresh branch unless there is a concrete repository reason.
- Fetch the branch HEAD before making assumptions; this document records a snapshot, not an immutable SHA.
- Read the reverse branch rather than repeating broad external research.
- Preserve exact client reply shapes.
- Preserve Story completion idempotence.
- Never refund vitality from `BreakJob`/`CancelJob`.
- Do not fake persistent social data.
- Do not implement unused-looking RPC constants merely for coverage.
- Do not merge/release before runtime CI plus user device smoke.
- Keep this handoff file updated when major conclusions, new implementations, or new blocking risks are established.

## 12. Recommended immediate execution order

1. Fetch latest `fix/story-service-compat` HEAD and read this file completely.
2. Inspect the latest audit workflow/commit and the reverse client contracts for the five targets in section 7.
3. Implement the highest-confidence active RPC first, with persistent behavior where the database supports it.
4. Add a focused runtime test and targeted workflow for that behavior.
5. Continue target-by-target without pausing for user confirmation unless device evidence is genuinely required.
6. Re-run current whole-branch audits once the target cluster is closed.
7. Build a fresh standalone GUI artifact and ask the user only for the device smoke that cannot be simulated in CI.
8. Update this document before the next handoff.

## 13. Final pre-device acceptance checkpoint (2026-09-03)

The five-RPC closeout cluster from section 7 is resolved:

- `ItemService.UseItem`: intentionally not registered. Reverse audit found the API constant/wrapper/DTO but no active UI/business request callsite. Gift flows use `UseGiftForCard` / `UseGiftForIdolGift`; vitality items use `RecoverVitalityByItem*`.
- `BirthdayService.ExecuteBirthdayPresent`: implemented with persistent, replay-safe semantics using preserved birthday/master data. IDs are validated, reward data comes from `MstBirthdayPresent`, execution state and supported idol-affection/result state are updated atomically, and overflow rewards are not silently lost.
- `IdolService.SetFavoriteCostume`: implemented as persistent ordered per-user-idol state. Ownership/idol membership is validated before atomic replacement; clear/replay are supported; `IdolSchema.favorite_costume_list` reflects saved state; old saves get the additive table through idempotent `checkfirst` creation.
- `IdolService.GetSalesCostumeList`: exact empty-list compatibility is intentional because the preserved database lacks the sales catalogue/price/prerequisite data required for truthful `SalesCostumeStatus` rows.
- `PresentService.GetPresentHistory`: exact empty-history compatibility remains intentional because the preserved database has no historical present ledger.

### Automated acceptance

Acceptance workflow run `33663584900` tested commit `60d852b7286995707a013d29ba3c99a099761136` and all three jobs succeeded:

1. Full standalone runtime suite: fresh SQLite database via normal `mltd.models.setup`; **80 tests passed**. This includes SQLAlchemy state tests for Birthday, FavoriteCostume, Story, Friend, interrupted Job recovery, Profile, Producer Rank, System Setting, Vitality, offline-content fallbacks, Unit compatibility, API transport, and related regressions.
2. Current client/server RPC audit: success. Raw IL2CPP surface is 309 RPC constants; current server registers 111 handlers; 198 names are unmatched string surfaces. This is not an active-RPC backlog: it includes event, shop/payment, Lounge, historical/minigame, legacy and dead surfaces. For the five closeout targets, Birthday/FavoriteCostume/SalesCostume/PresentHistory are registered and `ItemService.UseItem` is deliberately not registered.
3. Ubuntu standalone GUI: PyInstaller build, executable check and artifact upload succeeded. Artifact ID `9859679800`; executable SHA-256 `3bd32fa4e7c3df84fa80fd725c05a618a252f71958f3eae75aedf76c93128962`.

A non-fatal SQLAlchemy 2.0 deprecation warning remains in legacy `job.py` for `Row.tuple()`; it did not affect the 80-test acceptance run.

### Remaining gate

Server-side/reverse-engineering acceptance is complete. The only required gate before PR/merge/release is the centralized real-device smoke in section 10. Do not merge to `main` and do not create a new standalone release until that device smoke passes.

Post-acceptance commits may remove temporary CI helpers or update this handoff without changing runtime semantics. Always fetch actual branch HEAD and distinguish docs/CI-only movement from runtime changes.

## 14. Real-device vitality multi regression (2026-09-03)

Real-device smoke exposed a protocol mismatch in `UserService.RecoverVitalityByItemMulti`.

Observed device failure:

- `LookupError: item not found`
- failure path: `recover_vitality_by_item_multi -> _get_owned_item`

Root cause was confirmed against `client-decompiled-zh-fixed-v1` rather than inferred from the exception:

- `RecoverVitalityByItemArgs` (single-item RPC) contains `string item_id`.
- `RecoverVitalityByItemMultiArgs` contains `ItemAmount[] item_amount_list`.
- `ItemAmount` contains exactly `int mst_item_id`, `int item_type`, `int amount`.
- The old standalone multi implementation/tests incorrectly used inventory-row `Item.item_id` for each multi entry. The real client sends master IDs so a normal device request could not resolve the owned row and raised `item not found`.

Fix:

- Single-item recovery continues to resolve the wire `item_id`, unchanged.
- Multi recovery now resolves inventory by `(user_id, mst_item_id)`.
- The redundant wire `item_type` is validated against `MstItem.item_type`.
- Duplicate master IDs, non-positive amounts, wrong item types, missing ownership, and insufficient inventory are rejected before any mutation so the batch remains atomic.
- Runtime coverage now sends the exact real-client `ItemAmount` wire shape. It also covers item-type mismatch, the formerly-assumed wrong `item_id` DTO shape, persisted deductions, reply `ItemStatus` shape, and rollback.

Verification:

- Targeted workflow `Test user vitality RPC compatibility`, run `33716679545` has passed on fix/test HEAD `24e9ee29638669fecf1b825eb154cef55337c22a`.
- A fresh full acceptance and Ubuntu GUI build must be run from the post-cleanup final HEAD before asking the user to retry the device smoke.
