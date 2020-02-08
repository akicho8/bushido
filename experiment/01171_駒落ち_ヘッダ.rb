require "./example_helper"

info = Parser.parse(<<~EOT)
手合割：三枚落ち
上手：伊藤宗印
上手の持駒：なし
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
|v香v桂v銀v金v玉v金v銀v桂 ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
|v歩v歩v歩v歩v歩v歩v歩v歩v歩|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
| ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
| 香 桂 銀 金 玉 金 銀 桂 香|九
+---------------------------+
下手の持駒：なし
下手：天満屋

△６二銀
EOT
puts info.to_kif
# >> 手合割：三枚落ち
# >> 上手：伊藤宗印
# >> 下手：天満屋
# >> 下手の備考：居玉, 相居玉
# >> 上手の備考：居玉, 相居玉
# >> 手数----指手---------消費時間--
# >>    1 ６二銀(71)   (00:00/00:00:00)
# >>    2 投了
# >> まで1手で上手の勝ち
