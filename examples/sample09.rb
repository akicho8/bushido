# -*- coding: utf-8 -*-
# CPU同士の対局

require "bundler/setup"
require "bushido"
include Bushido

frame = LiveFrame.basic_instance
frame.piece_plot
while true
  way = frame.current_player.generate_way
  frame.execute(way)
  last_piece = frame.prev_player.last_piece
  if last_piece && last_piece.sym_name == :king
    break
  end
end
p frame
puts frame.kif_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
puts frame.ki2_logs.group_by.with_index{|v, i|i / 8}.values.collect{|v|v.join(" ")}
# >> 78手目: ▽後手番
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | 角v桂v銀 ・v金 ・ ・ ・v香|一
# >> |v香 ・ ・ ・ ・v銀 ・ ・ 歩|二
# >> |v歩v歩v飛v歩 圭 ・ ・ ・v桂|三
# >> | ・ ・v歩 ・v金 ・ ・v歩 ・|四
# >> | ・ ・ ・ ・ 角 歩 ・ 歩v歩|五
# >> | ・ ・ 歩 ・ ・v歩v歩 ・ ・|六
# >> | 歩 歩 ・ 歩 歩 ・ ・ ・ 銀|七
# >> | 香 ・ ・ 金 ・ 飛 金 ・ 香|八
# >> | ・ 銀 ・ 玉 ・ ・ ・ 桂 ・|九
# >> +---------------------------+
# >> ▲先手の持駒:歩 玉
# >> ▽後手の持駒:歩
# >>
# >> ▲4八玉(59) ▽5二金(41) ▲5六歩(57) ▽6二飛(82) ▲1六歩(17) ▽7二飛(62) ▲5九玉(48) ▽6二玉(51)
# >> ▲2六歩(27) ▽4二金(52) ▲4八飛(28) ▽5四歩(53) ▲7八銀(79) ▽5一金(61) ▲7六歩(77) ▽5五歩(54)
# >> ▲5五歩(56) ▽3二金(42) ▲5八飛(48) ▽3四歩(33) ▲7七桂(89) ▽9二香(91) ▲1八飛(58) ▽4二金(32)
# >> ▲6八金(69) ▽8二飛(72) ▲2八銀(39) ▽4四歩(43) ▲1五歩(16) ▽4三金(42) ▲1七銀(28) ▽2四歩(23)
# >> ▲6五桂(77) ▽3三金(43) ▲9八香(99) ▽4二銀(31) ▲2八飛(18) ▽3一角(22) ▲2七飛(28) ▽5二玉(62)
# >> ▲9九角(88) ▽4三金(33) ▲3九金(49) ▽4五歩(44) ▲8九銀(78) ▽1四歩(13) ▲5四歩(55) ▽1三桂(21)
# >> ▲4六歩(47) ▽6二飛(82) ▲4五歩(46) ▽5四金(43) ▲5七歩打 ▽2二角(31) ▲1八香(19) ▽5三玉(52)
# >> ▲2五歩(26) ▽7四歩(73) ▲6九玉(59) ▽5二飛(62) ▲2六飛(27) ▽4八歩打 ▲2八飛(26) ▽7二飛(52)
# >> ▲4八飛(28) ▽5五角(22) ▲5五角(99) ▽7三飛(72) ▲3六歩(37) ▽3五歩(34) ▲9一角打 ▽1五歩(14)
# >> ▲3八金(39) ▽4六歩打 ▲1二歩打 ▽3六歩(35) ▲5三桂成(65)
# >> ▲4八玉 ▽5二金 ▲5六歩 ▽6二飛 ▲1六歩 ▽7二飛 ▲5九玉 ▽6二玉
# >> ▲2六歩 ▽4二金 ▲4八飛 ▽5四歩 ▲7八銀 ▽5一金 ▲7六歩 ▽5五歩
# >> ▲同歩 ▽3二金 ▲5八飛 ▽3四歩 ▲7七桂 ▽9二香 ▲1八飛 ▽4二金
# >> ▲6八金 ▽8二飛 ▲2八銀 ▽4四歩 ▲1五歩 ▽4三金 ▲1七銀 ▽2四歩
# >> ▲6五桂 ▽3三金 ▲9八香 ▽4二銀 ▲2八飛 ▽3一角 ▲2七飛 ▽5二玉
# >> ▲9九角 ▽4三金 ▲3九金 ▽4五歩 ▲8九銀 ▽1四歩 ▲5四歩 ▽1三桂
# >> ▲4六歩 ▽6二飛 ▲4五歩 ▽5四金 ▲5七歩打 ▽2二角 ▲1八香 ▽5三玉
# >> ▲2五歩 ▽7四歩 ▲6九玉 ▽5二飛 ▲2六飛 ▽4八歩打 ▲2八飛 ▽7二飛
# >> ▲4八飛 ▽5五角 ▲同角 ▽7三飛 ▲3六歩 ▽3五歩 ▲9一角打 ▽1五歩
# >> ▲3八金 ▽4六歩打 ▲1二歩打 ▽3六歩 ▲5三桂成
