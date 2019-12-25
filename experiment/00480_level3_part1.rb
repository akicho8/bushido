require "./example_helper"

mediator = Mediator.new
mediator.placement_from_bod(<<~EOT)
+---------+
| ・ ・v玉|
| ・ ・ ・|
| 玉 金 ・|
+---------+
先手の持駒：飛香
EOT

mediator.players.each { |e| tp e.pressure_report }
player = mediator.player_at(:black)
evaluator = player.evaluator(evaluator_class: Evaluator::Level3)
evaluator.score            # => 3954
tp evaluator.score_compute_report

# mediator = Mediator.new
# mediator.placement_from_bod(<<~EOT)
# +---------+
# | ・ ・v玉|
# | ・ 金 ・|
# | ・ ・ ・|
# +---------+
# EOT
# evaluator = mediator.player_at(:black).evaluator(evaluator_class: Evaluator::Level3)
# s2 = evaluator.score                 # => -38635
#
# s2 - s1                         # => 5
# >> |----------+---------------+------|
# >> | 盤上     | 勢力          | 持駒 |
# >> |----------+---------------+------|
# >> | ▲３三玉 |             4 |      |
# >> | ▲２三金 |             3 |      |
# >> |          | 3 * 1         | 飛1  |
# >> |          | 1 * 1         | 香1  |
# >> |          | 合計 11       |      |
# >> |          | 終盤率 0.6875 |      |
# >> |          | 序盤率 0.3125 |      |
# >> |----------+---------------+------|
# >> |----------+------------|
# >> | 盤上     | 勢力       |
# >> |----------+------------|
# >> | △１一玉 |          0 |
# >> |          | 合計 0     |
# >> |          | 終盤率 0.0 |
# >> |          | 序盤率 1.0 |
# >> |----------+------------|
# >> |---------+----------------+-----------------------+------------------------+------------+------|
# >> | 先後    | 駒箱(常時加算) | 序盤                  | 終盤                   | 序終盤合計 | 全体 |
# >> |---------+----------------+-----------------------+------------------------+------------+------|
# >> | ▲ 自分 |           2730 | 41200 * 0.3 = 12875.0 | 41236 * 0.7 = 28349.75 |   43954.75 |      |
# >> | △      |              0 | 40000 * 1.0 = 40000.0 | 40025 * 0.0 = 0.0      |    40000.0 |      |
# >> |         |                |                       |                        |            | 3954 |
# >> |---------+----------------+-----------------------+------------------------+------------+------|
