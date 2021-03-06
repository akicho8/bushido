require "./example_helper"

rows = TacticInfo.all_elements.collect do |e|
  file = Pathname.glob("#{e.tactic_info.name}/#{e.key}.{kif,ki2}").first
  row = { key: e.key, file: file.to_s}
  if file
    str = file.read
    info = Parser.parse(str)
    info.mediator_run
    row[:matches] = info.mediator.players.collect { |player|
      player.skill_set.list_of(e).normalize.collect(&:key)
    }.flatten
    row[:status] = row[:matches].include?(e.key)
  end
  row
end

p rows.all? { |e| e[:status] }      # => true
tp rows
# >> true
# >> |----------------------+-------------------------------+-----------------------------------------------------------------------------------------------------+--------|
# >> | key                  | file                          | matches                                                                                             | status |
# >> |----------------------+-------------------------------+-----------------------------------------------------------------------------------------------------+--------|
# >> | カニ囲い             | 囲い/カニ囲い.kif             | [:カニ囲い]                                                                                         | true   |
# >> | カブト囲い           | 囲い/カブト囲い.kif           | [:カブト囲い]                                                                                       | true   |
# >> | 金矢倉               | 囲い/金矢倉.kif               | [:金矢倉]                                                                                           | true   |
# >> | 銀矢倉               | 囲い/銀矢倉.kif               | [:銀矢倉]                                                                                           | true   |
# >> | 流れ矢倉             | 囲い/流れ矢倉.kif             | [:カニ囲い, :流れ矢倉]                                                                              | true   |
# >> | 四角矢倉             | 囲い/四角矢倉.kif             | [:四角矢倉]                                                                                         | true   |
# >> | へこみ矢倉           | 囲い/へこみ矢倉.kif           | [:へこみ矢倉]                                                                                       | true   |
# >> | カタ囲い             | 囲い/カタ囲い.kif             | [:坊主美濃, :右矢倉, :カタ囲い]                                                                     | true   |
# >> | 悪形矢倉             | 囲い/悪形矢倉.kif             | [:悪形矢倉]                                                                                         | true   |
# >> | 天野矢倉             | 囲い/天野矢倉.kif             | [:天野矢倉]                                                                                         | true   |
# >> | 総矢倉               | 囲い/総矢倉.kif               | [:総矢倉]                                                                                           | true   |
# >> | 矢倉穴熊             | 囲い/矢倉穴熊.kif             | [:カニ囲い, :金矢倉, :矢倉穴熊, :カニ囲い, :総矢倉]                                                 | true   |
# >> | 菊水矢倉             | 囲い/菊水矢倉.kif             | [:菊水矢倉, :カニ囲い, :菊水矢倉]                                                                   | true   |
# >> | 銀立ち矢倉           | 囲い/銀立ち矢倉.kif           | [:舟囲い, :左美濃, :銀立ち矢倉, :高美濃囲い]                                                        | true   |
# >> | 菱矢倉               | 囲い/菱矢倉.kif               | [:総矢倉, :菱矢倉]                                                                                  | true   |
# >> | 一文字矢倉           | 囲い/一文字矢倉.kif           | [:一文字矢倉]                                                                                       | true   |
# >> | 富士見矢倉           | 囲い/富士見矢倉.kif           | [:金矢倉, :富士見矢倉]                                                                              | true   |
# >> | 土居矢倉             | 囲い/土居矢倉.kif             | [:土居矢倉, :総矢倉, :菱矢倉]                                                                       | true   |
# >> | 蟹罐囲い             | 囲い/蟹罐囲い.kif             | [:蟹罐囲い]                                                                                         | true   |
# >> | オールド雁木         | 囲い/オールド雁木.kif         | [:総矢倉, :オールド雁木]                                                                            | true   |
# >> | 右玉                 | 囲い/右玉.kif                 | [:カブト囲い, :銀矢倉, :右玉]                                                                       | true   |
# >> | 糸谷流右玉           | 囲い/糸谷流右玉.kif           | [:糸谷流右玉]                                                                                       | true   |
# >> | 雁木右玉             | 囲い/雁木右玉.kif             | [:ツノ銀雁木, :雁木右玉]                                                                            | true   |
# >> | 三段右玉             | 囲い/三段右玉.kif             | [:三段右玉]                                                                                         | true   |
# >> | 角換わり右玉         | 囲い/角換わり右玉.kif         | [:角換わり右玉]                                                                                     | true   |
# >> | カギ囲い             | 囲い/カギ囲い.kif             | [:カギ囲い]                                                                                         | true   |
# >> | ボナンザ囲い         | 囲い/ボナンザ囲い.kif         | [:片美濃囲い, :ボナンザ囲い, :天野矢倉]                                                             | true   |
# >> | 矢倉早囲い           | 囲い/矢倉早囲い.kif           | [:矢倉早囲い]                                                                                       | true   |
# >> | 美濃囲い             | 囲い/美濃囲い.kif             | [:美濃囲い]                                                                                         | true   |
# >> | 連盟美濃             | 囲い/連盟美濃.kif             | [:連盟美濃, :舟囲い]                                                                                | true   |
# >> | 早囲い               | 囲い/早囲い.kif               | [:早囲い]                                                                                           | true   |
# >> | 三手囲い             | 囲い/三手囲い.kif             | [:三手囲い]                                                                                         | true   |
# >> | ずれ美濃             | 囲い/ずれ美濃.kif             | [:早囲い, :ずれ美濃]                                                                                | true   |
# >> | 振り飛車エルモ       | 囲い/振り飛車エルモ.kif       | [:振り飛車エルモ]                                                                                   | true   |
# >> | カブト美濃           | 囲い/カブト美濃.kif           | [:坊主美濃, :カブト美濃, :カニ囲い]                                                                 | true   |
# >> | 高美濃囲い           | 囲い/高美濃囲い.kif           | [:舟囲い, :高美濃囲い]                                                                              | true   |
# >> | 銀冠                 | 囲い/銀冠.kif                 | [:銀冠]                                                                                             | true   |
# >> | 片銀冠               | 囲い/片銀冠.kif               | [:片銀冠]                                                                                           | true   |
# >> | 銀美濃               | 囲い/銀美濃.kif               | [:銀美濃]                                                                                           | true   |
# >> | 振り飛車四枚美濃     | 囲い/振り飛車四枚美濃.kif     | [:振り飛車四枚美濃, :居飛車穴熊]                                                                    | true   |
# >> | ダイヤモンド美濃     | 囲い/ダイヤモンド美濃.kif     | [:ダイヤモンド美濃, :舟囲い]                                                                        | true   |
# >> | 木村美濃             | 囲い/木村美濃.kif             | [:金矢倉, :木村美濃]                                                                                | true   |
# >> | 大山美濃             | 囲い/大山美濃.kif             | [:大山美濃]                                                                                         | true   |
# >> | 裾固め               | 囲い/裾固め.kif               | [:木村美濃, :裾固め]                                                                                | true   |
# >> | 片美濃囲い           | 囲い/片美濃囲い.kif           | [:片美濃囲い]                                                                                       | true   |
# >> | ちょんまげ美濃       | 囲い/ちょんまげ美濃.kif       | [:ちょんまげ美濃]                                                                                   | true   |
# >> | 坊主美濃             | 囲い/坊主美濃.kif             | [:坊主美濃, :いちご囲い]                                                                            | true   |
# >> | 金美濃               | 囲い/金美濃.kif               | [:早囲い, :金美濃]                                                                                  | true   |
# >> | 左美濃               | 囲い/左美濃.kif               | [:舟囲い, :左美濃]                                                                                  | true   |
# >> | 角道不突き左美濃     | 囲い/角道不突き左美濃.kif     | [:角道不突き左美濃]                                                                                 | true   |
# >> | 居飛車金美濃         | 囲い/居飛車金美濃.kif         | [:舟囲い, :居飛車金美濃, :片美濃囲い]                                                               | true   |
# >> | 升田美濃             | 囲い/升田美濃.kif             | [:升田美濃, :無敵囲い]                                                                              | true   |
# >> | 天守閣美濃           | 囲い/天守閣美濃.kif           | [:美濃囲い, :舟囲い, :天守閣美濃]                                                                   | true   |
# >> | 四枚美濃             | 囲い/四枚美濃.kif             | [:美濃囲い, :舟囲い, :天守閣美濃, :四枚美濃]                                                        | true   |
# >> | 端玉銀冠             | 囲い/端玉銀冠.kif             | [:左美濃, :端玉銀冠, :美濃囲い, :銀冠]                                                              | true   |
# >> | 四枚銀冠             | 囲い/四枚銀冠.kif             | [:舟囲い, :天守閣美濃, :四枚美濃, :金矢倉, :四枚銀冠, :美濃囲い]                                    | true   |
# >> | 串カツ囲い           | 囲い/串カツ囲い.kif           | [:舟囲い, :居飛車金美濃, :串カツ囲い]                                                               | true   |
# >> | 舟囲い               | 囲い/舟囲い.kif               | [:舟囲い, :銀雲雀, :早囲い]                                                                         | true   |
# >> | 舟囲いDX             | 囲い/舟囲いDX.kif             | [:舟囲いDX]                                                                                         | true   |
# >> | 居飛車穴熊           | 囲い/居飛車穴熊.kif           | [:居飛車穴熊]                                                                                       | true   |
# >> | 松尾流穴熊           | 囲い/松尾流穴熊.kif           | [:舟囲い, :松尾流穴熊]                                                                              | true   |
# >> | 銀冠穴熊             | 囲い/銀冠穴熊.kif             | [:左美濃, :銀冠穴熊, :高美濃囲い, :銀冠]                                                            | true   |
# >> | ビッグ４             | 囲い/ビッグ４.kif             | [:振り飛車四枚美濃, :ビッグ４]                                                                      | true   |
# >> | 文鎮囲い             | 囲い/文鎮囲い.kif             | [:文鎮囲い, :振り飛車穴熊]                                                                          | true   |
# >> | 箱入り娘             | 囲い/箱入り娘.kif             | [:箱入り娘]                                                                                         | true   |
# >> | 金盾囲い             | 囲い/金盾囲い.kif             | [:金盾囲い, :片美濃囲い]                                                                            | true   |
# >> | 大盾囲い             | 囲い/大盾囲い.kif             | [:舟囲い, :大盾囲い, :片美濃囲い]                                                                   | true   |
# >> | ミレニアム囲い       | 囲い/ミレニアム囲い.kif       | [:ミレニアム囲い]                                                                                   | true   |
# >> | 振り飛車穴熊         | 囲い/振り飛車穴熊.kif         | [:舟囲い, :振り飛車穴熊]                                                                            | true   |
# >> | 振り飛車ミレニアム   | 囲い/振り飛車ミレニアム.kif   | [:舟囲い, :居飛車穴熊, :振り飛車ミレニアム]                                                         | true   |
# >> | 右矢倉               | 囲い/右矢倉.kif               | [:右矢倉]                                                                                           | true   |
# >> | 金無双               | 囲い/金無双.kif               | [:金無双]                                                                                           | true   |
# >> | 中住まい             | 囲い/中住まい.kif             | [:三手囲い, :中住まい]                                                                              | true   |
# >> | 中原囲い             | 囲い/中原囲い.kif             | [:中原囲い]                                                                                         | true   |
# >> | 桐山流中原囲い       | 囲い/桐山流中原囲い.kif       | [:桐山流中原囲い]                                                                                   | true   |
# >> | アヒル囲い           | 囲い/アヒル囲い.kif           | [:中住まい, :アヒル囲い, :中原囲い]                                                                 | true   |
# >> | 裏アヒル囲い         | 囲い/裏アヒル囲い.kif         | [:裏アヒル囲い]                                                                                     | true   |
# >> | いちご囲い           | 囲い/いちご囲い.kif           | [:いちご囲い]                                                                                       | true   |
# >> | 無敵囲い             | 囲い/無敵囲い.kif             | [:無敵囲い, :エルモ囲い]                                                                            | true   |
# >> | エルモ囲い           | 囲い/エルモ囲い.kif           | [:エルモ囲い]                                                                                       | true   |
# >> | 左山囲い             | 囲い/左山囲い.kif             | [:エルモ囲い, :左山囲い]                                                                            | true   |
# >> | 無責任矢倉           | 囲い/無責任矢倉.kif           | [:無責任矢倉]                                                                                       | true   |
# >> | ツノ銀雁木           | 囲い/ツノ銀雁木.kif           | [:ツノ銀雁木]                                                                                       | true   |
# >> | 音無しの構え         | 囲い/音無しの構え.kif         | [:音無しの構え, :ビッグ４]                                                                          | true   |
# >> | 銀雲雀               | 囲い/銀雲雀.kif               | [:舟囲い, :銀雲雀, :振り飛車穴熊]                                                                   | true   |
# >> | あずまや囲い         | 囲い/あずまや囲い.kif         | [:あずまや囲い, :無敵囲い]                                                                          | true   |
# >> | セメント囲い         | 囲い/セメント囲い.kif         | [:セメント囲い, :片美濃囲い]                                                                        | true   |
# >> | 銀多伝               | 囲い/銀多伝.kif               | [:銀多伝]                                                                                           | true   |
# >> | 金多伝               | 囲い/金多伝.kif               | [:金多伝]                                                                                           | true   |
# >> | 美濃熊囲い           | 囲い/美濃熊囲い.kif           | [:美濃囲い, :美濃熊囲い, :左美濃]                                                                   | true   |
# >> | モノレール囲い       | 囲い/モノレール囲い.kif       | [:モノレール囲い]                                                                                   | true   |
# >> | チョコレート囲い     | 囲い/チョコレート囲い.kif     | [:舟囲い, :チョコレート囲い, :高美濃囲い]                                                           | true   |
# >> | 四段端玉             | 囲い/四段端玉.kif             | [:四段端玉, :あずまや囲い]                                                                          | true   |
# >> | 空中楼閣             | 囲い/空中楼閣.kif             | [:銀矢倉, :空中楼閣]                                                                                | true   |
# >> | 高田流左玉           | 囲い/高田流左玉.kif           | [:高田流左玉, :振り飛車穴熊]                                                                        | true   |
# >> | ３七銀戦法           | 戦型/３七銀戦法.kif           | [:３七銀戦法, :阿久津流急戦矢倉]                                                                    | true   |
# >> | 脇システム           | 戦型/脇システム.kif           | [:３七銀戦法, :脇システム, :矢倉棒銀, :棒銀]                                                        | true   |
# >> | 矢倉棒銀             | 戦型/矢倉棒銀.kif             | [:森下システム, :矢倉棒銀, :棒銀, :四手角]                                                          | true   |
# >> | 森下システム         | 戦型/森下システム.kif         | [:袖飛車, :森下システム]                                                                            | true   |
# >> | 雀刺し               | 戦型/雀刺し.kif               | [:３七銀戦法, :森下システム, :雀刺し]                                                               | true   |
# >> | 米長流急戦矢倉       | 戦型/米長流急戦矢倉.kif       | [:米長流急戦矢倉]                                                                                   | true   |
# >> | カニカニ銀           | 戦型/カニカニ銀.kif           | [:カニカニ銀, :右四間飛車]                                                                          | true   |
# >> | カニカニ金           | 戦型/カニカニ金.kif           | [:カニカニ金, :矢倉中飛車, :ゴキゲン中飛車, :原始中飛車]                                            | true   |
# >> | 中原流急戦矢倉       | 戦型/中原流急戦矢倉.kif       | [:袖飛車, :中原流急戦矢倉]                                                                          | true   |
# >> | 阿久津流急戦矢倉     | 戦型/阿久津流急戦矢倉.kif     | [:３七銀戦法, :阿久津流急戦矢倉]                                                                    | true   |
# >> | 矢倉中飛車           | 戦型/矢倉中飛車.kif           | [:相振り飛車, :矢倉中飛車, :原始中飛車, :かまいたち戦法, :ゴキゲン中飛車, :矢倉中飛車, :相振り飛車] | true   |
# >> | 右四間飛車           | 戦型/右四間飛車.kif           | [:四間飛車, :角交換振り飛車, :腰掛け銀, :右四間飛車, :右四間飛車急戦]                               | true   |
# >> | 原始棒銀             | 戦型/原始棒銀.kif             | [:原始棒銀, :棒銀]                                                                                  | true   |
# >> | かまいたち戦法       | 戦型/かまいたち戦法.kif       | [:四間飛車, :かまいたち戦法, :相振り飛車, :対振り持久戦]                                            | true   |
# >> | 英春流カメレオン     | 戦型/英春流カメレオン.kif     | [:棒銀, :英春流カメレオン, :棒玉, :向かい飛車, :相振り飛車, :四間飛車, :４→３戦法]                 | true   |
# >> | パックマン戦法       | 戦型/パックマン戦法.kif       | [:パックマン戦法]                                                                                   | true   |
# >> | 新米長玉             | 戦型/新米長玉.kif             | [:新米長玉]                                                                                         | true   |
# >> | 稲庭戦法             | 戦型/稲庭戦法.kif             | [:嬉野流, :稲庭戦法]                                                                                | true   |
# >> | 四手角               | 戦型/四手角.kif               | [:森下システム, :四手角]                                                                            | true   |
# >> | 一間飛車             | 戦型/一間飛車.kif             | [:一間飛車]                                                                                         | true   |
# >> | 一間飛車穴熊         | 戦型/一間飛車穴熊.kif         | [:一間飛車穴熊]                                                                                     | true   |
# >> | 都成流               | 戦型/都成流.kif               | [:都成流]                                                                                           | true   |
# >> | 右四間飛車左美濃     | 戦型/右四間飛車左美濃.kif     | [:右四間飛車, :右四間飛車左美濃]                                                                    | true   |
# >> | 角換わり             | 戦型/角換わり.kif             | [:角交換振り飛車, :角換わり]                                                                        | true   |
# >> | 角換わり腰掛け銀     | 戦型/角換わり腰掛け銀.kif     | [:角換わり早繰り銀, :角換わり腰掛け銀, :右四間飛車]                                                 | true   |
# >> | 角換わり棒銀         | 戦型/角換わり棒銀.kif         | [:原始棒銀, :角換わり棒銀, :棒銀]                                                                   | true   |
# >> | 角換わり早繰り銀     | 戦型/角換わり早繰り銀.kif     | [:角換わり早繰り銀, :角換わり腰掛け銀, :右四間飛車]                                                 | true   |
# >> | 筋違い角             | 戦型/筋違い角.kif             | [:筋違い角]                                                                                         | true   |
# >> | 相筋違い角           | 戦型/相筋違い角.kif           | [:筋違い角, :筋違い角, :相筋違い角]                                                                 | true   |
# >> | 木村定跡             | 戦型/木村定跡.kif             | [:木村定跡, :角換わり腰掛け銀]                                                                      | true   |
# >> | 一手損角換わり       | 戦型/一手損角換わり.kif       | [:一手損角換わり]                                                                                   | true   |
# >> | 相掛かり             | 戦型/相掛かり.kif             | [:相掛かり, :相掛かり棒銀]                                                                          | true   |
# >> | 相掛かり棒銀         | 戦型/相掛かり棒銀.kif         | [:相掛かり, :相掛かり棒銀]                                                                          | true   |
# >> | 塚田スペシャル       | 戦型/塚田スペシャル.kif       | [:相掛かり, :塚田スペシャル]                                                                        | true   |
# >> | 中原流相掛かり       | 戦型/中原流相掛かり.kif       | [:相掛かり, :中原流相掛かり, :腰掛け銀]                                                             | true   |
# >> | 中原飛車             | 戦型/中原飛車.kif             | [:横歩取り, :△３三角型空中戦法, :８五飛車戦法, :中原飛車]                                          | true   |
# >> | 腰掛け銀             | 戦型/腰掛け銀.kif             | [:腰掛け銀, :右四間飛車, :四間飛車]                                                                 | true   |
# >> | 鎖鎌銀               | 戦型/鎖鎌銀.kif               | [:鎖鎌銀, :ゴキゲン中飛車]                                                                          | true   |
# >> | ８五飛車戦法         | 戦型/８五飛車戦法.kif         | [:横歩取り, :△３三角型空中戦法, :８五飛車戦法]                                                     | true   |
# >> | UFO銀                | 戦型/UFO銀.kif                | [:相掛かり, :相掛かり棒銀, :UFO銀]                                                                  | true   |
# >> | 横歩取り             | 戦型/横歩取り.kif             | [:横歩取り, :△３三桂戦法]                                                                          | true   |
# >> | △３三角型空中戦法   | 戦型/△３三角型空中戦法.kif   | [:横歩取り, :△３三角型空中戦法]                                                                    | true   |
# >> | △３三桂戦法         | 戦型/△３三桂戦法.kif         | [:横歩取り, :△３三桂戦法]                                                                          | true   |
# >> | △２三歩戦法         | 戦型/△２三歩戦法.kif         | [:△２三歩戦法, :一手損角換わり]                                                                    | true   |
# >> | △４五角戦法         | 戦型/△４五角戦法.kif         | [:横歩取り, :△４五角戦法]                                                                          | true   |
# >> | 相横歩取り           | 戦型/相横歩取り.kif           | [:横歩取り, :相横歩取り]                                                                            | true   |
# >> | ゴキゲン中飛車       | 戦型/ゴキゲン中飛車.kif       | [:超急戦, :ゴキゲン中飛車, :角交換振り飛車]                                                         | true   |
# >> | ツノ銀中飛車         | 戦型/ツノ銀中飛車.kif         | [:英ちゃん流中飛車, :ツノ銀中飛車, :４五歩早仕掛け, :加藤流袖飛車, :袖飛車]                         | true   |
# >> | 平目                 | 戦型/平目.kif                 | [:ゴキゲン中飛車, :平目, :対振り持久戦]                                                             | true   |
# >> | 風車                 | 戦型/風車.kif                 | [:風車]                                                                                             | true   |
# >> | 新風車               | 戦型/新風車.kif               | [:新風車]                                                                                           | true   |
# >> | 英ちゃん流中飛車     | 戦型/英ちゃん流中飛車.kif     | [:英ちゃん流中飛車]                                                                                 | true   |
# >> | 原始中飛車           | 戦型/原始中飛車.kif           | [:相振り飛車, :矢倉中飛車, :原始中飛車, :かまいたち戦法, :ゴキゲン中飛車, :矢倉中飛車, :相振り飛車] | true   |
# >> | 加藤流袖飛車         | 戦型/加藤流袖飛車.kif         | [:英ちゃん流中飛車, :加藤流袖飛車, :袖飛車, :棒銀]                                                  | true   |
# >> | ５七金戦法           | 戦型/５七金戦法.kif           | [:５七金戦法, :玉頭位取り, :英ちゃん流中飛車]                                                       | true   |
# >> | 超急戦               | 戦型/超急戦.kif               | [:超急戦, :ゴキゲン中飛車]                                                                          | true   |
# >> | 中飛車左穴熊         | 戦型/中飛車左穴熊.kif         | [:矢倉中飛車, :ゴキゲン中飛車, :原始中飛車, :中飛車左穴熊]                                          | true   |
# >> | 遠山流               | 戦型/遠山流.kif               | [:遠山流, :ゴキゲン中飛車, :角交換振り飛車, :遠山流]                                                | true   |
# >> | 四間飛車             | 戦型/四間飛車.kif             | [:袖飛車, :四間飛車]                                                                                | true   |
# >> | 耀龍四間飛車         | 戦型/耀龍四間飛車.kif         | [:耀龍四間飛車, :４五歩早仕掛け]                                                                    | true   |
# >> | 藤井システム         | 戦型/藤井システム.kif         | [:藤井システム, :対振り持久戦]                                                                      | true   |
# >> | 立石流               | 戦型/立石流.kif               | [:四間飛車, :立石流]                                                                                | true   |
# >> | レグスペ             | 戦型/レグスペ.kif             | [:角換わり腰掛け銀, :レグスペ, :角換わり腰掛け銀, :右四間飛車急戦]                                  | true   |
# >> | 三間飛車             | 戦型/三間飛車.kif             | [:三間飛車, :棒金]                                                                                  | true   |
# >> | 石田流               | 戦型/石田流.kif               | [:石田流]                                                                                           | true   |
# >> | 早石田               | 戦型/早石田.kif               | [:早石田, :玉頭位取り]                                                                              | true   |
# >> | 升田式石田流         | 戦型/升田式石田流.kif         | [:升田式石田流, :一手損角換わり]                                                                    | true   |
# >> | 鬼殺し               | 戦型/鬼殺し.kif               | [:鬼殺し, :相振り飛車, :早石田, :石田流]                                                            | true   |
# >> | △３ニ飛戦法         | 戦型/△３ニ飛戦法.kif         | [:早石田, :４→３戦法, :相振り飛車, :△３ニ飛戦法, :相振り飛車]                                     | true   |
# >> | 中田功XP             | 戦型/中田功XP.kif             | [:対振り持久戦, :中田功XP]                                                                          | true   |
# >> | 真部流               | 戦型/真部流.kif               | [:対振り持久戦, :三間飛車, :真部流]                                                                 | true   |
# >> | ▲７八飛戦法         | 戦型/▲７八飛戦法.kif         | [:▲７八飛戦法]                                                                                     | true   |
# >> | ４→３戦法           | 戦型/４→３戦法.kif           | [:対振り持久戦, :袖飛車, :四間飛車, :三間飛車, :４→３戦法, :向かい飛車]                            | true   |
# >> | 楠本式石田流         | 戦型/楠本式石田流.kif         | [:三間飛車, :楠本式石田流, :対振り持久戦]                                                           | true   |
# >> | 新石田流             | 戦型/新石田流.kif             | [:三間飛車, :新石田流]                                                                              | true   |
# >> | 新鬼殺し             | 戦型/新鬼殺し.kif             | [:新鬼殺し]                                                                                         | true   |
# >> | ダイレクト向かい飛車 | 戦型/ダイレクト向かい飛車.kif | [:カメレオン戦法, :ダイレクト向かい飛車]                                                            | true   |
# >> | 向かい飛車           | 戦型/向かい飛車.kif           | [:向かい飛車]                                                                                       | true   |
# >> | メリケン向かい飛車   | 戦型/メリケン向かい飛車.kif   | [:向かい飛車, :メリケン向かい飛車, :対振り持久戦]                                                   | true   |
# >> | 阪田流向飛車         | 戦型/阪田流向飛車.kif         | [:ダイレクト向かい飛車, :阪田流向飛車]                                                              | true   |
# >> | 角頭歩戦法           | 戦型/角頭歩戦法.kif           | [:角頭歩戦法]                                                                                       | true   |
# >> | 鬼殺し向かい飛車     | 戦型/鬼殺し向かい飛車.kif     | [:丸山ワクチン, :角換わり, :ゴキゲン中飛車, :鬼殺し向かい飛車]                                      | true   |
# >> | 陽動振り飛車         | 戦型/陽動振り飛車.kif         | [:矢倉中飛車, :ゴキゲン中飛車, :陽動振り飛車]                                                       | true   |
# >> | 玉頭銀               | 戦型/玉頭銀.kif               | [:玉頭位取り, :玉頭銀, :原始棒銀, :棒銀]                                                            | true   |
# >> | つくつくぼうし戦法   | 戦型/つくつくぼうし戦法.kif   | [:つくつくぼうし戦法]                                                                               | true   |
# >> | ひねり飛車           | 戦型/ひねり飛車.kif           | [:相掛かり, :ひねり飛車]                                                                            | true   |
# >> | 耀龍ひねり飛車       | 戦型/耀龍ひねり飛車.kif       | [:耀龍ひねり飛車]                                                                                   | true   |
# >> | 相振り飛車           | 戦型/相振り飛車.kif           | [:ゴキゲン中飛車, :相振り飛車, :四間飛車]                                                           | true   |
# >> | 角交換振り飛車       | 戦型/角交換振り飛車.kif       | [:角交換振り飛車]                                                                                   | true   |
# >> | きｍきｍ金           | 戦型/きｍきｍ金.kif           | [:早石田, :きｍきｍ金]                                                                              | true   |
# >> | ポンポン桂           | 戦型/ポンポン桂.kif           | [:四間飛車, :対振り持久戦, :ポンポン桂]                                                             | true   |
# >> | 玉頭位取り           | 戦型/玉頭位取り.kif           | [:玉頭位取り, :玉頭銀, :原始棒銀, :棒銀]                                                            | true   |
# >> | 地下鉄飛車           | 戦型/地下鉄飛車.kif           | [:四間飛車, :対振り持久戦, :地下鉄飛車]                                                             | true   |
# >> | 飯島流引き角戦法     | 戦型/飯島流引き角戦法.kif     | [:三間飛車, :飯島流引き角戦法]                                                                      | true   |
# >> | 丸山ワクチン         | 戦型/丸山ワクチン.kif         | [:丸山ワクチン, :ゴキゲン中飛車]                                                                    | true   |
# >> | 新丸山ワクチン       | 戦型/新丸山ワクチン.kif       | [:新丸山ワクチン, :ゴキゲン中飛車]                                                                  | true   |
# >> | ４六銀左急戦         | 戦型/４六銀左急戦.kif         | [:四間飛車, :４→３戦法, :４六銀左急戦]                                                             | true   |
# >> | ４五歩早仕掛け       | 戦型/４五歩早仕掛け.kif       | [:４五歩早仕掛け]                                                                                   | true   |
# >> | 鷺宮定跡             | 戦型/鷺宮定跡.kif             | [:鷺宮定跡, :袖飛車, :四間飛車]                                                                     | true   |
# >> | 棒銀                 | 戦型/棒銀.kif                 | [:原始棒銀, :角換わり棒銀, :棒銀]                                                                   | true   |
# >> | ４六銀右急戦         | 戦型/４六銀右急戦.kif         | [:四間飛車, :４→３戦法, :４六銀右急戦]                                                             | true   |
# >> | 左美濃急戦           | 戦型/左美濃急戦.kif           | [:左美濃急戦, :角換わり棒銀, :棒銀, :四間飛車, :４→３戦法]                                         | true   |
# >> | 右四間飛車急戦       | 戦型/右四間飛車急戦.kif       | [:腰掛け銀, :右四間飛車, :右四間飛車急戦, :三間飛車, :四間飛車]                                     | true   |
# >> | 鳥刺し               | 戦型/鳥刺し.kif               | [:四間飛車, :向かい飛車, :飯島流引き角戦法, :鳥刺し]                                                | true   |
# >> | 嬉野流               | 戦型/嬉野流.kif               | [:嬉野流, :原始棒銀, :棒銀]                                                                         | true   |
# >> | メイドシステム       | 戦型/メイドシステム.kif       | [:初手７八銀戦法, :メイドシステム]                                                                  | true   |
# >> | 棒金                 | 戦型/棒金.kif                 | [:三間飛車, :棒金]                                                                                  | true   |
# >> | 棒玉                 | 戦型/棒玉.kif                 | [:棒銀, :袖飛車, :棒玉, :四間飛車, :４→３戦法]                                                     | true   |
# >> | 超速                 | 戦型/超速.kif                 | [:超速, :玉頭位取り, :ゴキゲン中飛車]                                                               | true   |
# >> | 対振り持久戦         | 戦型/対振り持久戦.kif         | [:対振り持久戦, :袖飛車, :四間飛車, :三間飛車, :４→３戦法, :向かい飛車]                            | true   |
# >> | ７二飛亜急戦         | 戦型/７二飛亜急戦.kif         | [:鷺宮定跡, :袖飛車, :７二飛亜急戦, :四間飛車, :４→３戦法]                                         | true   |
# >> | 袖飛車               | 戦型/袖飛車.kif               | [:袖飛車, :四間飛車]                                                                                | true   |
# >> | 一直線穴熊           | 戦型/一直線穴熊.kif           | [:対振り持久戦, :一直線穴熊, :四間飛車, :腰掛け銀, :向かい飛車]                                     | true   |
# >> | 穴角戦法             | 戦型/穴角戦法.kif             | [:三間飛車, :四間飛車, :穴角戦法, :右四間飛車, :腰掛け銀, :対振り持久戦]                            | true   |
# >> | 穴角向かい飛車       | 戦型/穴角向かい飛車.kif       | [:穴角向かい飛車]                                                                                   | true   |
# >> | うっかり三間飛車     | 戦型/うっかり三間飛車.kif     | [:うっかり三間飛車]                                                                                 | true   |
# >> | 菅井流三間飛車       | 戦型/菅井流三間飛車.kif       | [:菅井流三間飛車]                                                                                   | true   |
# >> | アヒル戦法           | 戦型/アヒル戦法.kif           | [:目くらまし戦法, :アヒル戦法]                                                                      | true   |
# >> | 裏アヒル戦法         | 戦型/裏アヒル戦法.kif         | [:目くらまし戦法, :裏アヒル戦法]                                                                    | true   |
# >> | 矢倉左美濃急戦       | 戦型/矢倉左美濃急戦.kif       | [:矢倉左美濃急戦]                                                                                   | true   |
# >> | 青野流               | 戦型/青野流.kif               | [:横歩取り, :青野流, :△３三角型空中戦法]                                                           | true   |
# >> | 勇気流               | 戦型/勇気流.kif               | [:横歩取り, :勇気流, :△３三角型空中戦法]                                                           | true   |
# >> | 極限早繰り銀         | 戦型/極限早繰り銀.kif         | [:極限早繰り銀]                                                                                     | true   |
# >> | トマホーク           | 戦型/トマホーク.kif           | [:三間飛車, :トマホーク, :対振り持久戦]                                                             | true   |
# >> | 羽生式袖飛車         | 戦型/羽生式袖飛車.kif         | [:UFO銀, :羽生式袖飛車]                                                                             | true   |
# >> | 初手７八銀戦法       | 戦型/初手７八銀戦法.kif       | [:初手７八銀戦法]                                                                                   | true   |
# >> | 初手３六歩戦法       | 戦型/初手３六歩戦法.kif       | [:初手３六歩戦法]                                                                                   | true   |
# >> | きんとうん戦法       | 戦型/きんとうん戦法.kif       | [:きんとうん戦法]                                                                                   | true   |
# >> | 魔界四間飛車         | 戦型/魔界四間飛車.kif         | [:魔界四間飛車]                                                                                     | true   |
# >> | 目くらまし戦法       | 戦型/目くらまし戦法.kif       | [:目くらまし戦法]                                                                                   | true   |
# >> | 端棒銀               | 戦型/端棒銀.kif               | [:端棒銀, :角交換振り飛車, :四間飛車]                                                               | true   |
# >> | 金銀橋               | 戦型/金銀橋.kif               | [:金銀橋, :右四間飛車, :腰掛け銀]                                                                   | true   |
# >> | カメレオン戦法       | 戦型/カメレオン戦法.kif       | [:カメレオン戦法]                                                                                   | true   |
# >> | xaby角戦法           | 戦型/xaby角戦法.kif           | [:一手損角換わり, :xaby角戦法]                                                                      | true   |
# >> | 金底の歩             | 手筋/金底の歩.kif             | [:金底の歩, :金底の歩]                                                                              | true   |
# >> | パンツを脱ぐ         | 手筋/パンツを脱ぐ.kif         | [:パンツを脱ぐ, :パンツを脱ぐ]                                                                      | true   |
# >> | 腹銀                 | 手筋/腹銀.kif                 | [:腹銀]                                                                                             | true   |
# >> | 垂れ歩               | 手筋/垂れ歩.kif               | [:垂れ歩]                                                                                           | true   |
# >> | 遠見の角             | 手筋/遠見の角.kif             | [:遠見の角]                                                                                         | true   |
# >> | 割り打ちの銀         | 手筋/割り打ちの銀.kif         | [:割り打ちの銀, :割り打ちの銀]                                                                      | true   |
# >> | 桂頭の銀             | 手筋/桂頭の銀.kif             | [:桂頭の銀]                                                                                         | true   |
# >> | ロケット             | 手筋/ロケット.kif             | [:ロケット]                                                                                         | true   |
# >> | ふんどしの桂         | 手筋/ふんどしの桂.kif         | [:ふんどしの桂]                                                                                     | true   |
# >> | 継ぎ桂               | 手筋/継ぎ桂.kif               | [:継ぎ桂]                                                                                           | true   |
# >> | 入玉                 | 備考/入玉.kif                 | [:入玉, :相入玉, :居飛車, :相居飛車, :入玉, :相入玉, :居飛車, :相居飛車]                            | true   |
# >> | 角不成               | 備考/角不成.kif               | [:角不成, :角不成, :居飛車, :相居飛車, :居玉, :居飛車, :相居飛車]                                   | true   |
# >> | 飛車不成             | 備考/飛車不成.kif             | [:居飛車, :飛車不成, :相居飛車, :居玉, :相居玉, :居飛車, :相居飛車, :居玉, :相居玉]                 | true   |
# >> | 居飛車               | 備考/居飛車.kif               | [:居飛車, :相居飛車, :居玉, :相居玉, :居飛車, :相居飛車, :居玉, :相居玉]                            | true   |
# >> | 振り飛車             | 備考/振り飛車.kif             | [:振り飛車, :対抗型, :居玉, :相居玉, :居飛車, :対振り, :対抗型, :居玉, :相居玉]                     | true   |
# >> | 相入玉               | 備考/相入玉.kif               | [:入玉, :相入玉, :居飛車, :相居飛車, :入玉, :相入玉, :居飛車, :相居飛車, :背水の陣]                 | true   |
# >> | 大駒全消失           | 備考/大駒全消失.kif           | [:大駒コンプリート, :居飛車, :対振り, :対抗型, :居玉, :振り飛車, :大駒全消失, :対抗型, :背水の陣]   | true   |
# >> | 居玉                 | 備考/居玉.kif                 | [:居飛車, :相居飛車, :居飛車, :相居飛車, :居玉]                                                     | true   |
# >> | 相居玉               | 備考/相居玉.kif               | [:居飛車, :相居飛車, :居玉, :相居玉, :居飛車, :相居飛車, :居玉, :相居玉]                            | true   |
# >> | 背水の陣             | 備考/背水の陣.kif             | [:振り飛車, :大駒全消失, :相振り, :背水の陣, :大駒コンプリート, :振り飛車, :相振り]                 | true   |
# >> | 相居飛車             | 備考/相居飛車.kif             | [:居飛車, :相居飛車, :居玉, :相居玉, :居飛車, :相居飛車, :居玉, :相居玉]                            | true   |
# >> | 対振り               | 備考/対振り.kif               | [:振り飛車, :対抗型, :居玉, :相居玉, :居飛車, :対振り, :対抗型, :居玉, :相居玉]                     | true   |
# >> | 相振り               | 備考/相振り.kif               | [:振り飛車, :相振り, :居玉, :相居玉, :振り飛車, :相振り, :居玉, :相居玉]                            | true   |
# >> | 対抗型               | 備考/対抗型.kif               | [:振り飛車, :対抗型, :居玉, :相居玉, :居飛車, :対振り, :対抗型, :居玉, :相居玉]                     | true   |
# >> | 大駒コンプリート     | 備考/大駒コンプリート.kif     | [:大駒コンプリート, :居飛車, :対振り, :対抗型, :居玉, :振り飛車, :大駒全消失, :対抗型, :背水の陣]   | true   |
# >> | 駒柱                 | 備考/駒柱.kif                 | [:振り飛車, :駒柱, :相振り, :居玉, :相居玉, :振り飛車, :駒柱, :相振り, :居玉, :相居玉]              | true   |
# >> |----------------------+-------------------------------+-----------------------------------------------------------------------------------------------------+--------|
