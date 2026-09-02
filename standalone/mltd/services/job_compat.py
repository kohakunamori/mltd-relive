"""Compatibility handlers for interrupted JobService flows.

The zh client exposes two parameterless recovery RPCs in addition to the
normal StartJob/FinishJob pair:

* ``BreakJob`` is invoked by ``RestartCheckView`` when the client starts
  with a job that was interrupted before FinishJob.
* ``CancelJob`` returns only ``is_event_tour``.  Standalone currently does
  not implement event-tour jobs, so the value is always false.

StartJob consumes vitality immediately.  Normal jobs cannot be retired in
the client, therefore recovery cleanup must not refund vitality or rewind the
natural-recovery clock: doing so would allow vitality duplication by killing
the client after StartJob.
"""
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import PendingJob


def _clear_pending_job(user_id):
    """Delete an interrupted pending job and its answer rows atomically.

    ``PendingJob.pending_job_answers`` is configured with
    ``cascade='all, delete-orphan'``, so ORM deletion also removes any
    challenge/chance answer rows.  Repeated cleanup is intentionally
    idempotent.
    """
    with Session(engine) as session:
        pending_job = session.scalar(
            select(PendingJob).where(PendingJob.user_id == user_id)
        )
        if pending_job is not None:
            session.delete(pending_job)
            session.commit()
            return True
    return False


@dispatcher.add_method(name='JobService.BreakJob', context_arg='context')
def break_job(params, context):
    """Discard a job left pending after an interrupted client session."""
    _clear_pending_job(UUID(context['user_id']))
    return {}


@dispatcher.add_method(name='JobService.CancelJob', context_arg='context')
def cancel_job(params, context):
    """Discard the current job without refunding already-consumed vitality.

    Event-tour jobs are unsupported by the standalone server, matching the
    existing StartJob constraint that ``is_event_tour`` must be false.
    """
    _clear_pending_job(UUID(context['user_id']))
    return {'is_event_tour': False}
