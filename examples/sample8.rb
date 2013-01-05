# -*- coding: utf-8 -*-

begin
  require_relative "../lib/bushido"
rescue LoadError
  require File.expand_path(File.join(File.dirname(__FILE__), "../lib/bushido"))
end

include Bushido

board = <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・v桂 ・ ・ 馬 ・ ・v桂v香|一
|v飛 ・ ・ ・ ・ と ・ ・ ・|二
| ・ ・ ・ 全v歩 ・v玉 ・ ・|三
| ・ ・ ・ ・ ・ ・v桂 ・v金|四
| ・v歩 ・ ・ ・ 銀v歩v歩v歩|五
|v歩 ・ 歩v角 ・ ・ ・ ・ ・|六
| ・ 歩 銀v歩vと ・ ・ ・ ・|七
| 歩 ・ 玉 香 ・ ・ ・ ・ 香|八
| 香 桂 ・ ・ ・ ・ 飛 ・ ・|九
+---------------------------+
EOT
BaseFormat::Parser.board_parse(board) # => {:white=>{:soldiers=>["８一桂", "２一桂", "１一香", "９二飛", "５三歩", "３三玉", "３四桂", "１四金", "８五歩", "３五歩", "２五歩", "１五歩", "９六歩", "６六角", "６七歩", "５七と"]}, :black=>{:soldiers=>["５一馬", "４二と", "６三全", "４五銀", "７六歩", "８七歩", "７七銀", "９八歩", "７八玉", "６八香", "１八香", "９九香", "８九桂", "３九飛"]}}
