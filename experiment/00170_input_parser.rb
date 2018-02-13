require "./example_helper"

InputParser.scan("▲４二銀 △４二銀")                  # => ["▲４二銀", "△４二銀"]
InputParser.scan("▲５五歩△４四歩 push ▲３三歩 pop") # => ["▲５五歩", "△４四歩", "▲３三歩"]
InputParser.scan("５五歩")                             # => ["５五歩"]
InputParser.slice_one("▲５五歩△６八銀")              # => "▲５五歩"

list = [
  "６八銀左",
  "△６八全",
  "△６八銀成",
  "△６八銀打",
  "△同銀",
  "△同銀成",
  "７六歩(77)",
  "7677FU",
  "-7677FU",
  "+0077RY",
  "8c8d",
  "P*2f",
  "4e5c+",
]
tp list.collect { |e| {source: e}.merge(InputParser.match!(e).named_captures) }
InputParser.scan(list.join) == list # => true
InputParser.scan(list.join) # => ["６八銀左", "△６八全", "△６八銀成", "△６八銀打", "△同銀", "△同銀成", "７六歩(77)", "7677FU", "-7677FU", "+0077RY", "8c8d", "P*2f", "4e5c+"]
# >> |------------+----------+-------+------+-------+-------------+--------------+------------+------+----------+--------+----------------+-------------------+------------------+------------+--------+----------+---------------------|
# >> | source     | triangle | point | same | piece | motion_part | trigger_part | point_from | sign | csa_from | csa_to | csa_basic_name | csa_promoted_name | usi_direct_piece | usi_direct | usi_to | usi_from | usi_promote_trigger |
# >> |------------+----------+-------+------+-------+-------------+--------------+------------+------+----------+--------+----------------+-------------------+------------------+------------+--------+----------+---------------------|
# >> | ６八銀左   |          | ６八  |      | 銀    | 左          |              |            |      |          |        |                |                   |                  |            |        |          |                     |
# >> | △６八全   | △       | ６八  |      | 全    |             |              |            |      |          |        |                |                   |                  |            |        |          |                     |
# >> | △６八銀成 | △       | ６八  |      | 銀    |             | 成           |            |      |          |        |                |                   |                  |            |        |          |                     |
# >> | △６八銀打 | △       | ６八  |      | 銀    |             | 打           |            |      |          |        |                |                   |                  |            |        |          |                     |
# >> | △同銀     | △       |       | 同   | 銀    |             |              |            |      |          |        |                |                   |                  |            |        |          |                     |
# >> | △同銀成   | △       |       | 同   | 銀    |             | 成           |            |      |          |        |                |                   |                  |            |        |          |                     |
# >> | ７六歩(77) |          | ７六  |      | 歩    |             |              | (77)       |      |          |        |                |                   |                  |            |        |          |                     |
# >> | 7677FU     |          |       |      |       |             |              |            |      |       76 |     77 | FU             |                   |                  |            |        |          |                     |
# >> | -7677FU    |          |       |      |       |             |              |            | -    |       76 |     77 | FU             |                   |                  |            |        |          |                     |
# >> | +0077RY    |          |       |      |       |             |              |            | +    |       00 |     77 |                | RY                |                  |            |        |          |                     |
# >> | 8c8d       |          |       |      |       |             |              |            |      |          |        |                |                   |                  |            | 8d     | 8c       |                     |
# >> | P*2f       |          |       |      |       |             |              |            |      |          |        |                |                   | P                | *          | 2f     |          |                     |
# >> | 4e5c+      |          |       |      |       |             |              |            |      |          |        |                |                   |                  |            | 5c     | 4e       | +                   |
# >> |------------+----------+-------+------+-------+-------------+--------------+------------+------+----------+--------+----------------+-------------------+------------------+------------+--------+----------+---------------------|
