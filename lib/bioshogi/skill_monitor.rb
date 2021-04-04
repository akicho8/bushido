# frozen-string-literal: true

module Bioshogi
  class SkillMonitor
    cattr_accessor(:walk_counts) { Hash.new(0) }

    attr_reader :executor

    def initialize(executor)
      @executor = executor
    end

    def execute
      if e = TacticInfo.soldier_hash_table[soldier]
        e.each do |e|
          walk_counts[e.key] += 1
          execute_one(e)
        end
      end

      if executor.mediator.params[:skill_monitor_technique_enable]
        # 主に手筋用で戦型チェックにも使える
        key = [soldier.piece.key, soldier.promoted, !!executor.drop_hand]
        if e = TacticInfo.piece_hash_table[key]
          e.each do |e|
            execute_block(e) do |list|
              walk_counts[e.key] += 1
              cold_war_verification(e)
              instance_eval(&e.technique_matcher_info.verify_process)
            end
          end
        end
      end

      # これはループなので遅い
      # TacticInfo.piece_hash_table.each do |e|
      #   execute_block(e) do |list|
      #     cold_war_verification(e)
      #     instance_eval(&e.technique_matcher_info.verify_process)
      #   end
      # end

      # 毎回呼ぶやつ
      TacticInfo.every_time_proc_list.each do |e|
        walk_counts[e.key] += 1
        if instance_exec(e, &e.every_time_proc)
          skill_push(e)
        end
      end
    end

    private

    def execute_block(e)
      catch :skip do
        list = player.skill_set.list_of(e)
        yield list
        skill_push(e)
      end
    end

    def skill_push(skill)
      player.skill_set.list_push(skill)   # プレイヤーの個別設定
      executor.skill_set.list_push(skill) # executor の方にも設定(これいる？)
    end

    def execute_one(e)
      execute_block(e) do |list|
        # 美濃囲いがすでに完成していれば美濃囲いチェックはスキップ
        if list.include?(e)
          throw :skip
        end

        # 「居飛車」判定のとき「振り飛車」がすでにあればスキップ
        if e.skip_elements
          if e.skip_elements.any? { |e| list.include?(e) }
            throw :skip
          end
        end

        # 片美濃のチェックをしようとするとき、すでに子孫のダイヤモンド美濃があれば、片美濃のチェックはスキップ
        if e.cached_descendants.any? { |e| list.include?(e) }
          throw :skip
        end

        # 手数制限。制限を超えていたらskip
        if e.turn_limit
          if e.turn_limit < player.mediator.turn_info.display_turn.next
            throw :skip
          end
        end

        # 手数限定。手数が異なっていたらskip
        if e.turn_eq
          if e.turn_eq != player.mediator.turn_info.display_turn.next
            throw :skip
          end
        end

        # 手番限定。手番が異なればskip
        if e.order_key
          if e.order_key != player.mediator.turn_info.order_key
            throw :skip
          end
        end

        # 開戦済みならskip
        cold_war_verification(e)

        # 「打」時制限。移動元駒があればskip
        if e.drop_only
          if origin_soldier
            throw :skip
          end
        end

        # 駒を取ったとき制限。取ってないならskip
        if e.kill_only
          unless executor.captured_soldier
            throw :skip
          end
        end

        # 駒を持っていないこと。異なっていたらskip
        if v = e.hold_piece_empty
          if !player.piece_box.empty?
            throw :skip
          end
        end

        if true
          # 何もない制限。何かあればskip
          if ary = e.board_parser.other_objects_loc_ary[location.key]["○"]
            ary.each do |e|
              if surface[e[:place]]
                throw :skip
              end
            end
          end

          # 何かある制限。何もなければskip
          if ary = e.board_parser.other_objects_loc_ary[location.key]["●"]
            ary.each do |e|
              if !surface[e[:place]]
                throw :skip
              end
            end
          end
        end

        if true
          # 移動元ではない制限。移動元だったらskip
          if ary = e.board_parser.other_objects_loc_ary[location.key]["☆"]
            # 移動元についての指定があるのに移動元がない場合はそもそも状況が異なるのでskip
            unless origin_soldier
              throw :skip
            end
            ary.each do |e|
              if e[:place] == origin_soldier.place
                throw :skip
              end
            end
          end

          # 移動元である(any条件)。どの移動元にも該当しなかったらskip
          if places_hash = e.board_parser.other_objects_loc_places_hash[location.key]["★"]
            # 移動元がないということは、もう何も該当しないので skip
            unless origin_soldier
              throw :skip
            end
            if places_hash[origin_soldier.place]
              # 移動元があったのでOK
            else
              throw :skip
            end
          end
        end

        # 自分の金or銀がある
        if ary = e.board_parser.other_objects_loc_ary[location.key]["◆"]
          ary.each do |e|
            unless worth_more_gteq_silver?(e[:place])
              throw :skip
            end
          end
        end

        # 自分の歩以上の駒がある
        if ary = e.board_parser.other_objects_loc_ary[location.key]["◇"]
          ary.each do |e|
            unless worth_more_gteq_pawn?(e[:place])
              throw :skip
            end
          end
        end

        # 歩を持っていたらskip
        if e.not_have_pawn
          if piece_box.has_key?(:pawn)
            throw :skip
          end
        end

        # # 歩を除いて何か持っていたらskip
        # if e.pawn_bishop_have_safe: nil, :pawn_have_safe
        #   if !piece_box.except(:pawn).empty?
        #     throw :skip
        #   end
        # end

        if true
          # 駒が一致していなければskip
          if v = e.hold_piece_eq
            if piece_box != v
              throw :skip
            end
          end

          # 指定の駒をすべて含んでいるならOK
          if v = e.hold_piece_in
            if v.all? { |piece_key, _| piece_box.has_key?(piece_key) }
            else
              throw :skip
            end
          end

          # 指定の駒をどれか含んでいるならskip
          if v = e.hold_piece_not_in
            if v.any? { |piece_key, _| piece_box.has_key?(piece_key) }
              throw :skip
            end
          end
        end

        # どれかが盤上に正確に含まれるならOK
        if ary = e.board_parser.any_exist_soldiers.location_adjust[location.key].presence
          if ary.any? { |e| soldier_exist?(e) }
          else
            throw :skip
          end
        end

        # 指定の配置が盤上に含まれるならOK
        ary = e.board_parser.location_adjust[location.key]
        if ary.all? { |e| soldier_exist?(e) }
        else
          throw :skip
        end
      end
    end

    ################################################################################

    def cold_war_verification(e)
      # 開戦済みならskip
      if e.cold_war
        if player.mediator.kill_counter.positive?
          throw :skip
        end
      end

      # 歩を除いて何か持っていたらskip
      if e.pawn_have_safe
        if !piece_box.except(:pawn).empty?
          throw :skip
        end
      end

      # 歩または角を除いて何か持っていたらskip
      if e.pawn_bishop_have_safe
        if !piece_box.except(:pawn, :bishop).empty?
          throw :skip
        end
      end
    end

    ################################################################################

    # 後手側の場合は先手側の座標に切り替え済み
    def soldier
      @soldier ||= executor.soldier.flip_if_white
    end

    # 比較順序超重要。不一致しやすいものから比較する
    def soldier_exist?(s)
      if v = surface[s.place]
        v.piece == s.piece && v.promoted == s.promoted && v.location == s.location
      end
    end

    # place の位置に銀以上の価値がある(自分の)駒がある
    def worth_more_gteq_silver?(place)
      if v = surface[place]
        v.location == location && v.abs_weight >= silver_piece_basic_weight
      end
    end

    # place の位置に歩以上の価値がある(自分の)駒がある
    def worth_more_gteq_pawn?(place)
      if v = surface[place]
        v.location == location
      end
    end

    # 銀の価値
    def silver_piece_basic_weight
      @silver_piece_basic_weight ||= Piece[:silver].basic_weight
    end

    # 持駒
    def piece_box
      @piece_box ||= player.piece_box
    end

    # 移動元情報
    def origin_soldier
      @origin_soldier ||= executor.origin_soldier
    end

    # 盤面
    def surface
      @surface ||= player.board.surface
    end

    # プレイヤーの向き
    def location
      @location ||= player.location
    end

    def player
      @player ||= executor.player
    end
  end
end
