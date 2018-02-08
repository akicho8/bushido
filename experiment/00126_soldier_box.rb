require "./example_helper"

soldier_box = SoldierBox.new
soldier_box << Soldier.from_str("△５一玉")
soldier_box << Soldier.from_str("▲６八銀")
soldier_box.collect(&:name)                                             # => ["△５一玉", "▲６八銀"]
soldier_box.sorted_soldiers.collect(&:name)                             # => ["▲６八銀", "△５一玉"]
soldier_box.point_as_key_table.collect { |p, s| [p.name, s.name] }.to_h # => {"５一"=>"△５一玉", "６八"=>"▲６八銀"}
soldier_box.location_split.transform_values { |e| e.collect(&:name) }   # => {:black=>["▲６八銀"], :white=>["△５一玉"]}
soldier_box.location_adjust.transform_values { |e| e.collect(&:name) }  # => {:black=>["▲６八銀", "△５一玉"], :white=>["△４二銀", "▲５九玉"]}
