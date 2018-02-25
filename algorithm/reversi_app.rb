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

    @players = [:o, :x]
    @board = {}
    @pass_counts = Hash.new(0)

    placement
  end

  def can_put_points(player)
    blank_points.find_all { |e| can_put_on?(player, e) }
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
      hash = reversible_counts_hash(player, point)

      # 空なら利きが一つもないことになるのでパスになるが事前にチェックしておきたいのでここでは例外とする
      if hash.empty?
        raise "反転できないのに置きました : player:#{player} point:#{point}\n#{self}"
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
    end
  end

  def evaluate(player)
    run_counts[:evaluate] += 1
    o = histogram[:o]
    x = histogram[:x]
    if player == :o
      o - x
    else
      x - o
    end
  end

  def histogram
    players.inject({}) { |a, e| a.merge(e => board.values.count(e)) }
  end

  def player_at(turn)
    players[turn.modulo(players.count)]
  end

  def pass(player)
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

  def run_counts
    @run_counts ||= Hash.new(0)
  end

  def dimension
    params[:dimension]
  end

  def to_s
    dimension.times.collect { |y|
      dimension.times.collect { |x|
        v = board[V[x, y]]
        if v
          if v == :o
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

  def run
    placement
    256.times do |turn|
      if game_over?
        break
      end
      player = player_at(turn)
      points = can_put_points(player)
      count = nil
      if points.empty?
        pass(player)
      else
        pass_reset
        if true
          # 賢く指す
          point = points.max { |e| reversible_total_count(player, e) }
        else
          # 適当に指す
          point = points.sample
        end
        count = put_on(player, point)
      end
      puts "---------------------------------------- [#{turn}] #{player} 反転数:#{count || 'pass'} #{histogram} 評価値:#{evaluate(:o)}"
      puts self
    end
    tp board.values.group_by(&:itself).transform_values(&:size)
  end

  private

  # 1個以上反転させられる利きと個数をペアにしたハッシュを返す
  def reversible_counts_hash(player, point)
    Around.collect { |vec|
      count = reversible_one_way_count(player, point, vec)
      if count >= 1
        [vec, count]
      end
    }.compact.to_h
  end

  def placement
    half = dimension / 2
    board[V[half - 1, half - 1]] = :x
    board[V[half, half]]         = :x
    board[V[half, half - 1]]     = :o
    board[V[half - 1, half]]     = :o
  end

  # point に置いたときに反転できる数
  def reversible_total_count(player, point)
    reversible_counts_hash(player, point).values.sum
  end

  # 空いている位置をすべて返す
  def blank_points
    dimension.times.flat_map { |y|
      dimension.times.collect { |x|
        v = Vector[x, y]
        unless board[v]
          v
        end
      }
    }.compact
  end

  def can_put_on?(player, point)
    raise "not blank" if board[point]
    Around.any? { |e| reversible_one_way_count(player, point, e) >= 1 }
  end

  # player が point の位置に置いたと仮定したとき vec の方向で何枚裏返すことができるか
  # 1個以上のときだけその個数を返す
  def reversible_one_way_count(player, point, vec)
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
end

if $0 == __FILE__
  ReversiApp.new.run
end
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・×○・・・
# >> ・・・○×・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 1 o 反転数:1 {:o=>4, :x=>1} 評価値:3
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・×○・・・
# >> ・・・○○・・・
# >> ・・・・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 2 x 反転数:1 {:o=>3, :x=>3} 評価値:0
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・×××・・
# >> ・・・○○・・・
# >> ・・・・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 3 o 反転数:1 {:o=>5, :x=>2} 評価値:3
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・○・
# >> ・・・××○・・
# >> ・・・○○・・・
# >> ・・・・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 4 x 反転数:1 {:o=>4, :x=>4} 評価値:0
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・○・
# >> ・・・××○・・
# >> ・・・×○・・・
# >> ・・×・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 5 o 反転数:3 {:o=>8, :x=>1} 評価値:7
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・・○・
# >> ・・○○○○・・
# >> ・・・○○・・・
# >> ・・×・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 6 x 反転数:2 {:o=>6, :x=>4} 評価値:2
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・・×○・
# >> ・・○○×○・・
# >> ・・・×○・・・
# >> ・・×・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 7 o 反転数:2 {:o=>9, :x=>2} 評価値:7
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・○○○○・・
# >> ・・・×○・・・
# >> ・・×・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 8 x 反転数:1 {:o=>8, :x=>4} 評価値:4
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・○○○○・・
# >> ・・・×××・・
# >> ・・×・○・・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 9 o 反転数:2 {:o=>11, :x=>2} 評価値:9
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・○○○○・・
# >> ・・・×○○・・
# >> ・・×・○○・・
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 10 x 反転数:1 {:o=>10, :x=>4} 評価値:6
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・○○○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・×・・
# >> ・・・・・・・・
# >> --------------------------------------------------------------------------------
# >> TURN 11 o 反転数:1 {:o=>12, :x=>3} 評価値:9
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・・○○○・
# >> ・・○○○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 12 x 反転数:1 {:o=>11, :x=>5} 評価値:6
# >> ・・・・・・・・
# >> ・・・・・・・・
# >> ・・・×○○○・
# >> ・・○×○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 13 o 反転数:1 {:o=>13, :x=>4} 評価値:9
# >> ・・・・・・・・
# >> ・・・・○・・・
# >> ・・・○○○○・
# >> ・・○×○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 14 x 反転数:1 {:o=>12, :x=>6} 評価値:6
# >> ・・・・・・・・
# >> ・・・×○・・・
# >> ・・・×○○○・
# >> ・・○×○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 15 o 反転数:2 {:o=>15, :x=>4} 評価値:11
# >> ・・・・・・・・
# >> ・・○○○・・・
# >> ・・・○○○○・
# >> ・・○×○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 16 x 反転数:1 {:o=>14, :x=>6} 評価値:8
# >> ・・・・・・・・
# >> ・・○○○・・・
# >> ・×・○○○○・
# >> ・・××○○・・
# >> ・・・×○○・・
# >> ・・×・×○・・
# >> ・・・・・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 17 o 反転数:1 {:o=>16, :x=>5} 評価値:11
# >> ・・・・・・・・
# >> ・・○○○・・・
# >> ・×・○○○○・
# >> ・・××○○・・
# >> ・・・×○○・・
# >> ・・×・○○・・
# >> ・・・○・○・・
# >> ・・・・・○・・
# >> --------------------------------------------------------------------------------
# >> TURN 18 x 反転数:1 {:o=>15, :x=>7} 評価値:8
# >> ・・・・・・・・
# >> ・・○○○・・・
# >> ・×・○○○○・
# >> ・・××○○・・
# >> ・・・×○○・・
# >> ・・×・○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 19 o 反転数:2 {:o=>18, :x=>5} 評価値:13
# >> ・・・・・・・・
# >> ・・○○○・・・
# >> ・×・○○○○・
# >> ・・×○○○・・
# >> ・・○○○○・・
# >> ・・×・○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 20 x 反転数:1 {:o=>17, :x=>7} 評価値:10
# >> ・・・×・・・・
# >> ・・×○○・・・
# >> ・×・○○○○・
# >> ・・×○○○・・
# >> ・・○○○○・・
# >> ・・×・○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 21 o 反転数:1 {:o=>19, :x=>6} 評価値:13
# >> ・・・×・・・・
# >> ・・×○○・・・
# >> ・×・○○○○・
# >> ・○○○○○・・
# >> ・・○○○○・・
# >> ・・×・○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 22 x 反転数:4 {:o=>15, :x=>11} 評価値:4
# >> ・・・×・・・・
# >> ・・××○・・・
# >> ・×・×○○○・
# >> ・○○×○○・・
# >> ・・○×○○・・
# >> ・・××○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 23 o 反転数:2 {:o=>18, :x=>9} 評価値:9
# >> ・・・×・・・・
# >> ・・××○・・・
# >> ・×○○○○○・
# >> ・○○○○○・・
# >> ・・○×○○・・
# >> ・・××○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 24 x 反転数:2 {:o=>16, :x=>12} 評価値:4
# >> ・・・×・・・・
# >> ・・××○・・・
# >> ××○○○○○・
# >> ・×○○○○・・
# >> ・・××○○・・
# >> ・・××○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 25 o 反転数:3 {:o=>20, :x=>9} 評価値:11
# >> ・・・×・・・・
# >> ・・××○・・・
# >> ××○○○○○・
# >> ・×○○○○・・
# >> ・・○×○○・・
# >> ・○○○○○・・
# >> ・・・×・○・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 26 x 反転数:4 {:o=>16, :x=>14} 評価値:2
# >> ・・・×・・・・
# >> ・・××○・・・
# >> ××○×○○○・
# >> ・×○○×○・・
# >> ・・○×○×・・
# >> ・○○○○○×・
# >> ・・・×・×・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 27 o 反転数:2 {:o=>19, :x=>12} 評価値:7
# >> ・・○×・・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・×○○×○・・
# >> ・・○×○×・・
# >> ・○○○○○×・
# >> ・・・×・×・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 28 x 反転数:3 {:o=>16, :x=>16} 評価値:0
# >> ・・○×・・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・××○×○・・
# >> ・×××○×・・
# >> ・○×○○○×・
# >> ・・・×・×・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 29 o 反転数:3 {:o=>20, :x=>13} 評価値:7
# >> ・・○×・・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・×○○×○・・
# >> ・×○×○×・・
# >> ・○○○○○×・
# >> ・・○×・×・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 30 x 反転数:4 {:o=>16, :x=>18} 評価値:-2
# >> ・・○×・・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・×○○×○・・
# >> ・×××××・・
# >> ・○○××○×・
# >> ・・○×××・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 31 o 反転数:1 {:o=>18, :x=>17} 評価値:1
# >> ・・○×・・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・○○○×○・・
# >> ○×××××・・
# >> ・○○××○×・
# >> ・・○×××・・
# >> ・・・・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 32 x 反転数:2 {:o=>16, :x=>20} 評価値:-4
# >> ・・○×・・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・○○○×○・・
# >> ○×××××・・
# >> ・○×××○×・
# >> ・・××××・・
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 33 o 反転数:1 {:o=>18, :x=>19} 評価値:-1
# >> ・・○○○・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ・○○○×○・・
# >> ○×××××・・
# >> ・○×××○×・
# >> ・・××××・・
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 34 x 反転数:3 {:o=>15, :x=>23} 評価値:-8
# >> ・・○○○・・・
# >> ・・○○○・・・
# >> ××○×○○○・
# >> ×××××○・・
# >> ○×××××・・
# >> ・○×××○×・
# >> ・・××××・・
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 35 o 反転数:4 {:o=>20, :x=>19} 評価値:1
# >> ・・○○○・・・
# >> ・・○○○・・・
# >> ××○○○○○・
# >> ××××○○・・
# >> ○××××○・・
# >> ・○×××○○・
# >> ・・××××・○
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 36 x 反転数:5 {:o=>15, :x=>25} 評価値:-10
# >> ・・○○○・・・
# >> ・・○○○×・・
# >> ××○○××○・
# >> ××××○×・・
# >> ○×××××・・
# >> ・○××××○・
# >> ・・××××・○
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 37 o 反転数:2 {:o=>18, :x=>23} 評価値:-5
# >> ・・○○○・・・
# >> ・・○○○×・・
# >> ××○○××○・
# >> ××○×○×・・
# >> ○○××××・・
# >> ○○××××○・
# >> ・・××××・○
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 38 x 反転数:1 {:o=>17, :x=>25} 評価値:-8
# >> ・・○○○・・・
# >> ・・○○○×・・
# >> ××○○×××・
# >> ××○×○×・×
# >> ○○××××・・
# >> ○○××××○・
# >> ・・××××・○
# >> ・・×・×○・・
# >> --------------------------------------------------------------------------------
# >> TURN 39 o 反転数:6 {:o=>24, :x=>19} 評価値:5
# >> ・・○○○・・・
# >> ・・○○○×・・
# >> ××○○×××・
# >> ××○○○×・×
# >> ○○×○××・・
# >> ○○×○××○・
# >> ・・○○××・○
# >> ・・×○○○・・
# >> --------------------------------------------------------------------------------
# >> TURN 40 x 反転数:3 {:o=>21, :x=>23} 評価値:-2
# >> ・・○○○・・・
# >> ・・○○○×・・
# >> ××○○×××・
# >> ××○○○×・×
# >> ○○×○××・・
# >> ○○×○××○・
# >> ・・○○××・○
# >> ・・×××××・
# >> --------------------------------------------------------------------------------
# >> TURN 41 o 反転数:1 {:o=>23, :x=>22} 評価値:1
# >> ・・○○○・・・
# >> ・・○○○×・・
# >> ××○○×××・
# >> ××○○○×・×
# >> ○○×○××・・
# >> ○○○○××○・
# >> ・○○○××・○
# >> ・・×××××・
# >> --------------------------------------------------------------------------------
# >> TURN 42 x 反転数:5 {:o=>18, :x=>28} 評価値:-10
# >> ・・○○○・・・
# >> ・×××××・・
# >> ×××○×××・
# >> ××○×○×・×
# >> ○○×○××・・
# >> ○○○○××○・
# >> ・○○○××・○
# >> ・・×××××・
# >> --------------------------------------------------------------------------------
# >> TURN 43 o 反転数:4 {:o=>23, :x=>24} 評価値:-1
# >> ・・○○○・○・
# >> ・××××○・・
# >> ×××○○××・
# >> ××○○○×・×
# >> ○○○○××・・
# >> ○○○○××○・
# >> ・○○○××・○
# >> ・・×××××・
# >> --------------------------------------------------------------------------------
# >> TURN 44 x 反転数:5 {:o=>18, :x=>30} 評価値:-12
# >> ・・○○○・○・
# >> ・××××○・・
# >> ×××○○××・
# >> ××○○○×・×
# >> ○×○○××・・
# >> ○×○×××○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 45 o 反転数:5 {:o=>24, :x=>25} 評価値:-1
# >> ・・○○○・○・
# >> ・×××○○・・
# >> ×××○○○×・
# >> ××○○○○○×
# >> ○×○○×○・・
# >> ○×○×○×○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 46 x 反転数:7 {:o=>17, :x=>33} 評価値:-16
# >> ・・○○○×○・
# >> ・×××××・・
# >> ××××○××・
# >> ×××○○×○×
# >> ○×○○××・・
# >> ○×○×○×○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 47 o 反転数:2 {:o=>20, :x=>31} 評価値:-11
# >> ・○○○○×○・
# >> ・×○×××・・
# >> ×××○○××・
# >> ×××○○×○×
# >> ○×○○××・・
# >> ○×○×○×○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 48 x 反転数:1 {:o=>19, :x=>33} 評価値:-14
# >> ・○○○○×××
# >> ・×○×××・・
# >> ×××○○××・
# >> ×××○○×○×
# >> ○×○○××・・
# >> ○×○×○×○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 49 o 反転数:5 {:o=>25, :x=>28} 評価値:-3
# >> ・○○○○×××
# >> ○○○×××・・
# >> ○○×○○××・
# >> ○×○○○×○×
# >> ○×○○××・・
# >> ○×○×○×○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 50 x 反転数:1 {:o=>24, :x=>30} 評価値:-6
# >> ・○○○○×××
# >> ○○○×××・・
# >> ○○×○○××・
# >> ○×○○○×××
# >> ○×○○×××・
# >> ○×○×○×○・
# >> ・××○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 51 o 反転数:3 {:o=>28, :x=>27} 評価値:1
# >> ・○○○○×××
# >> ○○○×××・・
# >> ○○×○○××・
# >> ○×○○○×××
# >> ○×○○×××・
# >> ○○○×○×○・
# >> ○○○○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 52 x 反転数:1 {:o=>27, :x=>29} 評価値:-2
# >> ・○○○○×××
# >> ○○○×××・・
# >> ○○×○○××・
# >> ○×○○○×××
# >> ○×○○×××・
# >> ○○○×○×××
# >> ○○○○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 53 o 反転数:4 {:o=>32, :x=>25} 評価値:7
# >> ・○○○○×××
# >> ○○○○○○○・
# >> ○○×○○○×・
# >> ○×○○○×××
# >> ○×○○×××・
# >> ○○○×○×××
# >> ○○○○××・○
# >> ・××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 54 x 反転数:6 {:o=>26, :x=>32} 評価値:-6
# >> ・○○○○×××
# >> ○○○○○○×・
# >> ○○×○○××・
# >> ○×○○××××
# >> ○×○××××・
# >> ○○××○×××
# >> ○×○○××・○
# >> ×××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 55 o 反転数:4 {:o=>31, :x=>28} 評価値:3
# >> ・○○○○×××
# >> ○○○○○○×・
# >> ○○×○○××・
# >> ○×○○××××
# >> ○×○×○××・
# >> ○○××○○××
# >> ○×○○○○○○
# >> ×××××××・
# >> --------------------------------------------------------------------------------
# >> TURN 56 x 反転数:5 {:o=>26, :x=>34} 評価値:-8
# >> ・○○○○×××
# >> ○○○○○○×・
# >> ○○×○○××・
# >> ○×○×××××
# >> ○×○××××・
# >> ○○××○×××
# >> ○×○○○○××
# >> ××××××××
# >> --------------------------------------------------------------------------------
# >> TURN 57 o 反転数:4 {:o=>31, :x=>30} 評価値:1
# >> ・○○○○×××
# >> ○○○○○○×・
# >> ○○×○○○○○
# >> ○×○×××○×
# >> ○×○××○×・
# >> ○○××○×××
# >> ○×○○○○××
# >> ××××××××
# >> --------------------------------------------------------------------------------
# >> TURN 58 x 反転数:2 {:o=>29, :x=>33} 評価値:-4
# >> ・○○○○×××
# >> ○○○○○○××
# >> ○○×○○○××
# >> ○×○×××○×
# >> ○×○××○×・
# >> ○○××○×××
# >> ○×○○○○××
# >> ××××××××
# >> --------------------------------------------------------------------------------
# >> TURN 59 o 反転数:2 {:o=>32, :x=>31} 評価値:1
# >> ・○○○○×××
# >> ○○○○○○××
# >> ○○×○○○××
# >> ○×○×××○×
# >> ○×○××○○○
# >> ○○××○×○×
# >> ○×○○○○××
# >> ××××××××
# >> --------------------------------------------------------------------------------
# >> TURN 60 x 反転数:11 {:o=>21, :x=>43} 評価値:-22
# >> ××××××××
# >> ××○○○○××
# >> ×○×○○○××
# >> ××○×××○×
# >> ××○××○○○
# >> ×○××○×○×
# >> ××○○○○××
# >> ××××××××
# >> ××××××××
# >> ××○○○○××
# >> ×○×○○○××
# >> ××○×××○×
# >> ××○××○○○
# >> ×○××○×○×
# >> ××○○○○××
# >> ××××××××
# >> {:x=>43, :o=>21}
