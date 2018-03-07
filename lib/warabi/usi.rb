# frozen-string-literal: true
module Warabi
  class Usi
    # mediator 側に sfen を受け取るメソッドを入れる方法もある
    class Class1
      # @mediator = Mediator.new
      # @mediator.board.placement_from_preset
      # @mediator.to_sfen                # => "lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b - 1"
      # @mediator.pieces_set("▲銀△銀銀")
      # puts @mediator
      # @mediator.board.to_sfen          # => "lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL"
      # @mediator.to_sfen                # => "lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b S2s 1"
      # @mediator.execute("▲６八銀")
      # @mediator.hand_logs.last.to_sfen # => "7i6h"
      # @mediator.to_sfen                # => "lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B1S3R1/LN1GKGSNL w S2s 2"
      # @mediator.execute("△２四銀打")
      # @mediator.hand_logs.last.to_sfen # => "S*2d"
      # @mediator.to_sfen                # => "lnsgkgsnl/1r5b1/ppppppppp/7s1/9/9/PPPPPPPPP/1B1S3R1/LN1GKGSNL b Ss 3"
      # @mediator.first_state_board_sfen # => "lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b - 1"
      # puts @mediator.board
      # @mediator.to_source        # => "one_place sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b - 1 moves 7i6h S*2d"

      attr_accessor :sfen

      # mediator 側に sfen を受け取るメソッドを入れる方法も検討
      def board_setup(mediator)
        sfen.soldiers.each do |soldier|
          player = mediator.player_at(soldier.location)
          player.board.place_on(soldier, validate: true)
        end
        mediator.turn_info.handicap = sfen.handicap?
        mediator.turn_info.counter = sfen.turn_counter
        sfen.piece_counts.each do |location_key, counts|
          mediator.player_at(location_key).piece_box.set(counts)
        end
        mediator.play_standby
      end

      def execute_moves(mediator)
        sfen.move_infos.each do |e|
          mediator.execute(e[:input])
        end
      end
    end

    class Class2 < Class1
      attr_accessor :mediator

      def execute(source)
        @sfen = Sfen.parse(source)

        @mediator = Mediator.new
        board_setup(@mediator)
        execute_moves(@mediator)
      end
    end
  end
end
