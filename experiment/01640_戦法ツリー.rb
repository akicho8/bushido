require "./example_helper"

TacticInfo.each do |e|
  puts "-" * 80 + " " + e.model.name
  e.model.each do |e|
    if e.root?
      puts e.to_s_tree { |e|
        if e.other_parents.present?
          "#{e.name} (別親: #{e.other_parents.collect(&:key).join(', ')})"
        else
          e.name
        end
      }
    end
  end
end
# >> -------------------------------------------------------------------------------- Bioshogi::DefenseInfo
# >> カニ囲い
# >> カブト囲い
# >> 金矢倉
# >> ├─総矢倉
# >> └─菱矢倉
# >> 銀矢倉
# >> 片矢倉
# >> 矢倉穴熊
# >> 菊水矢倉
# >> 銀立ち矢倉
# >> 雁木囲い
# >> ボナンザ囲い
# >> 矢倉早囲い
# >> 早囲い
# >> 三手囲い
# >> ずれ美濃
# >> カブト美濃
# >> 銀冠
# >> 木村美濃
# >> 裾固め
# >> 片美濃囲い
# >> ├─美濃囲い
# >> │   ├─高美濃囲い
# >> │   └─ダイヤモンド美濃 (別親: 銀美濃)
# >> ├─銀美濃
# >> └─ちょんまげ美濃
# >>     └─坊主美濃
# >> 金美濃
# >> 左美濃
# >> 天守閣美濃
# >> 四枚美濃
# >> 端玉銀冠
# >> 四枚銀冠
# >> 串カツ囲い
# >> 舟囲い
# >> └─箱入り娘
# >> 居飛車穴熊
# >> └─松尾流穴熊
# >> 銀冠穴熊
# >> ビッグ４
# >> ミレニアム囲い
# >> 振り飛車穴熊
# >> 右矢倉
# >> 金無双
# >> 中住まい
# >> 中原玉
# >> アヒル囲い
# >> 裏アヒル囲い
# >> いちご囲い
# >> 無敵囲い
# >> エルモ囲い
# >> └─左山囲い
# >> 無責任矢倉
# >> ツノ銀雁木
# >> 居飛穴音無しの構え
# >> 銀雲雀
# >> あずまや囲い
# >> 銀多伝
# >> 金多伝
# >> 美濃熊囲い
# >> モノレール囲い
# >> チョコレート囲い
# >> 四段端玉
# >> 空中楼閣
# >> -------------------------------------------------------------------------------- Bioshogi::AttackInfo
# >> ▲３七銀戦法
# >> 脇システム
# >> 矢倉棒銀
# >> 森下システム
# >> 雀刺し
# >> 米長流急戦矢倉
# >> カニカニ銀
# >> 中原流急戦矢倉
# >> 阿久津流急戦矢倉
# >> 矢倉中飛車
# >> 右四間飛車
# >> 原始棒銀
# >> 右玉
# >> かまいたち戦法
# >> パックマン戦法
# >> 新米長玉
# >> 稲庭戦法
# >> 四手角
# >> 一間飛車
# >> └─一間飛車穴熊
# >> 都成流△３一金
# >> 右四間飛車左美濃
# >> 角換わり
# >> ├─角換わり腰掛け銀
# >> │   └─木村定跡
# >> ├─角換わり棒銀
# >> └─角換わり早繰り銀
# >> 筋違い角
# >> 相筋違い角
# >> 一手損角換わり
# >> 相掛かり
# >> 相掛かり棒銀
# >> 塚田スペシャル
# >> 中原流相掛かり
# >> 中原飛車
# >> 腰掛け銀
# >> 鎖鎌銀
# >> ▲８五飛車戦法
# >> UFO銀
# >> 横歩取り
# >> △３三角型空中戦法
# >> △３三桂戦法
# >> △２三歩戦法
# >> △４五角戦法
# >> 相横歩取り
# >> ゴキゲン中飛車
# >> ツノ銀中飛車
# >> 平目
# >> 風車
# >> 新風車
# >> 英ちゃん流中飛車
# >> 原始中飛車
# >> 加藤流袖飛車
# >> ▲５七金戦法
# >> 超急戦
# >> 中飛車左穴熊
# >> 遠山流
# >> 四間飛車
# >> └─魔界四間飛車
# >> 藤井システム
# >> 立石流四間飛車
# >> レグスペ
# >> 三間飛車
# >> ├─石田流
# >> ├─早石田
# >> │   └─升田式石田流
# >> ├─中田功XP
# >> ├─うっかり三間飛車
# >> └─菅井流三間飛車
# >> 鬼殺し
# >> 2手目△３ニ飛戦法
# >> 真部流
# >> ▲７八飛戦法
# >> ４→３戦法
# >> 楠本式石田流
# >> 新石田流
# >> 新鬼殺し
# >> ダイレクト向かい飛車
# >> 向かい飛車
# >> メリケン向かい飛車
# >> 阪田流向飛車
# >> 角頭歩戦法
# >> 鬼殺し向かい飛車
# >> 陽動振り飛車
# >> 玉頭銀
# >> つくつくぼうし戦法
# >> ひねり飛車
# >> 相振り飛車
# >> 角交換振り飛車
# >> きｍきｍ金
# >> ポンポン桂
# >> ５筋位取り
# >> 玉頭位取り
# >> 地下鉄飛車
# >> 飯島流引き角戦法
# >> 丸山ワクチン
# >> └─新丸山ワクチン
# >> ▲４六銀左急戦
# >> ▲４五歩早仕掛け
# >> 鷺宮定跡
# >> 棒銀
# >> ▲４六銀右急戦
# >> 左美濃急戦
# >> 右四間飛車急戦
# >> 鳥刺し
# >> 嬉野流
# >> メイドシステム
# >> 棒金
# >> 超速▲３七銀
# >> 対振り持久戦
# >> 高田流左玉
# >> ▲７二飛亜急戦
# >> 袖飛車
# >> 一直線穴熊
# >> 穴角戦法
# >> └─穴角向かい飛車
# >> アヒル戦法
# >> 裏アヒル戦法
# >> 矢倉左美濃急戦
# >> 青野流
# >> 勇気流
# >> 極限早繰り銀
# >> トマホーク
# >> 羽生式袖飛車
# >> 初手７八銀戦法
# >> 初手３六歩戦法
# >> きんとうん戦法
# >> 目くらまし戦法
# >> 端棒銀
# >> -------------------------------------------------------------------------------- Bioshogi::TechniqueInfo
# >> 金底の歩
# >> パンツを脱ぐ
# >> 腹銀
# >> 垂れ歩
# >> 遠見の角
# >> 割り打ちの銀
# >> 桂頭の銀
# >> ロケット
# >> ふんどしの桂
# >> 継ぎ桂
# >> -------------------------------------------------------------------------------- Bioshogi::NoteInfo
# >> 入玉
# >> 居飛車
# >> 振り飛車
# >> 相入玉
# >> 大駒全消失
# >> 居玉
# >> 相居玉
# >> 相居飛車
# >> 対振り
# >> 相振り
# >> 対抗型
# >> 大駒コンプリート
# >> 駒柱
