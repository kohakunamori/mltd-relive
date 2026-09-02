# Live entry failure: UnitService.SetUnit / SQLAlchemy 2.x

> Date: 2026-09-02
> Branch: `fix/live-asset-compat`
> Status: **device-confirmed fixed**

## Device evidence

With `asset_mode = remote`, the corrected Traditional Chinese client successfully logs in and reaches the Live flow, then the server previously logged:

```text
jsonrpc.manager - ERROR - API Exception:
TypeError: 'ChunkedIteratorResult' object is not subscriptable

File "mltd/services/unit.py", line 117, in set_unit
```

This was a direct server-side exception in `UnitService.SetUnit`. It was independent of the hybrid Asset TLS regression.

After applying commit:

```text
351161e8df288fce8ab478953c34701010106ca0
```

the same corrected client was tested again in `asset_mode = remote` and Live now operates normally. This confirms the observed Live-entry failure was caused by the `SetUnit` SQLAlchemy result-conversion bug.

## Root cause

The optimized SetUnit implementation used:

```python
card_to_idol = dict(session.execute(
    select(Card.card_id, MstCard.mst_idol_id)
    ...
))
```

With the pinned SQLAlchemy 2.x API, `Session.execute()` returns a Result object (`ChunkedIteratorResult`/`CursorResult`). Result exposes `keys()`, so Python's `dict()` may interpret it as a Mapping and attempt `result[key]`. SQLAlchemy Result is not subscriptable, producing:

```text
TypeError: 'ChunkedIteratorResult' object is not subscriptable
```

The original yuyu implementation did not have this problem because it explicitly iterated the result rows and filled `card_to_idol` one row at a time.

## Fix

Keep the optimized bounded-query / `selectinload` path, but materialize the two-column rows before constructing the dictionary:

```python
card_rows = session.execute(
    select(Card.card_id, MstCard.mst_idol_id)
    ...
).all()
card_to_idol = dict(card_rows)
```

A regression test using SQLAlchemy 2.0.19 proves both behaviors:

- `dict(result)` raises the same non-subscriptable TypeError.
- `dict(result.all())` succeeds.

CI job: `unit-sqlalchemy`.

## Updated diagnosis

The Live failure observed on 2026-09-02 is now considered **resolved and device-confirmed**.

The earlier API transport hypothesis (`Connection: close`, serialized RPC dispatch, localhost HTTP hop) is no longer considered the root cause of this observed failure. The branch still contains `Connection: close` and serialized API dispatch as compatibility experiments; these should be A/B-tested separately before deciding whether they belong in the final release.

## Remaining work

The active blocker is now the Desktop `hybrid/local` Asset transport:

- v0.1.9 self-signed HTTPS Asset routing is confirmed incompatible;
- v0.1.10 currently tests a dedicated cleartext HTTP `:7651` Asset listener;
- if the corrected APK rejects cleartext Asset traffic, move to a dedicated Asset hostname with a public-CA certificate.
