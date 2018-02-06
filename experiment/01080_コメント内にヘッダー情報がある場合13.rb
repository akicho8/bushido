require "./example_helper"

info = Parser.parse(<<~EOT)
開始日時：2010/08/04
棋戦：その他の棋戦
戦型：相振飛車
先手：中村真梨花・山口恵梨子
後手：上田初美・井道千尋

場所：東京都「渋谷東急東横店」
持ち時間：
*棋戦詳細：第44回東急将棋まつり　駒桜特別対局 ペア将棋
*「中村真梨花女流二段・山口恵梨子女流初段」vs「上田初美女流二段・井道千尋女流初段」
EOT

tp info.header.to_h
tp info.header.__to_simple_names_h
tp info.header.meta_info
tp info.header.__to_meta_h
tp info.header.to_kisen_a
tp info.header.__to_simple_names_h
# >> |----------+--------------------------------------------|
# >> | 開始日時 | 2010/08/04                                 |
# >> |     棋戦 | その他の棋戦                               |
# >> |     戦型 | 相振飛車                                   |
# >> |     先手 | 中村真梨花・山口恵梨子                     |
# >> |     後手 | 上田初美・井道千尋                         |
# >> |     場所 | 東京都「渋谷東急東横店」                   |
# >> | 棋戦詳細 | 第44回東急将棋まつり 駒桜特別対局 ペア将棋 |
# >> | 先手詳細 | 中村真梨花女流二段・山口恵梨子女流初段     |
# >> | 後手詳細 | 上田初美女流二段・井道千尋女流初段         |
# >> |----------+--------------------------------------------|
# >> |----------+------------------------------------------------------------------|
# >> | 先手詳細 | ["中村真梨花", "女流", "二段", "山口", "恵梨子", "女流", "初段"] |
# >> | 後手詳細 | ["上田初美", "女流", "二段", "井道千尋", "女流", "初段"]         |
# >> |----------+------------------------------------------------------------------|
# >> |----------+----------------------------------------|
# >> | 先手詳細 | 中村真梨花女流二段・山口恵梨子女流初段 |
# >> | 後手詳細 | 上田初美女流二段・井道千尋女流初段     |
# >> |----------+----------------------------------------|
# >> |----------+--------------------------------------------------------------------------|
# >> | 開始日時 | 2010/08/04                                                               |
# >> |     棋戦 | その他の棋戦                                                             |
# >> |     戦型 | 相振飛車                                                                 |
# >> |     先手 | ["中村真梨花", "山口恵梨子"]                                             |
# >> |     後手 | ["上田初美", "井道千尋"]                                                 |
# >> |     場所 | 東京都「渋谷東急東横店」                                                 |
# >> | 棋戦詳細 | ["第44回", "東急", "将棋", "まつり", "駒桜", "特別対局", "ペア", "将棋"] |
# >> | 先手詳細 | ["中村真梨花", "女流", "二段", "山口", "恵梨子", "女流", "初段"]         |
# >> | 後手詳細 | ["上田初美", "女流", "二段", "井道千尋", "女流", "初段"]                 |
# >> |----------+--------------------------------------------------------------------------|
# >> |----------|
# >> | 第44回   |
# >> | 東急     |
# >> | 将棋     |
# >> | まつり   |
# >> | 駒桜     |
# >> | 特別対局 |
# >> | ペア     |
# >> | 将棋     |
# >> |----------|
# >> |------+------------------------------|
# >> | 先手 | ["中村真梨花", "山口恵梨子"] |
# >> | 後手 | ["上田初美", "井道千尋"]     |
# >> |------+------------------------------|
