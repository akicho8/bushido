require "./example_helper"

info = Parser.file_parse("yagura.kif")
tp info.mediator.players.collect {|e| {player: e.call_name, defense_infos: e.defense_infos.collect(&:name)} }
puts info.to_ki2
# >> |--------+--------------------------------|
# >> | player | defense_infos                  |
# >> |--------+--------------------------------|
# >> | 先手   | ["金矢倉", "総矢倉", "菱矢倉"] |
# >> | 後手   | []                             |
# >> |--------+--------------------------------|
# >> 開始日時：1981/05/15 09:00:00
# >> 棋戦：名将戦
# >> 場所：東京「将棋会館」
# >> 手合割：平手
# >> 先手：加藤一二三
# >> 後手：原田泰夫
# >> 戦型：矢倉
# >> 先手の囲い：金矢倉→総矢倉→菱矢倉
# >> 後手の囲い：
# >> 先手の戦型：
# >> 後手の戦型：
# >> 
# >> ▲７六歩   △８四歩   ▲６八銀   △３四歩 ▲７七銀   △６二銀     ▲２六歩   △４二銀   ▲４八銀   △３二金
# >> ▲５六歩   △４一玉   ▲７八金   △５四歩 ▲６九玉   △７四歩     ▲３六歩   △５三銀右 ▲５七銀   △４四歩
# >> ▲２五歩   △３三角   ▲５八金   △４三銀 ▲７九角   △５一角     ▲６八角   △５二金   ▲７九玉   △３一玉
# >> ▲６六歩   △８五歩   ▲６七金右 △１四歩 ▲８八玉   △９四歩     ▲９六歩   △１五歩   ▲４六歩   △２二玉
# >> ▲５九角   △６四歩   ▲２六角   △８四角 ▲３七桂   △３三桂     ▲２九飛   △７三桂   ▲１八香   △６五歩
# >> ▲１六歩   △同　歩   ▲１九飛   △８一飛 ▲１六香   △１四歩     ▲同　香   △同　香   ▲１五歩   △同　香
# >> ▲同　飛   △１四歩   ▲１九飛   △６六歩 ▲同銀右   △６五歩     ▲５七銀   △９五歩   ▲同　歩   △同　香
# >> ▲９六歩   △同　香   ▲同　香   △９五歩 ▲同　香   △同　角     ▲９九香   △８四角   ▲６八金引 △６六歩
# >> ▲同銀右   △６七歩   ▲同金直   △６三香 ▲１三歩   △６六香     ▲同　金   △６三香   ▲６七歩   △５七銀
# >> ▲６九香   △６五桂   ▲同　金   △同　香 ▲３五歩   △５八銀不成 ▲３四歩   △同　銀   ▲３六香   △２七金
# >> ▲１二歩成 △３一玉   ▲３四香   △２六金 ▲３三香成 △同　金     ▲３四歩   △３二金   ▲４五桂打 △同　歩
# >> ▲同　桂   △４二玉   ▲３三歩成 △同　金 ▲同桂成   △同　玉     ▲３五銀   △５七角成 ▲４五桂   △４二玉
# >> ▲６八金打 △４七馬   ▲３四歩   △８六桂 ▲同　歩   △同　歩     ▲８五歩   △６七香成 ▲同金直   △６九銀不成
# >> ▲８六銀   △７八銀成 ▲同　玉   △６六歩 ▲同　金   △６三香     ▲３三歩成 △５一玉   ▲５三桂成 △６九角
# >> ▲同　飛   △同　馬   ▲同　玉   △６六香 ▲６八歩   △同香成     ▲同　玉   △８八飛   ▲７八銀   △６四香
# >> ▲６七歩   △５八金   ▲７九玉
# >> まで153手で先手の勝ち
