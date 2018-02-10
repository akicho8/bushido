require "./example_helper"

sequencer = Sequencer.new
sequencer.pattern = Dsl.define do
  board <<~EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
  +---------------------------+
  | ・ ・ ・ ・ ・ ・ ・v桂v香|一
  | ・ ・ ・ ・ ・ ・v金 ・ ・|二
  | ・ ・ ・ ・ ・v歩 ・v歩 ・|三
  | ・ ・ ・ ・ ・ ・v歩 ・v歩|四
  | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
  | ・ ・ ・ ・ ・ ・ 歩 ・ 歩|六
  | ・ ・ ・ ・ ・ 歩 ・ ・ ・|七
  | ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
  | ・ ・ ・ ・ ・ ・ ・ 桂 香|九
  +---------------------------+
    EOT
end

sequencer.evaluate
puts sequencer.mediator_memento.mediator.to_text
# >> ----------------------------------------
# >> 棋譜: 
# >> 変数: {}
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・ ・ ・ ・ ・ ・v桂v香|一
# >> | ・ ・ ・ ・ ・ ・v金 ・ ・|二
# >> | ・ ・ ・ ・ ・v歩 ・v歩 ・|三
# >> | ・ ・ ・ ・ ・ ・v歩 ・v歩|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ 歩 ・ 歩|六
# >> | ・ ・ ・ ・ ・ 歩 ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ 飛 ・|八
# >> | ・ ・ ・ ・ ・ ・ ・ 桂 香|九
# >> +---------------------------+
# >> 先手の持駒:
# >> 後手の持駒:
