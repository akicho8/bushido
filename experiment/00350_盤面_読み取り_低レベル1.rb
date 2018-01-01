require "./example_helper"

tp BoardParser.parse(<<~EOT).soldiers
+---+
| 歩|
+---+
EOT

tp BoardParser.parse(<<~EOT).soldiers
+------+
|v桂v香|
| ・ ・|
+------+
EOT

tp BoardParser.parse(<<~EOT).soldiers
+---------------------------+
| ・v桂 ・ ・ 馬 ・ ・v桂v香|
|v飛 ・ ・ ・ ・ と ・ ・ ・|
| ・ ・ ・ 全v歩 ・v玉 ・ ・|
| ・ ・ ・ ・ ・ ・v桂 ・v金|
| ・v歩 ・ ・ ・ 銀v歩v歩v歩|
|v歩 ・ 歩v角 ・ ・ ・ ・ ・|
| ・ 歩 銀v歩vと ・ ・ ・ ・|
| 歩 ・ 玉 香 ・ ・ ・ ・ 香|
| 香 桂 ・ ・ ・ ・ 飛 ・ ・|
+---------------------------+
EOT

tp HandicapInfo["平手"].both_board_info[Location[:black]]
# >> |-------+----------+-------+----------|
# >> | piece | promoted | point | location |
# >> |-------+----------+-------+----------|
# >> | 歩    | false    | １一  | ▲       |
# >> |-------+----------+-------+----------|
# >> |-------+----------+-------+----------|
# >> | piece | promoted | point | location |
# >> |-------+----------+-------+----------|
# >> | 桂    | false    | ２一  | △       |
# >> | 香    | false    | １一  | △       |
# >> |-------+----------+-------+----------|
# >> |-------+----------+-------+----------|
# >> | piece | promoted | point | location |
# >> |-------+----------+-------+----------|
# >> | 桂    | false    | ８一  | △       |
# >> | 角    | true     | ５一  | ▲       |
# >> | 桂    | false    | ２一  | △       |
# >> | 香    | false    | １一  | △       |
# >> | 飛    | false    | ９二  | △       |
# >> | 歩    | true     | ４二  | ▲       |
# >> | 銀    | true     | ６三  | ▲       |
# >> | 歩    | false    | ５三  | △       |
# >> | 玉    | false    | ３三  | △       |
# >> | 桂    | false    | ３四  | △       |
# >> | 金    | false    | １四  | △       |
# >> | 歩    | false    | ８五  | △       |
# >> | 銀    | false    | ４五  | ▲       |
# >> | 歩    | false    | ３五  | △       |
# >> | 歩    | false    | ２五  | △       |
# >> | 歩    | false    | １五  | △       |
# >> | 歩    | false    | ９六  | △       |
# >> | 歩    | false    | ７六  | ▲       |
# >> | 角    | false    | ６六  | △       |
# >> | 歩    | false    | ８七  | ▲       |
# >> | 銀    | false    | ７七  | ▲       |
# >> | 歩    | false    | ６七  | △       |
# >> | 歩    | true     | ５七  | △       |
# >> | 歩    | false    | ９八  | ▲       |
# >> | 玉    | false    | ７八  | ▲       |
# >> | 香    | false    | ６八  | ▲       |
# >> | 香    | false    | １八  | ▲       |
# >> | 香    | false    | ９九  | ▲       |
# >> | 桂    | false    | ８九  | ▲       |
# >> | 飛    | false    | ３九  | ▲       |
# >> |-------+----------+-------+----------|
# >> |-------+----------+-------+----------|
# >> | piece | promoted | point | location |
# >> |-------+----------+-------+----------|
# >> | 歩    | false    | ９七  | ▲       |
# >> | 歩    | false    | ８七  | ▲       |
# >> | 歩    | false    | ７七  | ▲       |
# >> | 歩    | false    | ６七  | ▲       |
# >> | 歩    | false    | ５七  | ▲       |
# >> | 歩    | false    | ４七  | ▲       |
# >> | 歩    | false    | ３七  | ▲       |
# >> | 歩    | false    | ２七  | ▲       |
# >> | 歩    | false    | １七  | ▲       |
# >> | 角    | false    | ８八  | ▲       |
# >> | 飛    | false    | ２八  | ▲       |
# >> | 香    | false    | ９九  | ▲       |
# >> | 桂    | false    | ８九  | ▲       |
# >> | 銀    | false    | ７九  | ▲       |
# >> | 金    | false    | ６九  | ▲       |
# >> | 玉    | false    | ５九  | ▲       |
# >> | 金    | false    | ４九  | ▲       |
# >> | 銀    | false    | ３九  | ▲       |
# >> | 桂    | false    | ２九  | ▲       |
# >> | 香    | false    | １九  | ▲       |
# >> |-------+----------+-------+----------|
