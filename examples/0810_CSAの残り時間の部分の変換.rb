require "./example_helper"

info = Parser.parse("持ち時間：1時間01分")
puts info.to_kif
puts info.to_csa

info = Parser.parse("V2.2\n$TIME_LIMIT: 01:02+03")
info.raw_header_part_hash       # => {"持ち時間"=>"1時間2分 (1手3秒)"}
puts info.to_kif
puts info.to_csa
# >> 持ち時間：1時間1分
# >> 先手の囲い：
# >> 後手の囲い：
# >> 先手の戦型：
# >> 後手の戦型：
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 投了
# >> まで0手で後手の勝ち
# >> V2.2
# >> $TIME_LIMIT:01:01+00
# >> ' 手合割:平手
# >> PI
# >> +
# >> %TORYO
# >> 持ち時間：1時間2分 (1手3秒)
# >> 先手の囲い：
# >> 後手の囲い：
# >> 先手の戦型：
# >> 後手の戦型：
# >> 手合割：平手
# >> 手数----指手---------消費時間--
# >>    1 投了
# >> まで0手で後手の勝ち
# >> V2.2
# >> $TIME_LIMIT:01:02+03
# >> ' 手合割:平手
# >> PI
# >> +
# >> %TORYO
