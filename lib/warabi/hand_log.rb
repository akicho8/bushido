# frozen-string-literal: true

module Warabi
  class HandLog
    include ActiveModel::Model

    attr_accessor :direct_hand
    attr_accessor :move_hand

    attr_accessor :candidate
    attr_accessor :point_same
    attr_accessor :skill_set

    def to_kif(**options)
      options = {
        with_location: false,
      }.merge(options)

      hand.to_kif(options)
    end

    def to_ki2(**options)
      official_formatter(options).to_s
    end

    def to_csa(**options)
      hand.to_csa(options)
    end

    def to_sfen(**options)
      hand.to_sfen(options)
    end

    def to_kif_ki2
      [to_kif, to_ki2]
    end

    def to_kif_ki2_csa
      [to_kif, to_ki2, to_csa]
    end

    def to_skill_set_kif_comment(**options)
      skill_set.kif_comment(soldier.location)
    end

    def soldier
      hand.soldier
    end

    def hand
      move_hand || direct_hand
    end

    def official_formatter(**options)
      OfficialFormatter.new(self, options)
    end
  end
end
