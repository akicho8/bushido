module Bioshogi
  module Formatter
    concern :KifFormatter do
      def to_kif(**options)
        options = {
          length: 12,
          number_width: 4,
          header_skip: false,
        }.merge(options)

        mediator_run

        out = []
        unless options[:header_skip]
          out << header_part_string
        end
        out << "手数----指手---------消費時間--\n"

        chess_clock = ChessClock.new
        out << mediator.hand_logs.collect.with_index.collect { |e, i|
          chess_clock.add(used_seconds_at(i))
          s = "%*d %s %s\n" % [options[:number_width], mediator.initial_state_turn_info.display_turn + i.next, mb_ljust(e.to_kif(char_type: :formal_sheet), options[:length]), chess_clock]
          if v = e.to_skill_set_kif_comment
            s += v
          end
          s
        }.join

        ################################################################################

        left_part = nil
        right_part = nil

        if last_action_info.kif_word
          left_part = "%*d %s" % [
            options[:number_width],
            mediator.initial_state_turn_info.display_turn + mediator.hand_logs.size.next,
            mb_ljust(last_action_info.kif_word, options[:length]),
          ]
        end

        if true
          if @last_status_params
            if used_seconds = @last_status_params[:used_seconds]
              chess_clock.add(used_seconds)
              right_part = chess_clock.to_s
            end
          end
        end

        if left_part
          out << "#{left_part} #{right_part}".rstrip + "\n"
        end

        out << judgment_message + "\n"
        out << error_message_part

        out.join
      end
    end
  end
end
