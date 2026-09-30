"""Compatibility handlers for theater RPCs backed by no preserved master data.

The corrected Traditional Chinese client exposes
``TheaterService.FinishTheaterOpening`` as an active request.  Its reply
contains exactly one ``TheaterOpeningStatus``.  The preserved server does not
ship a theater-opening master table and ``TheaterService.GetTheater`` already
represents the no-opening state with an all-zero status.  Reuse that wire
shape here instead of inventing opening content.
"""

from jsonrpc import dispatcher


def empty_theater_opening_status():
    """Return the client-compatible no-opening TheaterOpeningStatus."""
    return {
        'mst_theater_opening_id': 0,
        'opening_type': 0,
        'resource_id': '',
        'jump_type': '',
        'cue_sheet': '',
        'cue_name': '',
        'mv_status': {
            'mst_song_id': 0,
            'mv_unit_idol_list': None,
        },
    }


@dispatcher.add_method(name='TheaterService.FinishTheaterOpening')
def finish_theater_opening(params):
    """Finish a theater opening and return the next opening state.

    No theater-opening master/state data is present in the preserved database,
    and GetTheater currently never advertises a non-zero opening.  Returning
    the canonical no-opening state is therefore the only state-consistent
    reply for this server snapshot.
    """
    # Read the field when supplied so malformed call sites are distinguishable
    # during debugging, but there is intentionally no synthetic state change.
    params.get('mst_theater_opening_id', 0)
    return {'theater_opening': empty_theater_opening_status()}
