# frozen-string-literal: true

module Bushido
  class DefenseInfo
    include ApplicationMemoryRecord
    memory_record [
      {key: "金矢倉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "基本的な囲い",       wars_code: "001",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-89.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kinyagura.html",            },
      {key: "カニ囲い",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "000",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-88.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kanigakoi.html",            },
      {key: "銀矢倉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "002",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-90.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ginyagura.html",            },
      {key: "片矢倉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: "天野矢倉", sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "003",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-91.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/katayagura.html",           },
      {key: "総矢倉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "004",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-92.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/souyagura.html",            },
      {key: "矢倉穴熊",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "005",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-93.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/yaguraanaguma.html",        },
      {key: "菊水穴熊",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "006",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-94.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kikusuiyagura.html",        },
      {key: "銀立ち矢倉",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "007",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-95.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/gindatiyagura.html",        },
      {key: "菱矢倉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "矢倉変化系",         wars_code: "008",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-96.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/hisiyagura.html",           },
      {key: "雁木囲い",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "その他の囲い",       wars_code: "009",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-97.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ganngi.html",               },
      {key: "ボナンザ囲い",     turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "その他の囲い",       wars_code: "010",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-98.html",  siratama_url: nil,                                                                                     },
      {key: "美濃囲い",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "美濃囲い変化形",     wars_code: "100",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-99.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/minokakoi.html",         },
      {key: "高美濃囲い",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "101",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-99.html",  siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/takaminokakoi.html",     },
      {key: "銀冠",             turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "102",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-101.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/ginkannmuri.html",       },
      {key: "銀美濃",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "103",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-102.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/ginmino.html",           },
      {key: "ダイヤモンド美濃", turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "104",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-103.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/daiyamondomino.html",    },
      {key: "木村美濃",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "105",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-104.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/kimuramino.html",        },
      {key: "片美濃囲い",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "106",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-105.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/kataminokakoi.html",     },
      {key: "ちょんまげ美濃",   turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "107",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-106.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/tyonmagemino.html",      },
      {key: "坊主美濃",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "108",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-107.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/tyonmagemino.html",      },
      {key: "左美濃",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "200",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-108.html", siratama_url: nil,                                                                                     },
      {key: "天守閣美濃",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "美濃囲い変化形",     wars_code: "201",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-109.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/tennsyukakumino.html",      },
      {key: "四枚美濃",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "美濃囲い変化形",     wars_code: "202",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-110.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/yonmaimino.html",        },
      {key: "舟囲い",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "基本的な囲い",       wars_code: "300",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-111.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/funagakoi.html",            },
      {key: "居飛車穴熊",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: "イビ穴",   sect_key: "居飛車",   defense_group_info: "基本的な囲い",       wars_code: "301",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-112.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/anaguma.html",              },
      {key: "松尾流穴熊",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "穴熊変化形",         wars_code: "302",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-113.html", siratama_url: nil,                                                                                     },
      {key: "銀冠穴熊",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "穴熊変化形",         wars_code: "303",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-114.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/ginkanmurianaguma.html", },
      {key: "ビッグ４",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "穴熊変化形",         wars_code: "304",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-115.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/big4.html",                 },
      {key: "箱入り娘",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "穴熊変化形",         wars_code: "305",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-116.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/hakoirimusume.html",        },
      {key: "ミレニアム囲い",   turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "穴熊変化形",         wars_code: "306",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-117.html", siratama_url: nil,                                                                                     },
      {key: "振り飛車穴熊",     turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "穴熊変化形",         wars_code: "400",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-118.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/anaguma.html",           },
      {key: "右矢倉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "矢倉変化系",         wars_code: "401",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-119.html", siratama_url: nil,                                                                                     },
      {key: "金無双",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "振り飛車", defense_group_info: "基本的な囲い",       wars_code: "402",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-120.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/furibisya/kinmusou.html",          },
      {key: "中住まい",         turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "自陣全体を守る囲い", wars_code: "403",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-121.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/nakazumai.html",            },
      {key: "中原玉",           turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "自陣全体を守る囲い", wars_code: "404",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-122.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/nakaharagakoi.html",        },
      {key: "アヒル囲い",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: "金開き",   sect_key: "居飛車",   defense_group_info: "自陣全体を守る囲い", wars_code: "500",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-123.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/kinnbiraki.html",           },
      {key: "いちご囲い",       turn_limit: nil, turn_eq: nil, my_side_only: true, compare_condition: :include, only_location_key: nil, alias_names: nil,        sect_key: "居飛車",   defense_group_info: "その他の囲い",       wars_code: "501",  uragoya_url: "http://mijinko83.blog110.fc2.com/blog-entry-124.html", siratama_url: "http://www5e.biglobe.ne.jp/~siratama/nonframe/syougi/ibisya/ichigogakoi.html",          },
    ]

    include TeaiwariInfo::DelegateToShapeInfoMethods

    def alias_names
      Array(super)
    end
  end
end
