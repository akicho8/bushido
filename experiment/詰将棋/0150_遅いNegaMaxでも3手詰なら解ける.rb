require "../example_helper"

# Bioshogi.logger = ActiveSupport::Logger.new(STDOUT)

Board.dimensiton_change([2, 4])

mediator = Mediator.new
mediator.player_at(:black).pieces_add("金金")
mediator.board.placement_from_shape <<~EOT
+------+
| ・ ・|
| ・v玉|
| ・ ・|
| ・ 歩|
+------+
EOT

# tp mediator.player_at(:black).normal_all_hands(legal_only: true, mate_only: true)

brain = mediator.player_at(:black).brain(diver_class: Diver::NegaMaxDiver)
records = brain.iterative_deepening(depth_max_range: 3..3, mate_mode: true)
tp Brain.human_format(records)

# >> |------+----------------+--------------------------------------+--------+------------+----------|
# >> | 順位 | 候補手         | 読み筋                               | ▲形勢 | 評価局面数 | 処理時間 |
# >> |------+----------------+--------------------------------------+--------+------------+----------|
# >> |    1 | ▲１三金打     | △１一玉(12) ▲２二金打 (詰み)       | 999997 |          6 | 0.011034 |
# >> |    2 | ▲２二金打     | △２二玉(12) ▲１三金打 △１一玉(22) | -39960 |         13 | 0.007254 |
# >> |    3 | ▲２三金打     | △２三玉(12) ▲１三金打 △２四玉(23) | -39960 |         15 | 0.014523 |
# >> |    4 | ▲１三歩成(14) | △１三玉(12) ▲１二金打 △１二玉(13) | -40105 |         18 | 0.013987 |
# >> |    5 | ▲１三歩(14)   | △１三玉(12) ▲１二金打 △１二玉(13) | -40105 |         39 | 0.022649 |
# >> |    6 | ▲１一金打     | △１一玉(12) ▲２一金打 △２一玉(11) | -42420 |         24 | 0.022745 |
# >> |------+----------------+--------------------------------------+--------+------------+----------|
