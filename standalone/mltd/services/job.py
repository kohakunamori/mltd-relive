from decimal import ROUND_DOWN
from mltd.servers.i18n import translation
import random
from datetime import datetime, timedelta, timezone
import secrets
from jsonrpc import dispatcher
from marshmallow.fields import Decimal
from uuid import UUID
from enum import Enum
from sqlalchemy import func, or_, select, update
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import Card, Costume, Idol, Item, MainStoryChapter, Memorial, Mission, MstCard, MstCostume, MstGameSetting, MstIdol, MstItem, MstJob, MstMainStory, MstMainStoryContactStatus, MstMemorial, MstMission, MstRewardItem, MstTheaterRoomStatus, PendingJob, PendingJobAnswer, Present, Song, User
from mltd.models.schemas import CardSchema, GashaMedalSchema, IdolSchema, ItemSchema, MemorialSchema, MissionSchema, MstJobSchema, MstRewardItemSchema, PendingJobSchema, UserSchema
from mltd.services.utils import add_card, add_item, add_present
from mltd.services.game_setting import get_item_day_idol_type
from mltd.services.mission import update_mission_progress

_ = translation.gettext


@dispatcher.add_method(name='JobService.GetJobList')
def get_job_list(params):
    """Service for getting a list of jobs.

    Invoked as part of the initial batch requests after logging in.
    Args:
        params: An empty dict.
    Returns:
        A dict containing the following keys.
        job_list: A list of dicts representing available jobs. Each dict
                  contains the following keys.
            mst_job_id: Master job ID.
            resource_id: A string for getting job-related resources.
            vitality_cost: Vitality cost (20).
            job_type: 1.
            idol_type: Job idol type (1-4).
            reward_exp: User EXP rewarded (143).
            reward_fan: Number of fans gained by the idol randomly
                        picked for the job (40).
            reward_affection: Affection value gained by the idol (9).
            reward_money: Money rewarded (630).
            reward_live_ticket: Number of live tickets rewarded (20).
            begin_date: Date when this job becomes available.
            end_date: Date when this job becomes unavailable.
        job_special_list: null.
    """
    with Session(engine) as session:
        mst_jobs = session.scalars(
            select(MstJob)
        ).all()

        mst_job_schema = MstJobSchema()
        mst_job_list = mst_job_schema.dump(mst_jobs, many=True)

    return {
        'job_list': mst_job_list,
        'job_special_list': None
    }

@dispatcher.add_method(name='JobService.StartJob', context_arg="context")
def start_job(params, context):
    """Service for starting a job.

    Invoked when the user initiates a job 
    (either from job selection or from tour-type event).
    Args:
        params: A dict containing the following keys.
            mst_job_id: Master job ID.
            is_event_tour:  whether this job is started from a tour-type event.
                            for now this is not supported and should always be false.
            tour_count: ? for now this is always 0. may be related to tour-type events and 
                        may represent the number of times the tour has been completed.
            macaroon_count: ? Magnification in the source code. 
                            may be related to event-type jobs.
                            for now this is not supported and should always be 0.
            job_token: A unique string representing the token for this job.

    Returns:
        A dict containing the following keys.
        token: A string token. will be used for finishing the job.
               not same as the job_token sent in the request.
        is_chance: boolean indicating whether this job is a "chance" or "challenge" job.
        mst_job_id: Master job ID.
        mst_idol_id: Master idol ID of the idol assigned to this job.
        text_scenerio_id: Scenario text ID for this job.
                          the line at the beginning of this job.
        adv_scenario_id: ADV Scenario ID for this job.
                         if neither a "chance" nor a "challenge" job, this will be "".
                         if a "chance" or "challenge" job, 
                         this will be the commu following the text scenerio.
        answer_list: a list of dicts representing the answer choices for this job.
                     validated only for 2-option "challenge" jobs and 3-option "chance" jobs. 
                     each dict contains the following keys.
            scenario_id: ADV Scenario ID for this answer choice.
            answer_key: Answer Scenario ID for this answer choice.
            count: chosen count for this answer choice. 
        text_background_id: Background ID for the text scenario.
        is_collab_available: always be false? 
        is_adv_collab_available: should be true for 3-option "chance" jobs, false otherwise.
        adv_background_id: Background ID for the ADV scenario. validated only when adv_scenario_id is not "".
        is_challenge: boolean indicating whether this job is a "challenge" job.
        is_challenge_good: boolean indicating whether the result of the "challenge" job is good.
        
        for the probability for each type of job, it is implemented referring https://note.com/krs0402/n/nda1ff7d503b9
    """
    now = datetime.now(timezone.utc)
    mst_job_id = params['mst_job_id']
    job_token = params['job_token']
    token = secrets.token_urlsafe()
    chance = random.random()
    is_chance = chance >= 0.7
    is_adv_collab_available = chance >= 0.92
    is_challenge = 0.85 <= chance and chance < 0.92
    is_challenge_good = 0.85 <= chance < 0.88
    text_background_id = f'bg2d_g{random.randint(1, 100):04}'
    is_collab_available = False
    adv_scenario_id = ''
    adv_background_id = ''
    job_answers = []

    with Session(engine) as session:
        user = session.scalars(
            select(User)
            .where(User.user_id == UUID(context['user_id']))
        ).one()
        stmt = select(MstIdol.mst_idol_id, MstIdol.resource_id)
        if mst_job_id in [1, 2, 3]:
            stmt = stmt.where(MstIdol.idol_type == mst_job_id)
        stmt = stmt.order_by(func.random()).limit(1)
        mst_idol_id, resource_id = session.execute(stmt).first().tuple()
        text_scenario_num = random.randint(0, 8)
        text_scenario_id = f'job_text_{resource_id}_100{text_scenario_num}'
        if is_chance:
            if not is_adv_collab_available and not is_challenge:
                adv_scenario_num = random.randint(1, 2)
            elif is_challenge:
                adv_scenario_num = 3
                job_answers.append(
                    {
                        "scenario_id": f"job_story_{resource_id}_3000",
                        "answer_key": f"job_story_{resource_id}_3000",
                        "count": 1
                    }
                )
            elif is_adv_collab_available:
                adv_scenario_num = 4
                for i in range(7, 10):
                    job_answers.append(
                        {
                            "scenario_id": f'job_story_{resource_id}_4000',
                            "answer_key": f'job_story_{resource_id}_400{i}',
                            "count": 1
                        }
                    )
            adv_scenario_id = f'job_story_{resource_id}_{adv_scenario_num}000'
        
        user.pending_job = PendingJob(
            user_id=user.user_id,
            job_token=job_token,
            token=token,
            is_chance=is_chance,
            mst_job_id=mst_job_id,
            mst_idol_id=mst_idol_id,
            text_scenario_id=text_scenario_id,
            adv_scenario_id=adv_scenario_id,
            text_background_id=text_background_id,
            is_collab_available=is_collab_available,
            is_adv_collab_available=is_adv_collab_available,
            adv_background_id=adv_background_id,
            is_challenge=is_challenge,
            is_challenge_good=is_challenge_good,
            is_valid=True,
            pending_job_answers=[
                PendingJobAnswer(**answer) for answer in job_answers
            ]
        )
        session.expire(user, ['pending_job'])

        # update user vitality
        before_vitality = user.vitality
        after_vitality = before_vitality
        cost = [0, 20, 20, 20, 20, 25, 30][mst_job_id]
        after_vitality -= cost
        if after_vitality < 0:
            raise RuntimeError('vitality cannot be negative')
        if after_vitality < user.max_vitality:
            user.full_recover_date = (
                user.full_recover_date.replace(tzinfo=timezone.utc)
                if before_vitality < user.max_vitality
                else now
            ) + timedelta(seconds=cost * user.auto_recover_interval)
        user.vitality = after_vitality
        session.commit()
    return {
        'token': token,
        'is_chance': is_chance,
        'mst_job_id': mst_job_id,
        'mst_idol_id': mst_idol_id,
        'text_scenario_id': text_scenario_id,
        'adv_scenario_id': adv_scenario_id,
        'answer_list': job_answers,
        'text_background_id': text_background_id,
        'is_collab_available': is_collab_available,
        'is_adv_collab_available': is_adv_collab_available,
        'adv_background_id': adv_background_id,
        'is_challenge': is_challenge,
        'is_challenge_good': is_challenge_good
    }

@dispatcher.add_method(name='JobService.FinishJob', context_arg='context')
def finish_job(params, context):
    """Service for finishing a job.

    Invoked when the user completes a job.
    Args:
        params: A dict containing the following keys.
            token: The string token received from start_job.
            evaluation: the evaluation of job results.
                non-evaluation result: 0
                bad: 1
                normal: 2
                good: 3
                perfect: 4
            answer_key_list: a list of answer keys that the user has chosen.
                for 2-option, it will be [""].
                for 3-option, it will be a list containing the answer key id.
                otherwise it will be a empty list.
            job_token: A string token for finishing the job, same as the one sent in start_job.

    Returns:
        A dict containing the following keys.
        result_user: A dict representing the changes to user info after
                     playing this song. Contains the following keys.
            level_up: Whether the user levels up after this song.
            before_level: User level before this song.
            after_level: User level after this song.
            rank_up: Whether the producer rank increases after this
                     song.
            before_rank: Producer rank before this song.
            after_rank: Producer rank after this song.
            rank_reward: A dict representing the reward for increasing
                         the producer rank (empty info if producer rank
                         does not increase). See the return value
                         'reward_item_list' of the method
                         'IdolService.GetIdolList' for the dict
                         definition.
            before_vitality: User vitality before leveling up.
            after_vitality: User vitality after leveling up.
            before_max_vitality: Maximum possible vitality before
                                 leveling up.
            after_max_vitality: Maximum possible vitality after leveling
                                up.
            before_live_ticket: Number of live tickets.
            after_live_ticket: Same as 'before_live_ticket'.
            before_max_friend: Maximum possible number of friends before
                               leveling up.
            after_max_friend: Maximum possible number of friends after
                              leveling up.
            before_theater_fan: Total number of theater fans before this
                                song.
            after_theater_fan: Total number of theater fans after this
                               song.
            before_live_point: User LP before this song.
            after_live_point: User LP after this song.
            before_song_live_point: Song LP before this song.
            after_song_live_point: Song LP after this song.
            before_money: Amount of money before this song.
            after_money: Amount of money after this song.
            before_exp: Total user EXP before this song.
            after_exp: Total user EXP after this song.
            before_exp_gauge: How much the EXP gauge was filled up in %
                              (rounded down to the nearest integer)
                              before this song.
            after_exp_gauge: How much the EXP gauge is filled up in %
                             after this song. If the user levels up,
                             this value is greater than or equal to 100.
            exp: Current user EXP after this song.
            next_exp: Required user EXP for leveling up after this song.
            full_recover_date: Date when vitality will be fully
                               recovered after this song.
            map_level: A dict representing current map level of the user
                       after this song. See the return value 'map_level'
                       of the method 'AuthService.Login' for the dict
                       definition.
            release_all_live_course: Whether all live courses should be
                                     released as a result of leveling up
                                     to 50 after this song. This value
                                     is true only if the user was below
                                     level 50 before this song and at or
                                     above level 50 after this song.
            before_training_point: 0.
            after_training_point: 0.
            total_training_point: 0.
        result_idol: representing the changes to idol info after 
                     this job. Each dict corresponds to the card 
                     and idol. Each dict contains the following keys.
            mst_idol_id: Master idol ID.
            before_awake_gauge: Awakening gauge value of the card before
                                this song.
            after_awake_gauge: Awakening gauge value of the card after
                               this song.
            max_awake_gauge: Maximum possible awakening gauge value of
                             the card.
            before_fan: Number of fans for this idol before this song.
                        If the same idol has appeared before in this
                        list, this value is the 'after_fan' value of the
                        last entry.
            after_fan: Number of fans for this idol after this song. If
                       the same idol has appeared before in this list,
                       this is the resulting value by adding the
                       additional fans gained at this position to
                       'before_fan'.
            before_affection: Affection value for this idol before this
                              song. If the same idol has appeared before
                              in this list, this value is the
                              'after_affection' value of the last entry.
            after_affection: Affection value for this idol after this
                             song. If the same idol has appeared before
                             in this list, this is the resulting value
                             by adding the additional affection gained
                             at this position to 'before_affection'.
            memorial_status: A dict representing the memorial unlocked
                             by obtaining the required affection value
                             after this song (empty memorial info if no
                             memorial is unlocked). See the return value
                             'memorial_list' of the method
                             'IdolService.GetIdolList' for the dict
                             definition.
            memorial_list: A list containing a single dict exactly the
                           same as 'memorial_status' above (null if no
                           memorial is unlocked).
        live_result_drop_reward: A dict representing the random drop
                                 rewards after playing this song.
                                 Contains the following key.
            drop_reward_box_list: A list of dicts (null if no drop
                                  rewards). Each dict contains the
                                  following key.
                drop_reward_item: A dict representing the drop reward
                                  item. See the return value
                                  'reward_item_list' of the method
                                  'IdolService.GetIdolList' for the dict
                                  definition.
                substitute_list: null.
                drop_reward_group_type: 1.
        result_gasha_medal: A dict representing the changes to gasha
                            medal info after playing this song (empty
                            info if no changes). Contains the following
                            keys.
            before_gauge: Gasha medal points before this song.
            after_gauge: Actual gasha medal points earned after this
                         song. No further gasha medal points can be
                         gained when the user owns the maximum possible
                         number of gasha medals (10).
            get_point: Gasha medal points dropped from random drop
                       rewards after playing this song.
            count: If the total gasha medal points after this song is
                   greater than or equal to 100, this is the number of
                   gasha medals gained by converting every 100 points
                   into 1 medal. Otherwise, this value is 0.
            expire_date: Expiry date of the newly obtained gasha medals
                         ('0001-01-01T00:00:00+0000' if no gasha medal
                         was gained).
            is_over: Whether the user is unable to earn some of the
                     gasha medal points because the maximum possible
                     number of gasha medals has been reached (or,
                     equivalently, 'after_gauge' is strictly less than
                     'get_point').
        gasha_medal: User gasha medal info after playing this song. See
                     the return value 'gasha_medal' of the method
                     'GashaMedalService.GetGashaMedal' for the dict
                     definition.
        reward_live_ticket: Number of live tickets rewarded by this job.
        substitute_live_ticket: int ?
        reward_money: Amount of money rewarded by this job.
        release_mst_main_story_id: Master main story ID of the unlocked
                                   main story as a result of playing
                                   this job (0 if no main story
                                   unlocked).
        mst_room_id: Master room ID for the intro contact of the
                     unlocked main story (0 if no main story unlocked).
        over_capacity_info: A dict containing the following keys.
            money: Whether the amount of money exceeds the maximum
                   possible amount of money after this song.
            live_ticket: Whether the number of live tickets exceeds
                            the maximum possible number of live tickets after
                            this song.
        mission_process: A dict representing changes in mission states
                         after playing this song. Contains the following
                         keys.
            complete_mission_list: A list of dicts representing missions
                                   that have just been completed (empty
                                   if none). See the return value
                                   'mission_list' of the method
                                   'MissionService.GetMissionList' for
                                   the dict definition.
            open_mission_list: An empty list.
            training_point_diff: Unknown. Contains the following keys.
                before: 0.
                after: 0.
                total: 0.
        mission_list: A list of dicts representing missions with changed
                      states. This list is the same as
                      'complete_mission_list' above.
        card_status_list: A list of cards dropped. for now it's []
        result_gasha_ticket: A dict containing the following keys.
            before_gauge: 0.
            after_gauge: 0.
            get_point: 0.
            count: 0.
            expire_date: null.
            is_over: false.
        updated_idol_list: A list of 10 dicts representing the final
                           states of the idols after playing this
                           song. The first 5 dicts contain empty idol
                           info. The last 5 dicts correspond to the
                           idols in the first 5 positions of the
                           selected unit. If multiple cards for the same
                           idol were selected in the unit, there will be
                           mulitple duplicated dicts for that idol in
                           this list. See the return value 'idol_list'
                           of the method 'IdolService.GetIdolList' for
                           the dict definition.
        updated_item_list: A list of dicts representing the final states
                           of user's items after playing this song. See
                           'item_list' of the method
                           'ItemService.GetItemList' for the dict
                           definition.
        result_event_tour: for now, empty
        result_event_point: for now, empty
        release_mst_event_story_id: 0.
        mst_event_id: 0.
        event_type: 0.
        event_point_result: null.
        job_type: 1
        token_verified: true

        
    """
    now = datetime.now(timezone.utc)
    evaluation = params['evaluation']
    with Session(engine) as session:
        user = session.scalars(
            select(User)
            .where(User.user_id == UUID(context['user_id']))
        ).one()
        if params['token'] != user.pending_job.token or params['job_token'] != user.pending_job.job_token:
            raise ValueError('Game and server job_tokens do not match')
        mst_job_id = user.pending_job.mst_job_id
        gained_exp = [0, 143, 143, 143, 143, 178, 215][mst_job_id]
        if user.level < 50:
            gained_exp *= 2
        gained_money = [0, 630, 630, 630, 630, 787, 945][mst_job_id]
        gained_fan = [0, 40, 40, 40, 40, 50, 60][mst_job_id]
        gained_affection = [0, 9, 9, 9, 9, 11, 15][mst_job_id]
        gained_live_ticket = [0, 20, 20, 20, 20, 25, 30][mst_job_id]
        user_lv_base = session.scalar(
            select(MstGameSetting.user_lv_base)
        )
        new_level = user.level
        new_exp = user.exp + gained_exp
        new_next_exp = user.next_exp
        while new_exp >= new_next_exp:
            new_level += 1
            new_exp -= new_next_exp
            new_next_exp += user_lv_base
        new_rank = user.producer_rank
        rank_up_requirement = [0, 1_000, 10_000, 50_000, 100_000, 300_000,
                               500_000, 1_000_000]
        if (new_rank < 8
                and user.theater_fan + gained_fan
                >= rank_up_requirement[new_rank]):
            new_rank += 1
        rank_reward = session.scalar(
            select(MstRewardItem)
            .where(MstRewardItem.mst_item_id
                   == 0 if new_rank == user.producer_rank else 3)
            .where(MstRewardItem.amount
                   == (0 if new_rank == user.producer_rank
                       else 50 if new_rank <= 6
                       else 100 if new_rank == 7
                       else 150))
        )
        new_vitality = user.vitality
        new_max_vitality = user.max_vitality
        if new_level > user.level:
            for level in range(user.level+1, new_level+1):
                if (level <= 60 and level % 2 == 0
                    or 60 < level and level <= 150 and level % 3 == 0
                    or 150 < level and level <= 426 and level % 4 == 0
                    or 426 < level and level <= 586 and level % 5 == 1
                    or 586 < level and level <= 700 and level % 6 == 4):
                    new_max_vitality += 1
                new_vitality += new_max_vitality
        new_max_friend = user.max_friend
        if new_level > user.level:
            for level in range(user.level+1, new_level+1):
                if level <= 151 and level % 3 == 1:
                    new_max_friend += 1
        new_theater_fan = user.theater_fan + gained_fan
        user_schema = UserSchema()
        user_dict = user_schema.dump(user)
        new_money = min(user.money + gained_money, user.max_money)
        if new_theater_fan >= 1_000_000:
            new_map_level = 20
            new_recognition = 100
        else:
            # TODO: Verify map level when 95 <= recognition <= 99.999 on
            # JP server.
            new_map_level = new_theater_fan//50_000 + 1
            new_recognition = (
                Decimal(new_theater_fan) / Decimal(10_000)
            ).quantize(Decimal('.001'), rounding=ROUND_DOWN)
        release_all_live_course = user.level < 50 and new_level >= 50
        new_live_ticket = min(user.live_ticket + gained_live_ticket, user.max_live_ticket)
        reward_item_schema = MstRewardItemSchema()
        result_user = {
            'level_up': new_level > user.level,
            'before_level': user.level,
            'after_level': new_level,
            'rank_up': new_rank > user.producer_rank,
            'before_rank': user.producer_rank,
            'after_rank': new_rank,
            'rank_reward': reward_item_schema.dump(rank_reward),
            'before_vitality': user.vitality,
            'after_vitality': new_vitality,
            'before_max_vitality': user.max_vitality,
            'after_max_vitality': new_max_vitality,
            'before_live_ticket': user.live_ticket,
            'after_live_ticket': new_live_ticket,
            'before_max_friend': user.max_friend,
            'after_max_friend': new_max_friend,
            'before_theater_fan': user.theater_fan,
            'after_theater_fan': new_theater_fan,
            'before_live_point': 0,
            'after_live_point': 0,
            'before_song_live_point': 0,
            'after_song_live_point': 0,
            'before_money': user.money,
            'after_money': new_money,
            'before_exp': (user.level-1)*(user.level-1)*50 + user.exp,
            'after_exp': (new_level-1)*(new_level-1)*50 + new_exp,
            'before_exp_gauge': user.exp*100//user.next_exp,
            'after_exp_gauge': ((new_level-user.level)*100
                                + new_exp*100//new_next_exp),
            'exp': new_exp,
            'next_exp': new_next_exp,
            'full_recover_date': (now if new_vitality >= new_max_vitality
                                  else user.full_recover_date),
            'map_level': {
                'user_map_level': user.map_level.user_map_level,
                'user_recognition': new_recognition,
                'actual_map_level': new_map_level,
                'actual_recognition': new_recognition
            },
            'release_all_live_course': release_all_live_course,
            'before_training_point': 0,
            'after_training_point': 0,
            'total_training_point': 0
        }
        user.level = new_level
        user.producer_rank = new_rank
        if rank_reward.mst_item_id:
            add_present(
                session=session,
                user=user,
                present=Present(
                    user_id=user.user_id,
                    comment=_(
                        'Reward obtained from reaching Producer Rank "{rank}."'
                    ).format(
                        rank=['E', 'D', 'C', 'B', 'A', 'S', 'SS'][new_rank-2]
                    ),
                    amount=rank_reward.amount,
                    item_id=f'{user.user_id}_{rank_reward.mst_item_id}'
                )
            )
        user.vitality = new_vitality
        user.max_vitality = new_max_vitality
        user.max_friend = new_max_friend
        user.theater_fan = new_theater_fan
        user.money = new_money
        user.exp = new_exp
        user.next_exp = new_next_exp
        user.live_ticket = new_live_ticket
        if new_vitality >= new_max_vitality:
            user.full_recover_date = now
        user.map_level.user_recognition = new_recognition
        user.map_level.actual_map_level = new_map_level
        user.map_level.actual_recognition = new_recognition
        # TODO: Receive achievement for every 20% recognition (when
        # should it be received? added to present list or achievement
        # list?)

        #endregion

        #region Update idol info.
        memorial_schema = MemorialSchema()
        idol = session.scalars(
            select(Idol)
            .where(Idol.user_id == user.user_id)
            .where(Idol.mst_idol_id == user.pending_job.mst_idol_id)
        ).one()
        before_fan = idol.fan
        before_affection = idol.affection
        after_fan = before_fan + gained_fan
        after_affection = before_affection + gained_affection
        result_idol = {
            'mst_idol_id': idol.mst_idol_id,
            'before_awake_gauge': 0,
            'after_awake_gauge': 0,
            'max_awake_gauge': 0,
            'before_fan': before_fan,
            'after_fan': after_fan,
            'before_affection': before_affection,
            'after_affection': after_affection,
            'memorial_status': {
                'mst_memorial_id': 0,
                'scenario_id': '',
                'mst_idol_id': 0,
                'release_affection': 0,
                'number': 0,
                'is_released': False,
                'is_read': False,
                'released_date': None,
                'reward_item_list': None,
                'is_available': False,
                'begin_date': None
            },
            'memorial_list': None
        }
        memorial_id = session.scalar(
            select(MstMemorial.mst_memorial_id)
            .where(MstMemorial.mst_idol_id == idol.mst_idol_id)
            .where(before_affection < MstMemorial.release_affection)
            .where(MstMemorial.release_affection <= after_affection)
        )
        if memorial_id:
            memorial = session.scalars(
                select(Memorial)
                .where(Memorial.user == user)
                .where(Memorial.mst_memorial_id == memorial_id)
            ).one()
            memorial_dict = memorial_schema.dump(memorial)
            result_idol['memorial_status'] = memorial_dict
            result_idol['memorial_list'] = [memorial_dict]
        idol.fan = result_idol['after_fan']
        idol.affection = result_idol['after_affection']
        if memorial_id:
            memorial.is_released = True
        idol_schema = IdolSchema()
        updated_idol_list = [idol_schema.dump(idol)]

        #endregion

        #region Pick random drop rewards and give them to the user.
        card_status_list = []
        # The drop rates are an approximation based on the following
        # 1309 items dropped across 245 songs.
        # Stage dress           105 ( 73 on non-item days)
        # Mini crown            116 ( 84 on non-item days)
        # Lipstick              187 (107 on non-item days)
        # Perfume               229 (150 on non-item days)
        # Mirror                112 ( 64 on non-item days)
        # Gasha medal 10pt       66
        # Gasha medal 15pt       79
        # Gasha medal 20pt       66
        # Lesson ticket N        74
        # Lesson ticket R        65
        # Throat lozenges         4
        # Tapioca drink           9
        # High cocoa chocolate    9
        # Roll cake               6
        # Fan letter              9
        # Single flower          10
        # Hand cream             10
        # Bath additive           5
        # Auto live pass         10
        # N cards               113
        # R cards                17
        # Costumes                8
        class DropType(Enum):
            AWAKENING_ITEM = 55.0
            GASHA_MEDAL_PT = 15.5
            LESSON_TICKET = 10.0
            CARD = 9.5
            AUTO_LIVE_PASS = 5.0
            GIFT = 4.5
            COSTUME = 0.5

        class AwakeningDropType(Enum):
            STAGE_DRESS = (4, 100, 15.7)
            MINI_CROWN = (4, 101, 17.7)
            PRINCESS_LIPSTICK = (1, 110, 7.4)
            PRINCESS_PERFUME = (1, 111, 10.4)
            PRINCESS_MIRROR = (1, 112, 4.4)
            FAIRY_LIPSTICK = (2, 120, 7.4)
            FAIRY_PERFUME = (2, 121, 10.4)
            FAIRY_MIRROR = (2, 122, 4.4)
            ANGEL_LIPSTICK = (3, 130, 7.4)
            ANGEL_PERFUME = (3, 131, 10.4)
            ANGEL_MIRROR = (3, 132, 4.4)
            def __init__(self, idol_type, mst_item_id, weight):
                self.idol_type = idol_type
                self.mst_item_id = mst_item_id
                self.weight = weight

        old_gasha_medals = len(user.gasha_medal.gasha_medal_expire_dates)
        old_gasha_medal_pt = user.gasha_medal.point_amount
        dropped_gasha_medal_pt = 0
        drop_reward_box_list = None
        updated_item_ids = []
        drop_reward_box_list = []
        is_item_day = mst_job_id == get_item_day_idol_type()
        n_card_id_stmt = (
            select(MstCard.mst_card_id)
            .where(MstCard.rarity == 1)
        )
        r_card_id_stmt = (
            select(MstCard.mst_card_id)
            .where(MstCard.rarity == 2)
        )
        if is_item_day and mst_job_id != 4:
            n_card_id_stmt = n_card_id_stmt.where(
                MstCard.idol_type == mst_job_id)
            r_card_id_stmt = r_card_id_stmt.where(
                MstCard.idol_type == mst_job_id)
        n_card_ids = session.scalars(n_card_id_stmt).all()
        r_card_ids = session.scalars(r_card_id_stmt).all()
        unlocked_costume_subq = (
            select(Costume.mst_costume_id)
            .where(Costume.user == user)
            .where(Costume.mst_costume_id == MstCostume.mst_costume_id)
        ).exists()
        locked_costume_ids = session.scalars(
            select(MstCostume.mst_costume_id)
            .where(MstCostume.costume_name == 'ex')
            .where(MstCostume.costume_number.in_([2, 3, 5, 6]))
            .where(~unlocked_costume_subq)
        ).all()
        auto_live_pass_remaining = session.scalar(
            select(MstItem.max_amount - Item.amount)
            .select_from(Item)
            .join(MstItem)
            .where(Item.user == user)
            .where(Item.mst_item_id == 50)
            .where(Item.amount < MstItem.max_amount)
        )
        allowed_drops = [
            DropType.AWAKENING_ITEM,
            DropType.GASHA_MEDAL_PT,
            DropType.LESSON_TICKET,
            DropType.CARD,
            DropType.GIFT
        ]
        if auto_live_pass_remaining:
            allowed_drops.append(DropType.AUTO_LIVE_PASS)
        if locked_costume_ids:
            allowed_drops.append(DropType.COSTUME)
        drop_count = [
            random.randint(2, 3), 
            random.randint(2, 3), 
            random.randint(2, 3), 
            random.randint(2, 3), 
            4
        ][evaluation]
        drop_count_chance = [
            0,
            0,
            random.randint(0, 2),
            random.randint(1, 2),
            2
        ][evaluation]
        if user.pending_job.is_challenge_good:
            drop_count_chance += 1
        selected_drops = random.choices(
            allowed_drops, [x.value for x in allowed_drops], k=drop_count)
        selected_drops_chance = random.choices(
            allowed_drops, [x.value for x in allowed_drops], k=drop_count_chance)
        for i, drop_type in enumerate(selected_drops + selected_drops_chance):
            if (drop_type is DropType.AUTO_LIVE_PASS
                    and not auto_live_pass_remaining):
                if DropType.AUTO_LIVE_PASS in allowed_drops:
                    allowed_drops.remove(DropType.AUTO_LIVE_PASS)
                drop_type = random.choices(
                    allowed_drops, [x.value for x in allowed_drops], k=1
                )[0]
            if drop_type is DropType.COSTUME and not locked_costume_ids:
                if DropType.COSTUME in allowed_drops:
                    allowed_drops.remove(DropType.COSTUME)
                drop_type = random.choices(
                    allowed_drops, [x.value for x in allowed_drops], k=1
                )[0]

            if drop_type is DropType.AWAKENING_ITEM:
                allowed_awakening_drops = [
                    AwakeningDropType.STAGE_DRESS,
                    AwakeningDropType.MINI_CROWN,
                    AwakeningDropType.PRINCESS_LIPSTICK,
                    AwakeningDropType.PRINCESS_PERFUME,
                    AwakeningDropType.PRINCESS_MIRROR,
                    AwakeningDropType.FAIRY_LIPSTICK,
                    AwakeningDropType.FAIRY_PERFUME,
                    AwakeningDropType.FAIRY_MIRROR,
                    AwakeningDropType.ANGEL_LIPSTICK,
                    AwakeningDropType.ANGEL_PERFUME,
                    AwakeningDropType.ANGEL_MIRROR
                ]
                if is_item_day:
                    allowed_awakening_drops = [
                        x for x in allowed_awakening_drops
                        if x.idol_type == mst_job_id]
                selected_awakening_drop = random.choices(
                    allowed_awakening_drops,
                    [x.weight for x in allowed_awakening_drops], k=1)[0]
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_awakening_drop.mst_item_id,
                    item_type=7,
                    amount=1
                )
            elif drop_type is DropType.GASHA_MEDAL_PT:
                selected_item_id = random.choice([502, 503, 504])
                dropped_gasha_medal_pt += (
                    10 if selected_item_id == 502
                    else 15 if selected_item_id == 503
                    else 20)
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_item_id,
                    item_type=4,
                    amount=1
                )
            elif drop_type is DropType.LESSON_TICKET:
                selected_item_id = random.choice([200, 201])
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_item_id,
                    item_type=8,
                    amount=1
                )
            elif drop_type is DropType.GIFT:
                selected_item_id = random.choices(
                    [70, 71, 72, 73, 80, 81, 82, 83],
                    [1, 2, 2, 1, 2, 2, 2, 1], k=1)[0]
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=selected_item_id,
                    item_type=25 if selected_item_id < 80 else 26,
                    amount=1
                )
            elif drop_type is DropType.AUTO_LIVE_PASS:
                auto_live_pass_remaining -= 1
                drop_reward_item = MstRewardItem(
                    reward_type=4,
                    mst_item_id=50,
                    item_type=23,
                    amount=1
                )
            elif drop_type is DropType.CARD:
                selected_card_type = random.choices(
                    ['N', 'R'], [9, 1], k=1)[0]
                if selected_card_type == 'N':
                    selected_card_id = random.choice(n_card_ids)
                else:
                    selected_card_id = random.choice(r_card_ids)
                drop_reward_item = MstRewardItem(
                    reward_type=6,
                    mst_card_id=selected_card_id,
                    amount=1
                )
            elif drop_type is DropType.COSTUME:
                selected_costume_id = random.choice(locked_costume_ids)
                locked_costume_ids.remove(selected_costume_id)
                drop_reward_item = MstRewardItem(
                    reward_type=8,
                    mst_costume_id=selected_costume_id,
                    amount=1
                )

            drop_reward_box_list.append({
                'drop_reward_item': reward_item_schema.dump(
                    drop_reward_item),
                'substitute_list': None,
                'drop_reward_group_type': 1 if i < len(selected_drops) else 2
            })
            if drop_reward_item.mst_item_id:
                add_item(
                    session=session,
                    user=user,
                    mst_item_id=drop_reward_item.mst_item_id,
                    item_type=drop_reward_item.item_type)
                if drop_type is not DropType.GASHA_MEDAL_PT:
                    updated_item_ids.append(drop_reward_item.mst_item_id)
            elif drop_reward_item.mst_card_id:
                rarity = session.scalar(
                    select(MstCard.rarity)
                    .select_from(Card)
                    .join(MstCard)
                    .where(Card.user == user)
                    .where(Card.mst_card_id
                            == drop_reward_item.mst_card_id)
                )
                if rarity:
                    lesson_ticket_item_id = 200 if rarity == 1 else 201
                    add_item(
                        session=session,
                        user=user,
                        mst_item_id=lesson_ticket_item_id,
                        item_type=8,
                        amount=2
                    )
                    updated_item_ids.append(lesson_ticket_item_id)
                    master_piece_item_id = 300 if rarity == 1 else 301
                    add_item(
                        session=session,
                        user=user,
                        mst_item_id=master_piece_item_id,
                        item_type=9,
                        amount=1
                    )
                    updated_item_ids.append(master_piece_item_id)
                else:
                    add_card(
                        session=session,
                        user=user,
                        mst_card_id=drop_reward_item.mst_card_id
                    )
                    new_card = session.scalars(
                        select(Card).where(Card.user == user)
                        .where(Card.mst_card_id == drop_reward_item.mst_card_id)
                    ).one()
                    card_schema = CardSchema()
                    card_status_list.append(
                        card_schema.dump(new_card)
                    )
            elif drop_reward_item.mst_costume_id:
                mst_costume_id = drop_reward_item.mst_costume_id
                user.costumes.append(Costume(
                    costume_id=(f'{user.user_id}_{mst_costume_id}'),
                    mst_costume_id=mst_costume_id
                ))

        result_gasha_medal = {
            'before_gauge': 0,
            'after_gauge': 0,
            'get_point': 0,
            'count': 0,
            'expire_date': None,
            'is_over': False
        }
        if dropped_gasha_medal_pt:
            old_total_pt = old_gasha_medals*100 + old_gasha_medal_pt
            new_total_pt = min(old_total_pt + dropped_gasha_medal_pt, 1000)
            new_gasha_medals = new_total_pt // 100
            new_gasha_medal_pt = new_total_pt - old_total_pt
            result_gasha_medal['before_gauge'] = old_gasha_medal_pt
            result_gasha_medal['after_gauge'] = new_gasha_medal_pt
            result_gasha_medal['get_point'] = dropped_gasha_medal_pt
            result_gasha_medal['count'] = new_gasha_medals - old_gasha_medals
            if new_gasha_medals > old_gasha_medals:
                result_gasha_medal['expire_date'] = now + timedelta(days=7)
            else:
                result_gasha_medal['expire_date'] = datetime(1, 1, 1)
            result_gasha_medal['is_over'] = (
                new_gasha_medal_pt < dropped_gasha_medal_pt)
        live_result_drop_reward = {
            'drop_reward_box_list': drop_reward_box_list
        }
        updated_items = session.scalars(
            select(Item)
            .where(Item.user == user)
            .where(Item.mst_item_id.in_(updated_item_ids))
        ).all()
        updated_item_list = []
        if updated_items:
            item_schema = ItemSchema()
            updated_item_list = item_schema.dump(updated_items, many=True)
        gasha_medal_schema = GashaMedalSchema()
        gasha_medal = gasha_medal_schema.dump(user.gasha_medal)

        #endregion

        #region Unlock main story episode (if any).

        release_mst_main_story_id = 0
        mst_room_id = 0
        min_locked_main_story_id = session.scalar(
            select(func.min(MainStoryChapter.mst_main_story_id))
            .where(MainStoryChapter.user == user)
            .where(MainStoryChapter.is_released == False)
        )
        if min_locked_main_story_id:
            release_song_id, release_level, room_id = session.execute(
                select(MstMainStory.release_song_id,
                       MstMainStory.release_level,
                       MstTheaterRoomStatus.mst_room_id)
                .join(MstMainStoryContactStatus)
                .join(MstTheaterRoomStatus)
                .where(MstMainStory.mst_main_story_id
                       == min_locked_main_story_id)
            ).one()
            release_song_is_cleared = session.scalar(
                select(Song.is_cleared)
                .where(Song.user == user)
                .where(Song.mst_song_id == release_song_id)
            )
            if new_level >= release_level and release_song_is_cleared:
                release_mst_main_story_id = min_locked_main_story_id
                mst_room_id = room_id
                session.execute(
                    update(MainStoryChapter)
                    .where(MainStoryChapter.user == user)
                    .where(MainStoryChapter.mst_main_story_id
                           == release_mst_main_story_id)
                    .where(MainStoryChapter.chapter == 1)
                    .values(is_released=True)
                )
                #TODO: add theater_room

        #endregion
        
        mission_list = []
        mission_schema = MissionSchema()
        # Update weekly mission progress.
        weekly_fan_mission = session.scalar(
            select(Mission)
            .where(Mission.user == user)
            .where(Mission.mst_mission_id == 70)
            .where(Mission.mission_state == 1)
        )
        if weekly_fan_mission:
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=weekly_fan_mission,
                progress=weekly_fan_mission.progress + gained_fan
            )
            if is_complete:
                mission_list.append(mission_schema.dump(weekly_fan_mission))
        # TODO: Update normal mission progress.
        card_count = len(user.cards)
        card_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 5)
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in card_missions:
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=card_count
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))

        affection_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 6)
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in affection_missions:
            progress = mission.progress
            if (result_idol['before_affection']
                    < int(mission.mst_mission.option)
                    and int(mission.mst_mission.option)
                    <= result_idol['after_affection']):
                progress += 1
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=progress
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))

        if result_user['rank_up']:
            user_level_missions = session.scalars(
                select(Mission)
                .join(MstMission)
                .where(Mission.user == user)
                .where(MstMission.mst_mission_class_id == 7)
                .where(Mission.mission_state.in_([0, 1]))
                .order_by(MstMission.sort_id)
            ).all()
            for mission in user_level_missions:
                is_complete = update_mission_progress(
                    session=session,
                    user=user,
                    mission=mission,
                    progress=user.level
                )
                if is_complete:
                    mission_list.append(mission_schema.dump(mission))
        
        costume_count = len(user.costumes)
        costume_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 9)
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in costume_missions:
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=costume_count
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))
        
        costume_set_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 47)
            .where(Mission.mission_state == 1)
        ).all()
        for mission in costume_set_missions:
            costume_count = len([
                costume for costume in user.costumes
                if costume.mst_costume.mst_costume_group_id
                == int(mission.mst_mission.option)
            ])
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=costume_count
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))
        
        # Update idol mission progress.
        idol_missions = session.scalars(
            select(Mission)
            .join(MstMission)
            .where(Mission.user == user)
            .where(MstMission.mst_mission_class_id == 36)
            .where(MstMission.option == str(result_idol['mst_idol_id']))
            .where(Mission.mission_state.in_([0, 1]))
            .order_by(MstMission.sort_id)
        ).all()
        for mission in idol_missions:
            progress = mission.progress
            if (result_idol['mst_idol_id']
                    == int(mission.mst_mission.option)
                    and result_idol['after_affection'] > progress):
                progress = result_idol['after_affection']
            is_complete = update_mission_progress(
                session=session,
                user=user,
                mission=mission,
                progress=progress
            )
            if is_complete:
                mission_list.append(mission_schema.dump(mission))

        # TODO: time-limited missions

        #endregion

        pending_job_schema = PendingJobSchema()
        pending_job = pending_job_schema.dump(user.pending_job)
        user.pending_job = None

        session.commit()
    
    money_over_capacity = user_dict['money'] + gained_money > user_dict['max_money']
    live_ticket_over_capacity = (result_user['before_live_ticket'] + gained_live_ticket
                            > user_dict['max_live_ticket'])
    if money_over_capacity:
        gained_money = user_dict['max_money'] - user_dict['money']
    if live_ticket_over_capacity:
        gained_live_ticket = user_dict['max_live_ticket'] - result_user['before_live_ticket']
    return {
        'result_user': result_user,
        'result_idol': result_idol,
        'result_drop_reward': live_result_drop_reward,
        'result_gasha_medal': result_gasha_medal,
        'gasha_medal': gasha_medal,
        'reward_live_ticket': gained_live_ticket,
        'substitute_live_ticket': 0,
        'reward_money': gained_money,
        'release_mst_main_story_id': release_mst_main_story_id,
        'mst_room_id': 0,
        'over_capacity_info': {
            'money': money_over_capacity,
            'live_ticket': live_ticket_over_capacity,
        },
        'mission_process': {
            'complete_mission_list': mission_list,
            'open_mission_list': [],
            'training_point_diff': {
                'before': 0,
                'after': 0,
                'total': 0
            }
        },
        'mission_list': mission_list,
        'card_status_list': card_status_list,
        'result_gasha_ticket': {
            'before_gauge': 0,
            'after_gauge': 0,
            'get_point': 0,
            'count': 0,
            'expire_date': None,
            'is_over': False
        },
        'updated_idol_list': updated_idol_list,
        'updated_item_list': updated_item_list,
        'result_event_tour': {
            'mst_event_id': 0,
            'before_playable_count': 0,
            'after_playable_count': 0,
            'playable_count_required_step': 0,
            'playable_count_step': 0,
            'before_playable_count_step': 0,
            'after_playable_count_step': 0,
            'required_fixed_step': 0,
            'fixed_step': 0,
            'is_keep_point_scale': False,
            'fixed_step_twin': 0,
            'is_keep_point_scale_twin': False
        },
        'result_event_point': {
            'mst_event_id': 0,
            'before_event_point': 0,
            'after_event_point': 0
        },
        'release_mst_event_story_id': 0,
        'mst_event_id': 0,
        'event_type': 0,
        'event_point_reward_list': None,
        'job_type': 1,
        'token_verified': True  
    }