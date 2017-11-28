# -*- compile-command: "bundle exec rspec ../../spec/kif_format_spec.rb" -*-
# frozen-string-literal: true

require "time"                  # for Time.parse
require "kconv"                 # for toeuc

require "active_support/core_ext/array/grouping" # for in_groups_of
require "active_support/core_ext/numeric"        # for 1.minute

require_relative "header_info"
require_relative "toryo_info"

module Bushido
  module Parser
    class Base
      cattr_accessor(:header_sep) { "：" }

      class << self
        def parse(source, **options)
          new(source, options).tap(&:parse)
        end

        def parse_file(file, **options)
          parse(Pathname(file).expand_path.read, options)
        end

        def accept?(source)
          raise NotImplementedError, "#{__method__} is not implemented"
        end
      end

      attr_reader :header, :move_infos, :first_comments, :last_status_info

      def initialize(source, **options)
        @source = source
        @options = default_options.merge(options)

        @header = {}
        @move_infos = []
        @first_comments = []
        @board_source = nil
        @last_status_info = nil
      end

      def default_options
        {}
      end

      def parse
        raise NotImplementedError, "#{__method__} is not implemented"
      end

      def normalized_source
        @normalized_source ||= Parser.source_normalize(@source)
      end

      private

      def header_read
        s = normalized_source
        s = s.gsub(/^#.*/, "")
        s.scan(/^(\S.*)#{header_sep}(.*)$/o).each do |key, value|
          header[key] = value
        end
      end

      def header_normalize
        # 正規化。別にしなくてもいい
        if true
          # 日時を整える
          ["開始日時", "終了日時"].each do |e|
            if v = header[e].presence
              if v = (Time.parse(v) rescue nil)
                if [v.hour, v.min, v.sec].all?(&:zero?)
                  format = "%Y/%m/%d"
                else
                  format = "%Y/%m/%d %H:%M:%S"
                end
                header[e] = v.strftime(format)
              end
            end
          end

          # 並びを綺麗にする
          Location.each do |e|
            e.hirate_and_komaochi_name.each do |e|
              key = "#{e}の持駒"
              if v = header[key]
                v = Utils.hold_pieces_s_to_a(v)
                v = Utils.hold_pieces_a_to_s(v, ordered: true, separator: " ")
                header[key] = v
              end
            end
          end
        end
      end

      def board_read
        # FIXME: 間にある前提ではなく、どこに書いていても拾えるようにしたい
        if md = normalized_source.match(/^後手の持駒#{header_sep}.*?\n(?<board>.*)^先手の持駒#{header_sep}/om)
          @board_source = md[:board]
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

      # def teban_insance
      #   @teban ||= Teban.new(header["手合割"])
      # end

      concerning :ConverterMethods do
        # CSA標準棋譜ファイル形式
        # http://www.computer-shogi.org/protocol/record_v22.html
        #
        #   V2.2
        #   N+久保利明 王将
        #   N-都成竜馬 四段
        #   $EVENT:王位戦
        #   $SITE:関西将棋会館
        #   $START_TIME:2017/11/16 10:00:00
        #   $END_TIME:2017/11/16 19:04:00
        #   $OPENING:相振飛車
        #   P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
        #   P2 * -HI *  *  *  *  * -KA *
        #   P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
        #   P4 *  *  *  *  *  *  *  *  *
        #   P5 *  *  *  *  *  *  *  *  *
        #   P6 *  *  *  *  *  *  *  *  *
        #   P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
        #   P8 * +KA *  *  *  *  * +HI *
        #   P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
        #   +
        #   +7776FU
        #   -3334FU
        #   %TORYO
        #
        def to_csa(**options)
          options = {
            board_expansion: false,
            strip: false, # テストですぐに差分が出てしまって転けるので右側のスペースを取る
          }.merge(options)

          out = []
          out << "V2.2\n"

          out << HeaderInfo.collect { |e|
            if v = header[e.replace_key].presence
              "#{e.csa_key}#{v}\n"
            end
          }.join

          teai_name = nil
          if true
            obj = Mediator.new
            obj.board_reset_old(@board_source || header["手合割"])
            teai_name = obj.board.teai_name
            if teai_name
              out << "\" 手合割:#{teai_name}\n"
            end
            if options[:board_expansion]
              out << obj.board.to_csa
            else
              if teai_name == "平手"
                out << "PI\n"
              else
                out << obj.board.to_csa
              end
            end
          end

          # 2通りある
          # 1. 初期盤面の状態から調べた手合割を利用して最初の手番を得る  (teban = Teban.new(teai_name))
          # 2. mediator.teban を利用する
          out << mediator.teban.base_location.csa_sign + "\n"

          out << mediator.hand_logs.collect.with_index { |e, i|
            if clock_exist?
              "#{e.to_s_csa},T#{used_seconds_at(i)}\n"
            else
              e.to_s_csa + "\n"
            end
          }.join

          if e = @last_status_info
            toryo_info = ToryoInfo.fetch(e[:last_behaviour])
            s = "%#{toryo_info.csa_key}"
            if v = e[:used_seconds].presence
              s += ",T#{v}"
            end
            out << "#{s}\n"
          else
            out << "%TORYO" + "\n"
          end

          out = out.join

          # テスト用
          if options[:strip]
            out = out.gsub(/\s+\n/, "\n")
          end

          out
        end

        def to_kif(**options)
          options = {
            length: 12,
            number_width: 4,
            header_skip: false,
          }.merge(options)

          out = []
          out << header_as_string unless options[:header_skip]
          out << "手数----指手---------消費時間--\n"

          chess_clock = ChessClock.new
          out << mediator.hand_logs.collect.with_index.collect {|e, i|
            chess_clock.add(used_seconds_at(i))
            "%*d %s %s\n" % [options[:number_width], i.next, mb_ljust(e.to_s_kif, options[:length]), chess_clock]
          }.join

          toryo_info = ToryoInfo[:TORYO]
          if @last_status_info
            if v = ToryoInfo[@last_status_info[:last_behaviour]]
              toryo_info = v
            end
          end

          left_part = "%*d %s" % [options[:number_width], mediator.hand_logs.size.next, mb_ljust(toryo_info.kif_diarect, options[:length])]
          right_part = nil

          if @last_status_info
            if used_seconds = @last_status_info[:used_seconds].presence
              chess_clock.add(used_seconds)
              right_part = chess_clock.to_s
            end
          end

          out << "#{left_part} #{right_part}".rstrip + "\n"

          out.join
        end

        def to_ki2(**options)
          options = {
            cols: 10,
            # length: 11,
            same_suffix: "　",
            header_skip: false,
          }.merge(options)

          out = []
          if header.present? && !options[:header_skip]
            out << header_as_string
            out << "\n"
          end

          if false
            out << mediator.hand_logs.group_by.with_index{|_, i| i / options[:cols] }.values.collect { |v|
              v.collect { |e|
                s = e.to_s_ki2(with_mark: true, same_suffix: options[:same_suffix])
                mb_ljust(s, options[:length])
              }.join.strip + "\n"
            }.join
          else
            list = mediator.hand_logs.collect do |e|
              e.to_s_ki2(with_mark: true, same_suffix: options[:same_suffix])
            end

            list2 = list.in_groups_of(options[:cols])
            column_widths = list2.transpose.collect do |e|
              e.collect { |e| e.to_s.toeuc.bytesize }.max
            end

            list2 = list2.collect do |a|
              a.collect.with_index do |e, i|
                mb_ljust(e.to_s, column_widths[i])
              end
            end
            out << list2.collect { |e| e.join(" ").strip + "\n" }.join
          end

          out << mediator.judgment_message + "\n"

          out.join
        end

        def mediator
          @mediator ||= Mediator.new.tap do |mediator|
            Location.each do |e|
              e.hirate_and_komaochi_name.each do |e|
                if v = @header["#{e}の持駒"]
                  mediator.player_at(e).pieces_set(v)
                end
              end
            end

            # p header
            # p header["手合割"]
            # exit

            if @board_source
              mediator.board_reset_for_text(@board_source)
            else
              # p mediator.teban
              mediator.board_reset(header["手合割"] || "平手")
              # p mediator.teban
            end

            move_infos.each do |info|
              mediator.execute(info[:input])
            end
          end
        end

        def header_as_string
          @header_as_string ||= __header_as_string
        end

        private

        def __header_as_string
          out = []

          obj = Mediator.new
          obj.board_reset_old(@board_source || header["手合割"])
          if v = obj.board.teai_name
            header["手合割"] = v
            out << raw_header_as_string
          else
            header["後手の持駒"] ||= ""
            header["先手の持駒"] ||= ""
            out << raw_header_as_string.gsub(/(後手の持駒：.*\n)/, '\1' + obj.board.to_s)
          end

          out.join
        end

        def raw_header_as_string
          header.collect { |key, value|
            "#{key}：#{value}\n"
          }.join
        end

        # mb_ljust("あ", 3)               # => "あ "
        # mb_ljust("1", 3)                # => "1  "
        # mb_ljust("123", 3)              # => "123"
        def mb_ljust(s, w)
          n = w - s.toeuc.bytesize
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

        class ChessClock
          def initialize
            @single_clocks = Location.inject({}) {|a, e| a.merge(e => SingleClock.new) }
            @counter = 0
          end

          def add(v)
            @single_clocks[Location[@counter]].add(v)
            @counter += 1
          end

          def latest_clock_format
            @single_clocks[Location[@counter.pred]].to_s
          end

          def to_s
            latest_clock_format
          end

          class SingleClock
            def initialize
              @total = 0
              @used = 0
            end

            def add(v)
              v = v.to_i
              @total += v
              @used = v
            end

            def to_s
              h, r = @total.divmod(1.hour)
              m, s = r.divmod(1.minute)
              "(%02d:%02d/%02d:%02d:%02d)" % [*@used.divmod(1.minute), h, m, s]
            end
          end
        end
      end
    end
  end
end
# ~> /usr/local/var/rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-5.1.4/lib/active_support/number_helper.rb:3:in `<module:NumberHelper>': uninitialized constant ActiveSupport::Autoload (NameError)
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-5.1.4/lib/active_support/number_helper.rb:2:in `<module:ActiveSupport>'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-5.1.4/lib/active_support/number_helper.rb:1:in `<top (required)>'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-5.1.4/lib/active_support/core_ext/numeric/conversions.rb:2:in `<top (required)>'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-5.1.4/lib/active_support/core_ext/numeric.rb:4:in `<top (required)>'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
# ~>    from /usr/local/var/rbenv/versions/2.4.1/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
# ~>    from -:8:in `<main>'
