require "./example_helper"

mediator = Mediator.start
loop do
  hand = mediator.current_player.brain.all_hands.sample
  mediator.execute(hand)
  last_captured_piece = mediator.flip_player.last_captured_piece
  if last_captured_piece && last_captured_piece.key == :king
    break
  end
end
puts mediator.to_s
puts mediator.kif_hand_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
puts mediator.ki2_hand_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
# >> 後手の持駒：なし
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ 馬 ・ ・v桂 杏 ・|一
# >> | と ・ ・ ・v歩v金 ・v桂 ・|二
# >> | と ・v桂 ・v金 ・ ・ ・v歩|三
# >> |v香 ・v歩 銀 ・ ・ 銀 ・v香|四
# >> | ・ ・ ・ ・v桂v飛 ・ ・ 歩|五
# >> |v金 ・ 歩v歩 ・ ・ ・v歩 ・|六
# >> | ・ ・ ・ 歩 ・v歩 歩v銀 ・|七
# >> |v香v歩 ・ 玉 歩 ・v歩 ・ ・|八
# >> | 歩 ・ 飛 ・ 角 ・ 銀v金 ・|九
# >> +---------------------------+
# >> 先手の持駒：玉 歩二
# >> 手数＝259 ▲６一馬(72) まで
# >> 
# >> 後手番
# >> ３八飛(28) ５四歩(53) ２八飛(38) ３二銀(31) １八飛(28) ５二玉(51) ２六歩(27) ６二玉(52)
# >> ５八玉(59) ７二飛(82) ５九玉(58) ５二金(41) ５八金(69) １四歩(13) ７八銀(79) １三香(11)
# >> ３八飛(18) ３四歩(33) ７九角(88) ８四歩(83) ６八金(58) ３五歩(34) ４六歩(47) ３三桂(21)
# >> ８八角(79) ９二香(91) １八香(19) ８二飛(72) ４八玉(59) ５五歩(54) ５九玉(48) ８三飛(82)
# >> ９六歩(97) ２五桂(33) ５六歩(57) ４四歩(43) ４八金(49) ７四歩(73) ９五歩(96) ５一金(61)
# >> ２五歩(26) ７三玉(62) ９四桂打 ７二銀(71) ４九玉(59) １五歩(14) ９八香(99) １六歩(15)
# >> ９七桂(89) ４一金(51) ６六歩(67) １四香(13) ６九金(68) ５一金(52) ４七金(48) ６一金(51)
# >> ８六歩(87) ２四歩(23) ５八金(69) ４五歩(44) ６七金(58) １七歩(16) ７六金(67) ５一金(41)
# >> ６八飛(38) ６二玉(73) ８五桂(97) ７三銀(72) ７三桂(85) ８五歩(84) ５五歩(56) ５三歩打
# >> ２八銀打 ８六歩(85) １九銀(28) ２五歩(24) ９九角(88) １六香(14) ２八飛(68) ７一金(61)
# >> ６八飛(28) ２三銀(32) ８四歩打 １四銀(23) ３八飛(68) ４一金(51) ６七銀(78) ５二金(41)
# >> ５六銀(67) ６四歩(63) ５九玉(49) ５四歩(53) ２八銀(39) ７二金(71) ６八玉(59) ２三銀(14)
# >> ９六香(98) ３三角(22) １七銀(28) １二歩打 ８六金(76) ４六歩(45) ８二桂成(94) ６五歩(64)
# >> ３六金(47) ７三飛(83) ８三歩成(84) ６七桂打 ５九玉(68) ５一玉(62) ４八歩打 ６二金(72)
# >> ９二と(83) ７一飛(73) ６五歩(66) ７三飛(71) ２四香打 ６八歩打 ８八角(99) ５五角(33)
# >> ２五金(36) １七香成(16) ８四歩打 ９一銀打 ７二圭(82) ６三飛(73) ８二圭(72) ４三金(52)
# >> ６九玉(59) １六杏(17) １六香(18) ５三金(43) １五歩打 ８三歩打 １八飛(38) ７三角(55)
# >> ２七歩打 １三歩(12) ９九香打 ６一金(62) ８三歩(84) ３四銀(23) ７二圭(82) ２五銀(34)
# >> ７九角(88) ５九桂成(67) ３八飛(18) ９五角(73) ２一香成(24) ５二玉(51) ８二圭(72) ３六歩(35)
# >> ５五歩打 ６五飛(63) ４七銀(56) １四銀(25) ６八角(79) ６七飛成(65) ３六銀(47) ４二玉(52)
# >> ３一杏(21) ４三玉(42) ５八玉(69) １八金打 ５四歩(55) ５二歩打 ９七香(99) ５一金(61)
# >> ８七金(86) ４二玉(43) ４五銀(36) ５七龍(67) ５七角(68) ４一玉(42) ２一杏(31) ４四金(53)
# >> ９九歩打 ６二歩打 ４七歩(48) ２五銀(14) ６三飛打 １六銀(25) ７二圭(82) １四香打
# >> ８六金(87) ８八歩打 ６九飛(63) ５四金(44) ２六歩(27) ４九圭(59) ５九歩打 ４七歩(46)
# >> ８七金(86) ２五歩打 ３九飛(38) ４八圭(49) ６二圭(72) ３九圭(48) ６七歩打 ５三金(54)
# >> ２八銀(19) ４二金(51) １一杏(21) ７三角(95) ５四銀(45) ８二銀(91) ３九角(57) ３八歩打
# >> ８五桂打 ５一飛打 ４五銀(54) ２六歩(25) ６八玉(58) ２七銀(16) ８二歩成(83) ６一飛(51)
# >> ３六銀打 ６二飛(61) ２五銀(36) ２二桂打 ８八金(87) ２九金(18) ５六銀(45) ６四飛(62)
# >> ７六歩(77) ３一桂打 ７五角(39) ８七歩打 ５八歩(59) ８八歩(87) ４四歩打 ４四飛(64)
# >> ９三と(92) ９八金打 ４八角(75) ６六歩打 ７九飛(69) ５一玉(41) ７三桂(85) ６二玉(51)
# >> ６五銀(56) ４三飛(44) ５四角打 ４五飛(43) ６四銀(65) ９七金(98) ２一杏(11) ６一玉(62)
# >> ７二角成(54) ９八香打 ９二と(82) ７三桂(81) ３四銀(25) ９六金(97) ３九銀(28) ５五桂打
# >> ５九角(48) ９四香打 ６一馬(72)
# >> ▲３八飛 △５四歩 ▲２八飛 △３二銀 ▲１八飛 △５二玉 ▲２六歩 △６二玉
# >> ▲５八玉 △７二飛 ▲５九玉 △５二金左 ▲５八金左 △１四歩 ▲７八銀 △１三香
# >> ▲３八飛 △３四歩 ▲７九角 △８四歩 ▲６八金 △３五歩 ▲４六歩 △３三桂
# >> ▲８八角 △９二香 ▲１八香 △８二飛 ▲４八玉 △５五歩 ▲５九玉 △８三飛
# >> ▲９六歩 △２五桂 ▲５六歩 △４四歩 ▲４八金 △７四歩 ▲９五歩 △５一金寄
# >> ▲２五歩 △７三玉 ▲９四桂 △７二銀 ▲４九玉 △１五歩 ▲９八香 △１六歩
# >> ▲９七桂 △４一金 ▲６六歩 △１四香 ▲６九金 △５一金引 ▲４七金 △６一金
# >> ▲８六歩 △２四歩 ▲５八金 △４五歩 ▲６七金 △１七歩不成 ▲７六金 △５一金左
# >> ▲６八飛 △６二玉 ▲８五桂 △７三銀 ▲同桂不成 △８五歩 ▲５五歩 △５三歩
# >> ▲２八銀打 △８六歩 ▲１九銀 △２五歩 ▲９九角 △１六香 ▲２八飛 △７一金
# >> ▲６八飛 △２三銀 ▲８四歩 △１四銀 ▲３八飛 △４一金 ▲６七銀 △５二金
# >> ▲５六銀 △６四歩 ▲５九玉 △５四歩 ▲２八銀左 △７二金 ▲６八玉 △２三銀
# >> ▲９六香 △３三角 ▲１七銀 △１二歩 ▲８六金 △４六歩 ▲８二桂成 △６五歩
# >> ▲３六金 △７三飛 ▲８三歩成 △６七桂 ▲５九玉 △５一玉 ▲４八歩 △６二金右
# >> ▲９二と △７一飛 ▲６五歩 △７三飛 ▲２四香 △６八歩 ▲８八角 △５五角
# >> ▲２五金 △１七香成 ▲８四歩 △９一銀 ▲７二圭 △６三飛 ▲８二圭 △４三金
# >> ▲６九玉 △１六杏 ▲同香 △５三金寄 ▲１五歩 △８三歩 ▲１八飛 △７三角
# >> ▲２七歩 △１三歩 ▲９九香 △６一金 ▲８三歩不成 △３四銀 ▲７二圭 △２五銀
# >> ▲７九角 △５九桂成 ▲３八飛 △９五角 ▲２一香成 △５二玉 ▲８二圭 △３六歩
# >> ▲５五歩 △６五飛 ▲４七銀 △１四銀 ▲６八角 △６七飛成 ▲３六銀 △４二玉
# >> ▲３一杏 △４三玉 ▲５八玉 △１八金 ▲５四歩 △５二歩 ▲９七香 △５一金
# >> ▲８七金 △４二玉 ▲４五銀 △５七龍 ▲同角 △４一玉 ▲２一杏 △４四金
# >> ▲９九歩 △６二歩 ▲４七歩 △２五銀 ▲６三飛 △１六銀 ▲７二圭 △１四香
# >> ▲８六金 △８八歩 ▲６九飛不成 △５四金 ▲２六歩 △４九圭 ▲５九歩 △４七歩不成
# >> ▲８七金 △２五歩 ▲３九飛 △４八圭 ▲６二圭 △３九圭 ▲６七歩 △５三金
# >> ▲２八銀 △４二金 ▲１一杏 △７三角 ▲５四銀 △８二銀 ▲３九角 △３八歩
# >> ▲８五桂 △５一飛 ▲４五銀 △２六歩 ▲６八玉 △２七銀不成 ▲８二歩成 △６一飛
# >> ▲３六銀打 △６二飛 ▲２五銀 △２二桂 ▲８八金 △２九金 ▲５六銀 △６四飛
# >> ▲７六歩 △３一桂 ▲７五角 △８七歩 ▲５八歩 △８八歩不成 ▲４四歩 △同飛
# >> ▲９三と △９八金 ▲４八角 △６六歩 ▲７九飛 △５一玉 ▲７三桂不成 △６二玉
# >> ▲６五銀 △４三飛 ▲５四角 △４五飛 ▲６四銀 △９七金 ▲２一杏 △６一玉
# >> ▲７二角成 △９八香 ▲９二と寄 △７三桂 ▲３四銀 △９六金 ▲３九銀 △５五桂
# >> ▲５九角 △９四香 ▲６一馬
