require "matrix"
require "org_tp"

class ReversiApp
  V = Vector

  Around = [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0],          [1,  0],
    [-1,  1], [0,  1], [1,  1],
  ].collect { |e| V[*e] }

  attr_accessor :board
  attr_accessor :players
  attr_accessor :params
  attr_accessor :pass_counts

  def initialize(**params)
    @params = {
      dimension: 4 * 2,
    }.merge(params)

    @players = ["o", "x"]
    @board = {}
    @pass_counts = {}

    placement
  end

  def run_counts
    @run_counts ||= Hash.new(0)
  end

  def dimension
    params[:dimension]
  end

  def placement
    half = dimension / 2
    board[V[half - 1, half - 1]] = "o"
    board[V[half, half]]         = "o"
    board[V[half, half - 1]]     = "x"
    board[V[half - 1, half]]     = "x"
  end

  def put_on(player, point, &block)
    if block_given?
      memento = board.dup
      begin
        put_on(player, point)
        yield
      ensure
        self.board = memento
      end
    else
      # 1個以上反転させられる利きと個数をペアにしたハッシュを返す
      hash = reversible_info(player, point)

      # 空なら利きが一つもないことになるのでパス
      if hash.values.sum.zero?
        return
      end

      # 置く
      board[point] = player
      run_counts[:put_on] += 1

      # 反転していく
      hash.each do |vec, count|
        v = point
        count.times do
          v += vec
          board[v] = player
        end
      end

      # 反転させた数
      hash.values.sum
    end
  end

  # 1個以上反転させられる利きと個数をペアにしたハッシュを返す
  def reversible_info(player, point)
    Around.collect { |vec|
      count = reversible_count(player, point, vec)
      if count >= 1
        [vec, count]
      end
    }.compact.to_h
  end

  # player が point の位置に置いたと仮定したとき vec の方向で何枚裏返すことができるか
  # 1個以上のときだけその個数を返す
  def reversible_count(player, point, vec)
    count = 0
    loop do
      point += vec          # 置いた次の位置から進めるため最初に実行する
      # 外に出てしまったらダメ
      if point.any? { |e| !(0...dimension).cover?(e) }
        count = 0
        break
      end
      element = board[point]
      # 空の升ならダメ
      unless element
        count = 0
        break
      end
      # 自分の駒が見つかった
      if element == player
        break
      end
      count += 1
    end
    count
  end

  def to_s
    dimension.times.collect { |y|
      dimension.times.collect { |x|
        v = board[V[x, y]]
        if v
          if v == "o"
            "○"
          else
            "×"
          end
        else
          "・"
        end
      }.join + "\n"
    }.join
  end

  # 空いている部分の位置をすべて返す
  def blank_points
    dimension.times.flat_map { |y|
      dimension.times.collect { |x|
        v = V[x, y]
        unless board[v]
          v
        end
      }
    }.compact
  end

  # 置ける部分をすべて返す
  def available_points(player)
    blank_points.find_all do |v|
      !reversible_info(player, v).empty?
    end
  end

  def evaluate(player)
    o = histogram["o"] || 0
    x = histogram["x"] || 0
    if player == "o"
      o - x
    else
      x - o
    end
  end

  def evaluate_for_o
    evaluate("o")
  end

  def histogram
    board.values.group_by(&:itself).transform_values(&:size)
  end

  def player_at(turn)
    players[turn.modulo(players.count)]
  end

  def pass(player)
    pass_counts[player] ||= 0
    pass_counts[player] += 1
  end

  def pass_reset
    pass_counts.clear
  end

  def continuous_pass?
    if pass_counts.count >= players.size
      pass_counts.values.all?(&:positive?)
    end
  end

  def game_over?
    board.size >= (dimension**2) || continuous_pass?
  end

  def run
    # 中央に4つ置く
    placement
    puts self

    turn = 0                 # 手番カウンター
    turn_limit = 2560            # 最大何手まで回すか

    turn_limit.times do |turn|
      player = players[turn.modulo(players.size)]
      if blank_points.empty?
        break
      end

      reversed_count = nil      # 反転した駒数を入れる
      if true
        # 賢く指す
        # 相手の駒をより多く反転させられる位置を取得
        point = blank_points.shuffle.max { |point| reversible_info(player, point).values.sum }
        if point
          # その位置に指す (指せない場合もある)
          if count = put_on(player, point) # ここで reversible_info を再び呼ぶのはちょっと無駄がある
            reversed_count = count
          end
        end
      else
        # ルールを守ってランダムに指す
        blank_points.shuffle.each do |point|
          count = put_on(player, point)
          # 反転した数が返る。正しい手が指せたので手番を渡す
          if count
            reversed_count = count
            break
          end
        end
      end

      turn += 1

      puts "--------------------------------------------------------------------------------"
      puts "TURN #{turn} #{player} 反転数:#{reversed_count || 'skip'} #{board.values.group_by(&:itself).transform_values(&:size)}"
      puts self
    end

    puts self
    p board.values.group_by(&:itself).transform_values(&:size)
  end
end

if $0 == __FILE__
  ReversiApp.new.run
end
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・○×・・・
# >> ・・・×○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 1 o 反転数:1 {"o"=>4, "x"=>1}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○・・・
# >> ・・・○○・・・
# >> ・・・×○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 2 x 反転数:1 {"o"=>3, "x"=>3}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○×・・
# >> ・・・○×・・・
# >> ・・・×○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 3 o 反転数:1 {"o"=>5, "x"=>2}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・・○×・・・
# >> ・・・×○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 4 x 反転数:1 {"x"=>4, "o"=>4}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・×××・・・
# >> ・・・×○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 5 o 反転数:1 {"o"=>6, "x"=>3}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○×・・・
# >> ・・・×○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 6 x 反転数:1 {"o"=>5, "x"=>5}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○×・・・
# >> ・・・×××・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 7 o 反転数:1 {"o"=>7, "x"=>4}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○×・・・
# >> ・・・○××・・
# >> ・・・○・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 8 x 反転数:1 {"o"=>6, "x"=>6}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○×・・・
# >> ・・××××・・
# >> ・・・○・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 9 o 反転数:2 {"o"=>9, "x"=>4}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○○・・・
# >> ・・××○×・・
# >> ・・・○○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 10 x 反転数:2 {"o"=>7, "x"=>7}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○○・・・
# >> ・・××○×・・
# >> ・・・××・・・
# >> ・・・×・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 11 o 反転数:1 {"o"=>9, "x"=>6}
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・○・○○○・
# >> ・・×○○・・・
# >> ・・××○○・・
# >> ・・・××・○・
# >> ・・・×・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 12 x 反転数:2 {"o"=>7, "x"=>9}
# >> ・・・・・・・・
# >> ・・・・・・×・
# >> ・・○・○×○・
# >> ・・×○×・・・
# >> ・・××○○・・
# >> ・・・××・○・
# >> ・・・×・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 13 o 反転数:1 {"o"=>9, "x"=>8}
# >> ・・・・・・・・
# >> ・・・・・・×・
# >> ・・○・○×○・
# >> ・○○○×・・・
# >> ・・××○○・・
# >> ・・・××・○・
# >> ・・・×・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 14 x 反転数:2 {"o"=>7, "x"=>11}
# >> ・・・・・・・・
# >> ・・×・・・×・
# >> ・・×・○×○・
# >> ・○×○×・・・
# >> ・・××○○・・
# >> ・・・××・○・
# >> ・・・×・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 15 o 反転数:3 {"o"=>11, "x"=>8}
# >> ・・・・・・・・
# >> ・・×・・・×・
# >> ・・×・○×○・
# >> ・○×○×・・・
# >> ・・×○○○・・
# >> ・・・○×・○・
# >> ・・・○・・・・
# >> ・・・○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 16 x 反転数:3 {"o"=>8, "x"=>12}
# >> ・・・・・・・・
# >> ・・×・・・×・
# >> ・・×・○×○・
# >> ・○×○×・・・
# >> ・・×××××・
# >> ・・・○×・○・
# >> ・・・○・・・・
# >> ・・・○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 17 o 反転数:1 {"o"=>10, "x"=>11}
# >> ・・・・・・・・
# >> ・・×○・・×・
# >> ・・○・○×○・
# >> ・○×○×・・・
# >> ・・×××××・
# >> ・・・○×・○・
# >> ・・・○・・・・
# >> ・・・○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 18 x 反転数:2 {"x"=>14, "o"=>8}
# >> ・・・・・・・・
# >> ・××○・・×・
# >> ・・×・○×○・
# >> ・○×××・・・
# >> ・・×××××・
# >> ・・・○×・○・
# >> ・・・○・・・・
# >> ・・・○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 19 o 反転数:4 {"o"=>13, "x"=>10}
# >> ・・・・・・・・
# >> ・××○・・×・
# >> ・・×○○×○・
# >> ・○×○○・・・
# >> ・・×○×○×・
# >> ・・・○×・○・
# >> ・・・○・・・・
# >> ・・・○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 20 x 反転数:1 {"o"=>12, "x"=>12}
# >> ・・・・・・・・
# >> ・××○・・×・
# >> ・・×○○×○・
# >> ・○×○○・・・
# >> ・・×○×○×・
# >> ・・・○×・○・
# >> ・・・×・・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 21 o 反転数:2 {"o"=>15, "x"=>10}
# >> ・・・・・・・○
# >> ・××○・・○・
# >> ・・×○○○○・
# >> ・○×○○・・・
# >> ・・×○×○×・
# >> ・・・○×・○・
# >> ・・・×・・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 22 x 反転数:1 {"o"=>14, "x"=>12}
# >> ・・・・・・・○
# >> ・××○・・○・
# >> ・・×○○○○・
# >> ・○×○○・・・
# >> ・・×○×○×・
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 23 o 反転数:1 {"o"=>16, "x"=>11}
# >> ・・・・・・・○
# >> ・××○・・○・
# >> ・・×○○○○・
# >> ・○×○○・・・
# >> ・・×○×○○○
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 24 x 反転数:1 {"o"=>15, "x"=>13}
# >> ・・・・・・・○
# >> ・××○・・○・
# >> ×・×○○○○・
# >> ・××○○・・・
# >> ・・×○×○○○
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 25 o 反転数:2 {"o"=>18, "x"=>11}
# >> ・・・・・・・○
# >> ・××○・・○・
# >> ×○○○○○○・
# >> ・×○○○・・・
# >> ・・×○×○○○
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 26 x 反転数:3 {"o"=>15, "x"=>15}
# >> ・・・・・・・○
# >> ×××○・・○・
# >> ××○○○○○・
# >> ・××○○・・・
# >> ・・×××○○○
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 27 o 反転数:4 {"o"=>20, "x"=>11}
# >> ・・・・・・・○
# >> ×××○・・○・
# >> ××○○○○○・
# >> ・×○○○・・・
# >> ・○○○○○○○
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 28 x 反転数:2 {"o"=>18, "x"=>14}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・×○○○・・・
# >> ・○○○○○○○
# >> ・・・××・○・
# >> ・・・××・・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 29 o 反転数:1 {"o"=>20, "x"=>13}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・×○○○・・・
# >> ・○○○○○○○
# >> ・・・×○・○・
# >> ・・・××○・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 30 x 反転数:1 {"o"=>19, "x"=>15}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・×○○○・・・
# >> ・×○○○○○○
# >> ・×・×○・○・
# >> ・・・××○・・
# >> ・・×○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 31 o 反転数:1 {"o"=>21, "x"=>14}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・×○○○・・・
# >> ・×○○○○○○
# >> ・×・×○・○・
# >> ・・・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 32 x 反転数:2 {"o"=>19, "x"=>17}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・××○○・・・
# >> ・××○○○○○
# >> ・×××○・○・
# >> ・・・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 33 o 反転数:1 {"o"=>21, "x"=>16}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・××○○・・・
# >> ・××○○○○○
# >> ・×○×○・○・
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 34 x 反転数:3 {"x"=>20, "o"=>18}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・×××○・・・
# >> ・××○×○○○
# >> ・×○×××○・
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 35 o 反転数:3 {"x"=>17, "o"=>22}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ・×○×○・・・
# >> ・○×○×○○○
# >> ○○○×××○・
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 36 x 反転数:2 {"x"=>20, "o"=>20}
# >> ・・・・×・・○
# >> ××××・・○・
# >> ×××○○○○・
# >> ××○×○・・・
# >> ・××○×○○○
# >> ○○××××○・
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 37 o 反転数:1 {"x"=>19, "o"=>22}
# >> ・・・○×・・○
# >> ×××○・・○・
# >> ×××○○○○・
# >> ××○×○・・・
# >> ・××○×○○○
# >> ○○××××○・
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 38 x 反転数:1 {"x"=>21, "o"=>21}
# >> ・・・○×・・○
# >> ×××○・・○・
# >> ×××○○○○・
# >> ××○×○・・・
# >> ・××○×○○○
# >> ○○××××××
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 39 o 反転数:5 {"x"=>16, "o"=>27}
# >> ・○・○×・・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・・・
# >> ・○×○×○○○
# >> ○○××××××
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 40 x 反転数:2 {"x"=>19, "o"=>25}
# >> ・○・○×・・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・×・
# >> ・○×○×××○
# >> ○○××××××
# >> ・○・××○・・
# >> ・○○○・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 41 o 反転数:5 {"x"=>14, "o"=>31}
# >> ・○・○×・・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・×・
# >> ・○×○○××○
# >> ○○○×○×××
# >> ・○・○○○・・
# >> ・○○○○・・・
# >> --------------------------------------------------------------------------------
# >> TURN 42 x 反転数:1 {"x"=>16, "o"=>30}
# >> ・○・○×・・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・×・
# >> ・○×○○××○
# >> ○○××○×××
# >> ・○×○○○・・
# >> ・○○○○・・・
# >> --------------------------------------------------------------------------------
# >> TURN 43 o 反転数:1 {"x"=>15, "o"=>32}
# >> ・○・○○○・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・×・
# >> ・○×○○××○
# >> ○○××○×××
# >> ・○×○○○・・
# >> ・○○○○・・・
# >> --------------------------------------------------------------------------------
# >> TURN 44 x 反転数:3 {"x"=>19, "o"=>29}
# >> ・○・○○○・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・×・
# >> ・○×○○××○
# >> ○○××○×××
# >> ・○×××××・
# >> ・○○○○・・・
# >> --------------------------------------------------------------------------------
# >> TURN 45 o 反転数:3 {"x"=>16, "o"=>33}
# >> ・○・○○○・○
# >> ×○○○・・○・
# >> ×○×○○○○・
# >> ×○○×○・×・
# >> ・○○○○××○
# >> ○○×○○×××
# >> ・○××○××・
# >> ・○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 46 x 反転数:4 {"x"=>21, "o"=>29}
# >> ・○・○○○・○
# >> ×○○○・・○・
# >> ×○××××××
# >> ×○○×○・×・
# >> ・○○○○××○
# >> ○○×○○×××
# >> ・○××○××・
# >> ・○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 47 o 反転数:5 {"x"=>16, "o"=>35}
# >> ・○・○○○・○
# >> ×○○○・・○・
# >> ×○××××××
# >> ×○○×○・×・
# >> ・○○○○○×○
# >> ○○×○○×○○
# >> ・○××○○○○
# >> ・○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 48 x 反転数:1 {"x"=>18, "o"=>34}
# >> ・○・○○○×○
# >> ×○○○・・×・
# >> ×○××××××
# >> ×○○×○・×・
# >> ・○○○○○×○
# >> ○○×○○×○○
# >> ・○××○○○○
# >> ・○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 49 o 反転数:2 {"x"=>16, "o"=>37}
# >> ・○・○○○×○
# >> ×○○○・・×・
# >> ×○××××××
# >> ×○○×○・×○
# >> ・○○○○○○○
# >> ○○×○○○○○
# >> ・○××○○○○
# >> ・○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 50 x 反転数:1 {"x"=>18, "o"=>36}
# >> ・○・○○○×○
# >> ×○○○・・×・
# >> ×○××××××
# >> ×○○×○・×○
# >> ・○○○○○○○
# >> ○○×○○○○○
# >> ・×××○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 51 o 反転数:4 {"x"=>14, "o"=>41}
# >> ・○・○○○×○
# >> ×○○○○・×・
# >> ×○×○○○××
# >> ×○○×○・○○
# >> ・○○○○○○○
# >> ○○×○○○○○
# >> ・×××○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 52 x 反転数:3 {"x"=>18, "o"=>38}
# >> ・○・○○○×○
# >> ×○○○○・×・
# >> ×○×○○○××
# >> ×○○×××○○
# >> ・○○○×○○○
# >> ○○××○○○○
# >> ・×××○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 53 o 反転数:1 {"x"=>17, "o"=>40}
# >> ・○・○○○×○
# >> ×○○○○○×・
# >> ×○×○○○○×
# >> ×○○×××○○
# >> ・○○○×○○○
# >> ○○××○○○○
# >> ・×××○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 54 x 反転数:7 {"x"=>25, "o"=>33}
# >> ・○×××××○
# >> ××××○○×・
# >> ×○×○×○○×
# >> ×○○×××○○
# >> ・○○○×○○○
# >> ○○××○○○○
# >> ・×××○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 55 o 反転数:3 {"x"=>22, "o"=>37}
# >> ・○×××××○
# >> ××××○○×・
# >> ×○×○×○○×
# >> ×○○×××○○
# >> ・○○○×○○○
# >> ○○××○○○○
# >> ○○○○○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 56 x 反転数:6 {"x"=>29, "o"=>31}
# >> ・○×××××○
# >> ××××○○×・
# >> ×○×○×○○×
# >> ××○×××○○
# >> ×××××○○○
# >> ×○××○○○○
# >> ×○○○○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 57 o 反転数:4 {"o"=>36, "x"=>25}
# >> ○○×××××○
# >> ×○××○○×・
# >> ×○○○×○○×
# >> ××○○××○○
# >> ××××○○○○
# >> ×○××○○○○
# >> ×○○○○○○○
# >> ×○○○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 58 x 反転数:12 {"o"=>24, "x"=>38}
# >> ○○×××××○
# >> ×○××○○×・
# >> ×○○○×○××
# >> ××○○×××○
# >> ××××○○×○
# >> ×○×××○×○
# >> ×○○○○××○
# >> ×××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 59 o 反転数:4 {"o"=>29, "x"=>34}
# >> ○○×××××○
# >> ×○××○○○○
# >> ×○○○×○○○
# >> ××○○×○×○
# >> ××××○○×○
# >> ×○×××○×○
# >> ×○○○○××○
# >> ×××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 60 x 反転数:skip {"o"=>29, "x"=>34}
# >> ○○×××××○
# >> ×○××○○○○
# >> ×○○○×○○○
# >> ××○○×○×○
# >> ××××○○×○
# >> ×○×××○×○
# >> ×○○○○××○
# >> ×××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 61 o 反転数:1 {"o"=>31, "x"=>33}
# >> ○○×××××○
# >> ×○××○○○○
# >> ×○○○×○○○
# >> ××○○×○×○
# >> ××××○○×○
# >> ×○×××○×○
# >> ×○○○○×○○
# >> ×××××××○
# >> ○○×××××○
# >> ×○××○○○○
# >> ×○○○×○○○
# >> ××○○×○×○
# >> ××××○○×○
# >> ×○×××○×○
# >> ×○○○○×○○
# >> ×××××××○
# >> {"o"=>31, "x"=>33}
