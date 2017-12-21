require "./example_helper"

# tp TacticInfo.all_soldier_points_hash1.inject({}) {|a, (k, v)| a.merge(k.name => v.count) }
# tp TacticInfo.all_soldier_points_hash2.inject({}) {|a, (k, v)| a.merge(k.name => v.count) }
tp TacticInfo.primary_soldiers.inject({}) {|a, (k, v)| a.merge(k.name => v.count) }

tp TacticInfo.all_soldier_points_hash.inject({}) {|a, (k, v)| a.merge(k.name => v.count) }

# >> |----------+----|
# >> | ▲７六歩 | 7  |
# >> | ▲５六歩 | 5  |
# >> | ▲６七歩 | 7  |
# >> | ▲７八金 | 23 |
# >> | ▲６八銀 | 3  |
# >> | ▲５八金 | 13 |
# >> | ▲６九玉 | 7  |
# >> | ▲７七銀 | 12 |
# >> | ▲６七金 | 9  |
# >> | ▲８八玉 | 6  |
# >> | ▲６七銀 | 2  |
# >> | ▲７八玉 | 5  |
# >> | ▲６八金 | 3  |
# >> | ▲５七銀 | 2  |
# >> | ▲９八香 | 5  |
# >> | ▲９九玉 | 5  |
# >> | ▲８八銀 | 6  |
# >> | ▲９九香 | 3  |
# >> | ▲８九玉 | 2  |
# >> | ▲７六銀 | 1  |
# >> | ▲６六銀 | 3  |
# >> | ▲２七歩 | 3  |
# >> | ▲３八銀 | 8  |
# >> | ▲２八玉 | 11 |
# >> | ▲４九金 | 9  |
# >> | ▲４七金 | 2  |
# >> | ▲２七銀 | 4  |
# >> | ▲３八金 | 4  |
# >> | ▲４七銀 | 4  |
# >> | ▲２六歩 | 1  |
# >> | ▲３七歩 | 2  |
# >> | ▲７八銀 | 3  |
# >> | ▲６九金 | 7  |
# >> | ▲８七玉 | 2  |
# >> | ▲８七銀 | 3  |
# >> | ▲９八玉 | 2  |
# >> | ▲８九桂 | 6  |
# >> | ▲４八銀 | 5  |
# >> | ▲７九銀 | 4  |
# >> | ▲７九金 | 3  |
# >> | ▲８八金 | 1  |
# >> | ▲２八銀 | 2  |
# >> | ▲１八香 | 1  |
# >> | ▲３九金 | 2  |
# >> | ▲２九桂 | 2  |
# >> | ▲１九玉 | 1  |
# >> | ▲３七銀 | 4  |
# >> | ▲４八金 | 1  |
# >> | ▲３八玉 | 1  |
# >> | ▲５八玉 | 2  |
# >> | ▲５九金 | 2  |
# >> | ▲６八玉 | 1  |
# >> | △９一香 | 1  |
# >> | △８一桂 | 1  |
# >> | △２一桂 | 1  |
# >> | △１一香 | 1  |
# >> | △８二飛 | 1  |
# >> | △３二金 | 1  |
# >> | △７三金 | 1  |
# >> | △６三銀 | 1  |
# >> | △４三銀 | 1  |
# >> | △３三歩 | 1  |
# >> | △２三歩 | 1  |
# >> | △９四歩 | 1  |
# >> | △７四歩 | 1  |
# >> | △６四角 | 1  |
# >> | △５四歩 | 1  |
# >> | △４四歩 | 1  |
# >> | △３四歩 | 1  |
# >> | △１四歩 | 1  |
# >> | △８五歩 | 1  |
# >> | ▲２五歩 | 3  |
# >> | ▲９六歩 | 1  |
# >> | ▲６六歩 | 2  |
# >> | ▲４六角 | 1  |
# >> | ▲３六歩 | 1  |
# >> | ▲１六歩 | 1  |
# >> | ▲８七歩 | 1  |
# >> | ▲６七角 | 1  |
# >> | ▲４七歩 | 2  |
# >> | ▲２八飛 | 3  |
# >> | ▲１九香 | 1  |
# >> | ▲２六銀 | 1  |
# >> | ▲３七桂 | 3  |
# >> | ▲３八飛 | 3  |
# >> | ▲１七香 | 1  |
# >> | ▲１八飛 | 1  |
# >> | ▲８八角 | 3  |
# >> | ▲５八飛 | 7  |
# >> | ▲５九玉 | 2  |
# >> | ▲５五角 | 1  |
# >> | ▲４八飛 | 2  |
# >> | ▲４八玉 | 2  |
# >> | ▲２九飛 | 2  |
# >> | ▲６五銀 | 1  |
# >> | ▲５五歩 | 3  |
# >> | ▲９八金 | 1  |
# >> | ▲５九飛 | 3  |
# >> | ▲２六角 | 1  |
# >> | ▲５六銀 | 4  |
# >> | ▲４六銀 | 6  |
# >> | ▲４五角 | 1  |
# >> | ▲４五歩 | 1  |
# >> | ▲２二馬 | 2  |
# >> | ▲２六飛 | 1  |
# >> | ▲２四歩 | 1  |
# >> | ▲５六飛 | 1  |
# >> | ▲３六銀 | 1  |
# >> | ▲２五飛 | 1  |
# >> | ▲３四飛 | 2  |
# >> | ▲７七角 | 1  |
# >> | ▲７七桂 | 5  |
# >> | ▲６五角 | 1  |
# >> | ▲５七金 | 1  |
# >> | ▲２一龍 | 1  |
# >> | ▲６八飛 | 4  |
# >> | ▲４六歩 | 2  |
# >> | ▲６五歩 | 1  |
# >> | ▲７八飛 | 8  |
# >> | ▲９七角 | 1  |
# >> | ▲７五歩 | 4  |
# >> | ▲８八飛 | 7  |
# >> | ▲７六飛 | 2  |
# >> | ▲３七角 | 1  |
# >> | ▲７四歩 | 1  |
# >> | ▲８六歩 | 1  |
# >> | △３三角 | 1  |
# >> | ▲４五桂 | 1  |
# >> | ▲９九飛 | 1  |
# >> | ▲７九角 | 1  |
# >> | ▲２七金 | 1  |
# >> |----------+----|
# >> |----------+----|
# >> | ▲７六歩 | 11 |
# >> | ▲５六歩 | 7  |
# >> | ▲６七歩 | 9  |
# >> | ▲７八金 | 42 |
# >> | ▲６八銀 | 7  |
# >> | ▲５八金 | 16 |
# >> | ▲６九玉 | 9  |
# >> | ▲７七銀 | 16 |
# >> | ▲６七金 | 9  |
# >> | ▲８八玉 | 7  |
# >> | ▲６七銀 | 5  |
# >> | ▲７八玉 | 12 |
# >> | ▲６八金 | 3  |
# >> | ▲５七銀 | 4  |
# >> | ▲９八香 | 5  |
# >> | ▲９九玉 | 5  |
# >> | ▲８八銀 | 9  |
# >> | ▲９九香 | 5  |
# >> | ▲８九玉 | 2  |
# >> | ▲７六銀 | 1  |
# >> | ▲６六銀 | 3  |
# >> | ▲２七歩 | 3  |
# >> | ▲３八銀 | 12 |
# >> | ▲２八玉 | 12 |
# >> | ▲４九金 | 17 |
# >> | ▲４七金 | 3  |
# >> | ▲２七銀 | 4  |
# >> | ▲３八金 | 4  |
# >> | ▲４七銀 | 8  |
# >> | ▲２六歩 | 1  |
# >> | ▲３七歩 | 5  |
# >> | ▲７八銀 | 5  |
# >> | ▲６九金 | 10 |
# >> | ▲８七玉 | 2  |
# >> | ▲８七銀 | 3  |
# >> | ▲９八玉 | 2  |
# >> | ▲８九桂 | 7  |
# >> | ▲４八銀 | 7  |
# >> | ▲７九銀 | 11 |
# >> | ▲７九金 | 3  |
# >> | ▲８八金 | 1  |
# >> | ▲２八銀 | 2  |
# >> | ▲１八香 | 1  |
# >> | ▲３九金 | 2  |
# >> | ▲２九桂 | 4  |
# >> | ▲１九玉 | 1  |
# >> | ▲３七銀 | 4  |
# >> | ▲４八金 | 1  |
# >> | ▲３八玉 | 1  |
# >> | ▲５八玉 | 2  |
# >> | ▲５九金 | 3  |
# >> | ▲６八玉 | 1  |
# >> | ▲２八飛 | 15 |
# >> | △９一香 | 1  |
# >> | △８一桂 | 1  |
# >> | △２一桂 | 1  |
# >> | △１一香 | 1  |
# >> | △８二飛 | 5  |
# >> | △３二金 | 13 |
# >> | △７三金 | 1  |
# >> | △６三銀 | 1  |
# >> | △４三銀 | 3  |
# >> | △３三歩 | 1  |
# >> | △２三歩 | 5  |
# >> | △９四歩 | 1  |
# >> | △７四歩 | 2  |
# >> | △６四角 | 1  |
# >> | △５四歩 | 2  |
# >> | △４四歩 | 3  |
# >> | △３四歩 | 15 |
# >> | △１四歩 | 3  |
# >> | △８五歩 | 5  |
# >> | ▲２五歩 | 7  |
# >> | ▲９六歩 | 1  |
# >> | ▲６六歩 | 5  |
# >> | ▲４六角 | 1  |
# >> | ▲３六歩 | 4  |
# >> | ▲１六歩 | 3  |
# >> | ▲８七歩 | 1  |
# >> | ▲６七角 | 1  |
# >> | ▲４七歩 | 6  |
# >> | ▲１九香 | 2  |
# >> | ▲２六銀 | 1  |
# >> | ▲３七桂 | 6  |
# >> | ▲３八飛 | 3  |
# >> | ▲１七香 | 1  |
# >> | ▲１八飛 | 1  |
# >> | ▲８八角 | 9  |
# >> | ▲５八飛 | 11 |
# >> | ▲５九玉 | 9  |
# >> | ▲５五角 | 1  |
# >> | ▲４八飛 | 3  |
# >> | ▲４八玉 | 4  |
# >> | ▲２九飛 | 2  |
# >> | ▲６五銀 | 1  |
# >> | ▲５五歩 | 3  |
# >> | ▲７九角 | 3  |
# >> | ▲９八金 | 1  |
# >> | ▲５九飛 | 3  |
# >> | ▲２六角 | 1  |
# >> | ▲４六歩 | 6  |
# >> | ▲５七歩 | 8  |
# >> | ▲５六銀 | 5  |
# >> | △５三歩 | 3  |
# >> | △３三銀 | 1  |
# >> | ▲４六銀 | 6  |
# >> | △６三歩 | 1  |
# >> | △４三歩 | 1  |
# >> | ▲４五角 | 1  |
# >> | △５二金 | 1  |
# >> | △２二玉 | 1  |
# >> | △７三桂 | 1  |
# >> | ▲４五歩 | 1  |
# >> | ▲２二馬 | 2  |
# >> | △３一銀 | 4  |
# >> | △２二角 | 5  |
# >> | ▲３九銀 | 4  |
# >> | ▲２六飛 | 3  |
# >> | △６四歩 | 1  |
# >> | ▲２四歩 | 1  |
# >> | ▲５六飛 | 1  |
# >> | ▲３六銀 | 1  |
# >> | △７四飛 | 1  |
# >> | ▲７七角 | 6  |
# >> | ▲２五飛 | 1  |
# >> | △８六飛 | 1  |
# >> | ▲３四飛 | 2  |
# >> | ▲２四飛 | 3  |
# >> | △７六飛 | 4  |
# >> | ▲７七桂 | 6  |
# >> | △２二銀 | 1  |
# >> | ▲６五角 | 1  |
# >> | △５二飛 | 4  |
# >> | ▲７八飛 | 15 |
# >> | ▲５七金 | 1  |
# >> | △５一玉 | 2  |
# >> | △３三角 | 7  |
# >> | ▲２一龍 | 1  |
# >> | ▲６八飛 | 8  |
# >> | ▲６五歩 | 1  |
# >> | ▲７六飛 | 3  |
# >> | ▲９七角 | 2  |
# >> | △８三歩 | 1  |
# >> | ▲７五歩 | 8  |
# >> | △８四歩 | 1  |
# >> | △１一玉 | 1  |
# >> | ▲８八飛 | 9  |
# >> | ▲３七角 | 1  |
# >> | ▲７四歩 | 1  |
# >> | ▲７七金 | 1  |
# >> | △７六歩 | 1  |
# >> | ▲８六歩 | 1  |
# >> | △４二飛 | 4  |
# >> | ▲４五桂 | 1  |
# >> | △７三歩 | 1  |
# >> | ▲９九飛 | 1  |
# >> | ▲７七歩 | 2  |
# >> | △１三歩 | 1  |
# >> | △３二銀 | 1  |
# >> | ▲２七金 | 1  |
# >> | △５五歩 | 1  |
# >> |----------+----|
