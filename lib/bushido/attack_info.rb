# frozen-string-literal: true

module Bushido
  class AttackInfo
    include ApplicationMemoryRecord
    memory_record [
      {wars_code: "2000", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-139.html", key: "３七銀戦法",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: :black, fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: "▲３七銀",               process_ki2: nil, },
      {wars_code: "2001", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-159.html", key: "脇システム",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: :black, fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                      process_ki2: nil, },
      {wars_code: "2002", sankou_url: "http://mudasure.com/blog-entry-50.html",               key: "矢倉棒銀",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: true,  mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: ["▲２七銀", "▲２六銀"], process_ki2: nil, },
      {wars_code: "2003", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-150.html", key: "森下システム",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: :black, fuganai: false, uttatokidake: nil, kaisenmae: true,  mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2004", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-149.html", key: "雀刺し",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2005", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-147.html", key: "米長流急戦矢倉",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2006", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-134.html", key: "カニカニ銀",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2007", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-148.html", key: "中原流急戦矢倉",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: true,  mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2008", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-146.html", key: "阿久津流急戦矢倉",     evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2009", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-152.html", key: "矢倉中飛車",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2010", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-129.html", key: "右四間飛車",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2011", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-137.html", key: "原始棒銀",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: true,  uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: "▲２七銀",                 process_ki2: nil, },
      {wars_code: "2012", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-154.html", key: "右玉",                 evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2013", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-165.html", key: "かまいたち戦法",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2014", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-125.html", key: "パックマン戦法",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: :white, fuganai: false, uttatokidake: nil, kaisenmae: true,  mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2015", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-153.html", key: "新米長玉",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: 2,   only_location_key: :white, fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                         process_ki2: "▲７六歩 △６二玉", },
      {wars_code: "2016", sankou_url: "http://mudasure.com/blog-entry-64.html",               key: "稲庭戦法",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: ["▲５九飛", "▲９八金"],     process_ki2: nil, },
      {wars_code: "2017", sankou_url: "http://mudasure.com/blog-entry-65.html",               key: "四手角",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers:"▲２六角",           process_ki2: nil, },
      {wars_code: "2100", sankou_url: "http://mudasure.com/blog-entry-66.html",               key: "角換わり",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: :black, fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: "角", triggers: "▲７七銀",           process_ki2: nil, },
      {wars_code: "2101", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-184.html", key: "腰掛け銀",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: "角", triggers: nil,              process_ki2: nil, },
      {wars_code: "2103", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-182.html", key: "早繰り銀",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: "角", mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2104", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-126.html", key: "筋違い角",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: true, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: 0, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2105", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-157.html", key: "木村定跡",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: "角", triggers: nil,                       process_ki2: nil, },

      # {wars_code: "2200", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-189.html", key: "相掛かり",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2201", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-191.html", key: "相掛かり棒銀",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2202", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-194.html", key: "塚田スペシャル",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2203", sankou_url: nil,                                                    key: "中原流相掛かり",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2204", sankou_url: nil,                                                    key: "中原飛車",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2205", sankou_url: nil,                                                    key: "腰掛け銀",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2207", sankou_url: nil,                                                    key: "８五飛車",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      {wars_code: "2300", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-198.html", key: "横歩取り",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,    fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: "▲３四飛",                  process_ki2: "▲７六歩 △３四歩 ▲２六歩 △８四歩 ▲２五歩 △８五歩 ▲７八金 △３二金 ▲２四歩 △同歩 ▲同飛 △８六歩 ▲同歩 △同飛 ▲３四飛", },
      # {wars_code: "2301", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-199.html", key: "３三角型空中戦法",     evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2302", sankou_url: nil,                                                    key: "３三桂戦法",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2304", sankou_url: nil,                                                    key: "４五角戦法",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2305", sankou_url: nil,                                                    key: "相横歩取り",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2400", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-151.html", key: "ゴキゲン中飛車",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2401", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-133.html", key: "ツノ銀中飛車",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2403", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-155.html", key: "風車",                 evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2404", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-130.html", key: "英ちゃん流中飛車",     evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2405", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-140.html", key: "原始中飛車",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2406", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-161.html", key: "加藤流袖飛車",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2407", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-162.html", key: "５七金戦法",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2500", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-127.html", key: "四間飛車",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2501", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-128.html", key: "藤井システム",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2502", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-131.html", key: "立石流",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2503", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-132.html", key: "レグスペ",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2600", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-141.html", key: "三間飛車",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2601", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-145.html", key: "石田流",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2602", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-144.html", key: "早石田",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2603", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-143.html", key: "升田式石田流",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2604", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-188.html", key: "鬼殺し",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2605", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-142.html", key: "３ニ飛戦法",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2606", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-163.html", key: "中田功ＸＰ",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2607", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-164.html", key: "真部流",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2700", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-174.html", key: "ダイレクト向かい飛車", evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2701", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-135.html", key: "向飛車",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2702", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-136.html", key: "メリケン向かい飛車",   evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2703", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-176.html", key: "阪田流向飛車",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2800", sankou_url: nil,                                                    key: "陽動振り飛車",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2802", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-186.html", key: "つくつくぼうし戦法",   evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2804", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-190.html", key: "相振り飛車",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2900", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-172.html", key: "ポンポン桂",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2901", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-168.html", key: "５筋位取り",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2902", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-167.html", key: "玉頭位取り",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2903", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-156.html", key: "地下鉄飛車",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2904", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-170.html", key: "飯島流引き角戦法",     evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2905", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-183.html", key: "丸山ワクチン",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2906", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-175.html", key: "４六銀左急戦",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2907", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-171.html", key: "４五歩早仕掛け",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2908", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-173.html", key: "鷺宮定跡",             evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2910", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-177.html", key: "４六銀右急戦",         evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2911", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-178.html", key: "左美濃急戦",           evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2912", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-179.html", key: "右四間飛車急戦",       evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2913", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-166.html", key: "鳥刺し",               evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2914", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-138.html", key: "棒金",                 evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
      # {wars_code: "2915", sankou_url: "http://mijinko83.blog110.fc2.com/blog-entry-187.html", key: "超速",                 evolution_keys: nil, turn_limit: nil, compare_my_side_only: false, compare_condition: :include, turn_eq: nil, only_location_key: nil,  fuganai: false, uttatokidake: nil, kaisenmae: false, mochigoma_in: nil, mochigoma_count_eq: nil, mochigoma_eq: nil, triggers: nil,                       process_ki2: nil, },
    ]

    include TeaiwariInfo::DelegateToShapeInfoMethods
    include DefenseInfo::AttackInfoSharedMethods
  end
end
