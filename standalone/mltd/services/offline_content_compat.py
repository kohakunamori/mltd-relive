"""Protocol-safe compatibility for server content absent from the old dump.

The bundled standalone database has no Navi, Drama, Blog, Mail, received-
present-history or real-money platform product tables.  Costume/song sales are
slightly different: their playable master rows survived, and the client still
contains the purchase UI/contract.  Relive therefore exposes a small,
preservation-safe catalog over that real master data and persists shop purchase
state separately from the intentionally fully-unlocked playable save.
"""

from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import func, select
from sqlalchemy.orm import Session

from mltd.models.engine import engine
from mltd.models.models import (
    Card,
    Costume,
    Idol,
    Jewel,
    MstCard,
    MstCostume,
    MstCostumeBulkChangeGroup,
    MstSong,
    Namecard,
    SalesCostumePurchase,
    SalesSongPurchase,
    Song,
    User,
)
from mltd.models.schemas import JewelSchema, MstCostumeSchema, SongSchema
from mltd.servers.utilities import format_datetime


# SalesCostumeStatus.id=40 is known to be a real legacy sales ID because the
# preserved client manifest contains costumesalesinfo0040.unity3d and the
# client formats that asset key directly from SalesCostumeStatus.id.  Group 40
# is the real セーラーミズギ group in the preserved mst_costume data.  The
# original mst_sales_costume_price table did not survive, so Relive owns the
# price key and keeps it stable/consistent with the sale key.
_COSTUME_SALE_ID = 40
_COSTUME_PRICE_ID = 40
_COSTUME_GROUP_ID = 40


def _context_user_id(context):
    if not context or not context.get('user_id'):
        raise ValueError('authenticated user_id is required')
    return UUID(context['user_id'])


def _costume_sale_status(session, user_id):
    costumes = session.scalars(
        select(MstCostume)
        .where(MstCostume.mst_costume_group_id == _COSTUME_GROUP_ID)
        .order_by(MstCostume.mst_idol_id, MstCostume.mst_costume_id)
    ).all()
    if not costumes:
        raise RuntimeError('preserved sailor-swimsuit costume group is missing')

    bulk_group = session.get(MstCostumeBulkChangeGroup, _COSTUME_GROUP_ID)
    if bulk_group is None:
        raise RuntimeError('preserved sailor-swimsuit bulk-change group is missing')

    sale_costume_ids = [c.mst_costume_id for c in costumes]
    owned_costume_ids = set(session.scalars(
        select(Costume.mst_costume_id)
        .where(Costume.user_id == user_id)
        .where(Costume.mst_costume_id.in_(sale_costume_ids))
    ))
    # A preservation/full-save profile already owns the content itself. Treat
    # that as authoritative shop ownership instead of forcing the player to
    # "buy" archived content again. The ledger remains useful for sparse or
    # imported saves where a sale is actually exercised through BuyCostume.
    purchased = (
        session.get(SalesCostumePurchase,
                    (user_id, _COSTUME_SALE_ID)) is not None
        or len(owned_costume_ids) == len(sale_costume_ids)
    )
    costume_list = MstCostumeSchema().dump(costumes, many=True)
    return {
        'id': _COSTUME_SALE_ID,
        'mst_sales_costume_price_id': _COSTUME_PRICE_ID,
        'costume_group_id': _COSTUME_GROUP_ID,
        'mst_costume_id': costumes[0].mst_costume_id,
        'resource_id': bulk_group.cbc_icon_resource_id,
        'sales_type': 1,  # SalesType.Free -- preservation mode has no billing.
        'price': 0,
        'comment': '',
        'has_costume': purchased,
        'num_sales_costumes': len(costumes),
        'num_have_costumes': len(costumes) if purchased else 0,
        'is_buyable': not purchased,
        'prerequisite_costume_group_id': 0,
        'begin_date': format_datetime(bulk_group.begin_date),
        'sort_id': bulk_group.cbc_sort_id,
        'price_begin_date': format_datetime(bulk_group.begin_date),
        'costume_list': costume_list,
        'mst_idol_id_list': [c.mst_idol_id for c in costumes],
    }


def _sales_song_status(session, user_id, mst_song):
    # The old client has no local sales-song master lookup; the server-provided
    # sales ID is only round-tripped into BuySongArgs.  Relive uses the real
    # mst_song_id as a stable compatibility sale/price key, while selecting the
    # catalog exclusively from real SongOpenType.Sale (=3) master rows.
    sale_id = mst_song.mst_song_id
    owned_song = session.scalar(
        select(Song.song_id)
        .where(Song.user_id == user_id)
        .where(Song.mst_song_id == mst_song.mst_song_id)
    )
    # As with costumes, full Relive saves already contain the playable song.
    # Existing content ownership therefore implies the legacy sale is owned.
    purchased = (
        session.get(SalesSongPurchase, (user_id, sale_id)) is not None
        or owned_song is not None
    )
    return {
        'id': sale_id,
        'mst_song_id': mst_song.mst_song_id,
        'mst_sales_song_price_id': sale_id,
        'resource_id': mst_song.resource_id,
        'idol_type': mst_song.idol_type,
        'sales_type': 1,  # SalesType.Free
        'price': 0,
        'comment': '',
        'has_song': purchased,
        'sort_id': mst_song.sort_id,
        'begin_date': '2018-01-01T00:00:00+0800',
    }


@dispatcher.add_method(name='NaviService.GetNaviList')
def get_navi_list(params):
    return {'navi_list': []}


@dispatcher.add_method(name='DramaService.GetDramaList')
def get_drama_list(params):
    return {'drama_list': []}


@dispatcher.add_method(name='BlogService.GetBlogList')
def get_blog_list(params):
    return {
        'blog_list': [],
        'cursor': '',
        'is_new_blog': False,
    }


@dispatcher.add_method(name='MailService.GetMailList')
def get_mail_list(params):
    return {
        'mail_list': [],
        'cursor': '',
        'is_new_mail': False,
    }


@dispatcher.add_method(name='PresentService.GetPresentHistory')
def get_present_history(params):
    # ReceivePresent currently consumes/deletes received rows and the legacy
    # database has no PresentHistory table, so an empty history is the only
    # truthful representation for existing saves.
    return {
        'present_history': [],
        'cursor': '',
    }


@dispatcher.add_method(name='ShopService.GetShopItemList')
def get_shop_item_list(params=None):
    # GetShopItemListReply has exactly one field: shop_item_list. Costume and
    # song sales use IdolService/SongService directly; do not fabricate a
    # platform billing product or the previously invented is_visible field.
    return {'shop_item_list': []}


@dispatcher.add_method(name='IdolService.GetSalesCostumeList',
                       context_arg='context')
def get_sales_costume_list(params=None, context=None):
    user_id = _context_user_id(context)
    with Session(engine) as session:
        return {'sales_costume_list': [_costume_sale_status(session, user_id)]}


@dispatcher.add_method(name='IdolService.BuyCostume', context_arg='context')
def buy_costume(params, context):
    user_id = _context_user_id(context)
    params = params or {}
    sale_id = int(params.get('mst_sales_costume_id', 0))
    price_id = int(params.get('mst_sales_costume_price_id', 0))
    if sale_id != _COSTUME_SALE_ID:
        raise ValueError('unknown mst_sales_costume_id')
    if price_id != _COSTUME_PRICE_ID:
        raise ValueError('invalid mst_sales_costume_price_id')

    with Session(engine) as session:
        sale = _costume_sale_status(session, user_id)
        costumes = session.scalars(
            select(MstCostume)
            .where(MstCostume.mst_costume_group_id == _COSTUME_GROUP_ID)
            .order_by(MstCostume.mst_idol_id, MstCostume.mst_costume_id)
        ).all()

        if session.get(SalesCostumePurchase, (user_id, sale_id)) is None:
            session.add(SalesCostumePurchase(
                user_id=user_id, mst_sales_costume_id=sale_id))

        # A normal/non-full Relive save also receives actual playable ownership.
        owned_ids = set(session.scalars(
            select(Costume.mst_costume_id)
            .where(Costume.user_id == user_id)
            .where(Costume.mst_costume_id.in_(
                [c.mst_costume_id for c in costumes]))
        ))
        for costume in costumes:
            if costume.mst_costume_id not in owned_ids:
                session.add(Costume(
                    costume_id=f'{user_id}_{costume.mst_costume_id}',
                    user_id=user_id,
                    mst_costume_id=costume.mst_costume_id,
                ))

        jewel = session.get(Jewel, user_id)
        session.commit()

        # Free preservation purchases do not mutate currency or mission state.
        return {
            'costume': sale['costume_list'][0],
            'mission_process': {
                'complete_mission_list': [],
                'open_mission_list': [],
                'update_mission_list': [],
                'training_point_diff': {
                    'mst_anniversary_id': 0,
                    'mst_item_id': 0,
                    'before': 0,
                    'after': 0,
                    'total': 0,
                },
                'idol_request_goal_mst_mission_id_list': [],
            },
            'mission_list': [],
            'buy_costume_result_status': {'result_comment': ''},
            'costume_substitute_item_list': [],
            'updated_idol_list': [],
            'updated_item_list': [],
            'jewel': (JewelSchema().dump(jewel) if jewel is not None else {
                'free_jewel_amount': 0,
                'paid_jewel_amount': 0,
            }),
        }


@dispatcher.add_method(name='SongService.GetSalesSongList', context_arg='context')
def get_sales_song_list(params=None, context=None):
    user_id = _context_user_id(context)
    with Session(engine) as session:
        sale_songs = session.scalars(
            select(MstSong)
            .where(MstSong.song_open_type == 3)  # SongOpenType.Sale
            .where(MstSong.is_visible.is_(True))
            .order_by(MstSong.sort_id, MstSong.mst_song_id)
        ).all()
        return {
            'sales_song_list': [
                _sales_song_status(session, user_id, song)
                for song in sale_songs
            ]
        }


@dispatcher.add_method(name='SongService.BuySong', context_arg='context')
def buy_song(params, context):
    user_id = _context_user_id(context)
    params = params or {}
    sale_id = int(params.get('mst_sales_song_id', 0))
    price_id = int(params.get('mst_sales_song_price_id', 0))
    if sale_id <= 0 or price_id != sale_id:
        raise ValueError('invalid sales song/price id')

    with Session(engine) as session:
        mst_song = session.scalar(
            select(MstSong)
            .where(MstSong.mst_song_id == sale_id)
            .where(MstSong.song_open_type == 3)
            .where(MstSong.is_visible.is_(True))
        )
        if mst_song is None:
            raise ValueError('song is not in the preserved sales catalog')

        if session.get(SalesSongPurchase, (user_id, sale_id)) is None:
            session.add(SalesSongPurchase(
                user_id=user_id, mst_sales_song_id=sale_id))

        song = session.scalar(
            select(Song)
            .where(Song.user_id == user_id)
            .where(Song.mst_song_id == mst_song.mst_song_id)
        )
        if song is None:
            song = Song(
                song_id=f'{user_id}_{mst_song.mst_song_id}',
                user_id=user_id,
                mst_song_id=mst_song.mst_song_id,
                is_released_horizontal_mv=True,
                is_released_vertical_mv=True,
                is_disable=False,
                is_new=True,
            )
            session.add(song)
        else:
            song.is_disable = False

        session.commit()
        # Refresh joined/viewonly relationships before marshmallow serialization.
        session.refresh(song)
        return {'song': SongSchema().dump(song)}


def _gallery_song_empty():
    return {'mst_song_id': 0, 'course_id': 0, 'score': 0}


@dispatcher.add_method(name='GalleryService.GetGallery', context_arg='context')
def get_gallery(params=None, context=None):
    """Return the profile/gallery summary expected by ProfileView.

    GalleryStatus is an aggregate server DTO rather than a master table.  Use
    the preserved save/master rows for the fields we can reconstruct exactly
    and neutral, non-null values for discontinued ranking/history counters.
    """
    user_id = _context_user_id(context)
    with Session(engine) as session:
        user = session.get(User, user_id)
        if user is None:
            raise LookupError('user not found')

        mst_cards = session.scalars(select(MstCard)).all()
        owned_cards = session.scalars(
            select(Card).where(Card.user_id == user_id)).all()
        owned_card_ids = {card.mst_card_id for card in owned_cards}

        card_idol_type_list = []
        for idol_type in (1, 2, 3):
            master_ids = {
                card.mst_card_id for card in mst_cards
                if card.idol_type == idol_type
            }
            card_idol_type_list.append({
                'idol_type': idol_type,
                'total': len(master_ids),
                'num_have_card': len(master_ids & owned_card_ids),
            })

        card_rarity_list = []
        for rarity in (1, 2, 3, 4):
            master_ids = {
                card.mst_card_id for card in mst_cards
                if card.rarity == rarity
            }
            card_rarity_list.append({
                'rarity': rarity,
                'total': len(master_ids),
                'num_have_card': len(master_ids & owned_card_ids),
            })

        awakening_by_rarity = [
            sum(1 for card in owned_cards
                if card.is_awakened and card.mst_card.rarity == rarity)
            for rarity in (1, 2, 3, 4)
        ]
        # The client displays cumulative master-lesson milestones 1..5.
        master_lesson_list = [
            sum(1 for card in owned_cards if card.master_rank >= rank)
            for rank in range(1, 6)
        ]
        costume_ids = list(session.scalars(
            select(Costume.mst_costume_id)
            .where(Costume.user_id == user_id)
            .order_by(Costume.mst_costume_id)
        ))
        number_of_fans = session.scalar(
            select(func.coalesce(func.sum(Idol.fan), 0))
            .where(Idol.user_id == user_id)
        ) or 0

        gallery = {
            'login_days': max(1, (user.last_login_date.date()
                                  - user.first_time_date.date()).days + 1),
            'number_of_awakening_list': awakening_by_rarity,
            'number_of_master_lesson_list': master_lesson_list,
            'card_idol_type_list': card_idol_type_list,
            'card_rarity_list': card_rarity_list,
            'number_of_a1st_cards': 0,
            'total_number_of_a1st_cards': 0,
            'number_of_a2nd_cards': 0,
            'total_number_of_a2nd_cards': 0,
            'number_of_a3rd_cards': 0,
            'total_number_of_a3rd_cards': 0,
            'number_of_a4th_cards': 0,
            'total_number_of_a4th_cards': 0,
            'number_of_a5th_cards': 0,
            'total_number_of_a5th_cards': 0,
            'number_of_a6th_cards': 0,
            'total_number_of_a6th_cards': 0,
            'number_of_a7th_cards': 0,
            'total_number_of_a7th_cards': 0,
            'number_of_a8th_cards': 0,
            'total_number_of_a8th_cards': 0,
            'number_of_a9th_cards': 0,
            'total_number_of_a9th_cards': 0,
            'number_of_albums': len(owned_card_ids),
            'total_number_of_albums': len(mst_cards),
            'number_of_fans': int(number_of_fans),
            'read_main_stories': 0,
            'read_memorials': 0,
            'read_episodes': 0,
            'read_costume_episodes': 0,
            'flower_stand_sent': 0,
            'flower_stand_received': 0,
            'job_count_list': [],
            'costume_list': costume_ids,
            'number_of_costumes': len(costume_ids),
            'number_of_contacts': 0,
            'produce_gauge': user.produce_gauge,
            # Course-indexed aggregates; six slots cover the legacy course IDs.
            'total_live_success_list': [0] * 6,
            'total_live_full_combo_list': [0] * 6,
            'song_high_score_all': _gallery_song_empty(),
            'song_high_score_princess': _gallery_song_empty(),
            'song_high_score_fairy': _gallery_song_empty(),
            'song_high_score_angel': _gallery_song_empty(),
            'event_rank_list': [],
            'offer_completed_count': 0,
            'attendant_album_list': [],
        }
        return {'gallery': gallery}


@dispatcher.add_method(name='GalleryService.GetGalleryEndRoll')
def get_gallery_end_roll(params=None):
    return {'end_roll_list': []}


def _target_user_id(params, context):
    target = (params or {}).get('target_user_id')
    if target:
        return UUID(target)
    return _context_user_id(context)


@dispatcher.add_method(name='NamecardService.GetNamecard', context_arg='context')
def get_namecard(params=None, context=None):
    target_user_id = _target_user_id(params, context)
    with Session(engine) as session:
        user = session.get(User, target_user_id)
        if user is None:
            raise LookupError('namecard user not found')

        namecard = session.get(Namecard, target_user_id)
        # ReadTwodCodeView passes the decoded QR payload verbatim as
        # GetProfileArgs.name_card_url.  The historical service generated that
        # opaque routing string server-side.  For Relive, the already-public
        # eight-character search ID is a compact, stable equivalent and fits
        # comfortably in the legacy 25-cell QR generator.
        qr_code = (namecard.qr_code if namecard and namecard.qr_code
                   else user.search_id)
        if namecard is None:
            # Empty layout strings are the original first-use state; the client
            # builds its editable default producer-card layout locally.
            return {
                'data_structure': '',
                'photo_data_structure': '',
                'qr_code': qr_code,
            }
        return {
            'data_structure': namecard.data_structure,
            'photo_data_structure': namecard.photo_data_structure,
            'qr_code': qr_code,
        }


@dispatcher.add_method(name='NamecardService.SetNamecard', context_arg='context')
def set_namecard(params, context):
    user_id = _context_user_id(context)
    params = params or {}
    with Session(engine) as session:
        namecard = session.get(Namecard, user_id)
        if namecard is None:
            namecard = Namecard(user_id=user_id)
            session.add(namecard)
        namecard.data_structure = params.get('data_structure') or ''
        namecard.photo_data_structure = params.get('photo_data_structure') or ''
        session.commit()
    return {}


@dispatcher.add_method(name='NamecardService.GetNamecardHolder',
                       context_arg='context')
def get_namecard_holder(params=None, context=None):
    _context_user_id(context)
    return {'namecard_holder_list': []}


@dispatcher.add_method(name='NamecardService.ReadNamecardHolder',
                       context_arg='context')
def read_namecard_holder(params, context):
    _context_user_id(context)
    return {}


@dispatcher.add_method(name='NamecardService.FavoriteNamecardHolder',
                       context_arg='context')
def favorite_namecard_holder(params, context):
    _context_user_id(context)
    return {}


@dispatcher.add_method(name='NamecardService.DeleteNamecardHolder',
                       context_arg='context')
def delete_namecard_holder(params, context):
    _context_user_id(context)
    return {}


@dispatcher.add_method(name='NamecardService.SendNamecardHolder',
                       context_arg='context')
def send_namecard_holder(params, context):
    _context_user_id(context)
    return {}
