# frozen-string-literal: true

module Bioshogi
  class Board
    class << self
      delegate :dimensiton_change, :size_type, :promotable_disable, to: "Bioshogi::Dimension"
    end

    delegate :hash, to: :surface

    def surface
      @surface ||= {}
    end

    concerning :UpdateMethods do
      def place_on(soldier, **options)
        options = {
          validate: false,
        }.merge(options)

        if options[:validate]
          assert_cell_blank(soldier.place)
        end

        surface[soldier.place] = soldier
        soldier_counts_surface[[soldier.location.key, soldier.piece.key]] += 1 # soldier.piece.stronger をキーにすると速くなるかも？
      end

      def pick_up(place)
        soldier = safe_delete_on(place)
        unless soldier
          raise NotFoundOnBoard, "#{place}の位置には何もありません"
        end
        soldier
      end

      def safe_delete_on(place)
        surface.delete(place).tap do |soldier|
          if soldier
            soldier_counts_surface[[soldier.location.key, soldier.piece.key]] -= 1
          end
        end
      end

      def all_clear
        surface.clear
        soldier_counts_surface.clear
      end

      def board_set_any(v)
        case
        when BoardParser.accept?(v)
          placement_from_shape(v)
        when v.kind_of?(Hash)
          placement_from_hash(v)
        when v.kind_of?(String) && !InputParser.scan(v).empty?
          placement_from_human(v)
        else
          placement_from_preset(v)
        end
      end

      def placement_from_preset(value = nil)
        placement_from_hash(white: value || "平手")
      end

      def placement_from_shape(str)
        placement_from_soldiers(BoardParser.parse(str).soldier_box)
      end

      def placement_from_hash(hash)
        placement_from_soldiers(Soldier.preset_soldiers(hash))
      end

      def placement_from_human(str)
        soldiers = InputParser.scan(str).collect { |s| Soldier.from_str(s) }
        placement_from_soldiers(soldiers)
      end

      def placement_from_soldiers(soldiers)
        soldiers.each { |soldier| place_on(soldier) }
      end

      private

      def soldier_counts_surface
        @soldier_counts_surface ||= Hash.new(0)
      end

      def assert_cell_blank(place)

        if surface.has_key?(place)
          raise PieceAlredyExist, "空のはずの#{place}に駒があります\n#{self}"
        end
      end
    end

    concerning :ReaderMethods do
      def lookup(place)
        place = Place.fetch(place)
        surface[place]
      end

      def [](place)
        lookup(place)
      end

      def fetch(place)
        lookup(place) or raise PieceNotFoundOnBoard, "#{place}に何もありません\n#{self}"
      end

      def piece_counts(location_key, piece_key)
        soldier_counts_surface[[location_key, piece_key]]
      end

      # FIXME: 空いている升の情報は駒を動かした時点で更新するようにすればこの部分の無駄な判定を減らせる
      def blank_places
        Enumerator.new do |y|
          Place.each do |place|
            if !surface[place]
              y << place
            end
          end
        end
      end

      def vertical_pieces(x)
        Enumerator.new do |yielder|
          Dimension::Yplace.dimension.times do |y|
            if soldier = lookup([x, y])
              yielder << soldier
            end
          end
        end
      end

      def move_list(soldier, **options)
        Movabler.move_list(self, soldier, options)
      end

      def to_s_soldiers
        surface.values.collect(&:name_without_location).sort.join(" ")
      end

      def to_kif
        KakikiBoardFormater.new(self).to_s
      end

      def to_ki2
        to_kif
      end

      def to_csa
        CsaBoardFormater.new(self).to_s
      end

      def to_s
        to_kif
      end

      def to_sfen
        Dimension::Yplace.dimension.times.collect { |y|
          Dimension::Xplace.dimension.times.collect { |x|
            place = Place.fetch([x, y])
            surface[place]
          }.chunk(&:class).flat_map { |klass, e|
            if klass == NilClass
              e.count
            else
              e.collect(&:to_sfen)
            end
          }.join
        }.join("/")
      end
    end

    concerning :TechniqueMatcherMethods do
      def flip
         self.class.new.tap do |board|
          surface.values.each do |e|
            board.place_on(e.flip)
          end
        end
      end

      def horizontal_flip
         self.class.new.tap do |board|
          surface.values.each do |e|
            board.place_on(e.horizontal_flip)
          end
        end
      end
    end

    concerning :PresetMethods do
      # ▲が平手であることが条件
      def preset_key
        if preset_key_by_location(:black) == :"平手"
          preset_key_by_location(:white)
        end
      end

      private

      # location 側の手合割を文字列で得る
      def preset_key_by_location(location)
        if e = preset_info_by_location(location)
          e.key
        end
      end

      # location 側の手合割情報を得る
      def preset_info_by_location(location)
        # 駒配置情報は9x9を想定しているため9x9ではないときは手合割に触れないようにする
        # これがないと、board_spec.rb だけを実行したとき落ちる
        if Dimension.size_type != :board_size_9x9
          return
        end

        location = Location[location]

        # 手合割情報はすべて先手のデータなので、先手側から見た状態に揃える
        black_only_soldiers = surface.values.collect { |e|
          if e.location == location
            e.flip_if_white
          end
        }.compact.sort

        PresetInfo.find do |e|
          e.location_split[:black] == black_only_soldiers
        end
      end
    end
  end
end