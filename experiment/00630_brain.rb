require "./example_helper"

Board.dimensiton_change([3, 3])
mediator = Mediator.new
mediator.pieces_set("▲歩")
mediator.board.placement_from_shape <<~EOT
+---------+
| ・ ・ ・|
| ・ 歩 ・|
| ・ ・ ・|
+---------+
EOT
brain = mediator.player_at(:black).brain
brain.normal_all_hands.collect(&:to_kif)                               # => ["▲２一歩成(22)", "▲３二歩打", "▲１二歩打", "▲３三歩打", "▲１三歩打"]
tp brain.fast_score_list.collect { |e| e.merge(hand: e[:hand].to_kif) } # => [{:hand=>"▲２一歩成(22)", :score=>1305, :socre2=>1305, :best_pv=>[], :eval_times=>1, :sec=>2.6e-05}, {:hand=>"▲３二歩打", :score=>200, :socre2=>200, :best_pv=>[], :eval_times=>1, :sec=>9.0e-06}, {:hand=>"▲１二歩打", :score=>200, :socre2=>200, :best_pv=>[], :eval_times=>1, :sec=>8.0e-06}, {:hand=>"▲３三歩打", :score=>200, :socre2=>200, :best_pv=>[], :eval_times=>1, :sec=>7.0e-06}, {:hand=>"▲１三歩打", :score=>200, :socre2=>200, :best_pv=>[], :eval_times=>1, :sec=>7.0e-06}]
# >> |----------------+-------+--------+---------+------------+---------|
# >> | hand           | score | socre2 | best_pv | eval_times | sec     |
# >> |----------------+-------+--------+---------+------------+---------|
# >> | ▲２一歩成(22) |  1305 |   1305 | []      |          1 | 2.6e-05 |
# >> | ▲３二歩打     |   200 |    200 | []      |          1 | 9.0e-06 |
# >> | ▲１二歩打     |   200 |    200 | []      |          1 | 8.0e-06 |
# >> | ▲３三歩打     |   200 |    200 | []      |          1 | 7.0e-06 |
# >> | ▲１三歩打     |   200 |    200 | []      |          1 | 7.0e-06 |
# >> |----------------+-------+--------+---------+------------+---------|
