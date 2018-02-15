require "./example_helper"

sfen = Sfen.parse("position sfen lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b S2s 1 moves 7i6h S*2d")
sfen.soldiers.first(3).collect(&:name) # => ["△９一香", "△８一桂", "△７一銀"]
sfen.location.key                      # => :black
sfen.move_infos                        # => [{:input=>"7i6h"}, {:input=>"S*2d"}]
sfen.piece_counts                      # => {:black=>{:silver=>1}, :white=>{:silver=>2}}
sfen.turn_counter                      # => 0
sfen.handicap?                         # => false
tp sfen.attributes

sfen = Sfen.parse("position startpos")
tp sfen.attributes
sfen.soldiers

# >> |-------------------+-----------------------------------------------------------|
# >> |             board | lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL |
# >> |            b_or_w | b                                                         |
# >> |       hold_pieces | S2s                                                       |
# >> | turn_counter_next | 1                                                         |
# >> |             moves | 7i6h S*2d                                                 |
# >> |-------------------+-----------------------------------------------------------|
# >> |-------------------+-----------------------------------------------------------|
# >> |             board | lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL |
# >> |            b_or_w | b                                                         |
# >> |       hold_pieces | -                                                         |
# >> | turn_counter_next | 1                                                         |
# >> |             moves |                                                           |
# >> |-------------------+-----------------------------------------------------------|