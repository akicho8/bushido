# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/utils_spec.rb" -*-
#
# 汎用の便利メソッド集
#

require "active_support/core_ext/object/to_query"

module Bushido
  module Utils
    extend self

    # 指定プレイヤー側の初期配置(「角落ち」などを指定可)
    # @example
    #   Utils.location_soldiers(:black, "平手")         # => ["9七歩", "8七歩", ...]
    #   Utils.location_soldiers(:black, "角落ち")       # => ["9七歩", "8七歩", ...]
    #   Utils.location_soldiers(:black, "+----+\n|...") # => [...]
    def location_soldiers(params)
      params = {
        location: nil,
        key: nil,
      }.merge(params)

      if BaseFormat.board_format?(params[:key])
        stock = Stock.new(board: params[:key])
        r = both_soldiers_from_char_board2(params.merge(stock: stock))
        r[L.b]
      else
        stock = Stock.list.find{|v|v[:key] == params[:key]}
        stock or raise BoardKeyNotFound, "盤面データがない : #{params[:key].inspect}"
        r = valid_both_soldiers_from_char_board(params.merge(stock: stock))
        r[L.b]
      end
    end

    # 指定プレイヤー側の初期配置(盤面のみ対応)
    # @example
    #   Utils.location_soldiers(:black, "+----+\n|...") # => [...]
    def valid_both_soldiers_from_char_board(params = {})
      params = {
        validate: true,
      }.merge(params)
      if params[:validate]
        if params[:stock].parsed_board[:white].present?
          raise BoardIsBlackOnly, "後手側データは定義できません: #{params[:stock].parsed_board[:white].inspect}"
        end
      end
      both_soldiers_from_char_board2(params)
    end

    def both_soldiers_from_char_board2(params)
      params[:stock].parsed_board.inject({}){|h, (key, value)|
        h.merge(key => value.collect{|s|s.merge(point: s[:point].as_location(params[:location]))})
      }
    end

    # board_reset の引数の解釈
    #
    # @example
    #   board_reset_args("+-----")                              # そのまま棋譜が入ってれいばそのままパース
    #   board_reset_args("角落ち")                              # 先手だけが角落ち(下と同じ)
    #   board_reset_args("先手" => "角落ち", "後手" => "平手")  # 先手だけが角落ち
    #
    #   => {
    #       "先手" => [<MiniSoldier>, ...],
    #       "後手" => [<MiniSoldier>, ...],
    #     }
    #
    def board_reset_args(value = nil)
      case
      when BaseFormat.board_format?(value)
        # Stock.new(board: value).parsed_board
        BaseFormat.board_parse(value)
      when value.kind_of?(Hash)
        # {"先手" => "角落ち", "後手" => "香落ち"}
        value.inject({}){|hash, (k, v)|
          hash.merge(Location[k] => Utils.location_soldiers(location: k, key: v))
        }
      else
        # "角落ち" なら {"先手" => "角落ち", "後手" => "平手"}
        board_reset_args(black: (value || "平手"), white: "平手")
      end
    end

    # 持駒表記変換 (人間表記 → コード)
    # @example
    #  Utils.hold_pieces_array_to_str([Piece["歩"], Piece["歩"], Piece["飛"]]) # => "歩二飛"
    def hold_pieces_array_to_str(pieces)
      pieces.group_by{|e|e.class}.collect{|klass, pieces|
        count = ""
        if pieces.size > 1
          count = pieces.size.to_s.tr("0-9", "〇一二三四五六七八九")
        end
        "#{pieces.first.name}#{count}"
      }.join(SEPARATOR)
    end

    # 持駒表記変換 (コード → 人間表記)
    # @example
    #   Utils.hold_pieces_str_to_array("歩2 飛") # => [Piece["歩"], Piece["歩"], Piece["飛"]]
    def hold_pieces_str_to_array(str)
      if str.kind_of?(String)
        str = str.tr("〇一二三四五六七八九", "0-9")
        infos = str.scan(/(?<piece>#{Piece.all_basic_names.join("|")})(?<count>\d+)?/).collect{|piece, count|
          {piece: piece, count: (count || 1).to_i}
        }
      else
        infos = str
      end
      pieces_parse2(infos)
    end

    # 適当な持駒文字列を先手後手に分離
    # @example
    #   Utils.triangle_hold_pieces_str_to_hash("▲歩2 飛 △歩二飛 ▲金") # => {L.b => "歩2 飛 金", L.w => "歩二飛 "}
    def triangle_hold_pieces_str_to_hash(str)
      hash = {}
      Array.wrap(str).join(" ").scan(/([#{Location.triangles}])([^#{Location.triangles}]+)/).each{|mark, pieces_str|
        location = Location[mark]
        hash[location] ||= ""
        hash[location] << pieces_str
      }
      hash
    end

    # 先手後手に分離した持駒情報を文字列化
    # @example
    #   Utils.triangle_hold_pieces_hash_to_str({L.b => "歩2 飛 金", L.w => "歩二飛 "}) # => "▲歩2 飛 金 ▽歩二飛 "
    def triangle_hold_pieces_hash_to_str(hash)
      hash.collect{|location, pieces_str|"#{location.mark}#{pieces_str}"}.join(" ")
    end

    # ki2形式に近い棋譜の羅列のパース
    # @example
    #   ki2_parse("▲４二銀△４二銀") # => [{location: :black, input: "４二銀"}, {location: :white, input: "４二銀"}]
    def ki2_parse(str)
      str = str.to_s
      str = str.gsub(/([#{Location.triangles}])/, ' \1')
      str = str.squish
      str.split(/\s+/).collect{|s|
        if s.match(/\A[#{Location.triangles}]/)
          movs_split(s)
        else
          s
        end
      }.flatten
    end

    def movs_split(str)
      regexp = /([#{Location.triangles}])([^#{Location.triangles}\s]+)/
      Array.wrap(str).join(" ").scan(regexp).collect{|mark, input|
        {location: Location[mark], input: input}
      }
    end

    def initial_soldiers_split(str)
      movs_split(str.gsub(/_+/, " "))
    end

    def mov_split_one(str)
      md = str.match(/(?<mark>[#{Location.triangles}])(?<input>.*)/)
      # md or raise(ArgumentError)
      {location: Location[md[:mark]], input: md[:input]}
    end

    # Google検索用URL
    # @example
    #   guguru_url("UFO銀")
    #   guguru_url(["UFO銀", "急戦"])
    def guguru_url(keywords)
      str = Array.wrap(keywords).compact.uniq.join(" ")
      "https://www.google.co.jp/search?source=ig&hl=ja&lr=lang_ja&#{{q: str.tosjis}.to_query}"
    end

    private

    def pieces_parse2(list)
      Array.wrap(list).collect{|info|
        (info[:count] || 1).times.collect{ Piece.fetch(info[:piece]) }
      }.flatten
    end
  end
end
