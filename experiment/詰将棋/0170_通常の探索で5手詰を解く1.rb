require "../example_helper"

# Bioshogi.logger = ActiveSupport::Logger.new(STDOUT)

Board.dimensiton_change([2, 5])

mediator = Mediator.new
mediator.player_at(:black).pieces_add("金3")
mediator.board.placement_from_shape <<~EOT
+------+
| ・ ・|
| ・ ・|
| ・v玉|
| ・ ・|
| ・ 歩|
+------+
EOT

# tp mediator.player_at(:black).normal_all_hands(legal_only: true, mate_only: true)

mate_records = []
mate_proc = proc do |player, score, hand_route|
  mate_records << {"評価値" => score, "詰み筋" => hand_route.collect(&:to_s).join(" "), "詰み側" => player.location.to_s, "攻め側の持駒" => player.op.piece_box.to_s}
end

brain = mediator.player_at(:black).brain(diver_class: Diver::NegaAlphaDiver)
records = brain.iterative_deepening(depth_max_range: 5..5, mate_mode: true, mate_proc: mate_proc)
tp Brain.human_format(records)
tp mate_records

# >> |------+--------------+--------------------------------------------------------------+--------+------------+----------+--------|
# >> | 順位 | 候補手       | 読み筋                                                       | ▲形勢 | 評価局面数 | 処理時間 | 他の手 |
# >> |------+--------------+--------------------------------------------------------------+--------+------------+----------+--------|
# >> |    1 | ▲２四金打   | △２四玉(13) ▲１四金打 △２五玉(24) ▲２四金打 (詰み)       | 999995 |        195 | 0.292295 |        |
# >> |    2 | ▲１四金打   | △１二玉(13) ▲２三金打 △１一玉(12) ▲２二金打 (詰み)       | 999995 |        148 | 0.204401 |        |
# >> |    3 | ▲２三金打   | △２三玉(13) ▲１四金打 △１二玉(23) ▲２三金打 △１一玉(12) | -38760 |        113 | 0.129854 |        |
# >> |    4 | ▲１二金打   | △１二玉(13) ▲２三金打 △２三玉(12) ▲１四金打 △１二玉(23) | -41220 |        226 | 0.273819 |        |
# >> |    5 | ▲１四歩(15) | △１四玉(13) ▲１三金打 △１三玉(14) ▲１二金打 △１二玉(13) | -41365 |        462 | 0.467762 |        |
# >> |------+--------------+--------------------------------------------------------------+--------+------------+----------+--------|
# >> |--------+------------------------------------------------------------------+--------+--------------|
# >> | 評価値 | 詰み筋                                                           | 詰み側 | 攻め側の持駒 |
# >> |--------+------------------------------------------------------------------+--------+--------------|
# >> | 999995 | ▲１四歩(15) △１四玉(13) ▲２四金打 △１五玉(14) ▲１四金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１四玉(13) ▲２四金打 △１五玉(14) ▲２五金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２四玉(13) ▲２五金打 △２三玉(24) ▲１三金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２四玉(13) ▲１五金打 △２三玉(24) ▲１三金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三歩成(14) △１一玉(12) ▲２二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三歩成(14) △１一玉(12) ▲１二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三歩成(14) △２一玉(12) ▲２二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三歩成(14) △２一玉(12) ▲１二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三歩(14) △１一玉(12) ▲１二金打   | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三歩(14) △２一玉(12) ▲１二金打   | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲２三金打 △１一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲２三金打 △１一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲２三金打 △２一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲２三金打 △２一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三金打 △１一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三金打 △１一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三金打 △２一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △１二玉(13) ▲１三金打 △２一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三歩成(14) △１一玉(22) ▲２二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三歩成(14) △１一玉(22) ▲１二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三歩成(14) △２一玉(22) ▲２二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三歩成(14) △２一玉(22) ▲１二金打 | △     | 金二         |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲２一金打 △１二玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲２三金打 △１一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲２三金打 △１一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲２三金打 △２一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲２三金打 △２一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三金打 △１一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三金打 △１一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三金打 △２一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四歩(15) △２二玉(13) ▲１三金打 △２一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１二金打 △２四玉(13) ▲１四金打 △２五玉(24) ▲２四金打       | △     |              |
# >> | 999995 | ▲１二金打 △２四玉(13) ▲２五金打 △２三玉(24) ▲２二金打       | △     |              |
# >> | 999995 | ▲１二金打 △２四玉(13) ▲２五金打 △２三玉(24) ▲１三金打       | △     |              |
# >> | 999995 | ▲１二金打 △２三玉(13) ▲２二金(12) △１三玉(23) ▲２三金打     | △     | 金           |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲２二金打 △１三玉(12) ▲２三金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲２三金打 △１一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲２三金打 △１一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲２三金打 △２一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲２三金打 △２一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲１三金打 △１一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲１三金打 △１一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲１三金打 △２一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１二金打 △１二玉(13) ▲１三金打 △２一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲２三金打 △２三玉(13) ▲２二金打 △１三玉(23) ▲２三金打       | △     |              |
# >> | 999995 | ▲２四金打 △２四玉(13) ▲１四金打 △２五玉(24) ▲２四金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金(24) △１一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金(24) △１一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金(24) △２一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金(24) △２一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金(24) △１一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金(24) △１一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金(24) △２一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金(24) △２一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１一金打 △２二玉(12) ▲２一金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１一金打 △２二玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金打 △１一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金打 △１一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金打 △２一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲２三金打 △２一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金打 △１一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金打 △１一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金打 △２一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △１二玉(13) ▲１三金打 △２一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金(24) △１一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金(24) △１一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金(24) △２一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金(24) △２一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金(24) △１一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金(24) △１一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金(24) △２一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金(24) △２一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２一金打 △１二玉(22) ▲１一金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２一金打 △１二玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金打 △１一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金打 △１一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金打 △２一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲２三金打 △２一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金打 △１一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金打 △１一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金打 △２一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲２四金打 △２二玉(13) ▲１三金打 △２一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金(14) △１一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金(14) △１一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金(14) △２一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金(14) △２一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金(14) △１一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金(14) △１一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金(14) △２一玉(12) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金(14) △２一玉(12) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１一金打 △２二玉(12) ▲２一金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１一金打 △２二玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金打 △１一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金打 △１一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金打 △２一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲２三金打 △２一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金打 △１一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金打 △１一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金打 △２一玉(12) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △１二玉(13) ▲１三金打 △２一玉(12) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金(14) △１一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金(14) △１一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金(14) △２一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金(14) △２一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金(14) △１一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金(14) △１一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金(14) △２一玉(22) ▲２二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金(14) △２一玉(22) ▲１二金打     | △     | 金           |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２一金打 △１二玉(22) ▲１一金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２一金打 △１二玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金打 △１一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金打 △１一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金打 △２一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲２三金打 △２一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金打 △１一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金打 △１一玉(22) ▲１二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金打 △２一玉(22) ▲２二金打       | △     |              |
# >> | 999995 | ▲１四金打 △２二玉(13) ▲１三金打 △２一玉(22) ▲１二金打       | △     |              |
# >> |--------+------------------------------------------------------------------+--------+--------------|
