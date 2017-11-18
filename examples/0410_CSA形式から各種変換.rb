require "./example_helper"

info = Parser.parse(<<~EOT)
'encoding=Shift_JIS
' ---- Kifu for Windows V7 V7.31 CSA形式棋譜ファイル ----
V2.2
N+akicho8
N-yosui26
$EVENT:レーティング対局室(早指2)
$START_TIME:2017/11/15 0:23:44
P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
P2 * -HI *  *  *  *  * -KA *
P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
P4 *  *  *  *  *  *  *  *  *
P5 *  *  *  *  *  *  *  *  *
P6 *  *  *  *  *  *  *  *  *
P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
P8 * +KA *  *  *  *  * +HI *
P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
+
+7968GI,T5
-3334FU
%TORYO,T16
EOT

puts "-" * 80
puts info.to_kif
puts "-" * 80
puts info.to_ki2
puts "-" * 80
puts info.to_csa
# >> --------------------------------------------------------------------------------
# >> 先手：akicho8
# >> 後手：yosui26
# >> 棋戦：レーティング対局室(早指2)
# >> 開始日時：2017/11/15 0:23:44
# >> 後手の持駒：
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金v銀v桂v香|一
# >> | ・v飛 ・ ・ ・ ・ ・v角 ・|二
# >> |v歩v歩v歩v歩v歩v歩v歩v歩v歩|三
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
# >> | ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> 先手の持駒：
# >> 手数----指手---------消費時間--
# >>    1 ６八銀(79)   (00:00/00:00:00)
# >>    2 ３四歩(33)   (00:00/00:00:00)
# >>    3 投了
# >> --------------------------------------------------------------------------------
# >> 先手：akicho8
# >> 後手：yosui26
# >> 棋戦：レーティング対局室(早指2)
# >> 開始日時：2017/11/15 0:23:44
# >> 後手の持駒：
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> |v香v桂v銀v金v玉v金v銀v桂v香|一
# >> | ・v飛 ・ ・ ・ ・ ・v角 ・|二
# >> |v歩v歩v歩v歩v歩v歩v歩v歩v歩|三
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
# >> | ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
# >> | 香 桂 銀 金 玉 金 銀 桂 香|九
# >> +---------------------------+
# >> 先手の持駒：
# >> 
# >> ▲６八銀 ▽３四歩
# >> まで2手で後手の勝ち
# >> --------------------------------------------------------------------------------
# >> V2.2
# >> N+akicho8
# >> N-yosui26
# >> $EVENT:レーティング対局室(早指2)
# >> $START_TIME:2017/11/15 0:23:44
# >> P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
# >> P2 * -HI *  *  *  *  * -KA * 
# >> P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
# >> P4 *  *  *  *  *  *  *  *  * 
# >> P5 *  *  *  *  *  *  *  *  * 
# >> P6 *  *  *  *  *  *  *  *  * 
# >> P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
# >> P8 * +KA *  *  *  *  * +HI * 
# >> P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
# >> +
# >> +7968GI
# >> -3334FU
# >> %TORYO
