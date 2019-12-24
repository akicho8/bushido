require "./example_helper"

mediator = Mediator.new
mediator.placement_from_bod(<<~EOT)
後手の持駒：
+---------------------------+
|v香v桂v銀v金v玉v金v銀v桂v香|
| ・v飛 ・ ・ ・ ・ ・v角 ・|
|v歩v歩v歩v歩v歩v歩v歩 とv歩|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
| ・ ・ ・ ・ ・ ・ ・ ・ ・|
| 歩 歩 歩 歩 歩 歩 歩 ・ 歩|
| ・ 角 ・ ・ ・ ・ ・ ・ ・|
| 香 桂 銀 金 玉 金 銀 桂 香|
+---------------------------+
先手の持駒：歩飛
EOT

player = mediator.player_at(:black)
evaluator = player.evaluator(evaluator_class: Evaluator::Level4)
evaluator.score            # => 1375
tp evaluator.score_compute_report
tp mediator.players.inject({}) { |a, e| a.merge(e.location => e.pressure_rate) }
mediator.players.each { |e| tp e.pressure_report }

# >> |---------+----------------+--------+------+-------+--------------|
# >> | 先後    | 駒箱(常時加算) | 駒組み | 終盤 | 合計  | 差(自分基準) |
# >> |---------+----------------+--------+------+-------+--------------|
# >> | ▲ 自分 |           2205 |  50816 |   39 | 53060 |              |
# >> | △      |              0 |  51616 |   69 | 51685 |              |
# >> |         |                |        |      |       |         1375 |
# >> |---------+----------------+--------+------+-------+--------------|
# >> |----+-------|
# >> | ▲ | 0.125 |
# >> | △ | 0.0   |
# >> |----+-------|
# >> |----------+--------------+------|
# >> | 盤上     | 勢力         | 持駒 |
# >> |----------+--------------+------|
# >> | ▲２三と |            3 |      |
# >> | ▲９七歩 |            0 |      |
# >> | ▲８七歩 |            0 |      |
# >> | ▲７七歩 |            0 |      |
# >> | ▲６七歩 |            0 |      |
# >> | ▲５七歩 |            0 |      |
# >> | ▲４七歩 |            0 |      |
# >> | ▲３七歩 |            0 |      |
# >> | ▲１七歩 |            0 |      |
# >> | ▲８八角 |            0 |      |
# >> | ▲９九香 |            0 |      |
# >> | ▲８九桂 |            0 |      |
# >> | ▲７九銀 |           -1 |      |
# >> | ▲６九金 |           -1 |      |
# >> | ▲５九玉 |            0 |      |
# >> | ▲４九金 |           -1 |      |
# >> | ▲３九銀 |           -1 |      |
# >> | ▲２九桂 |            0 |      |
# >> | ▲１九香 |            0 |      |
# >> |          | 0 * 1        | 歩1  |
# >> |          | 3 * 1        | 飛1  |
# >> |          | 合計 2       |      |
# >> |          | 序盤率 0.875 |      |
# >> |          | 終盤率 0.125 |      |
# >> |----------+--------------+------|
# >> |----------+------------|
# >> | 盤上     | 勢力       |
# >> |----------+------------|
# >> | △９一香 |          0 |
# >> | △８一桂 |          0 |
# >> | △７一銀 |         -1 |
# >> | △６一金 |         -1 |
# >> | △５一玉 |          0 |
# >> | △４一金 |         -1 |
# >> | △３一銀 |         -1 |
# >> | △２一桂 |          0 |
# >> | △１一香 |          0 |
# >> | △８二飛 |         -1 |
# >> | △２二角 |          0 |
# >> | △９三歩 |          0 |
# >> | △８三歩 |          0 |
# >> | △７三歩 |          0 |
# >> | △６三歩 |          0 |
# >> | △５三歩 |          0 |
# >> | △４三歩 |          0 |
# >> | △３三歩 |          0 |
# >> | △１三歩 |          0 |
# >> |          | 合計 -5    |
# >> |          | 序盤率 1.0 |
# >> |          | 終盤率 0.0 |
# >> |----------+------------|
