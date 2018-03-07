# frozen-string-literal: true

module Warabi
  # P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
  # P2 * -HI *  *  *  *  * -KA *
  # P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
  # P4 *  *  *  *  *  *  *  *  *
  # P5 *  *  *  *  *  *  *  *  *
  # P6 *  *  *  *  *  *  *  *  *
  # P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
  # P8 * +KA *  *  *  *  * +HI *
  # P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
  class CsaBoardFormater
    def initialize(board)
      @board = board
    end

    def to_s
      OnePlace::Xplace.dimension.times.collect { |y|
        "P#{y.next}" + OnePlace::Yplace.dimension.times.collect { |x|
          place = Place.fetch([x, y])
          soldier_to_str(@board.surface[place])
        }.join + "\n"
      }.join
    end

    private

    def soldier_to_str(soldier)
      if soldier
        soldier.to_csa_bod
      else
        " * "
      end
    end
  end
end
