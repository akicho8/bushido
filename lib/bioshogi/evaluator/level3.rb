# frozen-string-literal: true

require "bioshogi/evaluator/base"
require "bioshogi/evaluator/attack_weight_table"
require "bioshogi/evaluator/opening_basic_table"

module Bioshogi
  module Evaluator
    class Level3 < Base
      # 自分基準
      def score_compute
        (total_score(player) - total_score(player.op)).to_i
      end

      def score_compute_report
        rows = player.self_and_opponent.collect do |player|
          {
            "先後"           => "#{player.location} #{player == self.player ? "自分" : ''}",
            "駒箱(常時加算)" => player.piece_box.score,
            "序盤"           => "#{score1(player)} * #{(1.0 - pressure[player]).round(1)} = #{score1(player) * (1.0 - pressure[player])}",
            "終盤"           => "#{score2(player)} * #{pressure[player].round(1)} = #{score2(player) * pressure[player]}",
            "序終盤合計"     => total_score(player),
          }
        end
        rows += [{"全体" => score_compute}]
      end

      private

      def initialize(*)
        super

        # 途中で呼ばれると盤面が変化している場合があるので最初に作っておく
        #
        # YSS の場合は歩香桂以外では探索中でもきちんと動いた玉を考慮している
        # > http://www.yss-aya.com/book.html
        # > なお、高速化のため、歩、香、桂の小駒に対しては、探索途中で王が動いても再計算せずに、探索前の王の位置から増減表を作って加算している。
        #
        pressure
      end

      def total_score(player)
        w = 0
        w += player.piece_box.score
        w += score1(player) * (1.0 - pressure[player]) # 序盤 * 序盤の重み
        w += score2(player) * (0.0 + pressure[player]) # 終盤 * 終盤の重み
        w
      end

      # 序盤評価値
      def score1(player)
        w = 0
        player.soldiers.each do |e|
          w += e.abs_weight
          unless e.promoted
            if t = opening_basic_table[:field][e.piece.key]
              x, y = e.normalized_place.to_xy
              w += t[y][x]
            end
            if t = opening_basic_table[:advance][e.piece.key]
              w += t[e.bottom_spaces]
            end
          end
        end
        w
      end

      # 終盤評価値
      def score2(player)
        w = 0
        player.soldiers.each do |e|
          w += e.abs_weight
          w += soldier_score_for_scene(e, player.op.king_place, AttackWeightTable[:attack])  # 相手玉に攻まるとスコア＋
          w -= soldier_score_for_scene(e, player.my.king_place, AttackWeightTable[:defense]) # 相手玉に攻まるとスコア＋
        end
        w
      end

      # プレイヤーそれぞれの終盤度
      def pressure
        @pressure ||= players.inject({}) { |a, e| a.merge(e => e.pressure_rate) }
      end

      def opening_basic_table
        OpeningBasicTable
      end

      # 盤上の駒の位置による重み
      def soldier_score_for_scene(e, king_place, table)
        return 0 unless king_place

        if e.promoted || e.piece.key == :gold || e.piece.key == :silver
          # 相手の玉との距離
          sx, sy = e.place.to_xy
          tx, ty = king_place.to_xy
          gx = tx - sx
          gy = ty - sy

          # (mx, my) はテーブルのセルの位置
          # 金銀は上からの方が強いので縦は上と下でそれぞれ重みが違う
          oy = table.size / 2 # 8
          my = oy - gy        # 8 - (-2) = 10

          # mx は左右対象
          mx = gx.abs

          s = table.dig(my, mx)
          return 0 unless s
          # p ["#{__FILE__}:#{__LINE__}", __method__, e, w, s, [mx, my], king_place]
          s
        else
          0
        end
      end
    end
  end
end
