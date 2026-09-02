#!/usr/bin/env python3
from collections import Counter
from pathlib import Path

from mltd.models.setup import setup
from mltd.services.theater import get_theater

DB = Path('mltd-relive.db')
if DB.exists():
    DB.unlink()
setup()

context = {'user_id': 'ffffffff-ffff-ffff-ffff-ffffffffffff'}
resource_counts = Counter()
reaction_counts = Counter()
room_count = 0
iterations = 2000
for _ in range(iterations):
    result = get_theater({}, context)
    for room in result['theater']['room_list']:
        room_count += 1
        balloon = room['balloon']
        resource_counts[balloon['resource_id']] += 1
        for idol in balloon['room_idol_list'] or []:
            reaction_counts[idol.get('reaction_id')] += 1

print('iterations=', iterations, 'rooms=', room_count)
print('unique_resources=', len(resource_counts))
print('card_0000_contact_count=', resource_counts['card_0000_contact'])
print('card_0000_contact_rate=', resource_counts['card_0000_contact'] / max(1, room_count))
print('top_resources=', resource_counts.most_common(20))
print('sample_card_reactions=', [item for item in reaction_counts.most_common() if item[0] and '_SR' in item[0]][:30])
assert room_count > 0
assert resource_counts['card_0000_contact'] > 0, 'card_0000_contact was not selected in runtime sampling'
