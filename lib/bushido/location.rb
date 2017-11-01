#
# 先手・後手
#
module Bushido
  class Location
    include MemoryRecord
    memory_record [
      {key: :black, mark: "▲", reverse_mark: "▼", other_marks: ["b", "^"], name: "先手", varrow: " "},
      {key: :white, mark: "▽", reverse_mark: "△", other_marks: ["w"],      name: "後手", varrow: "v"},
    ]

    alias index code

    # 「▲先手」みたいなのを返す
    #   mark_with_name # => "▲先手"
    def mark_with_name
      "#{mark}#{name}"
    end

    # 先手か？
    def black?
      key == :black
    end

    # 後手か？
    def white?
      key == :white
    end

    # 属性っぽい値を全部返す
    def match_target_values
      [key, mark, reverse_mark, other_marks, name, name.chars.first, index, varrow].flatten
    end

    # 先手ならaを後手ならbを返す
    def where_value(a, b)
      black? ? a : b
    end

    # 反対を返す
    def reverse
      self.class.parse(index.next.modulo(self.class.count))
    end

    # # オブジェクトIDが異なってもキーが同じなら一致(Marshal関連で復活させたとき不一致になるため追加)
    # def ==(other)
    #   key == other.key
    # end

    alias next_location reverse

    class << self
      # 引数に対応する先手または後手の情報を返す
      #   Location[:black].name   # => "先手"
      #   Location["▲"].name     # => "先手"
      #   Location["先手"].name   # => "先手"
      #   Location[0].name        # => "先手"
      #   Location[1].name        # => "後手"
      #   Location[2]             # => SyntaxError
      #   Location["1手目"].name  # => "先手"
      #   Location["2手目"].name  # => "後手"
      #   Location["3手目"].name  # => "先手"
      def parse(arg)
        r = lookup(arg)
        unless r
          r = find { |e| e.match_target_values.include?(arg) }
        end
        unless r
          if arg.kind_of?(String) && md = arg.match(/(?<location_index>\d+)手目/)
            r = parse(md[:location_index].to_i.pred.modulo(each.count))
          end
        end
        r or raise SyntaxError, "#{arg.inspect}"
      end

      # 引数に対応する先手または後手の情報を返す
      #   Location[:black].name # => "先手"
      def [](*args)
        parse(*args)
      end

      def b; self[:black]; end
      def w; self[:white]; end

      def triangles
        collect { |e| [e.mark, e.reverse_mark] }.join
      end
    end
  end

  L = Location
end
