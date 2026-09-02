# Live entry failure: UnitService.SetUnit / SQLAlchemy 2.x

> Date: 2026-09-02
> Branch: `fix/live-asset-compat`

## Device evidence

With `asset_mode = remote`, the corrected Traditional Chinese client successfully logs in and reaches the Live flow, then the server logs:

```text
jsonrpc.manager - ERROR - API Exception:
TypeError: 'ChunkedIteratorResult' object is not subscriptable

File "mltd/services/unit.py", line 117, in set_unit
```

This is a direct server-side exception in `UnitService.SetUnit`. It is independent of the hybrid Asset TLS regression.

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

Fix commit:

```text
351161e8df288fce8ab478953c34701010106ca0
```

A regression test using SQLAlchemy 2.0.19 now proves both behaviors:

- `dict(result)` raises the same non-subscriptable TypeError.
- `dict(result.all())` succeeds.

CI job: `unit-sqlalchemy`.

## Updated Live diagnosis

This exception is now the primary known cause of the currently observed failure while entering/configuring a Live performance.

The earlier API transport hypothesis (`Connection: close`, serialized RPC dispatch, localhost HTTP hop) is downgraded to a secondary compatibility question. The branch still contains the connection-close/serialization experiment for the next device test, but those changes should not be considered proven necessary until a full Live start/finish cycle succeeds and is A/B-tested without them.

## Next device test

Use `asset_mode = remote` first and verify:

1. enter Live;
2. unit confirmation / SetUnit completes without JSON-RPC exception;
3. guest selection;
4. StartSong;
5. normal song completion / FinishSong;
6. return to song selection.

If a new exception appears, use that exact RPC traceback as the next root cause rather than returning to Asset/TLS speculation.
