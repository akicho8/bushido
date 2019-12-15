require "./example_helper"

mediator = Mediator.new
mediator.board.placement_from_shape(<<~EOT)
+---+
|v玉|
| ・|
| ・|
+---+
EOT
mediator.player_at(:black).pieces_set("★竜") # 必要なものだけ拾うのでエラーにはならない
mediator.player_at(:black).pieces_set("飛　金0銀1銀2")
mediator.player_at(:white).pieces_set("香2")
puts mediator
# >> 後手の持駒：香二
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・ ・v玉|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|三
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|九
# >> +---------------------------+
# >> 先手の持駒：飛 金 銀三
# >> 手数＝0 まで
# >> 
# >> 先手番
