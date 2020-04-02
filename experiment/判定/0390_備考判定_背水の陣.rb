require "../example_helper"

info = Parser.parse(<<~EOT)
手合割：平手
手数----指手---------消費時間--
   1 ７六歩(77)   (00:00/00:00:00)
   2 ３四歩(33)   (00:00/00:00:00)
   3 ２二角成(88) (00:00/00:00:00)
   4 ３二飛(82)   (00:00/00:00:00)
   5 ３二馬(22)   (00:00/00:00:00)
   6 ５二玉(51)   (00:00/00:00:00)
   7 投了
まで6手で後手の勝ち
EOT
puts info.to_kif
# >> 手合割：平手
# >> 先手の備考：大駒コンプリート, 居飛車, 対振り, 対抗型, 居玉
# >> 後手の備考：振り飛車, 大駒全消失, 対抗型, 背水の陣
# >> 手数----指手---------消費時間--
# >>    1 ７六歩(77)   (00:00/00:00:00)
# >>    2 ３四歩(33)   (00:00/00:00:00)
# >>    3 ２二角成(88) (00:00/00:00:00)
# >>    4 ３二飛(82)   (00:00/00:00:00)
# >> *△備考：振り飛車
# >>    5 ３二馬(22)   (00:00/00:00:00)
# >> *▲備考：大駒コンプリート
# >>    6 ５二玉(51)   (00:00/00:00:00)
# >>    7 投了
# >> まで6手で後手の勝ち
