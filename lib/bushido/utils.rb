# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/utils_spec.rb" -*-
#
# 汎用の便利メソッド集
#

module Bushido
  module Utils
    extend self

    # 人間が入力する *初期配置* の "４二竜" などをハッシュに分割する
    #   Utils.parse_str("４二竜") # => {:point => Point["４二"], :piece => Piece["竜"], :promoted => true}
    def parse_str(str)
      md = str.match(/\A(?<point>..)(?<piece>#{Piece.names.join("|")})\z/)
      md or raise SyntaxError, "表記が間違っています。'４二竜' や '42竜' のように入力してください : #{str.inspect}"
      Piece.parse!(md[:piece]).merge(:point => Point.parse(md[:point]))
    end

    # 平手での指定プレイヤー側の初期配置
    #   Utils.initial_placements_for(:black) # => ["9七歩", "8七歩", ...]
    def initial_placements_for(location)
      initial_placements.collect do |arg|
        Utils.parse_str(arg).tap do |info|
          info[:point] = info[:point].as_location(location)
        end
      end
    end

    # 持駒表記変換 (人間表記 → コード)
    #  Utils.stand_pack([Piece["歩"], Piece["歩"], Piece["飛"]]).should == "歩二 飛"
    def stand_pack(pieces)
      pieces.group_by{|e|e.class}.collect{|klass, pieces|
        count = ""
        if pieces.size > 1
          count = pieces.size.to_s.tr("0-9", "〇一二三四五六七八九")
        end
        "#{pieces.first.name}#{count}"
      }.join(SEPARATOR)
    end

    # 持駒表記変換 (コード → 人間表記)
    #   Utils.stand_unpack("歩2 飛").should == [Piece["歩"], Piece["歩"], Piece["飛"]]
    def stand_unpack(str)
      if String === str
        str = str.tr("〇一二三四五六七八九", "0-9")
        infos = str.split(/#{WHITE_SPACE}+/).collect{|s|
          md = s.match(/\A(?<piece>#{Piece.collect(&:basic_names).flatten.join("|")})(?<count>\d+)?\z/)
          md or raise SyntaxError, "例:「飛 歩2」 : #{str.inspect}"
          {:piece => md[:piece], :count => (md[:count] || 1).to_i}
        }
      else
        infos = str
      end
      pieces_parse2(infos)
    end

    def pieces_parse2(list)
      Array.wrap(list).collect{|info|
        (info[:count] || 1).times.collect{ Piece.get!(info[:piece]) }
      }.flatten
    end

    def first_distributed_pieces
      [
        {:piece => "歩", :count => 9},
        {:piece => "角", :count => 1},
        {:piece => "飛", :count => 1},
        {:piece => "香", :count => 2},
        {:piece => "桂", :count => 2},
        {:piece => "銀", :count => 2},
        {:piece => "金", :count => 2},
        {:piece => "玉", :count => 1},
      ]
    end

    # ki2形式に近い棋譜の羅列のパース
    #   ki2_input_seq_parse("▲４二銀△４二銀") # => [{:location => :black, :input => "４二銀"}, {:location => :white, :input => "４二銀"}]
    def ki2_input_seq_parse(str)
      str = str.to_s
      str = str.gsub(/([▲△])/, ' \1')
      str = str.squish
      str.split(/\s+/).collect{|s|
        if s.match(/\A[▲△]/)
          __ki2_input_seq_parse(s)
        else
          s
        end
      }.flatten
    end

    def __ki2_input_seq_parse(str)
      Array.wrap(str).join(" ").scan(/([▲△])([^▲△\s]+)/).collect{|mark, input|{:location => Location[mark].key, :input => input}}
    end

    private

    def initial_placements
      [
        "9七歩", "8七歩", "7七歩", "6七歩", "5七歩", "4七歩", "3七歩", "2七歩", "1七歩",
        "8八角", "2八飛",
        "9九香", "8九桂", "7九銀", "6九金", "5九玉", "4九金", "3九銀", "2九桂", "1九香",
      ].compact
    end
  end
end
