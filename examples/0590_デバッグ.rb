require "./example_helper"

teaiwari_info = TeaiwariInfo["平手"].both_board_info[Location[:black]]

mediator = Mediator.start
mediator.board_reset
soldiers = mediator.board.surface.values.collect {|e|
  if e.player.location.key == :black
    e.to_soldier
  end
}.compact

soldiers.sort.collect(&:name) # => ["９七歩", "９九香", "８七歩", "８八角", "８九桂", "７七歩", "７九銀", "６七歩", "６九金", "５七歩", "５九玉", "４七歩", "４九金", "３七歩", "３九銀", "２七歩", "２八飛", "２九桂", "１七歩", "１九香"]
teaiwari_info.sort.collect(&:name)     # => ["９七歩", "９九香", "８七歩", "８八角", "８九桂", "７七歩", "７九銀", "６七歩", "６九金", "５七歩", "５九玉", "４七歩", "４九金", "３七歩", "３九銀", "２七歩", "２八飛", "２九桂", "１七歩", "１九香"]

soldiers.sort == teaiwari_info.sort # => false

soldiers.sort.first        # => {:piece=><Bushido::Piece:70168203774880 歩 pawn>, :promoted=>false, :point=>#<Bushido::Point:70168202530940 "９七">}
teaiwari_info.sort.first            # => {:piece=><Bushido::Piece:70168203774880 歩 pawn>, :promoted=>false, :point=>#<Bushido::Point:70168202530940 "９七">, :location=>#<Bushido::Location:0x007fa29dbcb758 @attributes={:key=>:black, :name=>"先手", :mark=>"▲", :reverse_mark=>"▼", :other_match_chars=>["上手", "☗", "b"], :varrow=>" ", :angle=>0, :csa_sign=>"+", :code=>0}, @match_target_values_set=#<Set: {:black, "▲", "▼", "上手", "☗", "b", "先手", "先", 0, " ", "+"}>>}

#         # ここがかなり重い
#         DefenseInfo.collect do |defense_info|
#           placements = Utils.board_point_realize(location: location, both_board_info: defense_info.both_board_info)
#           a = placements.values.flatten.collect(&:to_s)
#           b = board.surface.values.collect(&:to_h).collect(&:to_s)
#           match_p = (a - b).empty?
#           {key: defense_info.key, placements: placements, match: match_p}
#         end
