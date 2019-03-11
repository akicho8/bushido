require "./example_helper"

mediator = Mediator.new
mediator.placement_from_bod <<~EOT
後手の持駒：
+------+
| ・v玉|
| ・v角|
| 玉 香|
+------+
先手の持駒：
手数＝1
  EOT
mediator.current_player.brain.normal_all_hands.to_a # => [<△２二玉(11)>, <△２一玉(11)>, <△２三角(12)>, <△２一角(12)>]