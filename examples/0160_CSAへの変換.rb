require "./example_helper"

puts Parser.parse("７六歩 ３四歩").to_csa # => nil
# >> V2.2
# >> P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
# >> P2 * -HI *  *  *  *  * -KA * 
# >> P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
# >> P4 *  *  *  *  *  *  *  *  * 
# >> P5 *  *  *  *  *  *  *  *  * 
# >> P6 *  *  *  *  *  *  *  *  * 
# >> P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
# >> P8 * +KA *  *  *  *  * +HI * 
# >> P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
# >> +
# >> +7677FU
# >> -3433FU
# >> %TORYO
