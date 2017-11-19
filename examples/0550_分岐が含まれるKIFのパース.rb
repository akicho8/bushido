require "./example_helper"

info = Parser.parse(<<~EOT)
# ----  激指 柿木形式棋譜ファイル  ----
# コメント：コメント
手合割：平手
先手：fukkachan1 12級
後手：hanairobiyori 1級
手数----指手---------消費時間--
*<analyze>0</analyze>
   1 ７六歩(77)   ( 0:00/00:00:00)
   2 ４二銀(31)   ( 0:00/00:00:00)
#--separator--
変化：3手
   3 ６八銀(79)   ( 0:00/00:00:00)
   4 ３四歩(33)   ( 0:00/00:00:00)
EOT

tp info.header
puts info.to_kif
# >> |--------+-------------------|
# >> | 手合割 | 平手              |
# >> |   先手 | fukkachan1 12級   |
# >> |   後手 | hanairobiyori 1級 |
# >> |--------+-------------------|
# >> 手合割：平手
# >> 先手：fukkachan1 12級
# >> 後手：hanairobiyori 1級
# >> 手数----指手---------消費時間--
# >>    1 ７六歩(77)   (00:00/00:00:00)
# >>    2 ４二銀(31)   (00:00/00:00:00)
# >>    3 投了
