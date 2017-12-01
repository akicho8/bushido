# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/shash_spec.rb" -*-
# frozen-string-literal: true
#
#  クラス      名前               有効な属性
#  Soldier 盤上の駒の状態     point piece promoted
#  PieceStake  駒を打った情報     point piece promoted
#  BattlerMove 駒が動かした情報   point piece promoted origin_battler promoted_trigger
#
module Bushido
  #  文字列なら「５二竜」となる情報をこのままだと扱いにくいので
  #  point, piece, promoted の3つの情報にわける
  #  しかし分るとバラバラで扱いにくいので Soldier として保持する
  #  promoted は「打」とは関係ない。
  #  盤上の駒の状態を表す
  #
  #  Soldier.from_str("４二竜") # => {point: Point["４二"], piece: Piece["竜"], promoted: true}
  #
  class Soldier < Hash
    class << self
      # 人間が入力する *初期配置* の "４二竜" などをハッシュに分割する
      #   Soldier.from_str("４二竜") # => {point: Point["４二"], piece: Piece["竜"], promoted: true}
      def from_str(str)
        if str.kind_of?(self)
          return str
        end
        md = str.match(/\A(?<point>..)(?<piece>#{Piece.all_names.join("|")})\z/) # FIXME: 他のところと同様に厳密にチェックする
        md or raise SyntaxDefact, "表記が間違っています。'６八銀' や '68銀' のように1つだけ入力してください : #{str.inspect}"
        Soldier.new_with_promoted(md[:piece]).merge(point: Point.parse(md[:point]))
      end

      # 「歩」や「と」を駒オブジェクトと成フラグに分離
      #   Soldier.new_with_promoted("歩") # => <Soldier piece:"歩">
      #   Soldier.new_with_promoted("と") # => <Soldier piece:"歩", promoted: true>
      def new_with_promoted(value)
        case
        when piece = Piece.basic_lookup(value)
          self[piece: piece, promoted: false]
        when piece = Piece.promoted_lookup(value)
          self[piece: piece, promoted: true]
        else
          raise PieceNotFound, "#{value.inspect} に対応する駒がありません"
        end
      end

      def csa_new_with_promoted(value)
        case
        when piece = Piece.find { |e| e.csa_basic_name == value }
          self[piece: piece, promoted: false]
        when piece = Piece.find { |e| e.csa_promoted_name == value }
          self[piece: piece, promoted: true]
        else
          raise PieceNotFound, "#{value.inspect} に対応する駒がありません"
        end
      end
    end

    # 「１一香成」ではなく「１一杏」を返す
    # 指し手を返すには to_hand を使うこと
    def to_s
      formal_name
    end

    def name
      formal_name
    end

    def formal_name
      [self[:point].name, piece_name].join
    end

    def piece_name
      self[:piece].some_name(self[:promoted])
    end

    def location_piece_name
      [self[:location].name, formal_name].join
    end

    def point
      self[:point]
    end

    # つかってない
    # def csa_piece_name
    #   self[:piece].csa_some_name(self[:promoted])
    # end

    # 現状の状態から成れるか？
    # 相手陣地から出たときのことは考慮しなくてよい
    # そもそも移動元をこのインスタンスは知らない
    def more_promote?(location)
      true &&
        self[:piece].promotable? &&           # 成ることができる駒の種類かつ
        !self[:promoted] &&                   # まだ成っていないかつ
        self[:point].promotable?(location) && # 現在地点は相手の陣地内か？
        true
    end

    # soldiers.sort できるようにする
    # 手合割などを調べる際に並び順で異なるオブジェクトと見なされないようにするためだけに用意したものなので何をキーにしてもよい
    def <=>(other)
      self[:point] <=> other[:point]
    end

    # # ▲側から見た状態に変換したインスタンスを返す
    # def reverse_if_white
    #   merge(point: self[:point].reverse_if_white(self[:location]), location: Location[:black])
    # end

    # 反転
    def reverse
      merge(point: self[:point].reverse, location: self[:location].reverse)
    end

    # △なら反転 (これって reverse_if_white と同じじゃ？)
    def reverse_if_white
      if self[:location].key == :white
        reverse
      else
        self
      end
    end
  end

  # Soldier にどこからどこへ成るかどうかの情報を含めたもの
  # origin_battler と promoted_trigger が必要。どちらか一方だけで to_hand は作れる。
  class BattlerMove < Soldier
    def to_hand
      [
        self[:point].name,
        self[:origin_battler].piece_name,
        (self[:promoted_trigger] ? "成" : ""),
        "(", self[:origin_battler].point.number_format, ")",
      ].join
    end
  end

  # 「打」専用
  class PieceStake < Soldier
    def to_hand
      [self[:point].name, self[:piece].name, "打"].join
    end
  end
end
