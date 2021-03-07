require "./example_helper"

TacticInfo.all_elements.each do |e|
  dir = Pathname("#{e.tactic_info.name}")
  file = dir.glob("#{e.key}.{kif,ki2}").first
  file = file.expand_path
  if file
    info = Parser.parse(file.read)
    new_file = dir.join(file.sub_ext(".kif"))
    new_file.write(info.to_kif)
    puts new_file
  end
end
# >> /Users/ikeda/src/bioshogi/experiment/囲い/カニ囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/カブト囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/金矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/悪形矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/片矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/総矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/矢倉穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/菊水矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀立ち矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/菱矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/一文字矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/富士見矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/土居矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/カニ缶囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/雁木囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ボナンザ囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/矢倉早囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/美濃囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/連盟美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/早囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/三手囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ずれ美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/カブト美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/高美濃囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀冠.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ダイヤモンド美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/木村美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/大山美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/裾固め.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/片美濃囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ちょんまげ美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/坊主美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/金美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/左美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/天守閣美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/四枚美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/端玉銀冠.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/四枚銀冠.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/串カツ囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/舟囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/居飛車穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/松尾流穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀冠穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ビッグ４.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/箱入り娘.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ミレニアム囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/振り飛車穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/振り飛車ミレニアム.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/右矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/金無双.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/中住まい.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/中原玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/アヒル囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/裏アヒル囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/いちご囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/無敵囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/エルモ囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/左山囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/無責任矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/ツノ銀雁木.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/音無しの構え.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀雲雀.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/あずまや囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/セメント囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/銀多伝.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/金多伝.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/美濃熊囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/モノレール囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/チョコレート囲い.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/四段端玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/囲い/空中楼閣.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/３七銀戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/脇システム.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/矢倉棒銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/森下システム.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/雀刺し.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/米長流急戦矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/カニカニ銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/カニカニ金.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/中原流急戦矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/阿久津流急戦矢倉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/矢倉中飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/右四間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/原始棒銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/右玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/かまいたち戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/英春流カメレオン.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/パックマン戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/新米長玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/稲庭戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/四手角.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/一間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/一間飛車穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/都成流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/右四間飛車左美濃.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/角換わり.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/角換わり腰掛け銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/角換わり棒銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/角換わり早繰り銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/筋違い角.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/相筋違い角.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/木村定跡.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/一手損角換わり.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/相掛かり.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/相掛かり棒銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/塚田スペシャル.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/中原流相掛かり.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/中原飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/腰掛け銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/鎖鎌銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/８五飛車戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/UFO銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/横歩取り.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/△３三角型空中戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/△３三桂戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/△２三歩戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/△４五角戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/相横歩取り.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/ゴキゲン中飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/ツノ銀中飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/平目.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/風車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/新風車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/英ちゃん流中飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/原始中飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/加藤流袖飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/５七金戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/超急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/中飛車左穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/遠山流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/四間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/耀龍四間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/藤井システム.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/立石流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/レグスペ.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/三間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/石田流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/早石田.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/升田式石田流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/鬼殺し.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/△３ニ飛戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/中田功XP.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/真部流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/▲７八飛戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/４→３戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/楠本式石田流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/新石田流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/新鬼殺し.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/ダイレクト向かい飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/向かい飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/メリケン向かい飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/阪田流向飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/角頭歩戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/鬼殺し向かい飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/陽動振り飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/玉頭銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/つくつくぼうし戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/ひねり飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/耀龍ひねり飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/相振り飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/角交換振り飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/きｍきｍ金.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/ポンポン桂.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/５筋位取り.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/玉頭位取り.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/地下鉄飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/飯島流引き角戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/丸山ワクチン.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/新丸山ワクチン.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/４六銀左急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/４五歩早仕掛け.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/鷺宮定跡.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/棒銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/４六銀右急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/左美濃急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/右四間飛車急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/鳥刺し.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/嬉野流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/メイドシステム.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/棒金.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/棒玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/超速.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/対振り持久戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/高田流左玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/７二飛亜急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/袖飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/一直線穴熊.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/穴角戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/穴角向かい飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/うっかり三間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/菅井流三間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/アヒル戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/裏アヒル戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/矢倉左美濃急戦.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/青野流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/勇気流.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/極限早繰り銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/トマホーク.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/羽生式袖飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/初手７八銀戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/初手３六歩戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/きんとうん戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/魔界四間飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/目くらまし戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/端棒銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/金銀橋.kif
# >> /Users/ikeda/src/bioshogi/experiment/戦型/カメレオン戦法.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/金底の歩.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/パンツを脱ぐ.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/腹銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/垂れ歩.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/遠見の角.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/割り打ちの銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/桂頭の銀.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/ロケット.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/ふんどしの桂.kif
# >> /Users/ikeda/src/bioshogi/experiment/手筋/継ぎ桂.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/入玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/角不成.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/飛車不成.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/居飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/振り飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/相入玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/大駒全消失.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/居玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/相居玉.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/背水の陣.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/相居飛車.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/対振り.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/相振り.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/対抗型.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/大駒コンプリート.kif
# >> /Users/ikeda/src/bioshogi/experiment/備考/駒柱.kif
