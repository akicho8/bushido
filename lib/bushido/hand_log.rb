#
# 棋譜の一手分の保存用
#
module Bushido
  class HandLog
    attr_reader :point, :piece, :promoted, :promote_trigger, :strike_trigger, :origin_point, :player, :candidate, :point_same_p

    def initialize(attrs)
      attrs.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

    # 両方返す
    # 主にテスト用
    def to_kif_ki2
      [to_s_kif, to_s_ki2]
    end

    # "7六歩" のようなCPUに優しいKIF形式の表記で返す
    def to_s_kif(options = {})
      options = {
        with_mark: false,
      }.merge(options)

      s = []
      if options[:with_mark]
        s << @player.location.mark
      end
      s << @point.name
      s << @piece.some_name(@promoted)
      if @promote_trigger
        s << "成"
      end
      if @strike_trigger
        s << "打"
      end
      if @origin_point
        s << "(#{@origin_point.number_format})"
      end
      s.join
    end

    # "58金右" のような人間向けの表記を返す
    def to_s_ki2(options = {})
      Ki2FormatConv.new(self, options).to_s
    end

    class Ki2FormatConv
      def initialize(hand_log, options = {})
        @hand_log = hand_log
        @options = {
          with_mark: false,
        }.merge(options)
      end

      # "同銀" のような人間向けの表記を返す
      def to_s
        s = []
        if @options[:with_mark]
          s << @hand_log.player.location.mark
        end
        if @hand_log.point_same_p
          s << "同"
        else
          s << @hand_log.point.name
        end
        s << @hand_log.piece.some_name(@hand_log.promoted)
        s << get_suffix
        if @hand_log.promote_trigger
          s << "成"
        else
          if @hand_log.origin_point && @hand_log.point
            if @hand_log.origin_point.promotable?(@hand_log.player.location) || @hand_log.point.promotable?(@hand_log.player.location)
              unless @hand_log.promoted
                if @hand_log.piece.promotable?
                  s << "不成"
                end
              end
            end
          end
        end
        if @hand_log.strike_trigger
          s << "打"
        end
        s.join
      end

      private

      # 左右引寄直
      def get_suffix
        s = []
        # 候補が2つ以上あったとき
        if @hand_log.candidate && @hand_log.candidate.size > 1
          if @hand_log.piece.brave?
            # 大駒の場合、
            # 【移動元で二つの龍が水平線上にいる】or【移動先の水平線上よりすべて上かすべて下】
            if @hand_log.candidate.collect{|s|s.point.y.value}.uniq.size == 1 || [     # 移動元で二つの龍が水平線上にいる
                @hand_log.candidate.all?{|s|s.point.y.value < @hand_log.point.y.value},   # 移動先の水平線上よりすべて上または
                @hand_log.candidate.all?{|s|s.point.y.value > @hand_log.point.y.value},   #                     すべて下
              ].any?

              sorted_candidate = @hand_log.candidate.sort_by{|soldier|soldier.point.x.value}
              if sorted_candidate.last.point.x.value == @hand_log.origin_point.x.value
                s << which_char("右", "左")
              end
              if sorted_candidate.first.point.x.value == @hand_log.origin_point.x.value
                s << which_char("左", "右")
              end
            end
          else
            # 普通駒の場合、
            # 左右がつくのは移動先の左側と右側の両方に駒があるとき
            if [@hand_log.candidate.any?{|s|s.point.x.value < @hand_log.point.x.value},      # 移動先の左側に駒がある、かつ
                @hand_log.candidate.any?{|s|s.point.x.value > @hand_log.point.x.value}].all? # 移動先の右側に駒がある
              if @hand_log.point.x.value < @hand_log.origin_point.x.value
                s << which_char("右", "左")
              end
              if @hand_log.point.x.value > @hand_log.origin_point.x.value
                s << which_char("左", "右")
              end
            end

            # 目標座標の左方向または右方向に駒があって、自分は縦の列から来た場合
            if [@hand_log.candidate.any?{|s|s.point.x.value < @hand_log.point.x.value},
                @hand_log.candidate.any?{|s|s.point.x.value > @hand_log.point.x.value}].any?
              if @hand_log.point.x.value == @hand_log.origin_point.x.value
                s << "直"
              end
            end
          end

          # 目標地点の上と下、両方にあって区別がつかないとき、
          if [@hand_log.candidate.any?{|s|s.point.y.value < @hand_log.point.y.value},
              @hand_log.candidate.any?{|s|s.point.y.value > @hand_log.point.y.value}].all? ||
              # 上か下にあって、水平線にもある
              [@hand_log.candidate.any?{|s|s.point.y.value < @hand_log.point.y.value},
              @hand_log.candidate.any?{|s|s.point.y.value > @hand_log.point.y.value}].any? && @hand_log.candidate.any?{|s|s.point.y.value == @hand_log.point.y.value}

            # 下から来たのなら、ひき"上"げ、
            # 上から来たなら、"引"く
            if @hand_log.point.y.value < @hand_log.origin_point.y.value
              s << which_char("上", "引")
            elsif @hand_log.point.y.value > @hand_log.origin_point.y.value
              s << which_char("引", "上")
            end
          end

          # 目標座標の上方向または下方向に駒があって、自分は真横の列から来た場合
          if [@hand_log.candidate.any?{|s|s.point.y.value < @hand_log.point.y.value},
              @hand_log.candidate.any?{|s|s.point.y.value > @hand_log.point.y.value}].any?
            if @hand_log.point.y.value == @hand_log.origin_point.y.value
              s << "寄"
            end
          end
        end
        s
      end

      def which_char(*args)
        @hand_log.player.location.where_value(*args)
      end
    end
  end
end
