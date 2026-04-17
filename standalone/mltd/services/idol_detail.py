from uuid import UUID

from jsonrpc import dispatcher
from sqlalchemy import select
from sqlalchemy.orm import Session
from sqlalchemy.util import defaultdict

from mltd.models.engine import engine
from mltd.models.models import MstVoiceCategory, Card, MstCard, MstCostume, MstDirectionCategory, MstIdol
from mltd.models.schemas import MstVoiceCategorySchema, CardSchema, MstDirectionCategorySchema, IdolDetailAlbumSchema, MstCostumeSchema

@dispatcher.add_method(name='IdolDetailService.GetIdolDetailList', context_arg='context')
def get_idol_detail_list(params, context):
    """Get a list of ...

    Invoked when 
    Args:
        params: An empty dict.
    Returns:
        A dict containing the following keys.
        idol_detail_list: A list of dicts
            mst_idol_id: master idol id
            album_list: a list of album objects
            costume_list: a list of costume objects
            idol_detail_costume_list: a list of dicts
                has_costume: True
                costume:  (costume object)
            direction_category_list: a list of direction category objects
            card_list: a list of card objects
        voice_category_list: a list of voice category objects
    
    TODO: direction_category: some idol's birthday should not be returned
    """
    with Session(engine) as session:
        mst_idol_ids = session.scalars(
            select(MstIdol.mst_idol_id)
        ).all()
        costume_list = session.scalars(
            select(MstCostume)
        ).all()
        mst_card_list = session.scalars(
            select(MstCard)
        ).all()
        card_list = session.scalars(
            select(Card)
            .where(Card.user_id == UUID(context['user_id']))
        ).all()
        direction_category_list = session.scalars(
            select(MstDirectionCategory)
        ).all()
        voice_category_list = session.scalars(
            select(MstVoiceCategory)
        ).all()

        album_schema = IdolDetailAlbumSchema()
        owned_album_list = album_schema.dump(mst_card_list, many=True)
        for card in owned_album_list:
            card['is_awakened'] = False
        awakened_album_list = album_schema.dump(mst_card_list, many=True)
        for card in awakened_album_list:
            card['is_awakened'] = True
        album_list = owned_album_list
        album_list.extend(awakened_album_list)

        costume_schema = MstCostumeSchema()
        costume_list = costume_schema.dump(costume_list, many=True)
        direction_category_schema = MstDirectionCategorySchema()
        direction_category_list = direction_category_schema.dump(direction_category_list, many=True)
        card_schema = CardSchema()
        card_list = card_schema.dump(card_list, many=True)
        voice_category_schema = MstVoiceCategorySchema()
        voice_category_list = voice_category_schema.dump(voice_category_list, many=True)

        album_by_idol = defaultdict(list)
        for album in album_list:
            album_by_idol[album['mst_idol_id']].append(album)

        costume_by_idol = defaultdict(list)
        for costume in costume_list:
            costume_by_idol[costume['mst_idol_id']].append(costume)

        card_by_idol = defaultdict(list)
        for card in card_list:
            card_by_idol[card['mst_idol_id']].append(card)

        idol_detail_list = []
        for mst_idol_id in mst_idol_ids:
            album_list_for_idol = album_by_idol.get(mst_idol_id, [])
            costume_list_for_idol = costume_by_idol.get(mst_idol_id, [])
            card_list_for_idol = card_by_idol.get(mst_idol_id, [])

            idol_detail_list.append({
                'mst_idol_id': mst_idol_id,
                'album_list': album_list_for_idol,
                'costume_list': costume_list_for_idol,
                'idol_detail_costume_list': [
                    {'has_costume': True, 'costume': costume}
                    for costume in costume_list_for_idol
                ],
                'direction_category_list': direction_category_list, 
                'card_list': [
                    {'is_has_card': True, 'card': card}
                    for card in card_list_for_idol
                ],
            })
        
    return {
        'idol_detail_list': idol_detail_list,
        'voice_category_list': voice_category_list,
    }
        