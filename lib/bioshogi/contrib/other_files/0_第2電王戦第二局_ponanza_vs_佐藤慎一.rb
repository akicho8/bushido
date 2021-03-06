require_relative "../../../bioshogi"

module Bioshogi
  XtraPattern.define do
    [
      {
        title: Pathname(__FILE__).basename(".*"),
        notation_dsl: lambda do
          board "平手"
          auto_flushing {
            set :hide_to_ki2_a, true
            mov "▲７六歩(77) △８四歩(83) ▲５六歩(57) △３四歩(33) ▲６六歩(67) △８五歩(84) ▲７七角(88) △６二銀(71) ▲７八銀(79) △５四歩(53) ▲４八銀(39) △３二銀(31) ▲５七銀(48) △３一角(22) ▲６八王(59) △８六歩(85) ▲同歩(87) △同角(31) ▲８七歩打 △７七角成(86) ▲同王(68) △４二王(51) ▲３六歩(37) △３一王(42) ▲５八金(49) △５二金(61) ▲２六歩(27) △４四歩(43) ▲１六歩(17) △５三銀(62) ▲１五歩(16) △４三金(52) ▲６七金(58) △３三銀(32) ▲６五歩(66) △３二金(41) ▲６六銀(57) △２二王(31) ▲９六歩(97) △９四歩(93) ▲８八王(77) △７四歩(73) ▲４六角打 △９二飛(82) ▲３七桂(29) △２四銀(33) ▲７七金(67) △４二銀(53) ▲８六歩(87) △５三銀(42) ▲５五歩(56) △同歩(54) ▲同銀(66) △３九角打 ▲５八飛(28) △８四角成(39) ▲５四歩打 △６二銀(53) ▲６四歩(65) △７三桂(81) ▲８七金(77) △６五桂(73) ▲６三歩成(64) △同銀(62) ▲５六飛(58) △４八馬(84) ▲５八金(69) △３八馬(48) ▲６六銀(55) △５五歩打 ▲５三歩成(54) △同金(43) ▲５五角(46) △５四歩打 ▲４六角(55) △６四銀(63) ▲２五桂(37) △４五歩(44) ▲６四角(46) △同金(53) ▲６五銀(66) △同金(64) ▲５四飛(56) △４三銀打 ▲５三飛成(54) △４四角打 ▲同竜(53) △同銀(43) ▲８三角打 △８二飛(92) ▲７四角成(83) △５四飛打 ▲６五馬(74) △５八飛成(54) ▲６七銀打 △５九竜(58) ▲５六桂打 △３三銀(44) ▲同桂(25) △同銀(24) ▲４一銀打 △４二金打 ▲３二銀(41) △同金(42) ▲３五歩(36) △３七馬(38) ▲３四歩(35) △同銀(33) ▲４四桂(56) △４二金(32) ▲３二金打 △同金(42) ▲同桂成(44) △同飛(82) ▲３三歩打 △同飛(32) ▲４四金打 △３二金打 ▲３三金(44) △同桂(21) ▲６一飛打 △５一歩打 ▲４四金打 △４三銀打 ▲３五歩打 △７三桂打 ▲６六馬(65) △４四銀(43) ▲３四歩(35) △２六馬(37) ▲６三飛成(61) △３五馬(26) ▲３三歩成(34) △同金(32) ▲２五桂打 △５三金打 ▲４二銀打 △４三金打 ▲３三桂成(25) △同金(43) ▲５三竜(63)"
          }
        end,
      },
    ]
  end

  if $0 == __FILE__
    # XtraPattern.each{|pattern|HybridSequencer.execute(pattern)}
    HybridSequencer.execute(XtraPattern.list.last).each{|frame|
      puts frame.to_text
    }
  end
end
