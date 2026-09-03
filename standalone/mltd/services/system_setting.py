from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import LessonWearConfig, MstLessonWearConfig


@dispatcher.add_method(
    name='SystemSettingService.SetSystemSetting', context_arg='context'
)
def set_system_setting(params, context):
    """Persist the lesson-wear setting selected in system settings.

    The client sends only ``lesson_wear_setting_id`` and expects an empty
    reply.  A user owns exactly one active :class:`LessonWearConfig`; the
    configured ID must exist in the master setting table.
    """
    user_id = UUID(context['user_id'])
    setting_id = int(params['lesson_wear_setting_id'])

    with Session(engine) as session:
        valid_setting = session.scalar(
            select(MstLessonWearConfig.mst_lesson_wear_setting_id)
            .where(
                MstLessonWearConfig.mst_lesson_wear_setting_id == setting_id
            )
        )
        if valid_setting is None:
            raise RuntimeError(
                f'unknown lesson wear setting id: {setting_id}'
            )

        session.execute(
            delete(LessonWearConfig)
            .where(LessonWearConfig.user_id == user_id)
        )
        session.add(
            LessonWearConfig(
                user_id=user_id,
                mst_lesson_wear_setting_id=setting_id,
            )
        )
        session.commit()

    return {}
