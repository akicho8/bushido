require "./example_helper"

info = Parser.parse("
▲７六歩    △８四歩    ▲７八銀    △３四歩    ▲７七銀    △８五歩    ▲２六歩    △４二銀    ▲７八金    △３二金
▲４八銀    △６二銀    ▲５六歩    △５四歩    ▲６九玉    △４一玉    ▲２五歩    △３三銀    ▲５七銀    △５三銀
▲３六歩    △５二金    ▲５八金    △７四歩    ▲４六歩    △４四歩    ▲３七桂    △６四銀    ▲６六歩    △４三金右
▲４七金    △３一角    ▲６八銀右  △７五歩    ▲６七銀    △７六歩    ▲同銀右
")

mediator = Mediator.new
mediator.board.set_from_preset_key(info.header["手合割"])
info.move_infos.each do |info|
  puts info[:input]
  mediator.execute(info[:input])
end
tp mediator.hand_logs.last.to_h
tp mediator.hand_logs.last.to_ki2
# >> ▲７六歩
# >> △８四歩
# >> ▲７八銀
# >> △３四歩
# >> ▲７七銀
# >> △８五歩
# >> ▲２六歩
# >> △４二銀
# >> ▲７八金
# >> △３二金
# >> ▲４八銀
# >> △６二銀
# >> ▲５六歩
# >> △５四歩
# >> ▲６九玉
# >> △４一玉
# >> ▲２五歩
# >> △３三銀
# >> ▲５七銀
# >> △５三銀
# >> ▲３六歩
# >> △５二金
# >> ▲５八金
# >> △７四歩
# >> ▲４六歩
# >> △４四歩
# >> ▲３七桂
# >> △６四銀
# >> ▲６六歩
# >> △４三金右
# >> ▲４七金
# >> △３一角
# >> ▲６八銀右
# >> △７五歩
# >> ▲６七銀
# >> △７六歩
# >> ▲同銀右
# >> |-----------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# >> |           point | ７六                                                                                                                                                                                                 |
# >> |           piece | 銀                                                                                                                                                                                                   |
# >> |        promoted | false                                                                                                                                                                                                |
# >> | promote_trigger | false                                                                                                                                                                                                |
# >> |  direct_trigger | false                                                                                                                                                                                                |
# >> |    point_from | ６七                                                                                                                                                                                                 |
# >> |          player | #<Warabi::Player:0x007fc922e8e958>                                                                                                                                                                  |
# >> |       candidate | [<Warabi::Battler:70250925847060 @player=#<Warabi::Player:0x007fc922e8e958> @piece=銀 ▲７七銀>, <Warabi::Battler:70250925847040 @player=#<Warabi::Player:0x007fc922e8e958> @piece=銀 ▲６七銀>] |
# >> |    point_same | true                                                                                                                                                                                                 |
# >> |-----------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# >> |--------|
# >> | 同銀右 |
# >> |--------|
