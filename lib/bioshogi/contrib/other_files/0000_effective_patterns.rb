require_relative "../../../bioshogi"

module Bioshogi
  XtraPattern.define do
    [
      {
        title: "桂と金の交換または桂成(おじいちゃんがよく使っていた技)",
        comment: "金が逃げても３二桂成を防げない",
        pieces: {black: "桂"},
        execute: "▲２四桂 △２三金 ▲３二桂成",
        board: <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・v銀v金|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
EOT
      },
      {
        title: "早囲い",
        comment: "3手で組める",
        execute: "▲４八玉 ▲３八玉 ▲４八銀",
        board: {"▲" => "平手", "△" => "十九枚落ち"}
      },
      {
        title: "ミレニアム囲い(別名カマクラ・カマボコ・トーチカ)",
        comment: "藤井システムに対抗する囲い",
        execute: "▲７六歩 ▲２六歩 ▲２五歩 ▲４八銀 ▲６八玉 ▲７八玉 ▲５六歩 ▲９六歩 ▲５八金右 ▲３六歩 ▲６六角 ▲８八銀 ▲７七桂 ▲６八金寄 ▲８九玉 ▲７九金 ▲７八金寄 ▲５九銀 ▲６八銀",
        board: {"▲" => "平手", "△" => "十九枚落ち"}
      },
      {
        title: "早囲いから飛車を追い返す方法",
        comment: "いろいろ応用が効きそう",
        url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/kifu/uke/furibisya/hayagakoi1.html",
        pieces: {black: "歩2"},
        execute: "▲６九歩 △同龍 ▲５九金 △９九龍 ▲６九歩",
        board: <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ 歩 歩 歩 歩|七
| ・ ・ ・ ・ ・ 銀 玉 ・ ・|八
|v龍 ・ ・ ・ ・ 金 ・ 桂 香|九
+---------------------------+
EOT
      },
      {
        title: "棒銀(一筋を香車で突破編)",
        execute: "▲２六歩 △３四歩 ▲３八銀 △３二金 ▲２七銀 △４二銀 ▲２五歩 △３三銀 ▲２六銀 △１四歩 ▲１六歩 △６二銀 ▲１五歩 △同歩 ▲同銀 △同香 ▲同香 △１三歩 ▲１九香",
        board: "平手",
      },
      # {
      #   title: "2筋の取り合い",
      #   execute: "▲２六歩 △２四歩 ▲２五歩 △同歩 ▲同飛",
      #   tags: "test",
      #   board: "平手",
      # },
      {
        title: "銀の真下に金を打たれると厳しい",
        pieces: {white: "金"},
        execute: "△５八金 ▲６八銀 △同金",
        board: <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ ・ ・ ・ ・ ・ ・ ・|一
| ・ ・ ・ ・ ・ ・ ・ ・ ・|二
| ・ ・ ・ ・ ・ ・ ・ ・ ・|三
| ・ ・ ・ ・ ・ ・ ・ ・ ・|四
| ・ ・ ・v歩 ・v歩 ・ ・ ・|五
| ・ ・ ・ ・ 歩 ・ ・ ・ ・|六
| ・ ・ ・ ・ 銀 ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
EOT
      },
      {
        title: "後手棒銀の矢倉崩し",
        comment: "9筋の突破",
        url: "http://home.att.ne.jp/aqua/DAIJIN/joseki/bougin10.html",
        execute: "▲７六歩 △８四歩 ▲６八銀 △８五歩 ▲７七銀 △３四歩 ▲７八金 △４二銀 ▲４八銀 △５二金右 ▲５六歩 △５四歩 ▲２六歩 △４四歩 ▲６九玉 △４三金 ▲５八金 △３三銀 ▲６六歩 △３一角 ▲６七金右 △４二玉 ▲３六歩 △３二玉 ▲７九角 △２二玉 ▲６八角 △３二金 ▲７九玉 △９四歩 ▲９六歩 △７二銀 ▲８八玉 △８三銀 ▲２五歩 △８四銀 ▲４六歩 △９五歩 ▲同歩 △同銀 ▲同香 △同香 ▲９七歩打 △９二飛 ▲９八銀打 △９三香打 ▲４七銀 △９七香成 ▲同桂 △同香成 ▲同銀 △同角成 ▲８九玉 △９八銀打",
        board: "平手",
      },
      {
        title: "後手の早石田対策",
        comment: nil,
        url: "http://home.att.ne.jp/aqua/DAIJIN/joseki/isida10.html",
        execute: "▲７六歩 △３四歩 ▲７五歩 △８四歩 ▲７八飛 △８五歩 ▲４八玉 △６二銀 ▲７四歩 △７二金 ▲７三歩成 △同銀 ▲２二角成 △同銀 ▲５五角打 △３三角打 ▲７三角成 △同金 ▲７四歩打 △８三金 ▲７三銀打 △３二飛 ▲８八銀 △７七歩打 ▲同銀 △７四金 ▲６六銀 △７三金",
        board: "平手",
      },
      {
        title: "新石田流の狙い",
        comment: "TODO:解説も入力できるようにしたい",
        url: "http://home.att.ne.jp/aqua/DAIJIN/joseki/isida14.html",
        execute: "▲７六歩 △３四歩 ▲７五歩 △８四歩 ▲７八飛 △８五歩 ▲７四歩 △同歩 ▲同飛 △８八角成 ▲同銀 △６五角打 ▲５六角打 △７四角 ▲同角 △６二銀 ▲５五角打 △７三歩打 ▲５六角 △１二飛打 ▲３四角 △３二金 ▲５六角 △８六歩 ▲１一角成 △同飛 ▲８三香打 △７二飛 ▲８一香成 △８七歩成 ▲同銀 △８八角打 ▲８四桂打 △９九角成 ▲８三角成 △７一香打 ▲７八銀 △８八歩打 ▲７七桂 △８九歩成 ▲７二桂成 △同金 ▲同馬 △同香 ▲８二成香 △８八と ▲７二成香 △７八と ▲同金",
        board: "平手",
      },
      {
        title: "飛車の利きを遮って金銀玉の並びにして王手金取り",
        url: "http://home.att.ne.jp/aqua/DAIJIN/joseki/isida12.html",
        pieces: {black: "歩 銀"},
        execute: "▲６二歩 ▲５二と △同金 ▲４一銀 △２二玉 ▲５二銀成",
        board: <<-EOT
  ９ ８ ７ ６ ５ ４ ３ ２ １
+---------------------------+
| ・ ・ 飛 ・ ・v金 ・ ・ ・|一
| ・v飛 ・ ・ ・v銀v玉 ・ ・|二
| ・ ・ ・ とv歩v歩v歩v歩 ・|三
| ・ ・ ・ ・ ・ ・ ・ ・v歩|四
| ・ ・ ・ ・ ・ ・ ・ ・ ・|五
| ・ ・ ・ ・ ・ ・ ・ ・ ・|六
| ・ ・ ・ ・ ・ ・ ・ ・ ・|七
| ・ ・ ・ ・ ・ ・ ・ ・ ・|八
| ・ ・ ・ ・ ・ ・ ・ ・ ・|九
+---------------------------+
EOT
      },
      {
        title: "原始鬼殺し",
        comment: "",
        url: "http://ja.wikipedia.org/wiki/%E9%AC%BC%E6%AE%BA%E3%81%97_%28%E5%B0%86%E6%A3%8B%29",
        execute: "▲７六歩 △３四歩 ▲７七桂 △８四歩 ▲６五桂 △６二銀 ▲７五歩 △６四歩 ▲２二角成 △同銀 ▲５五角 △３三銀 ▲６四角 △５二金右 ▲７四歩 △６三金 ▲７八飛 △６四金 ▲７三歩成",
        board: "平手",
      },
      {
        title: "早石田戦法",
        comment: "飛車先からの攻めを受けずに王手飛車(途中に説明入れたい)",
        # board: "平手",
        notation_dsl: lambda do
          board "平手"
          auto_flushing {
            mov "▲７六歩 △３四歩 ▲７五歩 △８四歩 ▲７八飛"
            push {
              mov "△８八角成 ▲同銀 △４五角 ▲７六角 △２七角成 ▲４三角成"
            }
            mov "△８五歩 ▲４八玉 △８六歩 ▲同歩 △同飛 ▲７四歩 △同歩 ▲２二角成 △同銀 ▲９五角"
          }
        end,
      },
      {
        title: "付き捨て+タタキ+合わせ",
        notation_dsl: lambda do
          board <<-EOT
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
          pieces "▲" => "歩4"
          mov "▲１五歩"
          mov "△同歩"
          push {
            mov "▲１二歩"
            mov "△同香"
            mov "▲１三歩"
            mov "△同香"
            mov "▲１四歩"
            mov "△同香"
            mov "▲２四歩"
            mov "△同歩"
            mov "▲同飛"
            mov "△２三歩"
            mov "▲１四飛"
            snapshot "香車ゲット"
          }
          mov "▲１三歩"
          mov "△同桂"
          mov "▲１二歩"
          mov "△同香"
          mov "▲１四歩"
          mov "▲１五香"
          mov "▲１三歩成"
          mov "△１三香"
          mov "▲１三香成"
          snapshot "桂馬と香車とゲット"
        end,
      },
      {
        title: "相掛かり棒銀",
        notation_dsl: lambda do
          board "平手"
          auto_flushing(false) {
            mov "▲２六歩"
            mov "△８四歩"
            mov "▲２五歩"
            mov "△８五歩"
            mov "▲７八金"
            mov "△３二金"
            mov "▲２四歩"
            mov "△同歩"
            mov "▲同飛"
            mov "△２三歩"
            mov "▲２八飛"
            mov "△８六歩"
            mov "▲同歩"
            mov "△同飛"
            mov "▲８七歩"
            # set :foo, 1
            mov "△８二飛"
          }
          auto_flushing(true) {
            mov "▲３八銀"
            mov "△６二銀"
            mov "▲２七銀"
            mov "△６四歩"
            mov "▲２六銀"
            mov "△６三銀"
            mov "▲２五銀"
            mov "△５四銀"
            mov "▲２四歩"
            mov "△同歩"
            mov "▲同銀"
          }

          # ここで新しい盤面を準備したときに持駒をクリアできないとだめ
          # pieces で追加じゃなくてセットにしたらいいかも
          #         board <<-EOT
          #   ９ ８ ７ ６ ５ ４ ３ ２ １
          # +---------------------------+
          # |v香v桂 ・v金v玉 ・v銀v桂v香|一
          # | ・v飛 ・v銀 ・ ・v金v角 ・|二
          # |v歩 ・v歩   v歩v歩 ・v歩v歩|三
          # | ・ ・ ・v歩 ・ ・v歩 ・ ・|四
          # | ・v歩 ・ ・ ・ ・ ・ 歩 ・|五
          # | ・ ・ ・ ・ ・ ・ ・ 銀 ・|六
          # | 歩 歩 歩 歩 歩 歩 歩 ・ 歩|七
          # | ・ 角 金 ・ ・ ・ ・ 飛 ・|八
          # | 香 桂 銀 ・ 玉 金 ・ 桂 香|九
          # +---------------------------+
          # EOT
        end,
      },
    ]
  end

  if $0 == __FILE__
    # XtraPattern.each{|pattern|HybridSequencer.execute(pattern)}

    HybridSequencer.execute(XtraPattern.last).each{|frame|
      puts frame.to_text
    }
  end
end