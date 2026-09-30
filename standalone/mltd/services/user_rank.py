from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import MstRewardItem, User
from mltd.models.schemas import MstRewardItemSchema


# These are the same thresholds used by JobService.FinishJob when advancing
# producer rank.  Index is the producer-rank ID returned to the client.
_PRODUCER_RANK_FAN = (
    0,
    1_000,
    10_000,
    50_000,
    100_000,
    300_000,
    500_000,
    1_000_000,
)

# Rank 1 has no reward. Ranks E..A give 50 jewels, S gives 100, SS gives 150.
_PRODUCER_RANK_REWARD_ID = (0, 3, 3, 3, 3, 3, 14, 15)


@dispatcher.add_method(
    name='UserService.GetProducerRankList', context_arg='context'
)
def get_producer_rank_list(params, context):
    """Return the producer-rank progression table for the current user."""
    user_id = UUID(context['user_id'])

    with Session(engine) as session:
        user = session.scalar(
            select(User).where(User.user_id == user_id)
        )
        if user is None:
            raise RuntimeError('user not found')

        reward_ids = sorted(set(_PRODUCER_RANK_REWARD_ID))
        rewards = session.scalars(
            select(MstRewardItem)
            .where(MstRewardItem.mst_reward_item_id.in_(reward_ids))
        ).all()
        rewards_by_id = {
            reward.mst_reward_item_id: reward for reward in rewards
        }
        missing = [
            reward_id for reward_id in reward_ids
            if reward_id not in rewards_by_id
        ]
        if missing:
            raise RuntimeError(
                f'missing producer rank reward master data: {missing}'
            )

        reward_schema = MstRewardItemSchema()
        rank_list = []
        for index, (fan, reward_id) in enumerate(
            zip(_PRODUCER_RANK_FAN, _PRODUCER_RANK_REWARD_ID),
            start=1,
        ):
            rank_list.append({
                'mst_producer_rank_id': index,
                'fan': fan,
                'is_released': index <= user.producer_rank,
                'reward_item': reward_schema.dump(rewards_by_id[reward_id]),
            })

    return {'producer_rank_list': rank_list}
