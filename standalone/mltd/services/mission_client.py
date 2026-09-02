from datetime import datetime, timezone
from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Mission, MstMission, Present, User
from mltd.models.schemas import MissionSchema
from mltd.services.utils import add_present


# These option families are emitted by the client for second-anniversary
# training missions. They map uniquely with option2 (idol ID) to mission
# classes 74/75 in mst_mission.csv.
_SUPPORTED_OPTIONS = {'dress', 'mobile', 'thirteen', '25,26'}
_SUPPORTED_CLASSES = {74, 75}


def _empty_mission_process():
    return {
        'complete_mission_list': [],
        'open_mission_list': [],
        'training_point_diff': {
            'before': 0,
            'after': 0,
            'total': 0,
        },
    }


def _grant_training_mission_rewards(session, user, mst_mission):
    """Grant the item rewards used by client-managed training missions.

    All class 74/75 rows in the bundled master data have exactly one item
    reward (the corresponding idol-specific anniversary item). Keep this
    validation explicit so a future master-data change cannot silently grant a
    reward with semantics this compatibility path does not implement.
    """
    rewards = mst_mission.mst_mission_rewards
    if len(rewards) != 1:
        raise RuntimeError(
            f'unexpected client mission reward count: {mst_mission.mst_mission_id}'
        )

    reward = rewards[0]
    if (not reward.mst_item_id
            or reward.mst_achievement_id
            or reward.mst_song_id):
        raise RuntimeError(
            f'unsupported client mission reward: {mst_mission.mst_mission_id}'
        )

    add_present(
        session=session,
        user=user,
        present=Present(
            user_id=user.user_id,
            comment='Training mission reward',
            amount=reward.amount,
            item_id=f'{user.user_id}_{reward.mst_item_id}',
        ),
    )


def _complete_client_mission(session, user, mission, progress):
    """Apply one client-reported progress value.

    Returns True only when the mission transitions from in-progress to
    completed. Closed and already-completed missions are intentionally
    idempotent no-ops.
    """
    if mission.mission_state != 1 or progress <= mission.progress:
        return False

    now = datetime.now(timezone.utc)
    mission.update_date = now
    mission.progress = progress
    if mission.progress < mission.mst_mission.goal:
        return False

    mission.finish_date = now
    mission.mission_state = 3
    _grant_training_mission_rewards(session, user, mission.mst_mission)

    next_missions = session.scalars(
        select(Mission)
        .join(MstMission)
        .where(Mission.user_id == user.user_id)
        .where(
            MstMission.premise_mst_mission_id_list
            == mission.mst_mission_id
        )
        .where(Mission.mission_state == 0)
    ).all()
    for next_mission in next_missions:
        next_mission.mission_state = 1

    return True


@dispatcher.add_method(
    name='MissionService.DoClientMission', context_arg='context'
)
def do_client_mission(params, context):
    """Process client-managed training mission progress.

    The client identifies these missions by ``option`` + ``option2`` rather
    than a mission ID. Only the four option families verified in the client
    and bundled master data are accepted. Unknown/stale reports are safe
    no-ops, which matches the nature of client-side mission checks.
    """
    user_id = UUID(context['user_id'])
    client_missions = params['client_mission_list']
    if not isinstance(client_missions, list):
        raise TypeError('client_mission_list must be a list')

    with Session(engine) as session:
        user = session.scalar(select(User).where(User.user_id == user_id))
        if user is None:
            raise RuntimeError('user not found')

        closed_before = set(session.scalars(
            select(Mission.mst_mission_id)
            .where(Mission.user_id == user_id)
            .where(Mission.mission_state == 0)
        ).all())

        completed = []
        for reported in client_missions:
            option = str(reported['option'])
            option2 = str(reported['option2'])
            progress = reported['progress']

            if option not in _SUPPORTED_OPTIONS or not option2:
                continue
            if not isinstance(progress, (int, float)) or progress < 0:
                raise ValueError('client mission progress must be non-negative')

            matches = session.scalars(
                select(Mission)
                .join(Mission.mst_mission)
                .where(Mission.user_id == user_id)
                .where(MstMission.mst_mission_class_id.in_(_SUPPORTED_CLASSES))
                .where(MstMission.option == option)
                .where(MstMission.option2 == option2)
            ).all()

            if not matches:
                continue
            if len(matches) != 1:
                raise RuntimeError(
                    f'ambiguous client mission mapping: {option!r}/{option2!r}'
                )

            mission = matches[0]
            if _complete_client_mission(session, user, mission, progress):
                completed.append(mission)

        opened = []
        if closed_before:
            opened = session.scalars(
                select(Mission)
                .where(Mission.user_id == user_id)
                .where(Mission.mst_mission_id.in_(closed_before))
                .where(Mission.mission_state == 1)
            ).all()

        session.flush()
        schema = MissionSchema()
        mission_process = _empty_mission_process()
        mission_process['complete_mission_list'] = schema.dump(
            completed, many=True
        )
        mission_process['open_mission_list'] = schema.dump(opened, many=True)
        session.commit()

    return {'mission_process': mission_process}
