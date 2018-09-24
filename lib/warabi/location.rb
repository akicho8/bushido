# frozen-string-literal: true
#
# 上下のみを表わす
#
# - 先手後手というのは平手の場合だけの名称
# - 駒落ちなら、まず名称が上手下手に代わり、もともと後手と呼ばれていた上側が先に指す
# - 先手というのが「先に指す」という意味で使われるなら「先手」は位置を特定できない。駒落ちなら△で、平手なら▲になる。
# - だから上下の位置を表わすのに先手後手の名前を使うのはまちがい
# - 上下は△▲だけに対応する
#
module Warabi
  class Location
    include ApplicationMemoryRecord
    memory_record [
      {key: :black, name: "▲", equality_name: "先手", handicap_name: "下手", equality_name2: "せんて", handicap_name2: "したて", flip_mark: "▼", varrow: " ", csa_sign: "+", angle: 0,   other_match_chars: ["☗"], to_sfen: "b", normalize_key: :itself, value_sign: +1 },
      {key: :white, name: "△", equality_name: "後手", handicap_name: "上手", equality_name2: "ごて",   handicap_name2: "うわて", flip_mark: "▽", varrow: "v", csa_sign: "-", angle: 180, other_match_chars: ["☖"], to_sfen: "w", normalize_key: :flip,   value_sign: -1 },
    ]

    class << self
      def lookup(value)
        v = super

        unless v
          if value.kind_of?(Integer)
            v = lookup(value.modulo(count))
          end
        end

        unless v
          v = find { |e| e.match_target_values_set.include?(value) }
        end

        v
      end

      def triangles_str
        @triangles_str ||= flat_map { |e| [e.mark, e.flip_mark] }.join
      end

      # b w とかではなく sfen の駒の文字の大文字小文字で判断する
      # だから v をキーにしたテーブルにするのはやめたほうがいい
      def fetch_by_sfen_char(ch)
        if ch.match?(/[[:upper:]]/)
          self[:black]
        else
          self[:white]
        end
      end
    end

    def call_names
      [equality_name, handicap_name]
    end

    def call_name(handicap)
      send(call_name_key(handicap))
    end

    def kifuyomi(handicap)
      if handicap
        handicap_name2
      else
        equality_name2
      end
    end

    def mark
      name
    end

    def black?
      key == :black
    end

    def white?
      key == :white
    end

    def which_val(a, b)
      black? ? a : b
    end

    def flip
      @flip ||= self.class.fetch(code.next.modulo(self.class.count))
    end

    alias next_location flip

    def match_target_values_set
      @match_target_values_set ||= [
        key,
        mark,
        flip_mark,
        other_match_chars,
        to_sfen,
        name,
        name.chars.first,
        code,
        varrow,
        csa_sign,
        equality_name,
        handicap_name,
      ].flatten.to_set
    end

    # HTMLにするとき楽なように後手なら transform: rotate(180deg) を返す
    def style_transform
      if angle.nonzero?
        "transform: rotate(#{angle}deg)"
      end
    end

    private

    def call_name_key(handicap)
      if handicap
        :handicap_name
      else
        :equality_name
      end
    end
  end
end
