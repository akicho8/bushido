# frozen-string-literal: true

module Warabi
  module InputAdapter
    class UsiAdapter < AbstractAdapter
      include OriginSoldierMethods

      def piece
        if direct_trigger
          Piece.fetch(input[:usi_direct_piece])
        else
          origin_soldier.piece
        end
      end

      def promoted
        if direct_trigger
          false
        else
          origin_soldier.promoted || promote_trigger
        end
      end

      def point_from
        if v = input[:usi_from]
          Point.fetch(alpha_to_digit(v))
        end
      end

      def point
        Point.fetch(alpha_to_digit(input[:usi_to]))
      end

      def direct_trigger
        !!input[:usi_direct_trigger]
      end

      def promote_trigger
        !!input[:usi_promote_trigger]
      end

      private

      def alpha_to_digit(s)
        s.gsub(/[[:lower:]]/) { |s| s.ord - 'a'.ord + 1 }
      end
    end
  end
end