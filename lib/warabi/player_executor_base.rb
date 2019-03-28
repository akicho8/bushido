# frozen-string-literal: true

module Warabi
  class PlayerExecutorBase
    attr_reader :player
    attr_reader :source
    attr_reader :params

    attr_reader :hand
    attr_reader :drop_hand
    attr_reader :move_hand

    delegate :board, :piece_box, :mediator, to: :player
    delegate :origin_soldier, :captured_soldier, to: :move_hand, allow_nil: true
    delegate :soldier, to: :hand

    def initialize(player, source, **params)
      @player = player
      @source = source
      @params = {}.merge(params)
    end

    def input
      @input ||= -> {
        md = InputParser.match!(@source)
        input_adapter_class(md).new(player, md.named_captures.symbolize_keys)
      }.call
    end

    def execute
      input.perform_validations
      if error = input.errors.first
        raise_error(error)
      end

      @hand               = input.hand
      @drop_hand          = input.drop_hand
      @move_hand          = input.move_hand
      @candidate_soldiers = input.candidate_soldiers

      hand.execute(mediator)
      if captured_soldier
        piece_box_added(captured_soldier)
      end

      perform_skill_monitor

      turn_ended_process

      mediator.turn_info.counter += 1

      turn_changed_process

      hand
    end

    def piece_box_added(captured_soldier)
    end

    def turn_ended_process
    end

    def perform_skill_monitor
    end

    def turn_changed_process
    end

    private

    def raise_error(error)
      attributes = {
        "手番"   => player.call_name,
        "指し手" => input.input.values.join,
        "棋譜"   => mediator.hand_logs.to_kif_a.join(" "),
      }

      str = [error[:message]]
      str.concat(attributes.collect { |*e| e.join(": ") })
      str << mediator.to_bod
      str = str.join("\n")

      obj = error[:error_class].new(str)

      obj.instance_variable_set(:@mediator, mediator)
      def obj.mediator
        @mediator
      end

      raise obj
    end

    def input_adapter_class(md)
      case
      when md[:kif_place_from]
        InputAdapter::KifAdapter
      when md[:usi_to]
        InputAdapter::UsiAdapter
      when md[:csa_piece]
        InputAdapter::CsaAdapter
      else
        InputAdapter::Ki2Adapter
      end
    end
  end
end
