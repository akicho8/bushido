require "./example_helper"

info = Parser.parse(<<~EOT)
棋戦詳細：第44期王位戦七番勝負第5局
*解説：増田五段 聞き手：増田五段
EOT
puts info.to_ki2

info = Parser.parse(<<~EOT)
棋戦詳細：第44期王位戦七番勝負第5局
解説：増田五段
聞き手：増田五段
EOT

puts info.to_ki2
# >> 棋戦詳細：第44期王位戦七番勝負第5局
# >> 解説：増田五段
# >> 聞き手：増田五段
# >> 手合割：平手
# >> 
# >> まで0手で後手の勝ち
# >> 棋戦詳細：第44期王位戦七番勝負第5局
# >> 解説：増田五段
# >> 聞き手：増田五段
# >> 手合割：平手
# >> 
# >> まで0手で後手の勝ち
