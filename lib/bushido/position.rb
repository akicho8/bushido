#
# 一次元座標管理
#
module Bushido
  module Position
    module Base
      extend ActiveSupport::Concern

      included do
        class_attribute :size
        self.size = 9

        attr_reader :value
        private_class_method :new
      end

      class_methods do
        # 座標をパースする
        # @example
        #   Position::Hpos.parse("１").name # => "1"
        def parse(arg)
          case arg
          when String, NilClass
            v = units.find_index { |e| e == arg }
            v or raise PositionSyntaxError, "#{arg.inspect} が #{units} の中にありません"
          when Base
            v = arg.value
          else
            v = arg
          end
          new(v) # TODO: 毎回 new するのではなく固定インスタンスを返すと速くなるかもしれない
        end

        # 幅
        def value_range
          (0...units.size)
        end

        # 全角の文字配列
        def units
          @units ||= {}
          @units[size] ||= _units.chars.to_a.send(_arrow, size)
        end
      end

      def initialize(value)
        @value = value
      end

      # 座標が盤上か？
      def valid?
        self.class.value_range.cover?(@value)
      end

      # 名前
      # @example
      #   Position::Vpos.parse("一").name # => "一"
      def name
        @name ||= self.class.units[@value]
      end

      # 数字表記
      # @example
      #   Position::Vpos.parse("一").number_format # => "1"
      def number_format
        name
      end

      # 座標反転
      # @example
      #   Position::Hpos.parse("1").reverse.name # => "9"
      def reverse
        @reverse ||= self.class.parse(self.class.units.size - 1 - @value)
      end

      # インスタンスが異なっても同じ座標なら同じ
      def ==(other)
        self.class == other.class && @value == other.value
      end

      def inspect
        "#<#{self.class.name}:#{object_id} #{name.inspect} #{@value}>"
      end

      # 成れるか？
      # @example
      #   Point.parse("１三").promotable?(:black) # => true
      #   Point.parse("１四").promotable?(:black) # => false
      def promotable?(location)
        v = self
        if location.white?
          v = v.reverse
        end
        if _promotable_size
          v.value < _promotable_size
        end
      end
    end

    class Hpos
      include Base # FIXME: Base を継承して cattr_accessor を class_attribute に変更
      cattr_accessor(:_units)     { "９８７６５４３２１" }
      cattr_accessor(:_arrow)             { :last } # ←左方向に増加
      cattr_accessor(:_promotable_size)   { nil }

      def self.parse(arg)
        if arg.kind_of?(String)
          arg = arg.tr("1-9", "１-９")
          arg = arg.tr("一二三四五六七八九", "１-９")
        end
        super
      end

      def number_format
        name.tr("１-９", "1-9")
      end
    end

    class Vpos
      include Base
      cattr_accessor(:_units)     { "一二三四五六七八九" }
      cattr_accessor(:_arrow)             { :first } # 右方向に増加→
      cattr_accessor(:_promotable_size)   { 3 }      # 相手の陣地の成れる縦幅

      # "(52)" の "2" に対応するため
      def self.parse(arg)
        if arg.kind_of?(String)
          arg = arg.tr("1-9１-９", "#{_units}#{_units}")
        end
        super
      end

      def number_format
        # "一-九" は文字コード順ではないので指定できない
        super.tr(_units, "1-9")
      end
    end
  end
end
