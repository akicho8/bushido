# -*- coding: utf-8; compile-command: "bundle execute rspec ../../spec/player_spec.rb" -*-
# frozen-string-literal: true

module Warabi
  class Brain
    attr_accessor :player

    def initialize(player)
      @player = player
    end

    def nega_alpha_run(**params)
      nega_alpha_executer = NegaAlphaExecuter.new(params)
      nega_alpha_executer.nega_alpha(player: player)
    end

    def smart_score_list(**params)
      hands = lazy_all_hands.collect do |hand|
        hand.execute(player.mediator)
        nega_alpha_executer = NegaAlphaExecuter.new(params)
        info = nega_alpha_executer.nega_alpha(player: player.opponent_player)
        hand.revert(player.mediator)
        {hand: hand, score: -info[:score], readout: info[:readout], eval_times: info[:eval_times]}
      end
      hands.sort_by { |e| -e[:score] }
    end

    def fast_score_list
      hands = lazy_all_hands.collect do |hand|
        hand.execute(player.mediator)
        score = player.evaluator.score
        hand.revert(player.mediator)
        {hand: hand, score: score}
      end
      hands.sort_by { |e| -e[:score] }
    end

    def lazy_all_hands
      Enumerator.new do |y|
        move_hands.each do |e|
          y << e
        end
        direct_hands.each do |e|
          y << e
        end
      end
    end

    # 盤上の駒の全手筋
    def move_hands
      Enumerator.new do |y|
        player.soldiers.each do |soldier|
          soldier.move_list(player.board, promoted_preferred: true).each do |move_hand|
            y << move_hand
          end
        end
      end
    end

    # 持駒の全打筋
    def direct_hands
      Enumerator.new do |y|
        # piece_box.each_key を使わずに keys で一旦キーの拝謁を取り出している理由は
        # 外側で execute 〜 revert するとき a.each { a.update } の状態になり
        # "can't add a new key into hash during iteration" が発生するため
        piece_keys = player.piece_box.keys
        player.board.blank_points.each do |point|
          piece_keys.each do |piece_key|
            soldier = Soldier.create(piece: Piece[piece_key], promoted: false, point: point, location: player.location)
            if soldier.rule_valid?(player.board)
              y << DirectHand.create(soldier: soldier)
            end
          end
        end
      end
    end
  end

  class HandInfo < Hash
    def to_s
      "#{self[:hand]} => #{self[:score]}"
    end
  end

  class NegaAlphaExecuter
    attr_accessor :params
    attr_accessor :eval_counter

    def initialize(params)
      @params = {
        depth_max: 0,           # 最大の深さ
        log_skip_depth: nil,
      }.merge(params)

      @eval_counter = 0
    end

    def nega_alpha(player:, depth: 0, alpha: -Float::INFINITY, beta: Float::INFINITY)
      if logger
        locals = {player: player, depth: depth}
      end

      if depth >= params[:depth_max]
        @eval_counter += 1
        score = player.evaluator.score
        logger_info(locals, "評価 #{score}") if logger
        return HandInfo[score: score, eval_times: eval_counter, readout: []]
      end

      mediator = player.mediator
      children = player.brain.lazy_all_hands

      best_hand = nil
      readout = nil
      eval_times = nil
      children_exist = false

      children.each.with_index do |hand, i|
        children_exist = true
        hand.execute(mediator)
        logger_info(locals, "試指 #{hand} (%d)" % i) if logger
        info = nega_alpha(player: player.opponent_player, depth: depth + 1, alpha: -beta, beta: -alpha)
        score = -info[:score] # 相手が良くなればなるほど自分にとってはマイナス
        hand.revert(mediator)

        if score > alpha
          alpha = score
          best_hand = hand
          readout = info[:readout]
          eval_times = eval_counter
        end
        if alpha >= beta
          break
        end
      end

      raise MustNotHappen unless children_exist

      if logger
        logger_info(locals, "★確 #{best_hand} 読み数:#{eval_counter}")
      end

      HandInfo[hand: best_hand, score: alpha, eval_times: eval_times, readout: [best_hand, *readout]]
    end

    def logger_info(locals, str)
      return unless logger

      if v = params[:log_skip_depth]
        if locals[:depth] >= v
          return
        end
      end

      str = str.lines.collect { |e|
        (" " * 4 * locals[:depth]) + e
      }.join.rstrip

      if str.match?(/\n/)
        str = "\n" + str
      end

      Warabi.logger.info "%d %s %s" % [
        locals[:depth],
        locals[:player].location,
        str,
      ]
    end

    def logger
      Warabi.logger
    end
  end
end
