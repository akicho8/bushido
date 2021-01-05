module Bioshogi
  class MediatorSerializerCheckmateYomiage
    attr_accessor :mediator
    attr_accessor :options

    def initialize(mediator, options = {})
      @mediator = mediator
      @options = options
    end

    def to_s
      messages = []
      messages.concat(soldiers)
      messages.push(piece_box)
      messages.join
    end

    private

    def soldiers
      soldiers = mediator.board.soldiers
      group = soldiers.group_by(&:location)
      group = group.transform_values do |soldiers|
        soldiers = soldiers.sort_by { |e| -e.abs_weight }
        soldiers.collect { |e|
          [e.place.yomiage, e.yomiage].join("").squish + "。"
        }.join
      end
      Location.collect do |e|
        [
          e.checkmate_yomiage + "。",
          group[e] || "なし。",
        ].join
      end
    end

    def piece_box
      piece_box = mediator.player_at(:black).piece_box
      piece_counts = piece_box.sort_by { |e, count| -Piece.fetch(e).basic_weight }
      "もちごま。" + piece_counts.collect { |e, count| (Piece.fetch(e).yomiage(false) + "。") * count }.join # =>
    end
  end
end
