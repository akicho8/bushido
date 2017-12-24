require "./example_helper"

info = Parser.parse(<<~EOT)
開始日時：1977/00/00
棋戦：その他の棋戦
戦型：四間飛車
消費時間：▲030△090
先手：小池重明
後手：滝　源太

場所：東京都新宿区歌舞伎町「天狗クラブ」
*棋戦詳細：一流新鋭激突三番勝負第2局
*「小池重明東海王将」vs「滝　源太赤旗準名人」
EOT

tp info.header.to_h
tp info.header.to_names_h
tp info.header.meta_info
tp info.header.to_meta_h
tp info.header.to_kisen_a
tp info.header.to_simple_names_h
# >> |----------+------------------------------------|
# >> | 開始日時 | 1977/0/0                           |
# >> |     棋戦 | その他の棋戦                       |
# >> | 棋戦詳細 | 一流新鋭激突三番勝負第2局          |
# >> |     戦型 | 四間飛車                           |
# >> | 消費時間 | ▲30△90                           |
# >> |     先手 | 小池重明                           |
# >> |     後手 | 滝源太                             |
# >> |     場所 | 東京都新宿区歌舞伎町「天狗クラブ」 |
# >> |----------+------------------------------------|
# >> |----------+----------------------------------|
# >> | 先手詳細 | ["小池重明", "東海", "王将"]     |
# >> | 後手詳細 | ["滝源太", "赤旗", "準", "名人"] |
# >> |----------+----------------------------------|
# >> |----------+------------------|
# >> | 先手詳細 | 小池重明東海王将 |
# >> | 後手詳細 | 滝源太赤旗準名人 |
# >> |----------+------------------|
# >> |----------+------------------------------------|
# >> | 開始日時 | 1977/0/0                           |
# >> |     棋戦 | その他の棋戦                       |
# >> | 棋戦詳細 | ["一流新鋭激突三番勝負", "第2局"]  |
# >> |     戦型 | 四間飛車                           |
# >> | 消費時間 | ▲30△90                           |
# >> |     先手 | 小池重明                           |
# >> |     後手 | 滝源太                             |
# >> |     場所 | 東京都新宿区歌舞伎町「天狗クラブ」 |
# >> | 先手詳細 | ["小池重明", "東海", "王将"]       |
# >> | 後手詳細 | ["滝源太", "赤旗", "準", "名人"]   |
# >> |----------+------------------------------------|
# >> |----------------------|
# >> | 一流新鋭激突三番勝負 |
# >> | 第2局                |
# >> |----------------------|
# >> |------+--------------|
# >> | 先手 | ["小池重明"] |
# >> | 後手 | ["滝源太"]   |
# >> |------+--------------|
