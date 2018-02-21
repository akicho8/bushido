require "./example_helper"

log_file = "00100_debug.txt"
FileUtils.rm_rf(log_file)
Warabi.logger = ActiveSupport::Logger.new(log_file)
Warabi.logger = ActiveSupport::Logger.new(STDOUT)

mediator = Mediator.new
mediator.placement_from_bod <<~EOT
後手の持駒：
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・v銀v玉 ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
| ・ ・ ・ ・ 角 ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・v角 ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ 銀 ・ 玉 ・ 銀 ・ ・|九
+---------------------------+
先手の持駒：
手数＝8 △５七角成(13) まで

EOT
puts mediator

tp mediator.board["53"].move_list(mediator.board, promoted_preferred: true).to_a

mediator.player_at(:black).evaluator.score # => 1000
mediator.player_at(:black).brain.nega_max_run(depth_max: 1, debug_level: nil) # => {:hand=>#<▲７一角成(53)>, :score=>-640, :depth=>0, :hands=>[#<▲７一角成(53)>, #<△７一玉(61)>]}

# >> 後手の持駒：なし
# >>   ９ ８ ７ ６ ５ ４ ３ ２ １
# >> +---------------------------+
# >> | ・ ・v銀v玉 ・ ・ ・ ・ ・|一
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
# >> | ・ ・ ・ ・ 角 ・ ・ ・ ・|三
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|四
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
# >> | ・ ・ ・ ・v角 ・ ・ ・ ・|七
# >> | ・ ・ ・ ・ ・ ・ ・ ・ ・|八
# >> | ・ ・ 銀 ・ 玉 ・ 銀 ・ ・|九
# >> +---------------------------+
# >> 先手の持駒：なし
# >> 手数＝8 まで
# >> 
# >> 先手番
# >> |----------------|
# >> | ▲６二角成(53) |
# >> | ▲７一角成(53) |
# >> | ▲４二角成(53) |
# >> | ▲３一角成(53) |
# >> | ▲６四角成(53) |
# >> | ▲７五角成(53) |
# >> | ▲８六角成(53) |
# >> | ▲９七角成(53) |
# >> | ▲４四角成(53) |
# >> | ▲３五角成(53) |
# >> | ▲２六角成(53) |
# >> | ▲１七角成(53) |
# >> |----------------|
# >> 0 ▲ 試指 ▲６二角成(53) (1/23)
# >> 1 △     試指 △６二銀(71) => 2690
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => 2690
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △６二銀(71) => 2690 読み数:19
# >> 0 ▲ 評価 ▲６二角成(53) => -2690 (1/23)
# >> 0 ▲ 試指 ▲７一角成(53) (2/23)
# >> 1 △     試指 △５二玉(61) => -3250
# >> 1 △     試指 △６二玉(61) => -3250
# >> 1 △     試指 △７二玉(61) => -3250
# >> 1 △     試指 △５一玉(61) => -3250
# >> 1 △     試指 △７一玉(61) => 640
# >> 1 △     試指 △４八角成(57) => -3050
# >> 1 △     試指 △３九角成(57) => -1000
# >> 1 △     試指 △６八角成(57) => -3050
# >> 1 △     試指 △７九角成(57) => -1000
# >> 1 △     試指 △４六角成(57) => -3050
# >> 1 △     試指 △３五角成(57) => -3050
# >> 1 △     試指 △２四角成(57) => -3050
# >> 1 △     試指 △１三角成(57) => -3050
# >> 1 △     試指 △６六角成(57) => -3050
# >> 1 △     試指 △７五角成(57) => -3050
# >> 1 △     試指 △８四角成(57) => -3050
# >> 1 △     試指 △９三角成(57) => -3050
# >> 1 △     抽出
# >> 1 △     ★確 △７一玉(61) => 640 読み数:36
# >> 0 ▲ 評価 ▲７一角成(53) => -640 (2/23)
# >> 0 ▲ 試指 ▲４二角成(53) (3/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:55
# >> 0 ▲ 評価 ▲４二角成(53) => -1050 (3/23)
# >> 0 ▲ 試指 ▲３一角成(53) (4/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:74
# >> 0 ▲ 評価 ▲３一角成(53) => -1050 (4/23)
# >> 0 ▲ 試指 ▲６四角成(53) (5/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:93
# >> 0 ▲ 評価 ▲６四角成(53) => -1050 (5/23)
# >> 0 ▲ 試指 ▲７五角成(53) (6/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => 2890
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △７五角成(57) => 2890 読み数:110
# >> 0 ▲ 評価 ▲７五角成(53) => -2890 (6/23)
# >> 0 ▲ 試指 ▲８六角成(53) (7/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:129
# >> 0 ▲ 評価 ▲８六角成(53) => -1050 (7/23)
# >> 0 ▲ 試指 ▲９七角成(53) (8/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:148
# >> 0 ▲ 評価 ▲９七角成(53) => -1050 (8/23)
# >> 0 ▲ 試指 ▲４四角成(53) (9/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:167
# >> 0 ▲ 評価 ▲４四角成(53) => -1050 (9/23)
# >> 0 ▲ 試指 ▲３五角成(53) (10/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => 2890
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３五角成(57) => 2890 読み数:184
# >> 0 ▲ 評価 ▲３五角成(53) => -2890 (10/23)
# >> 0 ▲ 試指 ▲２六角成(53) (11/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:203
# >> 0 ▲ 評価 ▲２六角成(53) => -1050 (11/23)
# >> 0 ▲ 試指 ▲１七角成(53) (12/23)
# >> 1 △     試指 △５二玉(61) => -1200
# >> 1 △     試指 △６二玉(61) => -1200
# >> 1 △     試指 △７二玉(61) => -1200
# >> 1 △     試指 △５一玉(61) => -1200
# >> 1 △     試指 △４八角成(57) => -1000
# >> 1 △     試指 △３九角成(57) => 1050
# >> 1 △     試指 △６八角成(57) => -1000
# >> 1 △     試指 △７九角成(57) => 1050
# >> 1 △     試指 △４六角成(57) => -1000
# >> 1 △     試指 △３五角成(57) => -1000
# >> 1 △     試指 △２四角成(57) => -1000
# >> 1 △     試指 △１三角成(57) => -1000
# >> 1 △     試指 △６六角成(57) => -1000
# >> 1 △     試指 △７五角成(57) => -1000
# >> 1 △     試指 △８四角成(57) => -1000
# >> 1 △     試指 △９三角成(57) => -1000
# >> 1 △     試指 △６二銀(71) => -1200
# >> 1 △     試指 △７二銀(71) => -1200
# >> 1 △     試指 △８二銀(71) => -1200
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1050 読み数:222
# >> 0 ▲ 評価 ▲１七角成(53) => -1050 (12/23)
# >> 0 ▲ 試指 ▲８八銀(79) (13/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => -800
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1250 読み数:241
# >> 0 ▲ 評価 ▲８八銀(79) => -1250 (13/23)
# >> 0 ▲ 試指 ▲７八銀(79) (14/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => -800
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1250 読み数:260
# >> 0 ▲ 評価 ▲７八銀(79) => -1250 (14/23)
# >> 0 ▲ 試指 ▲６八銀(79) (15/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1250 読み数:278
# >> 0 ▲ 評価 ▲６八銀(79) => -1250 (15/23)
# >> 0 ▲ 試指 ▲６八玉(59) (16/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => 19198
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △６八角成(57) => 19198 読み数:296
# >> 0 ▲ 評価 ▲６八玉(59) => -19198 (16/23)
# >> 0 ▲ 試指 ▲５八玉(59) (17/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1250 読み数:315
# >> 0 ▲ 評価 ▲５八玉(59) => -1250 (17/23)
# >> 0 ▲ 試指 ▲４八玉(59) (18/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => 19198
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △４八角成(57) => 19198 読み数:333
# >> 0 ▲ 評価 ▲４八玉(59) => -19198 (18/23)
# >> 0 ▲ 試指 ▲６九玉(59) (19/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1250 読み数:352
# >> 0 ▲ 評価 ▲６九玉(59) => -1250 (19/23)
# >> 0 ▲ 試指 ▲４九玉(59) (20/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △３九角成(57) => 1250 読み数:371
# >> 0 ▲ 評価 ▲４九玉(59) => -1250 (20/23)
# >> 0 ▲ 試指 ▲４八銀(39) (21/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => 1250
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △４八角成(57) => 1250 読み数:389
# >> 0 ▲ 評価 ▲４八銀(39) => -1250 (21/23)
# >> 0 ▲ 試指 ▲３八銀(39) (22/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => -800
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △７九角成(57) => 1250 読み数:408
# >> 0 ▲ 評価 ▲３八銀(39) => -1250 (22/23)
# >> 0 ▲ 試指 ▲２八銀(39) (23/23)
# >> 1 △     試指 △５二玉(61) => -1000
# >> 1 △     試指 △６二玉(61) => -1000
# >> 1 △     試指 △７二玉(61) => -1000
# >> 1 △     試指 △５一玉(61) => -1000
# >> 1 △     試指 △４八角成(57) => -800
# >> 1 △     試指 △３九角成(57) => -800
# >> 1 △     試指 △６八角成(57) => -800
# >> 1 △     試指 △７九角成(57) => 1250
# >> 1 △     試指 △４六角成(57) => -800
# >> 1 △     試指 △３五角成(57) => -800
# >> 1 △     試指 △２四角成(57) => -800
# >> 1 △     試指 △１三角成(57) => -800
# >> 1 △     試指 △６六角成(57) => -800
# >> 1 △     試指 △７五角成(57) => -800
# >> 1 △     試指 △８四角成(57) => -800
# >> 1 △     試指 △９三角成(57) => -800
# >> 1 △     試指 △６二銀(71) => -1000
# >> 1 △     試指 △７二銀(71) => -1000
# >> 1 △     試指 △８二銀(71) => -1000
# >> 1 △     抽出
# >> 1 △     ★確 △７九角成(57) => 1250 読み数:427
# >> 0 ▲ 評価 ▲２八銀(39) => -1250 (23/23)
# >> 0 ▲ 
# >> |--------+----------------+----------------|
# >> | score  |              0 |              1 |
# >> |--------+----------------+----------------|
# >> |   -640 | ▲７一角成(53) | △７一玉(61)   |
# >> |  -1050 | ▲４二角成(53) | △３九角成(57) |
# >> |  -1050 | ▲３一角成(53) | △３九角成(57) |
# >> |  -1050 | ▲６四角成(53) | △３九角成(57) |
# >> |  -1050 | ▲１七角成(53) | △３九角成(57) |
# >> |  -1050 | ▲８六角成(53) | △３九角成(57) |
# >> |  -1050 | ▲９七角成(53) | △３九角成(57) |
# >> |  -1050 | ▲２六角成(53) | △３九角成(57) |
# >> |  -1050 | ▲４四角成(53) | △３九角成(57) |
# >> |  -1250 | ▲２八銀(39)   | △７九角成(57) |
# >> |  -1250 | ▲５八玉(59)   | △３九角成(57) |
# >> |  -1250 | ▲６九玉(59)   | △３九角成(57) |
# >> |  -1250 | ▲４九玉(59)   | △３九角成(57) |
# >> |  -1250 | ▲４八銀(39)   | △４八角成(57) |
# >> |  -1250 | ▲３八銀(39)   | △７九角成(57) |
# >> |  -1250 | ▲８八銀(79)   | △３九角成(57) |
# >> |  -1250 | ▲７八銀(79)   | △３九角成(57) |
# >> |  -1250 | ▲６八銀(79)   | △３九角成(57) |
# >> |  -2690 | ▲６二角成(53) | △６二銀(71)   |
# >> |  -2890 | ▲３五角成(53) | △３五角成(57) |
# >> |  -2890 | ▲７五角成(53) | △７五角成(57) |
# >> | -19198 | ▲６八玉(59)   | △６八角成(57) |
# >> | -19198 | ▲４八玉(59)   | △４八角成(57) |
# >> |--------+----------------+----------------|
# >> 0 ▲ 
# >> 抽出
# >> ▲７一角成(53) => -640
# >> ▲４二角成(53) => -1050
# >> ▲３一角成(53) => -1050
# >> ▲６四角成(53) => -1050
# >> ▲１七角成(53) => -1050
# >> ▲８六角成(53) => -1050
# >> ▲９七角成(53) => -1050
# >> ▲２六角成(53) => -1050
# >> ▲４四角成(53) => -1050
# >> ▲２八銀(39) => -1250
# >> ▲５八玉(59) => -1250
# >> ▲６九玉(59) => -1250
# >> ▲４九玉(59) => -1250
# >> ▲４八銀(39) => -1250
# >> ▲３八銀(39) => -1250
# >> ▲８八銀(79) => -1250
# >> ▲７八銀(79) => -1250
# >> ▲６八銀(79) => -1250
# >> ▲６二角成(53) => -2690
# >> ▲３五角成(53) => -2890
# >> ▲７五角成(53) => -2890
# >> ▲６八玉(59) => -19198
# >> ▲４八玉(59) => -19198
# >> 0 ▲ ★確 ▲７一角成(53) => -640 読み数:427
