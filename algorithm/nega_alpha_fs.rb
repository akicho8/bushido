# def nega_alpha_fs(node, depth = 0, alpha = -Float::INFINITY, beta = Float::INFINITY)
#   if depth.zero?
#     return evaluate(node.player)
#   end
#
#   max = -Float::INFINITY
#   node.children.each do |node|
#     max = [max, -nega_alpha_fs(node, depth.pred, -beta, -[alpha, max].max)].max
#     if max >= beta
#       break
#     end
#   end
#   max
# end

require "./nega_alpha"

class NegaAlphaFs < NegaAlpha
  def compute_score(*args)
    nega_alpha_fs(*args)
  end

  def nega_alpha_fs(turn:, depth_max:, depth: 0, alpha: -Float::INFINITY, beta: Float::INFINITY)
    perform_out_of_time_check

    player = mediator.player_at(turn)

    # 一番深い局面に達したらはじめて評価する
    if depth_max <= depth
      return [mediator.evaluate(player), []] # 現局面手番視点
    end

    # # 合法手がない場合はパスして相手に手番を渡す
    children = mediator.available_places(player)
    if children.empty?
      v, way = nega_alpha_fs(turn: turn + 1, depth_max: depth_max, depth: depth + 1, alpha: -beta, beta: -alpha)
      return [-v, [:pass, *way]]
    end

    max_v = -Float::INFINITY
    forecast = []
    children.each do |place|
      mediator.place_on(player, place) do
        v, way = nega_alpha_fs(turn: turn + 1, depth_max: depth_max, depth: depth + 1, alpha: -beta, beta: -[alpha, max_v].max)
        v = -v # 相手の一番良い手は自分の一番悪い手としたいので符号を反転する
        if max_v < v
          max_v = v
          forecast = [place, *way]
        end
      end
      if beta <= alpha
        break
      end
    end
    [max_v, forecast]
  end
end

if $0 == __FILE__
  NegaAlphaFs.new.run             # => {:o=>1, :x=>10}
end
# >> ------------------------------------------------------------ [0] o 実行速度:0.031326
# >> ・○・・
# >> ・○○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 時間 |
# >> |------+--------+----------------------+--------+------|
# >> |    1 | [1, 0] | [0, 0] [3, 2] [2, 0] |      0 |      |
# >> |    2 | [0, 1] | [0, 0] [3, 2] [3, 1] |      0 |      |
# >> |    3 | [3, 2] | [1, 3] [0, 0] [1, 0] |      0 |      |
# >> |    4 | [2, 3] | [3, 1] [0, 0] [0, 1] |      0 |      |
# >> |------+--------+----------------------+--------+------|
# >> ------------------------------------------------------------ [1] x 実行速度:0.01904
# >> ×○・・
# >> ・×○・
# >> ・○×・
# >> ・・・・
# >> |------+--------+----------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 時間 |
# >> |------+--------+----------------------+--------+------|
# >> |    1 | [0, 0] | [3, 2] [2, 0] [0, 1] |      3 |      |
# >> |    2 | [0, 2] | [0, 3] [2, 0] [3, 0] |      3 |      |
# >> |    3 | [2, 0] | [3, 0] [0, 0] [0, 1] |      5 |      |
# >> |------+--------+----------------------+--------+------|
# >> ------------------------------------------------------------ [2] o 実行速度:0.015304
# >> ×○・・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+----------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 時間 |
# >> |------+--------+----------------------+--------+------|
# >> |    1 | [3, 2] | [2, 0] [0, 1] [0, 2] |     -2 |      |
# >> |    2 | [2, 3] | [2, 0] [0, 1] [0, 2] |     -2 |      |
# >> |    3 | [0, 1] | [2, 0] [3, 2] [0, 2] |     -4 |      |
# >> |------+--------+----------------------+--------+------|
# >> ------------------------------------------------------------ [3] x 実行速度:0.014054
# >> ×××・
# >> ・×○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+----------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 時間 |
# >> |------+--------+----------------------+--------+------|
# >> |    1 | [2, 0] | [0, 1] [0, 2] PASS   |     -2 |      |
# >> |    2 | [3, 3] | [0, 1] [2, 0] [3, 0] |      1 |      |
# >> |    3 | [1, 3] | [0, 1] [2, 0] [0, 2] |      3 |      |
# >> |    4 | [3, 1] | [3, 0] [2, 0] [0, 1] |      5 |      |
# >> |------+--------+----------------------+--------+------|
# >> ------------------------------------------------------------ [4] o 実行速度:0.00452
# >> ×××・
# >> ○○○・
# >> ・○○○
# >> ・・・・
# >> |------+--------+--------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋             | 評価値 | 時間 |
# >> |------+--------+--------------------+--------+------|
# >> |    1 | [0, 1] | [0, 2] PASS [2, 3] |     -9 |      |
# >> |------+--------+--------------------+--------+------|
# >> ------------------------------------------------------------ [5] x 実行速度:0.011133
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> |------+--------+----------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 時間 |
# >> |------+--------+----------------------+--------+------|
# >> |    1 | [0, 2] | PASS [2, 3] PASS     |     -9 |      |
# >> |    2 | [3, 3] | [2, 3] [0, 2] PASS   |     -2 |      |
# >> |    3 | [2, 3] | [3, 3] [0, 2] [3, 0] |     -1 |      |
# >> |    4 | [1, 3] | [0, 3] [3, 1] [3, 0] |      1 |      |
# >> |------+--------+----------------------+--------+------|
# >> ------------------------------------------------------------ [6] o 実行速度:0.000208
# >> ×××・
# >> ××○・
# >> ×○○○
# >> ・・・・
# >> (pass)
# >> ------------------------------------------------------------ [7] x 実行速度:0.00445
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> |------+--------+----------------------+--------+------|
# >> | 順位 | 候補手 | 読み筋               | 評価値 | 時間 |
# >> |------+--------+----------------------+--------+------|
# >> |    1 | [2, 3] | PASS PASS PASS       |     -9 |      |
# >> |    2 | [1, 3] | [0, 3] [2, 3] [3, 0] |     -4 |      |
# >> |    3 | [3, 3] | [2, 3] [3, 1] [3, 0] |     -4 |      |
# >> |    4 | [3, 1] | [3, 0] [2, 3] [0, 3] |     -2 |      |
# >> |------+--------+----------------------+--------+------|
# >> ------------------------------------------------------------ [8] o 実行速度:0.000341
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> (pass)
# >> ------------------------------------------------------------ [9] x 実行速度:0.000165
# >> ×××・
# >> ×××・
# >> ×××○
# >> ・・×・
# >> (pass)
# >> 連続パスで終了
# >> |---+----|
# >> | o | 1  |
# >> | x | 10 |
# >> |---+----|
