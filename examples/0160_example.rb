# KIFファイルの読み込み
require "./example_helper"

info = Bushido.parse(Pathname("ryuou20101214.kif"))
pp info.header

mediator = Mediator.start
mediator.piece_plot
info.move_infos.each{|info| # !> shadowing outer local variable - info
  mediator.execute(info[:input])
}
puts mediator.inspect
puts mediator.simple_hand_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
puts mediator.human_hand_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
# >> {"対局ID"=>"333",
# >>  "開始日時"=>"2010/12/14 9:00",
# >>  "終了日時"=>"2010/12/15 19:13",
# >>  "表題"=>"竜王戦",
# >>  "棋戦"=>"第23期竜王戦七番勝負第6局",
# >>  "持ち時間"=>"各8時間",
# >>  "消費時間"=>"146▲479△471",
# >>  "場所"=>"岐阜・ホテルアソシア高山リゾート",
# >>  "手合割"=>"平手",
# >>  "先手"=>"羽生善治",
# >>  "後手"=>"渡辺　明"}
# >> 147手目: ▲先手番
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・v桂 ・ ・ 馬 ・ ・v桂v香|一
# >> |v飛 ・ ・ ・ ・ と ・ ・ ・|二
# >> | ・ ・ ・ 全v歩 ・v玉 ・ ・|三
# >> | ・ ・ ・ ・ ・ ・v桂 ・v金|四
# >> | ・v歩 ・ ・ ・ 銀v歩v歩v歩|五
# >> |v歩 ・ 歩v角 ・ ・ ・ ・ ・|六
# >> | ・ 歩 銀v歩vと ・ ・ ・ ・|七
# >> | 歩 ・ 玉 香 ・ ・ ・ ・ 香|八
# >> | 香 桂 ・ ・ ・ ・ 飛 ・ ・|九
# >> +---------------------------+
# >> ▲先手の持駒:歩三 金
# >> ▽後手の持駒:金二 歩三 銀
# >> ▲7六歩(77) ▽8四歩(83) ▲7八金(69) ▽3二金(41) ▲2六歩(27) ▽8五歩(84) ▲7七角(88) ▽3四歩(33)
# >> ▲8八銀(79) ▽7七角成(22) ▲7七銀(88) ▽4二銀(31) ▲3八銀(39) ▽7二銀(71) ▲9六歩(97) ▽9四歩(93)
# >> ▲4六歩(47) ▽6四歩(63) ▲4七銀(38) ▽6三銀(72) ▲6八玉(59) ▽3三銀(42) ▲5八金(49) ▽5四銀(63)
# >> ▲3六歩(37) ▽4二玉(51) ▲7九玉(68) ▽6五歩(64) ▲5六銀(47) ▽5二金(61) ▲1六歩(17) ▽1四歩(13)
# >> ▲3七桂(29) ▽3一玉(42) ▲4七金(58) ▽4四歩(43) ▲2五歩(26) ▽4三金(52) ▲8八玉(79) ▽2二玉(31)
# >> ▲4八金(47) ▽4二金(43) ▲2九飛(28) ▽4三金(42) ▲1八香(19) ▽9二香(91) ▲2八飛(29) ▽4二金(43)
# >> ▲2六飛(28) ▽5二金(42) ▲2九飛(26) ▽4三金(52) ▲2八飛(29) ▽4二金(43) ▲2七飛(28) ▽5二金(42)
# >> ▲4五歩(46) ▽4三金(52) ▲4四歩(45) ▽4四金(43) ▲2九飛(27) ▽4三金(44) ▲4六角打 ▽9三香(92)
# >> ▲4五歩打 ▽4二金(43) ▲4七銀(56) ▽9二飛(82) ▲3五歩(36) ▽3五歩(34) ▲3五角(46) ▽6四角打
# >> ▲5六歩(57) ▽9五歩(94) ▲9五歩(96) ▽9六歩打 ▲5七角(35) ▽9五香(93) ▲9八歩打 ▽3四歩打
# >> ▲3六銀(47) ▽7四歩(73) ▲1五歩(16) ▽1五歩(14) ▲2四歩(25) ▽2四銀(33) ▲2五銀(36) ▽4六歩打
# >> ▲2四銀(25) ▽2四歩(23) ▲8三銀打 ▽5二飛(92) ▲7四銀成(83) ▽9一角(64) ▲2四飛(29) ▽2三金(32)
# >> ▲2六飛(24) ▽2五歩打 ▲2五桂(37) ▽2四歩打 ▲1二歩打 ▽1二玉(22) ▲8四角(57) ▽4七歩成(46)
# >> ▲4七金(48) ▽1四金(23) ▲9五角(84) ▽2五歩(24) ▲3六飛(26) ▽2三玉(12) ▲5五歩(56) ▽4五銀(54)
# >> ▲3九飛(36) ▽4六歩打 ▲3六金(47) ▽3六銀(45) ▲3六飛(39) ▽4七歩成(46) ▲6三全(74) ▽9二飛(52)
# >> ▲5一角成(95) ▽6九銀打 ▲4五銀打 ▽2二桂打 ▲4三歩打 ▽3三金(42) ▲3五歩打 ▽3五歩(34)
# >> ▲3九飛(36) ▽7八銀成(69) ▲7八玉(88) ▽5五角(91) ▲3四歩打 ▽3四桂(22) ▲4二歩成(43) ▽5七と(47)
# >> ▲6九香打 ▽6六歩(65) ▲6六歩(67) ▽6八歩打 ▲6八香(69) ▽6七歩打 ▲4四銀打 ▽6六角(55)
# >> ▲3三銀成(44) ▽3三玉(23)
# >> ▲7六歩 ▽8四歩 ▲7八金 ▽3二金 ▲2六歩 ▽8五歩 ▲7七角 ▽3四歩
# >> ▲8八銀 ▽7七角成 ▲同銀 ▽4二銀 ▲3八銀 ▽7二銀 ▲9六歩 ▽9四歩
# >> ▲4六歩 ▽6四歩 ▲4七銀 ▽6三銀 ▲6八玉 ▽3三銀 ▲5八金 ▽5四銀
# >> ▲3六歩 ▽4二玉 ▲7九玉 ▽6五歩 ▲5六銀 ▽5二金 ▲1六歩 ▽1四歩
# >> ▲3七桂 ▽3一玉 ▲4七金 ▽4四歩 ▲2五歩 ▽4三金 ▲8八玉 ▽2二玉
# >> ▲4八金 ▽4二金 ▲2九飛 ▽4三金 ▲1八香 ▽9二香 ▲2八飛 ▽4二金
# >> ▲2六飛 ▽5二金 ▲2九飛 ▽4三金 ▲2八飛 ▽4二金 ▲2七飛 ▽5二金
# >> ▲4五歩 ▽4三金 ▲4四歩 ▽同金 ▲2九飛 ▽4三金 ▲4六角打 ▽9三香
# >> ▲4五歩打 ▽4二金 ▲4七銀 ▽9二飛 ▲3五歩 ▽同歩 ▲同角 ▽6四角打
# >> ▲5六歩 ▽9五歩 ▲同歩 ▽9六歩打 ▲5七角 ▽9五香 ▲9八歩打 ▽3四歩打
# >> ▲3六銀 ▽7四歩 ▲1五歩 ▽同歩 ▲2四歩 ▽同銀 ▲2五銀 ▽4六歩打
# >> ▲2四銀 ▽同歩 ▲8三銀打 ▽5二飛 ▲7四銀成 ▽9一角 ▲2四飛 ▽2三金
# >> ▲2六飛 ▽2五歩打 ▲同桂 ▽2四歩打 ▲1二歩打 ▽同玉 ▲8四角 ▽4七歩成
# >> ▲同金 ▽1四金 ▲9五角 ▽2五歩 ▲3六飛 ▽2三玉 ▲5五歩 ▽4五銀
# >> ▲3九飛 ▽4六歩打 ▲3六金 ▽同銀 ▲同飛 ▽4七歩成 ▲6三全 ▽9二飛
# >> ▲5一角成 ▽6九銀打 ▲4五銀打 ▽2二桂打 ▲4三歩打 ▽3三金 ▲3五歩打 ▽同歩
# >> ▲3九飛 ▽7八銀成 ▲同玉 ▽5五角 ▲3四歩打 ▽同桂 ▲4二歩成 ▽5七と
# >> ▲6九香打 ▽6六歩 ▲同歩 ▽6八歩打 ▲同香 ▽6七歩打 ▲4四銀打 ▽6六角
# >> ▲3三銀成 ▽同玉
