from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import func, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Friend, Profile
from mltd.models.schemas import GuestSchema


@dispatcher.add_method(
    name='FriendService.GetRecommendUserList', context_arg='context'
)
def get_recommend_user_list(params, context):
    """Return random users that are not already friends with the caller.

    ``UserSummary`` in the client matches the existing ``GuestSchema`` used by
    live guest selection, so the same canonical profile serializer is reused.
    """
    user_id = UUID(context['user_id'])

    with Session(engine) as session:
        friend_ids = session.scalars(
            select(Friend.friend_id)
            .where(Friend.user_id == user_id)
        ).all()

        query = select(Profile).where(Profile.id_ != user_id)
        if friend_ids:
            query = query.where(~Profile.id_.in_(friend_ids))
        profiles = session.scalars(
            query.order_by(func.random()).limit(20)
        ).all()

        schema = GuestSchema()
        user_list = schema.dump(profiles, many=True)
        for user in user_list:
            user['is_friend'] = False

    return {'user_list': user_list}
