require "./example_helper"

info = Parser.parse("position startpos moves 7i6h")
puts info.to_kif
puts info.to_sfen

info = Parser.parse("position sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b - 1 moves 7i6h")
puts info.to_kif
puts info.to_sfen

info = Parser.parse("position sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b S2s 1 moves 7i6h S*2d")
puts info.to_kif
puts info.to_sfen

# >> 先手の囲い：
# >> 後手の囲い：
# >> 先手の戦型：嬉野流
# >> 後手の戦型：
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 ６八銀(79)   (00:00/00:00:00)
# >> *▲戦型：嬉野流
# >>    2 投了
# >> まで1手で先手の勝ち
# >> position startpos moves 7i6h
# >> 先手の囲い：
# >> 後手の囲い：
# >> 先手の戦型：嬉野流
# >> 後手の戦型：
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 ６八銀(79)   (00:00/00:00:00)
# >> *▲戦型：嬉野流
# >>    2 投了
# >> まで1手で先手の勝ち
# >> position startpos moves 7i6h
# >> 先手の持駒：銀
# >> 後手の持駒：銀二
# >> 先手の囲い：
# >> 後手の囲い：
# >> 先手の戦型：嬉野流
# >> 後手の戦型：
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 ６八銀(79)   (00:00/00:00:00)
# >> *▲戦型：嬉野流
# >>    2 ２四銀打     (00:00/00:00:00)
# >>    3 投了
# >> まで2手で後手の勝ち
# >> position sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b S2s 1 moves 7i6h S*2d
