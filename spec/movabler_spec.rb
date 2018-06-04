require_relative "spec_helper"

module Warabi
  describe "#move_list" do
    it "ある地点に移動するとき成れるのか？" do
      soldier = Soldier.from_str("▲13銀")
     assert { soldier.next_promotable?(Place["14"]) }
    end

    it "移動可能な筋(相手陣地から外に出た場合にも成れる)" do
      mediator = Mediator.new
      mediator.board.placement_from_shape <<~EOT
      +------+
        | ・ ・|
      | ・ 歩|
      | ・ 銀|
      +------+
        EOT
      soldier = mediator.board["13"]
      assert { soldier.move_list(mediator.board).collect(&:to_kif) == ["▲２二銀成(13)", "▲２二銀(13)", "▲２四銀成(13)", "▲２四銀(13)"] }
      assert { soldier.move_list(mediator.board, promoted_preferred: true).collect(&:to_kif) == ["▲２二銀成(13)", "▲２四銀成(13)"] }
    end

    it "移動可能な筋の取得(超重要なテスト)" do
      Board.dimensiton_change([1, 5]) do
        test = -> s {
          soldier = Soldier.from_str(s)
          soldier.move_list(Board.new).collect(&:to_kif).sort
        }
        assert { test["▲１五香"] == ["▲１一香成(15)", "▲１三香(15)", "▲１三香成(15)", "▲１二香(15)", "▲１二香成(15)", "▲１四香(15)"] }
        assert { test["▲１五杏"] == ["▲１四杏(15)"] }
      end
    end

    it "成るパターンと成らないパターンがある。相手の駒があるのでそれ以上進めない" do
      Board.dimensiton_change([1, 5]) do
        mediator = Mediator.test1(init: "▲１五香 △１三歩")
        assert { mediator.board["１五"].move_list(mediator.board).collect(&:to_kif) == ["▲１四香(15)", "▲１三香成(15)", "▲１三香(15)"] }
      end
    end

    it "初期配置での移動可能な座標" do
      mediator = Mediator.start
      test = -> place { mediator.board[place].move_list(mediator.board).collect(&:to_kif) }
      assert { test["７七"] == ["▲７六歩(77)"]                                                                                 } # 歩
      assert { test["９九"] == ["▲９八香(99)"]                                                                                 } # 香
      assert { test["８九"] == []                                                                                               } # 桂
      assert { test["７九"] == ["▲７八銀(79)", "▲６八銀(79)"]                                                                 } # 銀
      assert { test["６九"] == ["▲７八金(69)", "▲６八金(69)", "▲５八金(69)"]                                                 } # 金
      assert { test["５九"] == ["▲６八玉(59)", "▲５八玉(59)", "▲４八玉(59)"]                                                 } # 玉
      assert { test["８八"] == []                                                                                               } # 角
      assert { test["２八"] == ["▲３八飛(28)", "▲４八飛(28)", "▲５八飛(28)", "▲６八飛(28)", "▲７八飛(28)", "▲１八飛(28)"] } # 飛
    end
  end
end
