require "./example_helper"
require "stackprof"

# Warabi.logger = ActiveSupport::Logger.new(STDOUT)

mediator = Mediator.new
mediator.pieces_set("▲歩△歩")
mediator.board.placement_from_shape <<~EOT
+------+
|v飛v香|
| ・ ・|
| ・v歩|
|v香 ・|
|v歩 歩|
| ・ 香|
| 歩 ・|
| ・ ・|
| 香 飛|
+------+
  EOT

mediator.execute("▲17飛", executor_class: PlayerExecutorCpu)
mediator.player_at(:black).evaluator.score  # => 0
mediator.player_at(:black).evaluator.score2 # => -9999

mediator.execute("△23飛", executor_class: PlayerExecutorCpu)
mediator.execute("▲19飛", executor_class: PlayerExecutorCpu)
mediator.execute("△21飛", executor_class: PlayerExecutorCpu)
mediator.execute("▲17飛", executor_class: PlayerExecutorCpu)
tp mediator.position_map

mediator.player_at(:black).evaluator.score  # => 0
mediator.player_at(:black).evaluator.score2 # => -19998
#
# mediator.player_at(:black).brain.nega_max_run(depth_max: 1) # => {:hand=>#<▲２八香(29)>, :score=>0, :depth=>0, :reading_hands=>[#<▲２八香(29)>, #<△９一飛(21)>]}
# >> |----------------------+---|
# >> |  2068361328277002845 | 2 |
# >> | -1581136720064930357 | 1 |
# >> |  -273841745352659855 | 1 |
# >> |  3195651637983543358 | 1 |
# >> |----------------------+---|
