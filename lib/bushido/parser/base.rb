# -*- compile-command: "bundle exec rspec ../../spec/kif_format_spec.rb" -*-
# frozen-string-literal: true

require_relative "header"
require_relative "csa_header_info"
require_relative "last_action_info"

require_relative "kif_serializer"
require_relative "ki2_serializer"
require_relative "csa_serializer"
require_relative "usi_serializer"

module Bushido
  module Parser
    class Base
      cattr_accessor(:header_sep) { "：" }

      class << self
        def parse(source, **options)
          new(source, options).tap(&:parse)
        end

        def file_parse(file, **options)
          parse(Pathname(file).expand_path.read, options)
        end

        def accept?(source)
          raise NotImplementedError, "#{__method__} is not implemented"
        end
      end

      attr_reader :move_infos, :first_comments, :last_status_params, :board_source, :error_message

      def initialize(source, **parser_options)
        @source = source
        @parser_options = default_parser_options.merge(parser_options)

        @move_infos = []
        @first_comments = []
        @board_source = nil
        @last_status_params = nil
        @error_message = nil
      end

      def default_parser_options
        {
          # embed: 二歩の棋譜なら例外を出さずに直前で止めて反則であることを棋譜に記す
          #  skip: 棋譜には記さない
          # false: 例外を出す(デフォルト)
          typical_error_case: false,
          # run_and_build_skip: false,
          skill_set_flag: true,
        }
      end

      # def parse
      #   unless @parser_options[:run_and_build_skip]
      #     mediator_run
      #   end
      # end

      def parse
        raise NotImplementedError, "#{__method__} is not implemented"
      end

      def normalized_source
        @normalized_source ||= Parser.source_normalize(@source)
      end

      def header
        @header ||= Header.new
      end

      private

      def header_read
        header.parse_from_kif_format_header(normalized_source)
      end

      def header_normalize
        header.normalize_all
      end

      def board_read
        # FIXME: 間にある前提ではなく、どこに書いていても拾えるようにしたい
        if md = normalized_source.match(/^(?:後手|上手)の持駒#{header_sep}.*?\n(?<board>.*)^(?:先手|下手)の持駒#{header_sep}/om)
          @board_source = md[:board].presence
          # header[:board] = BoardParser.parse(md[:board]) # TODO: 使ってない
        end
      end

      def comment_read(line)
        if md = line.match(/^\p{blank}*\*\p{blank}*(?<comment>.*)/)
          if @move_infos.empty?
            first_comments_add(md[:comment])
          else
            note_add(md[:comment])
          end
        end
      end

      def first_comments_add(comment)
        @first_comments << comment
      end

      # コメントは直前の棋譜の情報と共にする
      def note_add(comment)
        @move_infos.last[:comments] ||= []
        @move_infos.last[:comments] << comment
      end

      concerning :ConverterMethods do
        include KifSerializer
        include Ki2Serializer
        include CsaSerializer
        include UsiSerializer

        def mediator_run
          mediator
        end

        def mediator_new
          Mediator.new.tap do |e|
            e.mediator_options[:skill_set_flag] = @parser_options[:skill_set_flag]
          end
        end

        def mediator
          @mediator ||= mediator_new.tap do |e|
            mediator_board_setup(e)
            mediator_run_all(e)
          end
        end

        def mediator_board_setup(mediator)
          Location.each do |e|
            e.call_names.each do |e|
              if v = header["#{e}の持駒"]
                mediator.player_at(e).pieces_set(v)
              end
            end
          end

          if @board_source
            mediator.board_reset_by_shape(@board_source)
            if mediator.board.preset_name != "平手"
              if header["手合割"].blank? || header["手合割"] == "その他"
                mediator.turn_info.komaochi = true
              end
            end
          else
            mediator.board_reset(header["手合割"] || "平手")
          end

          mediator.play_standby
        end

        def mediator_run_all(mediator)
          # FIXME: ここらへんは mediator のなかで実行する
          begin
            move_infos.each do |info|
              if @parser_options[:debug]
                p mediator
              end
              if @parser_options[:callback]
                @parser_options[:callback].call(mediator)
              end
              if @parser_options[:turn_limit] && mediator.turn_max > @parser_options[:turn_limit]
                break
              end
              mediator.execute(info[:input])
            end
          rescue TypicalError => error
            if v = @parser_options[:typical_error_case]
              case v
              when :embed
                @error_message = error.message
              when :skip
              else
                raise MustNotHappen
              end
            else
              raise error
            end
          end

          if @parser_options[:skill_set_flag]
            TacticInfo.each do |e|
              mediator.players.each do |player|
                if v = player.skill_set.public_send(e.list_key).normalize.collect(&:name).presence
                  skill_set_hash["#{player.call_name}の#{e.name}"] = v
                end
              end
            end
            header.object.update(skill_set_hash.transform_values { |e| e.join(", ") })
          end
        end

        def skill_set_hash
          @skill_set_hash ||= {}
        end

        def header_part_string
          @header_part_string ||= __header_part_string
        end

        def judgment_message
          mediator_run
          last_action_info.judgment_message(mediator)
        end

        def raw_header_part_hash
          header.object.collect { |key, value|
            if value
              if e = CsaHeaderInfo[key]
                if e.as_kif
                  value = e.instance_exec(value, &e.as_kif)
                end
              end
              [key, value]
            end
          }.compact.to_h
        end

        def last_action_info
          # 棋譜の実行結果から見た判断を初期値として
          key = :TORYO
          if @error_message
            key = :ILLEGAL_MOVE
          end
          last_action_info = LastActionInfo[key]

          # 元の棋譜の記載を優先
          if @last_status_params
            if v = LastActionInfo[@last_status_params[:last_action_key]]
              last_action_info = v
            end
          end

          last_action_info
        end

        private

        def __header_part_string
          out = []

          mediator_run

          obj = Mediator.new
          mediator_board_setup(obj)

          if v = obj.board.preset_name
            header["手合割"] = v

            # 手合割がわかるとき持駒が空なら消す
            Location.each do |e|
              e.call_names.each do |e|
                key = "#{e}の持駒"
                if v = header[key]
                  if v.blank?
                    header.object.delete(key)
                  end
                end
              end
            end

            out << raw_header_part_string
          else
            # 手合がわからないので図を出す場合
            # 2つヘッダー行に挟む形になっている仕様が特殊でデータの扱いが難しい

            header["手合割"] ||= "その他"

            Location.each do |location|
              key = "#{location.call_name(obj.turn_info.komaochi?)}の持駒"
              v = header[key]
              if v.blank?
                header[key] = "なし"
              end
            end
            s = raw_header_part_string
            out << s.gsub(/(#{Location[:white].call_name(obj.turn_info.komaochi?)}の持駒：.*\n)/, '\1' + obj.board.to_s)
          end

          out.join
        end

        def raw_header_part_string
          raw_header_part_hash.collect { |key, value| "#{key}：#{value}\n" }.join
        end

        # mb_ljust("あ", 3)               # => "あ "
        # mb_ljust("1", 3)                # => "1  "
        # mb_ljust("123", 3)              # => "123"
        def mb_ljust(s, w)
          n = w - s.encode("EUC-JP").bytesize
          if n < 0
            n = 0
          end
          s + " " * n
        end

        def clock_exist?
          @clock_exist ||= @move_infos.any? {|e| e[:used_seconds] && e[:used_seconds].to_i >= 1 }
        end

        def used_seconds_at(index)
          @move_infos.dig(index, :used_seconds).to_i
        end

        def error_message_part(comment_mark = "*")
          if @error_message
            v = @error_message.strip + "\n"
            s = "-" * 76 + "\n"
            [s, *v.lines, s].collect {|e| "#{comment_mark} #{e}" }.join
          end
        end
      end
    end
  end
end
